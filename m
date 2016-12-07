From: andreas2025@gmail.com (Andy Ng)
Date: Wed, 7 Dec 2016 00:44:27 +0000
Subject: IMX6S MRII does not work
Message-ID: <CAAVaN8z8jAkPw-=bDxNUvZOL4xB7ZK2_hkGyp8FQSE6ivhzeTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have quite recent kernel linux-4.1.20 from Freescale's git repo.


I am using MRII and a fec setup that uses clock that goes to the phy too.


My dtsi has:

    pinctrl_enet: enetgrp {
            fsl,pins = <
                MX6QDL_PAD_ENET_MDIO__ENET_MDIO        0x1b0b0
                MX6QDL_PAD_ENET_MDC__ENET_MDC          0x1b0b0
                MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN  0x1b0b0
                MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0  0x1b0b0
                MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1  0x1b0b0
                MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN      0x1b0b0
                MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER      0x1b0b0
                MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0    0x1b0b0
                MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1     0x1b0b0
               MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x4001b0a8

            >;
        };


the fec entry:

&fec {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_enet>;
    phy-mode = "rmii";
    phy-reset-duration = <2>;
    phy-reset-gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
    status = "okay";
};


The kernel comes up and detects the phy (MDIO works), but it seems fec
is not doing much:

INIT: Entering runlevel: 5
Configuring network interfaces... RMII Detected
fec 2188000.ethernet eth0: Freescale FEC PHY driver [SMSC
LAN8710/LAN8720] (mii_bus:phy_addr=2188000.ethernet:00, irq=-1)
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
udhcpc (v1.24.1) started
Sending discover...
Sending discover...
Sending discover...
No lease, forking to background
done.

I have checked the code, and  I've found very few boards that use
rmii, and from those, most of them are using external clock for the
phy.

I have the impression that GPIO_16_ENET_REF_CLK with SION bit ON may
not have been tested, as there is no imx6 ref board that uses
that mode.

Did anyone else have seen the same issue?
Any thoughts will be very much appreciated.

Thank you
Andy
