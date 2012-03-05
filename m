From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Mar 2012 21:07:09 +0800
Subject: [PATCH 20/20] ASoC: fsl: add imx-sgtl5000 machine driver
In-Reply-To: <20120305115612.GB3224@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-21-git-send-email-shawn.guo@linaro.org>
 <20120304133818.GE3083@opensource.wolfsonmicro.com>
 <20120305080623.GD16232@S2101-09.ap.freescale.net>
 <20120305115612.GB3224@opensource.wolfsonmicro.com>
Message-ID: <20120305130707.GF16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 11:56:12AM +0000, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 04:06:25PM +0800, Shawn Guo wrote:
> > On Sun, Mar 04, 2012 at 01:38:18PM +0000, Mark Brown wrote:
> 
> > > This looks like there's a problem with the bindings, why are you
> > > registering the DMA device from the card?
> 
> > There is a dma node in the device tree to instantiate the dma device
> > backed by a dmaengine driver.  As a client peripheral of that dmaengine
> > device, the SSI owns just a dma request/event number.  With the number
> > encoded in SSI node, there is no hardware resource to be claimed by
> > that pcm-device, so we do not have it in device tree.  Then we have
> > to register this device in either fsl_ssi driver or machine driver.
> > I chose to do something that tegra is doing, registering the pcm device
> > in machine driver, to keep fsl_ssi away from imx specific bits as much
> > as possible.
> 
> The above sounds like you have a unified DAI and PCM driver.

The pcm-dma driver is being shared across several i.MX SoCs, and we
are trying to reuse fsl_ssi driver between PowerPC and IMX.

> In that
> case they should either both be using the same device or should have
> some sort of parent/child/sibling relationship.

Sorry, I do not understand it.  Can you elaborate it a little bit?

> Either way the machine
> driver really shouldn't be involved in instantiating things, perhaps
> arch/arm but not the audio machine driver.

So you are saying neither what tegra_wm8903 and tegra_alc5632 are doing
(registering pcm device in machine driver) nor what imx-ssi is doing
(registering pcm device in DAI driver) is correct?  Can you please make
it clear what's the right thing to do?

-- 
Regards,
Shawn
