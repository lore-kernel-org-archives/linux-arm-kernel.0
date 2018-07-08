From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 8 Jul 2018 21:53:39 +0200
Subject: [PATCH 3/3] ARM: dts: Add devicetree for Storlink/Storm SL93512R
In-Reply-To: <20180705223730.GQ23469@lunn.ch>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-3-linus.walleij@linaro.org>
 <20180704205627.GF23469@lunn.ch>
 <CACRpkdbgoVjCaTE3xg1Q_-UKG3cdVdDdNFW4j1UOA9bX0o-wpQ@mail.gmail.com>
 <20180705223730.GQ23469@lunn.ch>
Message-ID: <CACRpkdao_cEBJ9XkMfvOa3Z394K5z0HQEE=-rN-UXqiRp2iUkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 6, 2018 at 12:37 AM Andrew Lunn <andrew@lunn.ch> wrote:

> arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
>
> &eth0 {
>         phy-mode = "rgmii-id";
>         status = "okay";
>
>         fixed-link {
>                 speed = <1000>;
>                 full-duplex;
>         };
> };
>
> phy-mode is O.K, since you need to set RGMII.

OK hm maybe we should have "link-mode" as an alternative
as it makes it less stressful syntactically...

> phy-handle should not be used, since the fixed-link takes its
> place. But it could be your MAC driver has problems, does not
> correctly support fixed link, and has phy-handle as being mandatory,
> when it should not be.
>
> Which MAC driver is this?

This is
drivers/net/ethernet/cortina/gemini.c

My own driver code so the errors are likely mine...

the callback trail is usually:

gemini_ethernet_port_probe() or
.ndo_open() -> gmac_open()
I guess that is normal as net_device_ops doesn't have any
.adjust_link() callback or so.

then:

if (!netdev->phydev)
     gmac_setup_phy(netdev);

gmac_setup_phy()
of_phy_get_and_connect(netdev,
                                     dev->of_node,
                                     gmac_speed_set);
gmac_speed_set()

As long as a "phydev" is carrying over the
fixed link info it should be fine I think, this just
sets up the RGMII speed in this case, but it doesn't
get opened or something.

Yours,
Linus Walleij
