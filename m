From: npcomplete13@gmail.com (Vivek Unune)
Date: Tue, 27 Jun 2017 13:03:52 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add support for Linksys EA9500
In-Reply-To: <2e4ed52f-4134-9b6a-18c9-7c1f28cd7038@broadcom.com>
References: <1489590033-4946-1-git-send-email-npcomplete13@gmail.com>
 <20170315185214.GF21021@lunn.ch>
 <CAChtp75xk3LN1-DPVvaHT5qEvrdoFFvXEk-daVCcJ=4rYu_vmw@mail.gmail.com>
 <7f5ddeba-6f79-9de5-2c67-a77e6bec0ef9@broadcom.com>
 <CAChtp75mzHkSg4rVh602vaMotqs6NtaPOD4383Gef8tVPO37FQ@mail.gmail.com>
 <2e4ed52f-4134-9b6a-18c9-7c1f28cd7038@broadcom.com>
Message-ID: <CAChtp76sbKjxq03ipSDJN69XeJRU-0aRTeJ75+gCXZfo4D5r0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 5:19 PM, Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> On 03/15/2017 01:18 PM, Vivek Unune wrote:
>> Thanks Florian.
>>
>> Let me try this out. First I'll try to figure out how to add a mdio node.
>>
>> Over the weekend I was trying enable DSA driver, but did not see DSA
>> under network. I'm using LEDE source with kernel 4.9. Nor did I see it
>> when I tried 'make kernel_menuconfig'
>
> (please don't top post on public mailing lists)
>
> You need to enable SWITCHDEV to have DSA. AFAIR SWITCHDEV may depend on
> EXPERT/EXPERIMENTAL as of 4.9 (or that was before).
>

Florian,

I have managed to use DSA driver and was able detect both internal and
external switches. However, I only get packets flowing only through the
internal switch. I have used the ip & bridge commands to setup the vlan
101 & 102 for lan and wan respectively.

VLAN101 = lan1 lan2 lan3 lan4 lan5 lan6 lan7 lan8 eth0.101
VLAN102 = wan eth0.102

Reading configs from the factory firmware, I'm sure that sw0port0 and
sw1port8 are connected. Excerpt from the same:

port_numbers=0 2 4 2 1 3 1 3
port_switch_id=1 1 1 0 1 1 0 0
port_names=port0 port1 port2 port3 port4 port5 port6 port7
cpu_port_number=5 7 8
cpu_port_switch_id=0 0 0
hidden_port_numbers=0 8
hidden_port_switch_id=0 1

Below is my updated device tree.

Thanks,

Vivek

&srab {
    compatible = "brcm,bcm53012-srab", "brcm,bcm5301x-srab";
    status = "okay";
    dsa,member = <0 0>;

    ports {
        #address-cells = <1>;
        #size-cells = <0>;

        port at 1 {
            reg = <1>;
            label = "lan7";
        };

        port at 2 {
            reg = <2>;
            label = "lan4";
        };

        port at 3 {
            reg = <3>;
            label = "lan8";
        };

        port at 4 {
            reg = <4>;
            label = "wan";
        };

        port at 5 {
            reg = <5>;
            ethernet = <&gmac0>;
            label = "cpu";

            fixed-link {

                speed = <1000>;
                full-duplex;
            };
        };

        sw0port0: port at 0 {
            reg = <0>;
            label = "extswitch";

            fixed-link {
                speed = <1000>;
                full-duplex;
            };
        };
    };
};

&mdiomux {
    mdio-slave at 0 {
        reg = <0x00>;
        address-cells = <1>;
        size-cells = <0>;

        switch at 0  {
            compatible = "brcm,bcm53125";
            #address-cells = <1>;
            #size-cells = <0>;
            reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
            reset-names = "robo_reset";
             reg = <0>;
             dsa,member = <1 0>;

            ports {
                #address-cells = <1>;
                #size-cells = <0>;

                port at 0 {
                        reg = <0>;
                        label = "lan1";
                };

                port at 1 {
                        reg = <1>;
                        label = "lan5";
                };

                port at 2 {
                        reg = <2>;
                        label = "lan2";
                };

                port at 3 {
                        reg = <3>;
                        label = "lan6";
                };

                port at 4 {
                        reg = <4>;
                        label = "lan3";
                };

                sw1port8:port at 8 {
                        reg = <8>;
                        ethernet = <&sw0port0>;
                        label = "cpu";
                        phy-mode = "rgmii-txid";

                        fixed-link {
                            speed = <1000>;
                            full-duplex;
                        };
                };
            };
        };
    };
};
