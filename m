From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 13:13:57 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
Message-ID: <20130927121357.GY12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 08:25:49PM -0300, Fabio Estevam wrote:
> On Thu, Sep 26, 2013 at 5:59 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > Here's Rabeeh's preliminary patches against Freescale's 3.0.35 BSP 4.1.0
> > kernel:
> >
> > http://download.solid-run.com/pub/solidrun/c1/kernel/initial/
> 
> Ok, that helps. I assume they are using the AR8035 in RGMII mode.

It appears so.

> We also need to provide the AR8035 reset (GPIO4_15, but could not see
> from their code which pad that corresponds to) via 'phy-reset-gpios'
> in the dts file.

Okay, I've added this fixup function:

static int ar8035_phy_fixup(struct phy_device *dev)
{
	u16 val;
printk("ar8035 found\n");
	/* Ar803x phy SmartEEE feature cause link status generates glitch,
	 * which cause ethernet link down/up issue, so disable SmartEEE
	 */
	phy_write(dev, 0xd, 0x3);
	phy_write(dev, 0xe, 0x805d);
	phy_write(dev, 0xd, 0x4003);

	val = phy_read(dev, 0xe);
	phy_write(dev, 0xe, val & ~(1 << 8));

	/* To enable AR8031 output a 125MHz clk from CLK_25M */
	phy_write(dev, 0xd, 0x7);
	phy_write(dev, 0xe, 0x8016);
	phy_write(dev, 0xd, 0x4007);

	val = phy_read(dev, 0xe);
	val &= 0xffe3;
	val |= 0x18;
	phy_write(dev, 0xe, val);

	/* introduce tx clock delay */
	phy_write(dev, 0x1d, 0x5);
	val = phy_read(dev, 0x1e);
	val |= 0x0100;
	phy_write(dev, 0x1e, val);

	/*check phy power*/
	val = phy_read(dev, 0x0);
	if (val & BMCR_PDOWN)
		phy_write(dev, 0x0, val & ~BMCR_PDOWN);

	return 0;
}

#define PHY_ID_AR8035 0x004dd072

static void __init imx6q_enet_phy_init(void)
{
	if (IS_BUILTIN(CONFIG_PHYLIB)) {
...
		phy_register_fixup_for_uid(PHY_ID_AR8035, 0xffffffef,
				ar8035_phy_fixup);
	}
}

and in the dts file:

&iomuxc {
	enet {
		pinctrl_enet_1_cuboxi: enetgrp-4 {
			fsl,pins = <
				MX6QDL_PAD_ENET_MDIO__ENET_MDIO 	0x1b0b0
				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 	0x130b0
				MX6QDL_PAD_DI0_PIN2__GPIO4_IO18 	0x80000000
				/* RMII */
				MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x03000
				MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x03000
				MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x03000
				MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x80000000
				MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x80000000
				MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x80000000
				//MX6QDL_PAD_GPIO_16__ENET_REF_CLK               Output on AR8035
				MX6QDL_PAD_RGMII_TXC__RGMII_TXC 	0x1b0b0
				MX6QDL_PAD_RGMII_TD0__RGMII_TD0 	0x1b0b0
				MX6QDL_PAD_RGMII_TD1__RGMII_TD1 	0x1b0b0
				MX6QDL_PAD_RGMII_TD2__RGMII_TD2 	0x1b0b0
				MX6QDL_PAD_RGMII_TD3__RGMII_TD3 	0x1b0b0
				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
				MX6QDL_PAD_RGMII_RXC__RGMII_RXC 	0x1b0b0
				MX6QDL_PAD_RGMII_RD0__RGMII_RD0 	0x130b0
				MX6QDL_PAD_RGMII_RD1__RGMII_RD1 	0x130b0
				/* In RGMII mode RD2 should be '1' to disable the PLL OFF mode */
				MX6QDL_PAD_RGMII_RD2__RGMII_RD2 	0x130b0
				MX6QDL_PAD_RGMII_RD3__RGMII_RD3 	0x130b0
				/* In RGMII mode RX_DV should be pulled down for reset strap */
				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x130b0
			>;
		};
	};
};

&fec {
	pintctrl-names = "default";
	pinctrl-0 = <&pinctrl_enet_1_cuboxi>;
	phy-mode = "rgmii";
	phy-reset-duration = <2>;
	phy-reset-gpios = <&gpio4 15 0>;
	status = "okay";
};

I get my "ar8035 found" so the fixup is working fine.  I also see the
ethernet link ok lamp go out and come back on, so I think the reset is
working.  However, I see no traffic from it - I'm booting with ip=dhcp
as the test at the moment.

I notice Rabeeh also does this:

+       imx6q_add_anatop_thermal_imx(1, &mx6q_c1_anatop_thermal_data);
+       /* Set GPR1, bit 21 to 1 */
+       mxc_iomux_set_gpr_register(1, 21, 1, 1);

Bit 21 appears to be IMX6Q_GPR1_ENET_CLK_SEL_MASK /
IMX6Q_GPR1_ENET_CLK_SEL_ANATOP, which I see imx6q_1588_init() is doing.
This happens some time before the phy fixup function is called, so I
think that's covered.

There's also this which follows the above:

+       /* Set enet clock to 50MHz RMII */
+       enet = clk_get_sys("enet.0", NULL);
+       if (IS_ERR(enet))
+               pr_err("Unable to get enet.0 clock\n");
+       else {
+               clk_prepare(enet);
+               clk_set_rate(enet, 50000000);
+               clk_enable(enet);
+       }

I'm not sure at the moment which clock that refers to, or whether that's
necessary only for the AR8030 (which is used in RMII mode).  The enable
bit seems to be CCM_CCGR1 CG5_OFFSET.  Even when I work out how that
relates to the mass of clock initialisations in
arch/arm/mach-imx/clk-imx6q.c, it's virtually impossible to translate
that into a DT <&clks N> representation because of this:

enum mx6q_clks {
        dummy, ckil, ckih, osc, pll2_pfd0_352m, pll2_pfd1_594m, pll2_pfd2_396m,
        pll3_pfd0_720m, pll3_pfd1_540m, pll3_pfd2_508m, pll3_pfd3_454m,
        pll2_198m, pll3_120m, pll3_80m, pll3_60m, twd, step, pll1_sw,
        periph_pre, periph2_pre, periph_clk2_sel, periph2_clk2_sel, axi_sel,

Is this sane?  Is it sane to expect people to sit and count these fscking
things?  No.  Add some comments, mark every 10 or so, or something like
that.  How this is at the moment, it's completely inpenetrable.

Given this, I'd much rather write board support in C rather than use this
disgusting DT crap which just seems to be designed to make it extremely
difficult to bring boards up.  I'm beginning to believe that DT is a
means to lock-in people to various vendors who understand this junk.
