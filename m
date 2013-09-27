From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 16:19:00 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20130927132601.GL25146@S2101-09.ap.freescale.net>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
 <20130926205906.GT12758@n2100.arm.linux.org.uk>
 <CAOMZO5Dj7o3qBH2hzPFWjepgpt5XR5qKmQorKS6jH_7=gnY5cg@mail.gmail.com>
 <20130927121357.GY12758@n2100.arm.linux.org.uk>
 <20130927132601.GL25146@S2101-09.ap.freescale.net>
Message-ID: <20130927151900.GA12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:26:02PM +0800, Shawn Guo wrote:
> On Fri, Sep 27, 2013 at 01:13:57PM +0100, Russell King - ARM Linux wrote:
> > There's also this which follows the above:
> > 
> > +       /* Set enet clock to 50MHz RMII */
> > +       enet = clk_get_sys("enet.0", NULL);
> > +       if (IS_ERR(enet))
> > +               pr_err("Unable to get enet.0 clock\n");
> 
> I can not find clock lookup for "enet.0" in FSL 3.0.35 BSP 4.1.0, so
> I'm not sure how this works at all.  Can you confirm that by running
> Rabeeh's kernel to see if you get that error message?

Here . Trying to find clock enet.0 (null)
Returning clk_lookup at 824f9854
Here . Trying to find clock (null) esai_clk
Returning clk_lookup at 824f95ac
Here . Trying to find clock (null) pll3_pfd_508M
Returning clk_lookup at 824f919c
Here . Trying to find clock (null) asrc_clk
Returning clk_lookup at 824f96ec

So it seems to be able to get that clock.  I'm wondering if it's based
on BSP 4.0.0 which does have that clock, rather than 4.1.0.

> > +       else {
> > +               clk_prepare(enet);
> > +               clk_set_rate(enet, 50000000);
> > +               clk_enable(enet);
> > +       }
> > 
> > I'm not sure at the moment which clock that refers to, or whether that's
> > necessary only for the AR8030 (which is used in RMII mode).  The enable
> > bit seems to be CCM_CCGR1 CG5_OFFSET.
> 
> There are two clocks ENET related, 'enet' (117) and 'enet_ref' (190).
> The enet is fec internal working clock, and enet_ref is provided by
> imx6q CCM (Clock Controller Module) on pad ENET_REF_CLK which can
> generally be used to clock the external PHY.

In this case, the phy provides the clock to the IMX6.

> The CCM_CCGR1_CG5 is clock 'enet', while I think the clock in above
> code should be 'enet_ref'.  It seems you need to set up
> MX6QDL_PAD_GPIO_16__ENET_REF_CLK to use the clock though.

Okay, and it seems Rabeeh is setting the enet clock (117) to 50MHz.
It defaults to 66MHz for me in 3.12-rc1, but I've hacked clk-imx6q.c
to call clk_set_rate(clk[enet], 50000000).

I've changed the enet_ref clock pinctrl settings to:

        /* ENET_REF_CLK is an output on AR8035 - SION must be set */
        MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0xc0000000
(which expands to: 0x214 0x5e4 0x80c 0x2 0x0 0xc0000000)

which in Rabeeh's version corresponds to:

        MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT,
(which expands to: IOMUX_PAD(0x05E4, 0x0214, 0x12, 0x080C, 0, NO_PAD_CTRL))

I've been through all the pinctrl settings for this now, taking them
back to the hex numbers and comparing.  I'm quite certain I have the
pinctrl settings correct now.

Probing the AR8035, I see that it's generating its 125M clock, as per
the fixup function, so at least that's working.

I've just enabled the debug in pinctrl-imx.c, and I get this:

imx6dl-pinctrl 20e0000.iomuxc: group(3): enetgrp-4
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE0: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE1: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE2: 5 0x000130b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE3: 5 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE4: 1 0x00003000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE5: 1 0x00003000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE6: 1 0x00003000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE7: 1 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE8: 1 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE9: 1 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE10: 18 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE11: 1 0x80000000
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE12: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE13: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE14: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE15: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE16: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE17: 1 0x0000a0b1
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_RESERVE18: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_CSI0_DAT10: 1 0x000130b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_CSI0_DAT11: 1 0x000130b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_CSI0_DAT12: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_CSI0_DAT13: 1 0x0001b0b0
imx6dl-pinctrl 20e0000.iomuxc: MX6DL_PAD_CSI0_DAT14: 1 0x000130b0
...
brd: module loaded
loop: module loaded
imx6dl-pinctrl 20e0000.iomuxc: maps: function enet group enetgrp-4 num 19
ar8035_phy_fixup()
libphy: fec_enet_mii_bus: probed
fec 2188000.ethernet eth0: registered PHC device 0

So where is the pinctrl settings applied - or more to the point, why
aren't they being applied?  This would probably explain why ethernet
doesn't work - I mean, if the pinctrl settings are never written to
the registers...
