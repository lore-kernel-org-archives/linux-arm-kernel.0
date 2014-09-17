From: b38343@freescale.com (Robin Gong)
Date: Wed, 17 Sep 2014 17:28:25 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410945574.2731.3.camel@pengutronix.de>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <1410774073.3314.1.camel@pengutronix.de>
 <20140916034123.GA20800@Robin-OptiPlex-780>
 <1410861006.2746.1.camel@pengutronix.de>
 <20140917084120.GA6369@Robin-OptiPlex-780>
 <1410944156.2731.1.camel@pengutronix.de>
 <20140917091922.GA6551@Robin-OptiPlex-780>
 <1410945574.2731.3.camel@pengutronix.de>
Message-ID: <20140917092823.GB6551@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 11:19:34AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 17.09.2014, 17:19 +0800 schrieb Robin Gong:
> > On Wed, Sep 17, 2014 at 10:55:56AM +0200, Lucas Stach wrote:
> > > Am Mittwoch, den 17.09.2014, 16:41 +0800 schrieb Robin Gong:
> > > > On Tue, Sep 16, 2014 at 11:50:06AM +0200, Lucas Stach wrote:
> > > > > Hi Robin,
> > > > > 
> > > > > Am Dienstag, den 16.09.2014, 11:41 +0800 schrieb Robin Gong:
> > > > > > Hi Lucas,
> > > > > >   I understood your concern,but looks we have to break old DT.
> > > > > 
> > > > > Sorry, but this isn't going to happen. And honestly I don't even see the
> > > > > need to do so.
> > > > > 
> > > > > > Our old DT
> > > > > > support SPI DMA on i.mx6q/dl(v2,b3810c3dc1bcbc6a), but the DMA support patch
> > > > > > for SPI driver is still in reviewing(v6).
> > > > > 
> > > > > So this means now is the time to fix this driver patch to not enable DMA
> > > > > on imx6dl. Nobody will experience any breakage in this case.
> > > > >
> > > > Sorry, i.mx6q and i.mx6dl are totally same, not only IP but also clock. So we
> > > > can't distinguish them except for different compatible name....
> > > 
> > > I know that, but I still don't see the problem.
> > > 
> > > If this issue is specific to the ECSPI IP integrated into a imx6dl SoC
> > > you need to check for the machine compatible in the driver and disable
> > > DMA support based on this. We generally avoid checking for the machine
> > > compatible in drivers and prefer to have a specific IP block compatible
> > > instead, but in that case it's the only reasonable thing to do.
> > > 
> > > Regards,
> > > Lucas
> > Sounds we make a agreement on use different compatible name, right? I will
> > make patch for reviewing, thanks.
> 
> No you can't use a new compatible name for the IP block, as this again
> would only fix things for users with new devicetrees. Also this has
> nothing to do with the IP block, but is an integration issue between
> ECPSI and imx6dl.
> 
> So what you need to do is something like this in the ecspi kernel
> driver:
> 
> if (of_machine_is_compatible("fsl,imx6dl") {
>     do_whatever_is_necessary_to_make_sure_DMA_is_not_enabled();
> }
> 
> Regards,
> Lucas
Sure, the ecspi kernel driver must check the new compatible name for i.mx6dl.
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
