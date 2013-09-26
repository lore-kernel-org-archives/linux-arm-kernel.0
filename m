From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Sep 2013 21:59:07 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <CAOMZO5ANsZGcpvmtBE7d0q0E6+f0bE_U8CBF7G2v3xtqoLbqcA@mail.gmail.com>
Message-ID: <20130926205906.GT12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 05:29:47PM -0300, Fabio Estevam wrote:
> Hi Russell,
> 
> On Thu, Sep 26, 2013 at 4:51 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > Can someone please point me at the current documentation for the
> > iMX6DL pinctrl bindings?
> 
> Best reference is the mx6dl reference manual (chapter 37 - IOMUXC):
> http://cache.freescale.com/files/32bit/doc/ref_manual/IMX6SDLRM.pdf
> 
> > I mean the stuff which looks like this:
> >
> > #define MX6QDL_PAD_ENET_MDC__ESAI_TX5_RX0           0x1e8 0x5b8 0x858 0x2 0x0
> 
> Let me try to decode it:
> 
> 0x1e8: Offset of IOMUXC_SW_MUX_CTL_PAD_ENET_MDC register
> 
> 0x5b8: Offset of IOMUXC_SW_PAD_CTL_PAD_ENET_MDC register
> 
> 0x2: This means that the MUX_MODE field selects the ESAI_TX5_RX0 function
> in this pad
> 
> 0x0: SELECT_INPUT not used for this pad

Okay, that's relatively straight forward.

> Let me know if you need help with the iomux settings for cubox-i.

Yes please. :)

Here's Rabeeh's preliminary patches against Freescale's 3.0.35 BSP 4.1.0
kernel:

http://download.solid-run.com/pub/solidrun/c1/kernel/initial/

I think I've translated the bulk of them.  I have a number of problems
though.  One of the things I'd like to sort out is the ethernet.  Most
of these convert straight:

+       MX6DL_PAD_ENET_MDIO__ENET_MDIO,
+       MX6DL_PAD_ENET_MDC__ENET_MDC,
+       IOMUX_PAD(0x0650, 0x0268, 5, 0x0000, 0, MX6DL_ENET_PAD_CTRL_PD), /* KEY_ROW4 reset signal */
+       
+       MX6DL_PAD_DI0_PIN2__GPIO_4_18, /* Interrupt */
+       /* RMII */
+       IOMUX_PAD(0x05B4, 0x01E4, 1, 0x0828, 0, PAD_CTL_PKE | PAD_CTL_PUE  |
+                 PAD_CTL_PUS_100K_DOWN), /* MX6DL_PAD_ENET_CRS_DV__ENET_RX_EN */
+       IOMUX_PAD(0x05C8, 0x01F8, 1, 0x0818, 0, PAD_CTL_PKE | PAD_CTL_PUE  |
+                 PAD_CTL_PUS_100K_DOWN), /* MX6DL_PAD_ENET_RXD0__ENET_RDATA_0 */
+       IOMUX_PAD(0x05CC, 0x01FC, 1, 0x081C, 0, PAD_CTL_PKE | PAD_CTL_PUE  |
+                 PAD_CTL_PUS_100K_DOWN), /* MX6DL_PAD_ENET_RXD1__ENET_RDATA_1 */
+       MX6DL_PAD_ENET_TXD0__ENET_TDATA_0,
+       MX6DL_PAD_ENET_TXD1__ENET_TDATA_1,
+       MX6DL_PAD_ENET_TX_EN__ENET_TX_EN,
+       MX6DL_PAD_GPIO_16__ENET_ANATOP_ETHERNET_REF_OUT,
+       MX6DL_PAD_RGMII_TXC__ENET_RGMII_TXC,
+       MX6DL_PAD_RGMII_TD0__ENET_RGMII_TD0,
+       MX6DL_PAD_RGMII_TD1__ENET_RGMII_TD1,
+       MX6DL_PAD_RGMII_TD2__ENET_RGMII_TD2,
+       MX6DL_PAD_RGMII_TD3__ENET_RGMII_TD3,
+       MX6DL_PAD_RGMII_TX_CTL__ENET_RGMII_TX_CTL,
+       MX6DL_PAD_ENET_REF_CLK__ENET_TX_CLK,
+       MX6DL_PAD_RGMII_RXC__ENET_RGMII_RXC,
+       IOMUX_PAD(0x0694, 0x02AC, 1, 0x0818, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RD0*/
+       IOMUX_PAD(0x0698, 0x02B0, 1, 0x081C, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RD1*/
+       /* In RGMII mode RD2 should be '1' to disable the PLL OFF mode */
+       MX6DL_PAD_RGMII_RD2__ENET_RGMII_RD2,
+       MX6DL_PAD_RGMII_RD3__ENET_RGMII_RD3,
+       /* In RGMII mode RX_DV should be pulled down for reset strap */
+       IOMUX_PAD(0x06A4, 0x02BC, 1, 0x0828, 1, MX6DL_ENET_PAD_CTRL_PD),/*RGMII RXCTL*/

The ones which don't are those IOMUX_PAD() ones - what I have so far for
them (I'm still busy adding to the DT file for everything else) are
(in order):

        MX6QDL_PAD_ENET_MDIO__ENET_MDIO
        MX6QDL_PAD_ENET_MDC__ENET_MDC 
        MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 -- ?
        MX6QDL_PAD_DI0_PIN2__GPIO4_IO18
        /* RMII */
        MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN ... extra stuff
        MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0 ... extra stuff
        MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1 ... extra stuff
        MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0
        MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1
        MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN
        MX6QDL_PAD_GPIO_16__ENET_REF_CLK  -- ?
        MX6QDL_PAD_RGMII_TXC__RGMII_TXC
        MX6QDL_PAD_RGMII_TD0__RGMII_TD0
        MX6QDL_PAD_RGMII_TD1__RGMII_TD1
        MX6QDL_PAD_RGMII_TD2__RGMII_TD2
        MX6QDL_PAD_RGMII_TD3__RGMII_TD3
        MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL
        MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK
        MX6QDL_PAD_RGMII_RXC__RGMII_RXC
        MX6QDL_PAD_RGMII_RD0__RGMII_RD0 ... extra stuff
        MX6QDL_PAD_RGMII_RD1__RGMII_RD1 ... extra stuff
        /* In RGMII mode RD2 should be '1' to disable the PLL OFF mode */
        MX6QDL_PAD_RGMII_RD2__RGMII_RD2
        MX6QDL_PAD_RGMII_RD3__RGMII_RD3
        /* In RGMII mode RX_DV should be pulled down for reset strap */
        MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL ... extra stuff

If I have to customize any of these settings, how do I do that?

Final question is - in imx6qdl.dtsi, I see for instance:

        MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0

What does the final number refer to?

Thanks.
