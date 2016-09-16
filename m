From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 15:47:43 +0200
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <57DBAB2F.3040905@ti.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <CAFBinCCDDwydB+RP0CZKoAW5Suxotn224ZFVWvt2OGW3gNJR1g@mail.gmail.com>
 <57DBAB2F.3040905@ti.com>
Message-ID: <2190413.jSIVEWUDcp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 1:49:59 PM CEST Kishon Vijay Abraham I wrote:
> 
> I think the offset information can come from the devicetree too. The phy can be
> modeled something like below.
> 
>                 usb-phys at c0000000 {
>                         compatible = "amlogic,meson-gxbb-usb2-phy";
>                         reg = <0x0 0xc0000000 0x0 0x40>;
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x40>;
>                         resets = <&reset 34>;
> 
>                         usb0_phy: usb_phy at 0 {
>                                 #phy-cells = <0>;
>                                 reg = <0x0 0x0 0x0 0x20>;
>                                 clocks = <&clkc CLKID_USB &clkc CLKID_USB0>;
>                                 clock-names = "usb_general", "usb";
>                                 status = "disabled";
>                         };
> 
>                         usb1_phy: usb_phy at 20 {
>                                 #phy-cells = <0>;
>                                 reg = <0x0 0x20 0x0 0x20>;
>                                 clocks = <&clkc CLKID_USB &clkc CLKID_USB1>;
>                                 clock-names = "usb_general", "usb";
>                                 status = "disabled";
>                         };
>                 };
> 
> This way the driver will be probed only once (the reset can be done during
> probe). The phy driver should scan the dt node and for every sub-node it
> invokes phy_create?

Why not just use #phy-cells=<1> and pass the phy number as an argument
in the reference?

	Arnd
