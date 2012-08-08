From: ian.molton@codethink.co.uk (Ian Molton)
Date: Wed, 08 Aug 2012 12:51:02 +0100
Subject: [PATCH v3 0/7] mv643xx.c: Add basic device tree support.
In-Reply-To: <50223428.6030506@codethink.co.uk>
References: <1344350092-24050-1-git-send-email-ian.molton@codethink.co.uk>
 <20120807.162923.34400427265666163.davem@davemloft.net>
 <201208080816.29218.arnd@arndb.de> <50223428.6030506@codethink.co.uk>
Message-ID: <502252A6.4090409@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/12 10:40, Ian Molton wrote:
> On 08/08/12 09:16, Arnd Bergmann wrote:
>
>> I'd prefer to take the entire series through the arm-soc tree from
>> the kirkwood maintainers. We first have to work out the bindings
>> though, since the current patch introduces a new one that is
>> incompatible with the one we were using on powerpc with open
>> firmware before.

Looking at the ethernet-group stuff, specifically from
arch/powerpc/boot/dts/prpmc2800.dts, which I've taken as a base for
the below:


The SMI / PHY stuff should look very similar, so I'm happy with something
like:

mdio at 2000 {
                #address-cells = <1>;
                #size-cells = <1>;
                device_type = "mdio";
                compatible = "marvell,mv643xx-mdio";
                phy0: ethernet-phy at 0 {
                        device_type = "ethernet-phy";
                        compatible = "marvell,whatever";
                        interrupts = <76>;
                        interrupt-parent = <&mpic>;
                        reg = <0 32>;          // Auto probed phy addr
                };

                phy1: ethernet-phy at 3 {
                        device_type = "ethernet-phy";
                        compatible = "marvell,whatever";
                        interrupts = <77>;
                        interrupt-parent = <&mpic>;
                        reg = <3 1>;            // specified phy addr
                };

                ... and so on.
}

Where we can use the reg parameter to allow auto-probing, by
specifying a size of 32 (32 phy addrs max).


The ethernet driver itself is more complicated:

We have the following considerations:

* we have one MDIO bus, typically, shared between all the MACs / PHYs.
* each ethernet device can multiple ports (up to three), each with its
  own MAC/PHY.
* MAC <-> PHY mapping can be specified, probed (ugh!) or a (gah!)
  mix of the two.
* existing D-T users, albeit not well documented / code complete.
* some port address ranges overlap (MIB counters, MCAST / UNICAST
  tables, etc.

The existing ethernet-group idea only works because the current
platform-device based driver doesnt really do proper resource
management, and thus the MAC registers are actually mapped by
the MDIO driver.

I don't think that preserving this bad behaviour is a good idea, which
leaves us with two choices:

1) My preferred solution - allow each device to specify up to three
interrupts, MACs, and PHYs. This is clean in that it doesnt require
multiply instantiating a driver three times over the same address
space.

ethernet at 2400 {
                compatible = "marvell,mv643xx-eth";
                reg = <0x2400 0x1c00>
                interrupt_parent = <&mpic>;
                ports = <3>;
                interrupts = <4>, <5>, <6>;
                phys = <&phy0>, <&phy1>, <&phy2>;
};

ethernet at 6400 {
                compatible = "marvell,mv643xx-eth";
                reg = <0x6400 0x1c00>
                interrupt_parent = <&mpic>;
                ports = <1>;
                interrupts = <4>;
                phys = <&phy3>;
};

Note that the address is 2400, not 2000 - since this driver no longer
would share its address range with the MDIO driver.

This method would require a small amount of rework in the driver to
set up <n> ports, rather than just one.

2) Create some kind of pseudo-ethernet group device that manages
all the work for some sort of lightweight ethernet device, one per
port. This can never be done cleanly since the port address ranges
overlap:

pseudo_eth at 2400 {
        #address-cells = <1>;
        #size-cells = <0>;
        compatible = "marvell,mv643xx-shared-eth"
        reg = <0x2400 0x1c00>;

        ethernet at 0 {
                compatible = "marvell,mv643xx-port";
                interrupts = <4>;
                interrupt_parent = <&mpic>;
                phy = <&phy0>;
        };

        ethernet at 1 {
                compatible = "marvell,mv643xx-port";
                interrupts = <5>;
                interrupt_parent = <&mpic>;
                phy = <&phy1>;
        };

        ethernet at 2 {
                compatible = "marvell,mv643xx-port";
                interrupts = <6>;
                interrupt_parent = <&mpic>;
                phy = <&phy2>;
        };
}
pseudo_eth at 6400 {
        #address-cells = <1>;
        #size-cells = <0>;
        compatible = "marvell,mv643xx-shared-eth"
        reg = <0x6400 0x1c00>;

        ethernet at 0 {
                compatible = "marvell,mv643xx-port";
                interrupts = <4>;
                interrupt_parent = <&mpic>;
                phy = <&phy3>;
        };
};

Thoughts?

-Ian
