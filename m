From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sat, 3 Nov 2012 20:03:11 -0600
Subject: [4/4] arm: mvebu: enable Ethernet controllers on Armada 370/XP
 eval boards
In-Reply-To: <1351245804-31478-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121104020311.GA26747@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+                ethernet at d0070000 {
+                        clock-frequency = <200000000>;
+                        status = "okay";
+                        phy-mode = "rgmii-id";
+                        phy-addr = <0>;
+                };

We've been using the patches from Ian Molton for the mv643xx driver
that make it use the more standard, separately described MDIO
bus..

Please consider not copying the unsual 'phy-addr' binding
for the new driver.

What we are used to seeing for ethernet+mdio is more like:

                smi0: mdio at 72000 {
                        device_type = "mdio";
                        compatible = "marvell,mdio-mv643xx";
                        reg = <0x72000 0x4000>;
                        interrupts = <46>;
                        tx_csum_limit = <1600>;

                        #address-cells = <1>;
                        #size-cells = <0>;
                        PHY1: ethernet-phy at 1 {
                                reg = <1>;
                                device_type = "ethernet-phy";
                                phy-id = <0x01410e90>;
                        };
                };

                egiga0 {
                        device_type = "network";
                        compatible = "marvell,mv643xx-eth";
                        reg = <0x72000 0x4000>;
                        mdio = <&smi0>;
                        port_number = <0>;
                        phy-handle = <&PHY1>;
                        interrupts = <11>;
                };
        };

Where the MDIO bus is explicit, the PHY, its address and parameters
are explicit - the PHY has an of_node pointer - and phy-handle is used
to connect them.

I'm not sure having the MDIO bus as a distinct top level item is
great, considering how the registers overlap.. It might be better
to put it under the egiga0 block? But that is a minor nit :)

Regards,
Jason
