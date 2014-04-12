From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 12 Apr 2014 18:28:57 +0200
Subject: [REGRESSION, BISECTED] mvneta broken in 3.14 on RN2120,
 RN102 and RN104 after e3a8786c10e7
Message-ID: <87k3au8qba.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Network is broken w/ 3.14 kernel on Netgear ReadyNAS 102 (the SoC is
an Armada 370 using mvneta driver and rgmii phy): nothing sent, nothing
received from the interface. This came as a surprise (it was reported by
two users) as 3.14-rc8 was ok on my side.

I also checked on a ReadyNAS 104 (Armada 370 using mvneta driver and
rgmii phy for both interfaces) and a ReadyNAS 2120 (Armada XP using
mvneta driver and rgmii phy for both interfaces). They are both
affected too.

A short bisect session pointed e3a8786c10e7 (net: mvneta: fix usage as a
module on RGMII configurations). Reverting it put things back in order
on those three devices.

I took a quick look at e3a8786c10e7 commit and did some tests to narrow
the root cause (I do not have A370 functional specification doc at hand
today so I was not able to check mvneta details):

    -}
    -
     /* Start the Ethernet port RX and TX activity */
     static void mvneta_port_up(struct mvneta_port *pp)
     {
    @@ -2756,12 +2728,15 @@ static void mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
            mvreg_write(pp, MVNETA_UNIT_INTR_CAUSE, 0);
     
            if (phy_mode == PHY_INTERFACE_MODE_SGMII)
    -               mvneta_port_sgmii_config(pp);
    +               mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_SGMII_SERDES_PROTO);
    +       else
    +               mvreg_write(pp, MVNETA_SERDES_CFG, MVNETA_RGMII_SERDES_PROTO);


I built a first kernel with the 'else' branch above removed (rationale:
SERDES config was not set for RGMII prior to the patch). The issue
remained.
     
    -       mvneta_gmac_rgmii_set(pp, 1);
    +       val = mvreg_read(pp, MVNETA_GMAC_CTRL_2);
    +
    +       val |= MVNETA_GMAC2_PCS_ENABLE | MVNETA_GMAC2_PORT_RGMII;

I removed MVNETA_GMAC2_PCS_ENABLE flag setting (rationale: it was only
done for SGMII prior to the patch and all my platforms have RGMII
connected PHY). *The issue disappeared on all 3 NAS with that simple
change*.

Some additional notes:
 - you tested w/ mvneta as a module. Did you test w/ mvneta driver
   built in the kernel? This is what I have on my side.
 - e3a8786c10e7 is in 3.13.9 kernel and possibly previous ones: I can
   confirm 3.13.9 is also broken for me.
 - I initially thought the issue was specific to A370 (some differences
   in mvneta logic?) as all your tests had been done on AXP. This is the
   reason I also checked the RN2120 (mv78230) and it is impacted.

Any idea is welcome.

Cheers,

a+
