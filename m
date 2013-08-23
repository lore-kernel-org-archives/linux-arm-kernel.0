From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Fri, 23 Aug 2013 13:13:14 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130822201658.GK6617@n2100.arm.linux.org.uk>
References: <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
Message-ID: <1377259994.2444.41.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-22 at 21:16 +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 22, 2013 at 08:22:50PM +0100, Liam Girdwood wrote:
> > On Tue, 2013-08-20 at 21:18 +0100, Russell King - ARM Linux wrote:
> > > On Tue, Aug 20, 2013 at 07:50:19PM +0100, Mark Brown wrote:
> > > > On Tue, Aug 20, 2013 at 02:31:43PM +0100, Russell King - ARM Linux wrote:
> > > > 
> > > > > Let's be a little more clear about that: I don't know how to do that
> > > > > because that's the approach taken by _these_ very patches which you've
> > > > > rejected for "abusing the ASoC core".  That's why I'm asking Liam
> > > > 
> > > > The patches I can recall seeing recently have all had some workarounds
> > > > in the core which would need to be resolved differently, though it's
> > > > possible I missed that being done in some version in your mails as there
> > > > have generally also been a lot of modifications adding debug statements
> > > > in the core.
> > > 
> > > The "workarounds in the core" are because there's bugs in the core that
> > > I have no idea how to solve.  You are allegedly the maintainer for the
> > > core code, and so you should understand that code, so you are best placed
> > > to say how the core code should be fixed.  I'm willing to do the patch
> > > generation to fix them but *you* need to give some guidance here -
> > > something that you seem incapable to do.  At the moment, the only fix I
> > > can see being workable is to comment out the broken bit in the core code.
> > > 
> > 
> > I'll fix this issue as I've replied privately, but you know it's not
> > appropriate to just comment stuff out in core code (especially if you
> > don't fully understand it). I'm sure you would complain loudly to me if
> > I tried to do a similar HACK in the ARM core.
> 
> Hang on, tell me exactly *where* I've asked for the hack to be merged.  The
> answer is: I haven't.  What I've been asking for all along is how this
> should be solved, and getting nowhere - whether I ask in a reasonable and
> calm manner or have to take it to extremes like I have done now.
> 

You asked me privately to Ack the series so you could carry it in your
own tree for upstreaming. Sorry if I misunderstood this request, but it
seemed straightforward.

> > > If the problem is that you don't understand the issue, then you could try
> > > replying with some questions about it.
> > > 
> > > If the problem is that you don't understand the code, well... there's not
> > > much point in continuing this discussion until you've had time to study
> > > and understand that code.
> > > 
> > > > If you've got code you think is in a good state to submit then please do
> > > > send it as a normal patch series, the last one I've got here has "ASoC:
> > > > HACK: avoid creating duplicated widgets" as part of it for example.
> > > 
> > > That patch still hasn't gone away, and is still required, because there
> > > has been no guidance or comments about the problem.  Let's explain it
> > > yet again...
> > > 
> > > You have said "there is no problem registering the platform and the CPU
> > > dai from the same device structure".  Let's assume that's a fact and see
> > > what happens in the core code:
> > > 
> > > static int soc_probe_platform(struct snd_soc_card *card,
> > >                            struct snd_soc_platform *platform)
> > > {
> > >         /* Create DAPM widgets for each DAI stream */
> > >         list_for_each_entry(dai, &dai_list, list) {
> > >                 if (dai->dev != platform->dev)
> > >                         continue;
> > > 
> > >                 snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
> > >         }
> > > }
> > > 
> > > static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
> > > {
> > >         if (!cpu_dai->probed &&
> > >                         cpu_dai->driver->probe_order == order) {
> > >                 if (!cpu_dai->codec) {
> > >                         cpu_dai->dapm.card = card;
> > >                         if (!try_module_get(cpu_dai->dev->driver->owner))
> > >                                 return -ENODEV;
> > > 
> > >                         list_add(&cpu_dai->dapm.list, &card->dapm_list);
> > >                         snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
> > >                 }
> > > 
> > > Now, the CPU DAI is added to the dai_list (it has to be there to be found
> > > so the DAI link can bind it, and so soc_probe_link_dais() can be called.)
> > > 
> > > Think about what happens with the above code if platform->dev is the same
> > > as the device used for the CPU DAI (dai->dev) - which can happen when the
> > > platform and CPU DAI are registered from the same platform_device, which
> > > you claim is legal with ASoC.
> > > 
> > > Now, look at snd_soc_dapm_new_dai_widgets():
> > > 
> > > int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
> > >                                  struct snd_soc_dai *dai)
> > > {
> > >         if (dai->driver->playback.stream_name) {
> > > ...
> > >                 dai->playback_widget = w;
> > >         }
> > >         if (dai->driver->capture.stream_name) {
> > > ...
> > >                 dai->capture_widget = w;
> > >         }
> > > 
> > > What happens if the widgets which are bound to are the first set that
> > > are created, but they're overwritten when the second set get created?
> > > (And that _does_ happen.)  The second set are the ones activated when
> > > the audio device is opened, not the first set.
> > > 
> > > Now, there's nothing new in the above, I've already explained all the
> > > above to you several times.  I've had nothing of any help what so ever
> > > back from you on this.  I've asked you how to solve this.  I've had
> > > absolutely nothing back.  So what am I supposed to do here?  Stuff
> > > doesn't work with the core code how it is, so I took the only solution
> > > _you_ left me by your silence, which is to hack the core code.
> > > 
> > 
> > It does seem that your configuration is different to the configurations
> > that work well on Haswell, OMAP4 and Qualcomm and that's probably why
> > you are the only person reporting this atm. I also think the tight
> > coupling between the I2S and SPDIF HW made your problem far more complex
> > and therefore more difficult (for me at least) to follow when the
> > signal to noise ratio of this and related threads started to
> > deteriorate.
> 
> Erm, you have completely the wrong end of the stick here.  This has
> nothing to do with I2S and SPDIF at all.
> 
> It's about having the _same_ struct device assocated with both the
> platform/DMA backend, registered by snd_soc_register_platform() and
> the CPU DAI registered via snd_soc_register_component().  SPDIF or
> I2S doesn't come into this bug.

I was trying to highlight that your HW is the only one with the shared
struct device and this iiuc was due to the tight coupling between I2s
and SPDIF.

Liam
