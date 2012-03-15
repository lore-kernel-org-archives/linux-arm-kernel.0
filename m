From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 14:27:03 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F612319.50302@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
Message-ID: <20120315142702.GL3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 06:00:41PM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> So using imx-audio-sgtl5000.txt as an example, you're saying that if I
> have two SSIs, I should do this in my device tree:

> sound1 {
> };

> sound2 {
> };

That's a totally sensible option if you've got two unrelated audio
subsystems on your board for some reason.  If you've got a system where
that's not applicable and the two devices are related in some way then
you'd define a new sound card binding that reflects that.

> >>> The biggest improvement is that the SoC binding knows nothing about the
> >>> card binding at all, cards are completely separate and are free to
> >>> define any binding they choose using any number of on-SoC and off-SoC
> >>> devices.

> >> Ok, I don't understand that at all.

> > Do you have some questions about the above?  What is it that you find
> > unclear?   

> What's the difference between an "SoC binding" and a "card binding"?

The SoC is the bit of silicon with the CPU and other devices on it like
the DMA controller and SSI or whatever ports.  The card is the PCB this
has been soldered down onto.

> > We've been through this *repeatedly*, including in the message you're
> > replying to, and we're still going back to square one every time you
> > decide to start talking about device tree again.  This is frustrating
> > in the extreme.

> I'm sorry you're frustrated, but so am I.  I still don't understand why
> the binding that I invented for the SSI driver isn't good enough for i.MX.
>  The binding and the code was documented and approved a long time ago.
> Why can't we keep the same binding on i.MX, to keep the code simpler?

The problem with your binding has always been, and continues to be, that
it's based on the idea that there's one CODEC per SSI and that the CODEC
is a simple appendage of that SSI.  There's no real real binding for the
machine driver, it's just silently created by a single SSI port.  Really
there's nothing new with this issue, there's always been this absence of
a representation for the machine distinct from the individual devices it
is built up from.

This means that when you get systems which have auxiliary devices (like
most of the Wolfson reference boards which have a power amplifier for
the sub speaker not connected to an SSI port) or that need to set up
things like complex accessory detection mechanisms there's no real place
in your binding to support those systems.  Things like the configuration
of the input and output connections which the nVidia WM8903 drivers are
able to do over multiple boards are another example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/5a7763df/attachment.sig>
