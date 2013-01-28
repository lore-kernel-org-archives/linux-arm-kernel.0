From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Mon, 28 Jan 2013 15:41:12 -0300
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130128192445.6984e7dd@skate>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
 <20130128180716.GA9436@obsidianresearch.com>
 <20130128192445.6984e7dd@skate>
Message-ID: <CALF0-+U5DVGAMZGw1nsBMe5cJ1=U1b19D+kunWtSYn3sUYiRDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Jan 28, 2013 at 3:24 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
>
> Instead, I think the "address decoding window driver" in the kernel
> should provide an API for device drivers to request an address decoding
> window at a given address, with a given size and target/attribute. This
> is already what the PCIe code is doing (I'm going to submit v2 of the
> PCIe code soon), and I think we should to the same for other devices as
> well.
>

Note that in Jason's proposal, it's possible to instantiate a bus' child
device, configure its address window and then call the corresponding
driver using a regular of_node.

For instance,

// MBUS Decoder window for NAND
nand at f4000000 {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "simple-bus", "marvell,orion-mbus";
        mbus-target = <0x01 0x2f>;
        ranges = <0 0xf4000000 0x10000>;

        nand at 0 {
                // ...
               compatible = "marvell,orion-nand";
               reg = <0x0 0x400>;
        };
};

In this example, we can configure the window using both mbus-target and ranges
properties and then use the child node to instantiate an "orion-nand" device.

I understand your point regarding PCIe flexibility needs.
So I wonder, in your proposed scheme,
who should call this "address decoding window" driver
in order to still be able to instantiate child devices easily?

Thanks,

-- 
    Ezequiel
