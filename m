From: ian.molton@codethink.co.uk (Ian Molton)
Date: Wed, 08 Aug 2012 10:40:56 +0100
Subject: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <201208080816.29218.arnd@arndb.de>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <20120807.162923.34400427265666163.davem@davemloft.net>
 <201208080816.29218.arnd@arndb.de>
Message-ID: <50223428.6030506@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/12 09:16, Arnd Bergmann wrote:

> I'd prefer to take the entire series through the arm-soc tree from
> the kirkwood maintainers. We first have to work out the bindings
> though, since the current patch introduces a new one that is
> incompatible with the one we were using on powerpc with open firmware
> before.

Looking at the ethernet-group stuff, specifically from
arch/powerpc/boot/dts/prpmc2800.dts, which I've taken as a base for the
below:

I think we can (and should) do something similar.

Sadly, there is no code present to describe marvell,mv64360-mdio,
however the device tree looks basically sane.



        mdio at 2000 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        device_type = "mdio";
                        compatible = "marvell,mv643xx-mdio";
                        PHY0: ethernet-phy at 1 {
                                device_type = "ethernet-phy";
                                compatible = "broadcom,bcm5421";
                                interrupts = <76>;      /* GPP 12 */
                                interrupt-parent = <&PIC>;
                                reg = <1>;
                        };
                        PHY1: ethernet-phy at 3 {
                                device_type = "ethernet-phy";
                                compatible = "broadcom,bcm5421";
                                interrupts = <76>;      /* GPP 12 */
                                interrupt-parent = <&PIC>;
                                reg = <3>;
                        };
                };

                ethernet-group at 2400 {
                        #address-cells = <1>;
                        #size-cells = <0>;
                        compatible = "marvell,mv64360-eth-group";
                        reg = <0x2400 0x2000>;
                        ethernet at 0 {
                                device_type = "network";
                                compatible = "marvell,mv64360-eth";
                                reg = <0>;
                                interrupts = <32>;
                                interrupt-parent = <&mpic>;
                                phy = <&phy0>;
                                local-mac-address = [ 00 00 00 00 00 00 ];
                        };
                        ethernet at 1 {
                                device_type = "network";
                                compatible = "marvell,mv64360-eth";
                                reg = <1>;
                                interrupts = <33>;
                                interrupt-parent = <&mpic>;
                                phy = <&phy1>;
                                local-mac-address = [ 00 00 00 00 00 00 ];
                        };
                };
