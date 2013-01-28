From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 28 Jan 2013 20:03:32 +0100
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <CALF0-+U5DVGAMZGw1nsBMe5cJ1=U1b19D+kunWtSYn3sUYiRDg@mail.gmail.com>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
 <20130128180716.GA9436@obsidianresearch.com>
 <20130128192445.6984e7dd@skate>
 <CALF0-+U5DVGAMZGw1nsBMe5cJ1=U1b19D+kunWtSYn3sUYiRDg@mail.gmail.com>
Message-ID: <20130128200332.2770093e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 28 Jan 2013 15:41:12 -0300, Ezequiel Garcia wrote:

> Note that in Jason's proposal, it's possible to instantiate a bus'
> child device, configure its address window and then call the
> corresponding driver using a regular of_node.
> 
> For instance,
> 
> // MBUS Decoder window for NAND
> nand at f4000000 {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         compatible = "simple-bus", "marvell,orion-mbus";
>         mbus-target = <0x01 0x2f>;
>         ranges = <0 0xf4000000 0x10000>;
> 
>         nand at 0 {
>                 // ...
>                compatible = "marvell,orion-nand";
>                reg = <0x0 0x400>;
>         };
> };
> 
> In this example, we can configure the window using both mbus-target
> and ranges properties and then use the child node to instantiate an
> "orion-nand" device.
> 
> I understand your point regarding PCIe flexibility needs.
> So I wonder, in your proposed scheme,
> who should call this "address decoding window" driver
> in order to still be able to instantiate child devices easily?

I am not sure to exactly understand what you mean here. You would have
a DT node for the NAND, and another one for the NOR. Each of them use a
different compatible string (such as the "marvell,orion-nand" you've
mentioned). Those correspond to platform_drivers, like all other
devices described in the DT, nothing different. In their ->probe()
function, those driver call some mvebu_setup_addr_decoding_window()
function, which is part of an API provided by the address mapping
driver.

The address at which we configure the various address decoding windows
is an operating system specific decision, it is not a description of
the hardware. Therefore, it shouldn't be encoded in the DT, because the
DT describes the hardware, not the Linux-specific decisions on how the
hardware should be used.

Of course, for things like the internal registers decoding windows, we
can't really make the DT unaware of that, because it is so fundamental
to even having the platform booting. But for all other windows, it is
an operating system decision, and not a hardware description.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
