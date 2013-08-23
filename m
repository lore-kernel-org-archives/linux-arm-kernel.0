From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 23 Aug 2013 13:58:03 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <1377259994.2444.41.camel@loki>
References: <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
 <20130820201824.GA17845@n2100.arm.linux.org.uk>
 <1377199370.2618.99.camel@loki>
 <20130822201658.GK6617@n2100.arm.linux.org.uk>
 <1377259994.2444.41.camel@loki>
Message-ID: <20130823125803.GN6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 01:13:14PM +0100, Liam Girdwood wrote:
> On Thu, 2013-08-22 at 21:16 +0100, Russell King - ARM Linux wrote:
> > On Thu, Aug 22, 2013 at 08:22:50PM +0100, Liam Girdwood wrote:
> > > I'll fix this issue as I've replied privately, but you know it's not
> > > appropriate to just comment stuff out in core code (especially if you
> > > don't fully understand it). I'm sure you would complain loudly to me if
> > > I tried to do a similar HACK in the ARM core.
> > 
> > Hang on, tell me exactly *where* I've asked for the hack to be merged.  The
> > answer is: I haven't.  What I've been asking for all along is how this
> > should be solved, and getting nowhere - whether I ask in a reasonable and
> > calm manner or have to take it to extremes like I have done now.
> 
> You asked me privately to Ack the series so you could carry it in your
> own tree for upstreaming. Sorry if I misunderstood this request, but it
> seemed straightforward.

What I'm after are acks for those patches which are acceptable - which
I believe is the entire series with the exception of the HACK patch.

> > Erm, you have completely the wrong end of the stick here.  This has
> > nothing to do with I2S and SPDIF at all.
> > 
> > It's about having the _same_ struct device assocated with both the
> > platform/DMA backend, registered by snd_soc_register_platform() and
> > the CPU DAI registered via snd_soc_register_component().  SPDIF or
> > I2S doesn't come into this bug.
> 
> I was trying to highlight that your HW is the only one with the shared
> struct device and this iiuc was due to the tight coupling between I2s
> and SPDIF.

Not at all - the tight coupling of the DMA and the CPU DAI backend is
merely because there is no actual separation of those two items: the
DMA engine is tightly coupled with the audio interface itself.  They
both share the same register space, and they both make use of the same
iomapping created by kirkwood_i2s_dev_probe() in the current tree.

The split of the DMA backend from the CPU DAI backend is something
which early ASoC forced, but that has "mostly" been fixed with (as
far as I'm currently aware through testing) the problem I've been
trying to get addressed for the last month.  Moreover, the split is
undesirable when switching to device tree, and as all Marvell support
is moving to device tree, having the DMA and CPU DAI backends combined
(as Mark has told me several times is fully supported in ASoC) will be
required.

Bear in mind that ARM is no longer accepting new non-DT support for
Marvell stuff, so this is something which must be fixed if any new
Marvell platform is to be supported.
