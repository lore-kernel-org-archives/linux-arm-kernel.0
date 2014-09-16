From: b38343@freescale.com (Robin Gong)
Date: Tue, 16 Sep 2014 11:41:24 +0800
Subject: [PATCH v2] ARM: dts: imx6dl: disable dma support for spi on
 i.mx6dl
In-Reply-To: <1410774073.3314.1.camel@pengutronix.de>
References: <1410327012-31185-1-git-send-email-b38343@freescale.com>
 <1410774073.3314.1.camel@pengutronix.de>
Message-ID: <20140916034123.GA20800@Robin-OptiPlex-780>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,
  I understood your concern,but looks we have to break old DT. Our old DT
support SPI DMA on i.mx6q/dl(v2,b3810c3dc1bcbc6a), but the DMA support patch
for SPI driver is still in reviewing(v6). So the violation you mentioned comes
if someone use the DT during the time(from v2 to spi driver patch upstreamed).
  The different behaviors on different chips(only i.mxdl can't pass strength
test) are just found from last month, this is why I sent the patch for disable
SPI DMA support on i.mx6dl during I sent v6 patch for spi driver. I think that's
make sense, because DTs are also in development, new difference between different
chips maybe found in the future although they share the same IP....
  Yes, I can check cpu type by looking at DT in spi driver, but it's not nice.
So I'm afraid that we have to break the old DTs in the gap between the two
levels patch accepted cycle.

On Mon, Sep 15, 2014 at 11:41:13AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 10.09.2014, 13:30 +0800 schrieb Robin Gong:
> > There is one weird data in rxfifo after one full rx/tx transfer
> > done sometimes. It looks a design issue and hard to workaround
> > totally, so disable dma functhion here. And will re-enable it
> > once the root cause found.
> > 
> Sorry, I'm late to this as Shawn seems to already have picked up this
> patch, but this isn't the right way to fix the problem.
> 
> We made it clear at kernel summit last year that we try to not break
> existing DTs as booting a new kernel with an old DT is a valid use case.
> While you don't strictly violate this rule what you do here is only
> fixing systems booting with a new DT while leaving others broken.
> 
> If you are working around a hardware problem please disable DMA support
> in the driver. This will also allow you to enable it again, if you find
> another workaround without touching the DT again.
> 
> So this patch gets a NAK from me.
> 
> > Signed-off-by: Robin Gong <b38343@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q.dtsi   | 20 ++++++++++++++++++++
> >  arch/arm/boot/dts/imx6qdl.dtsi |  8 --------
> >  2 files changed, 20 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> > index e9f3646..8d5d33b 100644
> > --- a/arch/arm/boot/dts/imx6q.dtsi
> > +++ b/arch/arm/boot/dts/imx6q.dtsi
> > @@ -291,6 +291,26 @@
> >  	};
> >  };
> >  
> > +&ecspi1 {
> > +	dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
> > +	dma-names = "rx", "tx";
> > +};
> > +
> > +&ecspi2 {
> > +	dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
> > +	dma-names = "rx", "tx";
> > +};
> > +
> > +&ecspi3 {
> > +	dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
> > +	dma-names = "rx", "tx";
> > +};
> > +
> > +&ecspi4 {
> > +	dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
> > +	dma-names = "rx", "tx";
> > +};
> > +
> >  &mipi_dsi {
> >  	port at 2 {
> >  		reg = <2>;
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index 70d7207..f696546 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -210,8 +210,6 @@
> >  					clocks = <&clks IMX6QDL_CLK_ECSPI1>,
> >  						 <&clks IMX6QDL_CLK_ECSPI1>;
> >  					clock-names = "ipg", "per";
> > -					dmas = <&sdma 3 7 1>, <&sdma 4 7 2>;
> > -					dma-names = "rx", "tx";
> >  					status = "disabled";
> >  				};
> >  
> > @@ -224,8 +222,6 @@
> >  					clocks = <&clks IMX6QDL_CLK_ECSPI2>,
> >  						 <&clks IMX6QDL_CLK_ECSPI2>;
> >  					clock-names = "ipg", "per";
> > -					dmas = <&sdma 5 7 1>, <&sdma 6 7 2>;
> > -					dma-names = "rx", "tx";
> >  					status = "disabled";
> >  				};
> >  
> > @@ -238,8 +234,6 @@
> >  					clocks = <&clks IMX6QDL_CLK_ECSPI3>,
> >  						 <&clks IMX6QDL_CLK_ECSPI3>;
> >  					clock-names = "ipg", "per";
> > -					dmas = <&sdma 7 7 1>, <&sdma 8 7 2>;
> > -					dma-names = "rx", "tx";
> >  					status = "disabled";
> >  				};
> >  
> > @@ -252,8 +246,6 @@
> >  					clocks = <&clks IMX6QDL_CLK_ECSPI4>,
> >  						 <&clks IMX6QDL_CLK_ECSPI4>;
> >  					clock-names = "ipg", "per";
> > -					dmas = <&sdma 9 7 1>, <&sdma 10 7 2>;
> > -					dma-names = "rx", "tx";
> >  					status = "disabled";
> >  				};
> >  
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 
