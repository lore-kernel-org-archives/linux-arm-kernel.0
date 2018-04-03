From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 3 Apr 2018 21:14:47 +0900
Subject: [Question] MFD driver that handles clocks/resets and populates
 child nodes
In-Reply-To: <20180403080335.ksekhxwvbzbxhmln@dell>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch>
 <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
 <20180402133219.GA10520@lunn.ch> <20180403080335.ksekhxwvbzbxhmln@dell>
Message-ID: <CAK7LNAQbWUYuhow5VdNDc+SuttY+u3xh9zk92kLEy9id6TNCFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-04-03 17:03 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> On Mon, 02 Apr 2018, Andrew Lunn wrote:
>
>> On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
>> > 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
>> > >> The maintainer of DWC3, Felipe Balbi, requested to
>> > >> split the glue layer driver into small parts such as
>> > >> reset, regulator, phy, etc.
>> > >
>> > > What exactly did Felipe ask for? Did he ask that the patch be split
>> > > up, one patch per reset, regulator, phy etc?
>> >
>> >
>> > Yeah.  That is what we understood from his comments.
>> >
>> >
>> > These are the feed-backs from him.
>> >
>> > https://lkml.org/lkml/2018/1/23/298
>> > https://lkml.org/lkml/2018/1/24/352
>>
>> > > Are all these resources used just by the DWC3? Or is it a true MFD,
>> > > multiple functions?
>> >
>> > I do not think this is a real MFD.
>> >
>> > This is a DWC3 glue layer, i.e.
>> > a collection of misc registers that control
>> > the DWC3 IP.
>> >
>> >
>> > Just splitting it into small pieces
>> > to use PHY, reset, regulator framework in Linux.
>> >
>> > Of course, the price of this approach
>> > is so cluttered Device Tree,
>> > honestly I do not like it much.
>>
>> This however the correct way to do this. You should have a phy driver,
>> and a regulator driver, and a reset driver. The DWC3 then uses
>> phandles to these drivers.
>>
>> How is the IO map area 65b00000 split up. Can you cleanly separate it
>> into sub areas, which do not overlap, so you have a sub-area for the
>> PHY driver, a sub-area for the regulator driver and a sub-area for the
>> reset area? If you can cleanly split it up, you don't need an MFD. If
>> however the registers are in overlapping areas, you do need an
>> MFD. The MFD core provides access to the registers, while its children
>> implement PHY, reset, regulator etc.
>
> This device certainly sounds like an MFD to me.
>
> Can you share the DT you've written please?


This is still under the internal review in Socionext,
but I attached it below FWIW.

(I am not the author of this DT.
 Written by Kunihiko Hayashi,
 and clocks/resets parts were slightly modified by me.)


Just skimming the driver, I guess it will be possible to flatten
the node structure by separating the register space into sub-areas.
If this is success, we do not the MFD driver.


usb at 65b00000 {
        compatible = "socionext,uniphier-ld20-usb3-glue",
                     "syscon";
        reg = <0x65b00000 0x1000>;
        clock-names = "usb";
        clocks = <&sys_clk 14>;
        reset-names = "usb";
        resets = <&sys_rst 14>;

        usb_rst: reset {
                compatible = "socionext,uniphier-ld20-usb3-reset";
                #reset-cells = <1>;
        };

        regulators {
                compatible = "socionext,uniphier-ld20-usb3-regulator";

                usb_vbus0: vbus-0 { };
                usb_vbus1: vbus-1 { };
                usb_vbus2: vbus-2 { };
                usb_vbus3: vbus-3 { };
        };

        usb_hsphy: hs-phy {
                compatible = "socionext,uniphier-ld20-usb3-hsphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                clock-names = "phy-clk0", "phy-clk1";
                clocks = <&sys_clk 16>, <&sys_clk 17>;
                reset-names = "phy-rst0", "phy-rst1";
                resets = <&sys_rst 16>, <&sys_rst 17>;
                port0-supply = <&usb_vbus0>;
                port1-supply = <&usb_vbus1>;
                port2-supply = <&usb_vbus2>;
                port3-supply = <&usb_vbus3>;

                port at 0 {
                        reg = <0>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm0>,
                                      <&usb_sel_t0>,
                                      <&usb_hs_i0>;
                };
                port at 1 {
                        reg = <1>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm1>,
                                      <&usb_sel_t1>,
                                      <&usb_hs_i0>;
                };
                port at 2 {
                        reg = <2>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm2>,
                                      <&usb_sel_t2>,
                                      <&usb_hs_i2>;
                };
                port at 3 {
                        reg = <3>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm3>,
                                      <&usb_sel_t3>,
                                      <&usb_hs_i2>;
                };
        };

        usb_ssphy: ss-phy {
                compatible = "socionext,uniphier-ld20-usb3-ssphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                reset-names = "phy-rst0", "phy-rst1";
                resets = <&sys_rst 18>, <&sys_rst 19>;
                port0-supply = <&usb_vbus0>;
                port1-supply = <&usb_vbus1>;

                port at 0 {
                        reg = <0>;
                };
                port at 1 {
                        reg = <1>;
                };
        };
};






-- 
Best Regards
Masahiro Yamada
