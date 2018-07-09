From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 9 Jul 2018 16:54:50 +0200
Subject: [PATCH 3/3] ARM: dts: Add devicetree for Storlink/Storm SL93512R
In-Reply-To: <CACRpkdao_cEBJ9XkMfvOa3Z394K5z0HQEE=-rN-UXqiRp2iUkw@mail.gmail.com>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-3-linus.walleij@linaro.org>
 <20180704205627.GF23469@lunn.ch>
 <CACRpkdbgoVjCaTE3xg1Q_-UKG3cdVdDdNFW4j1UOA9bX0o-wpQ@mail.gmail.com>
 <20180705223730.GQ23469@lunn.ch>
 <CACRpkdao_cEBJ9XkMfvOa3Z394K5z0HQEE=-rN-UXqiRp2iUkw@mail.gmail.com>
Message-ID: <20180709145450.GK10376@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2018 at 09:53:39PM +0200, Linus Walleij wrote:
> On Fri, Jul 6, 2018 at 12:37 AM Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> >
> > &eth0 {
> >         phy-mode = "rgmii-id";
> >         status = "okay";
> >
> >         fixed-link {
> >                 speed = <1000>;
> >                 full-duplex;
> >         };
> > };
> >
> > phy-mode is O.K, since you need to set RGMII.
> 
> OK hm maybe we should have "link-mode" as an alternative
> as it makes it less stressful syntactically...
> 
> > phy-handle should not be used, since the fixed-link takes its
> > place. But it could be your MAC driver has problems, does not
> > correctly support fixed link, and has phy-handle as being mandatory,
> > when it should not be.
> >
> > Which MAC driver is this?
> 
> This is
> drivers/net/ethernet/cortina/gemini.c
> 
> My own driver code so the errors are likely mine...

Hi Linus

drivers/net/ethernet/cortina/gemini.c does not appear to have anything
to actually parse the fixed-link properties. I would probably extend
of_phy_get_and_connect() to do this parsing. Something like this,
which is not even compile tested:

@@ -367,14 +367,24 @@ struct phy_device *of_phy_get_and_connect(struct net_device *dev,
        phy_interface_t iface;
        struct device_node *phy_np;
        struct phy_device *phy;
+       int ret;
 
-       iface = of_get_phy_mode(np);
-       if (iface < 0)
-               return NULL;
+       if (of_phy_is_fixed_link(np)) {
+               ret = of_phy_register_fixed_link(np);
+               if (ret < 0) {
+                       dev_err(dev, "broken fixed-link specification\n");
+                       return NULL;
+               }
+               phy_np = of_node_get(np);
+       } else {
+               iface = of_get_phy_mode(np);
+               if (iface < 0)
+                       return NULL;
 
-       phy_np = of_parse_phandle(np, "phy-handle", 0);
-       if (!phy_np)
-               return NULL;
+               phy_np = of_parse_phandle(np, "phy-handle", 0);
+               if (!phy_np)
+                       return NULL;
+       }
 
        phy = of_phy_connect(dev, phy_np, hndlr, 0, iface);
 

	Andrew
