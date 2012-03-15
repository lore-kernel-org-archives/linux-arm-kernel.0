From: b04825@freescale.com (Timur Tabi)
Date: Thu, 15 Mar 2012 11:44:16 -0500
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120315142702.GL3138@opensource.wolfsonmicro.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
 <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
 <4F591B8D.8090705@freescale.com>
 <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
Message-ID: <4F621C60.5090700@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> On Wed, Mar 14, 2012 at 06:00:41PM -0500, Timur Tabi wrote:
>> Mark Brown wrote:
> 
>> So using imx-audio-sgtl5000.txt as an example, you're saying that if I
>> have two SSIs, I should do this in my device tree:
> 
>> sound1 {
>> };
> 
>> sound2 {
>> };
> 
> That's a totally sensible option if you've got two unrelated audio
> subsystems on your board for some reason.  If you've got a system where
> that's not applicable and the two devices are related in some way then
> you'd define a new sound card binding that reflects that.

Well, the two SSIs are related only in that they're the same kind of
device.  But SSI1 connected to CS4270_1 is completely independent from
SSI2 connected to CS4270_2.

So I guess that means that we'd have two soundX {} top-level nodes.

> The SoC is the bit of silicon with the CPU and other devices on it like
> the DMA controller and SSI or whatever ports.  The card is the PCB this
> has been soldered down onto.

Well, I asked about the difference between the soc BINDING and the card
BINDING.  On PowerPC, at least, there's no distinct binding for either.
For example, I2C devices are on the PCB, but they're listed as child nodes
of the I2C controller, which is on the SoC.

> The problem with your binding has always been, and continues to be, that
> it's based on the idea that there's one CODEC per SSI and that the CODEC
> is a simple appendage of that SSI.  There's no real real binding for the
> machine driver, it's just silently created by a single SSI port.  Really
> there's nothing new with this issue, there's always been this absence of
> a representation for the machine distinct from the individual devices it
> is built up from.
> 
> This means that when you get systems which have auxiliary devices (like
> most of the Wolfson reference boards which have a power amplifier for
> the sub speaker not connected to an SSI port) or that need to set up
> things like complex accessory detection mechanisms there's no real place
> in your binding to support those systems.  Things like the configuration
> of the input and output connections which the nVidia WM8903 drivers are
> able to do over multiple boards are another example.

Ok, fair enough.  I understand that my binding has no way of specifying
board-specific properties, or anything that isn't directly related to the
SSI, codec, or DMA controller.

However, I don't like the way this is being represented as a PowerPC vs.
ARM issue, because that's just not correct.  It's an "old binding" vs "new
binding" issue.  For example:

+	/*
+	 * In case of imx, the machine driver uses new binding which does
+	 * not require SSI driver to trigger machine driver's probe, but
+	 * the pcm device needs to be registered here.
+	 */
+	if (ssi_private->ssi_on_imx) {
+		ssi_private->imx_pcm_pdev =
+			platform_device_register_simple("imx-pcm-audio",

This prohibits me from using the new binding on any future PowerPC parts,
because it clearly says "iMX" on everything.
-- 
Timur Tabi
Linux kernel developer at Freescale
