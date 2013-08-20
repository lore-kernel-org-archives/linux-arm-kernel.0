From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 21:18:24 +0100
Subject: [alsa-devel] [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM
 links between codec and cpu DAI
In-Reply-To: <20130820185019.GP30073@sirena.org.uk>
References: <20130810161123.GW23006@n2100.arm.linux.org.uk>
 <20130810211342.GX23006@n2100.arm.linux.org.uk>
 <1376293215.2385.32.camel@loki>
 <20130812082837.GB23006@n2100.arm.linux.org.uk>
 <1376405952.2617.101.camel@loki>
 <20130820102555.GZ23006@n2100.arm.linux.org.uk>
 <20130820114421.GN30073@sirena.org.uk>
 <20130820114949.GB23006@n2100.arm.linux.org.uk>
 <20130820133143.GC23006@n2100.arm.linux.org.uk>
 <20130820185019.GP30073@sirena.org.uk>
Message-ID: <20130820201824.GA17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 07:50:19PM +0100, Mark Brown wrote:
> On Tue, Aug 20, 2013 at 02:31:43PM +0100, Russell King - ARM Linux wrote:
> 
> > Let's be a little more clear about that: I don't know how to do that
> > because that's the approach taken by _these_ very patches which you've
> > rejected for "abusing the ASoC core".  That's why I'm asking Liam
> 
> The patches I can recall seeing recently have all had some workarounds
> in the core which would need to be resolved differently, though it's
> possible I missed that being done in some version in your mails as there
> have generally also been a lot of modifications adding debug statements
> in the core.

The "workarounds in the core" are because there's bugs in the core that
I have no idea how to solve.  You are allegedly the maintainer for the
core code, and so you should understand that code, so you are best placed
to say how the core code should be fixed.  I'm willing to do the patch
generation to fix them but *you* need to give some guidance here -
something that you seem incapable to do.  At the moment, the only fix I
can see being workable is to comment out the broken bit in the core code.

If the problem is that you don't understand the issue, then you could try
replying with some questions about it.

If the problem is that you don't understand the code, well... there's not
much point in continuing this discussion until you've had time to study
and understand that code.

> If you've got code you think is in a good state to submit then please do
> send it as a normal patch series, the last one I've got here has "ASoC:
> HACK: avoid creating duplicated widgets" as part of it for example.

That patch still hasn't gone away, and is still required, because there
has been no guidance or comments about the problem.  Let's explain it
yet again...

You have said "there is no problem registering the platform and the CPU
dai from the same device structure".  Let's assume that's a fact and see
what happens in the core code:

static int soc_probe_platform(struct snd_soc_card *card,
                           struct snd_soc_platform *platform)
{
        /* Create DAPM widgets for each DAI stream */
        list_for_each_entry(dai, &dai_list, list) {
                if (dai->dev != platform->dev)
                        continue;

                snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
        }
}

static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
{
        if (!cpu_dai->probed &&
                        cpu_dai->driver->probe_order == order) {
                if (!cpu_dai->codec) {
                        cpu_dai->dapm.card = card;
                        if (!try_module_get(cpu_dai->dev->driver->owner))
                                return -ENODEV;

                        list_add(&cpu_dai->dapm.list, &card->dapm_list);
                        snd_soc_dapm_new_dai_widgets(&cpu_dai->dapm, cpu_dai);
                }

Now, the CPU DAI is added to the dai_list (it has to be there to be found
so the DAI link can bind it, and so soc_probe_link_dais() can be called.)

Think about what happens with the above code if platform->dev is the same
as the device used for the CPU DAI (dai->dev) - which can happen when the
platform and CPU DAI are registered from the same platform_device, which
you claim is legal with ASoC.

Now, look at snd_soc_dapm_new_dai_widgets():

int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
                                 struct snd_soc_dai *dai)
{
        if (dai->driver->playback.stream_name) {
...
                dai->playback_widget = w;
        }
        if (dai->driver->capture.stream_name) {
...
                dai->capture_widget = w;
        }

What happens if the widgets which are bound to are the first set that
are created, but they're overwritten when the second set get created?
(And that _does_ happen.)  The second set are the ones activated when
the audio device is opened, not the first set.

Now, there's nothing new in the above, I've already explained all the
above to you several times.  I've had nothing of any help what so ever
back from you on this.  I've asked you how to solve this.  I've had
absolutely nothing back.  So what am I supposed to do here?  Stuff
doesn't work with the core code how it is, so I took the only solution
_you_ left me by your silence, which is to hack the core code.

At this point, you leave me with no other conclusion but to assume
that the reason you are being so unhelpful is that you don't understand
this code, and that you don't know what the right solution is.  I dare
you to tell me I'm wrong: and the only thing that will convince me that
I'm wrong is if you tell me how you'd like the above issue to be solved.

> Just to be clear when I say either/or I'm talking about a DAI driver
> that can either run in S/PDIF mode or run in I2S mode in a given machine
> but not support both being hooked up in the same machine.  Obviously
> this isn't the end goal but it might be a useful intermediate step if
> you find you are are blocked. 

Well, it doesn't take much to realise that the CPU DAI needs to know
whether the _single_ attached codec is SPDIF or I2S.  How it does that
is via which AIFs are bound - and as DPCM doesn't work at the moment,
you can only do that by having _one_ DAI link specified, and DAPM
routes between the AIFs and the codecs streams.

If you know a better way, you could try saying what that is, because
at the moment what I've presented in these patches is the best that I
can do with the limited knowledge of ASoC.

I'm not going to litter the driver with #ifdef's to work around this
when there's a perfectly good way to work around it at runtime - which
I've proven can work if the core code issue I point out above gets fixed.

> > Since you continue to refuse to take the patches, but haven't given any
> > further reasons why, and I've shown your original objections to be
> > provably false, you leave me no other options but to try and bypass
> 
> To reiterate please submit patches if you believe everything is OK now
> and then let's go through and review them.

You mean like your poor review attempt on the first round where you
completely ignored the issue with the core code (the HACK patch)?

You mean like your poor review stating that the DAPM infrastructure I
added in the CPU level code was all wrong, but it turns out that it's
exactly the same as Liam's DPCM setup.

Why should I submit a new round of patches which haven't changed in any
meaningful way (which I've already stated) for another review by someone
who seems not to know what they're talking about?  Can't you go back and
look at the existing set again and provide a better quality of review,
maybe providing some suggestions on the core issue which I keep pointing
out?

This is precisely why I've called for Liam to look at them instead; I
feel that I will get a much better quality of review from Liam, and
maybe even some helpful suggestions about how to solve some of the
remaining issues - something which has been totally lacking in every
response from you.

> > you, especially when you have plainly stated that you don't care about
> > Kirkwood stuff.
> 
> I think you'll find that anything I've said along those lines has been
> in relation to your strongly worded requests for me to make changes for
> you.

No, my strongly worded emails are directed at you not to ask you to make
changes for me, but because you are being obstructive, uncooperative,
and unhelpful.  Apart from "use DPCM" and "DAPM is just a graph walk"
I've had nothing of any real use what so ever back from you.  Much of
my effort has been based around my own interpretations and debugging of
the ASoC code inspite of you, which may or may not be correct.

However, one thing I do know is that I've pointed out the bug above
multiple times to you and there's still no movement on it - which
just confirms my conclusion that you are just being plain obstructive.
