From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 06 Aug 2015 10:11:30 +0200
Subject: [PATCH] ARM: imx6: correct i.MX6 PCIe interrupt routing
In-Reply-To: <20150806012832.GP12927@tiger>
References: <1438793677-19153-1-git-send-email-l.stach@pengutronix.de>
 <20150806012832.GP12927@tiger>
Message-ID: <1438848690.24317.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 06.08.2015, 09:28 +0800 schrieb Shawn Guo:
> On Wed, Aug 05, 2015 at 06:54:37PM +0200, Lucas Stach wrote:
> > The PCIe interrupts are also routed through the GPC. This has been
> > missed from the conversion to stacked IRQ domains as the PCIe
> > controller uses an explicit interrupt map and thus doesn't inherit
> > the SoC global interrupt parent.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> So this is a fix and need copy stable?
> 
I'm a bit on the fence with this. It only fixes PCIe wake-up and I'm not
aware of anyone using this functionality and haven't seen any bug
reports yet.

On the other hand it is a clear fix and has practically zero chances for
regressions, so yes please add stable 4.0+ to this.

Thanks,
Lucas

> Shawn
> 
> > ---
> > This commit does not change the i.MX6SX PCIe node, as PCIe isn't
> > functional in mainline on this SoC and the DT node needs a major
> > rewrite to account for the specifics of this SoC anyway.
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index e6d13592080d..b57033e8c633 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -181,10 +181,10 @@
> >  			interrupt-names = "msi";
> >  			#interrupt-cells = <1>;
> >  			interrupt-map-mask = <0 0 0 0x7>;
> > -			interrupt-map = <0 0 0 1 &intc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > -			                <0 0 0 2 &intc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > -			                <0 0 0 3 &intc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> > -			                <0 0 0 4 &intc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> > +			interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
> > +			                <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
> >  				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
> >  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > -- 
> > 2.4.6
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
