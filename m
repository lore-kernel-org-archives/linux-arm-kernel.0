From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 6 Feb 2014 13:18:19 +0800
Subject: imx6dl/imx6q fec rmii mode with external ref_clk
In-Reply-To: <20140129095429.GA30854@frolo.macqel>
References: <20140114153012.GA22550@frolo.macqel>
 <20140115073536.GD1914@S2101-09.ap.freescale.net>
 <20140129095429.GA30854@frolo.macqel>
Message-ID: <20140206051817.GB3708@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 10:54:29AM +0100, Philippe De Muyter wrote:
> > diff --git a/arch/arm/mach-imx/mach-imx6q.c
> > b/arch/arm/mach-imx/mach-imx6q.c
> > index e51e3da..be8d074 100644
> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -188,7 +188,7 @@ static void __init imx6q_1588_init(void)
> >         if (!IS_ERR(gpr))
> >                 regmap_update_bits(gpr, IOMUXC_GPR1,
> >                                 IMX6Q_GPR1_ENET_CLK_SEL_MASK,
> > -                               IMX6Q_GPR1_ENET_CLK_SEL_ANATOP);
> > +                               0);
> >         else
> >                 pr_err("failed to find fsl,imx6q-iomux-gpr regmap\n");
> > 
> 
> Yes, it works now.  Thanks.  Is that configurable from the device tree ?

Yes, with some code change, I think that's configurable from device
tree.  But, it's not that simple.  As I explained in thread [1], the
RMII reference clock ENET_REF_CLK from pad GPIO_16 will also be used
by PTP (IEEE 1588) as sampling clock in your configuration.  Right now,
the ptp clock in fec node is defaulted to be enet_ref from IMX6 CCM
(id 190) in imx6qdl.dtsi.  You will need to correct it in your board dts
file, something like the following.

clocks {
	#address-cells = <1>;
	#size-cells = <0>;

	rmii_clk: clock at 0 {
		compatible = "fixed-clock";
		reg = <0>;
		#clock-cells = <0>;
		clock-frequency = <25000000>;  /* 25MHz for example */
	};
};

&fec {
	clocks = <&clks 117>, <&clks 117>, <&rmii_clk>;
};

I think we can even save a device tree property and ask kernel to figure
it out that bit GPR1[21] should be set or cleared.  Yes, kernel should
be able to do that by checking whether the ptp_clk in fec node points to
the enet_ref clock coming from IMX6 clock driver (ANATOP/CCM).  I will
send a patch for this soon.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/269265/focus=269646
