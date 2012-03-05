From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 5 Mar 2012 17:03:18 +0000
Subject: [alsa-devel] [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
 <20120305131332.GM3224@opensource.wolfsonmicro.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
Message-ID: <20120305170317.GV3224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 08:55:22AM -0800, Stephen Warren wrote:
> Mark Brown wrote at Monday, March 05, 2012 6:14 AM:

> > The DMA and SSI drivers should have some relationship with each other if
> > they're the same piece of hardware.  The machine driver certainly
> > shouldn't be creating either of them.

> Note that in Tegra's case, the DMA HW and the DAI (I2S/SPDIF) HW are
> entirely separate HW blocks and have entirely separate drivers. The DMA
> engine is generic and not audio specific, so has a node that instantiates
> just a standalone DMA device which has its own API. This doesn't
> instantiate any kind of ALSA PCM driver. It doesn't make sense to have a

In this case (and probably in the i.MX case, at a guess the structure is
the same) I'd just have the DAI drivers kick off registration of the
ASoC DMA stuff, it's all part of the ASoC driver for the hardware really.

> DT node to instantiate the ALSA PCM driver since the PCM driver is more
> of an API bridge to the real DMA HW, and certainly not an actual HW

Yes, and a Linux driver model device is questionable too.

> Perhaps our regular DMA module driver should expose both its custom
> interface for other clients, and register an ASoC PCM driver? That way
> we could remove the PCM device registration from the ASoC machine
> drivers.

That's another option, do it from the DMA driver instead of the DAI
driver.  My main concern here is that it shouldn't be the machine driver
as it's all internal to the CPU and not machine specific.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120305/0af2901c/attachment.sig>
