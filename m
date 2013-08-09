From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Aug 2013 10:43:40 +0100
Subject: [PATCH v4 1/1] ASoc: kirkwood: add DT support to the mvebu
 audio subsystem
In-Reply-To: <5204B7A6.9050907@gmail.com>
References: <20130808132201.2610aef3@armhf> <5204A716.6070507@gmail.com>
 <20130809091953.GO6427@sirena.org.uk> <5204B7A6.9050907@gmail.com>
Message-ID: <20130809094340.GO23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 11:34:30AM +0200, Sebastian Hesselbarth wrote:
> Mark,
>
> I do understand there may be SoCs requiring sophisticated extra audio
> nodes, but Marvell SoCs don't. I prefer having a single node for the
> i2s controller *and* exploit the audio subsystem properties from that.
>
> For Marvell audio, we only need a single node for all three ASoC
> drivers. No other subsystem _requires_ you to have extra nodes for
> it's needs. If you can provide interrupts, just have an interrupt-
> controller property. If you can provide clocks, you can link to that
> very node - no virtual device node required. Even for media they
> do not insist on a virtual node but they do have generic properties
> you can exploit.

Certainly from the "DT is a hardware description" you are completely
correct.  The audio controller _should_ link directly to the codec,
because that's how the hardware is wired.  Remember though that there
are two outputs from the audio controller (please, call it audio
controller, not I2S controller) so you need to specify which of those
two outputs the "codec" is connected to.

I would say that's required irrespective of whether or not we have a
virtual node to aggregate the stuff together for ASoC's purposes (which
should not be part of the DT hardware description - it can be part of
the "software" configuration though.)

We may be able to have kirkwood-i2s.c (which I plan to rename to
mvebu-audio.c) automatically generate the snd_soc_card stuff from the
audio controller node.  Given that we need a more complex description
than the "simple" thing for DPCM, that might be overall the best
solution in any case (maybe calling out to a library which can be
shared between CPU DAI drivers to do this.)

Note that we do have another case not yet in tree, which is DRM, but
this case is different from that, because ASoC can cope with components
with independent initialisation.
