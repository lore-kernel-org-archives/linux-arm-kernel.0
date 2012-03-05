From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 5 Mar 2012 08:55:22 -0800
Subject: [alsa-devel] [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine
 driver
In-Reply-To: <20120305131332.GM3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
 <20120305130707.GF16232@S2101-09.ap.freescale.net>
 <20120305131332.GM3224@opensource.wolfsonmicro.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BE861C14@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote at Monday, March 05, 2012 6:14 AM:
> On Mon, Mar 05, 2012 at 09:07:09PM +0800, Shawn Guo wrote:
> > On Mon, Mar 05, 2012 at 11:56:12AM +0000, Mark Brown wrote:
> 
> > > In that
> > > case they should either both be using the same device or should have
> > > some sort of parent/child/sibling relationship.
> 
> > Sorry, I do not understand it.  Can you elaborate it a little bit?
> 
> The DMA and SSI drivers should have some relationship with each other if
> they're the same piece of hardware.  The machine driver certainly
> shouldn't be creating either of them.

Note that in Tegra's case, the DMA HW and the DAI (I2S/SPDIF) HW are
entirely separate HW blocks and have entirely separate drivers. The DMA
engine is generic and not audio specific, so has a node that instantiates
just a standalone DMA device which has its own API. This doesn't
instantiate any kind of ALSA PCM driver. It doesn't make sense to have a
DT node to instantiate the ALSA PCM driver since the PCM driver is more
of an API bridge to the real DMA HW, and certainly not an actual HW
module. It doesn't make sense to have either the I2S or SPDIF DAI drivers
instantiate the PCM driver, since they both share the same one. Hence,
the machine driver instantiates the PCM driver.

Perhaps our regular DMA module driver should expose both its custom
interface for other clients, and register an ASoC PCM driver? That way
we could remove the PCM device registration from the ASoC machine
drivers.

> > > Either way the machine
> > > driver really shouldn't be involved in instantiating things, perhaps
> > > arch/arm but not the audio machine driver.
> 
> > So you are saying neither what tegra_wm8903 and tegra_alc5632 are doing
> > (registering pcm device in machine driver) nor what imx-ssi is doing
> > (registering pcm device in DAI driver) is correct?  Can you please make
> > it clear what's the right thing to do?
> 
> The above.

-- 
nvpublic
