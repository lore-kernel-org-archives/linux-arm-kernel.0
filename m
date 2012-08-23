From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 23 Aug 2012 10:22:17 +0100
Subject: [PATCH 07/22] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <006d01cd7f5a$65937840$30ba68c0$@se>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <002801cd7c31$14d3d0c0$3e7b7240$@se>
 <20120820085111.GJ8450@gmail.com>
 <006d01cd7f5a$65937840$30ba68c0$@se>
Message-ID: <20120823092216.GA27264@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

> > > I'm sorry but this patch is breaking the design of ASoC.
> > > The ASoC-platform is the DMA-block (in combination with the
> > > MSP-block), and there should be a platform-driver for the DMA/PCM.
> > > The
> > > platform-driver then has a DAI which is the MSP. The ASoC
> > > DAI-link-struct should have one driver for each of these, so the
> > > dummy-driver for PCM should be there.
> > 
> > Just thinking about this now. I converted it to the current format at
> > the request of Mark. If this isn't the correct method I'm not quite
> > sure what is. If you want it to be registered as a device, then it
> > needs to go into the Device Tree, but Mark doesn't want it in there
> > because it doesn't actually represent hardware.

I've just taken a closer look at this with a view to finding the most
suitable solution. My conclusion is that although the PCM doesn't
contain any registers, or represent hardware it should be a device and
therefore be present in the Device Tree.

These are my findings:

PCM devices already represented in DTs:
  fsl,mpc5200-pcm - written by Grant Likely, the author of Device Tree
  phytec,pcm030   - written by Grant Likely, the author of Device Tree

PCM devices which register as actual devices (should be in DT):
  samsung  - samsung-pcm
  sh       - siu-pcm-audio
  omap     - omap-pcm-audio
  pxa      - pxa-pcm-audio
  jz4740   - jz4740-pcm-audio
  kirkwood - kirkwood-pcm-audio
  ep93xx   - ep93xx-pcm-audio
  ...

The later was basically every PCM device bar one I think.

The Open Firmware used to stipulate that each device represented in
the Device Tree to own registers and therefore be an actual hardware
device, but that has since been lifted as it didn't make sense.

I propose to represent the PCM in the Device Tree again and have it
probe just like all the other PCM devices in sound/soc.

If you give me the nod, I'll revert this patch, enable the PCM for DT
again and resent the patch-set in full.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
