From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 23 Mar 2016 03:12:53 +0100
Subject: [PATCH] ARM: dts: orion5x: add device tree for kurobox-pro
In-Reply-To: <CAEQ9gEniE1CGaSb46uWDdg1AU0VWEU-Eq8uVF7X7Rxn1jM+KUw@mail.gmail.com>
References: <1458656898-16183-1-git-send-email-rogershimizu@gmail.com>
 <20160322164200.GH5250@lunn.ch>
 <CAEQ9gEniE1CGaSb46uWDdg1AU0VWEU-Eq8uVF7X7Rxn1jM+KUw@mail.gmail.com>
Message-ID: <20160323021253.GB19953@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > kurobox_pro-setup.c says:
> >
> > /*
> >  * 256K NOR flash Device bus boot chip select
> >  */
> >
> > #define KUROBOX_PRO_NOR_BOOT_BASE       0xf4000000
> > #define KUROBOX_PRO_NOR_BOOT_SIZE       SZ_256K
> >
> > /*
> >  * 256M NAND flash on Device bus chip select 1
> >  */
> >
> > #define KUROBOX_PRO_NAND_BASE           0xfc000000
> > #define KUROBOX_PRO_NAND_SIZE           SZ_2M
> >
> > So there is a NOR on CS0, not NAND.
> 
> The NOR is on Device Bus Boot, which described in
> orion5x-linkstation.dtsi and is the probed OK:
> 
> [    1.843221] Found: SST 39LF020
> [    1.846391] f4000000.flash: Found 1 x8 devices at 0x0 in 8-bit bank
> [    1.852715] number of JEDEC chips: 1
> [    1.872860] 3 ofpart partitions found on MTD device f4000000.flash
> [    1.879122] Creating 3 MTD partitions on "f4000000.flash":
> [    1.884697] 0x000000000000-0x000000030000 : "header"
> [    1.893209] 0x000000030000-0x00000003f000 : "uboot"
> [    1.901671] 0x00000003f000-0x000000040000 : "uboot_env"
> 
> 
> The NAND, which is on Device Bus CS0, has probing issue. I only can
> have it probed by the board file:

The comment on the board file says chip select 1, not 0.

> So you mean I need to refer the nand block in mbus part in
> kirkwood.dtsi?
 
>         nand: nand at 012f {
>             #address-cells = <1>;
>             #size-cells = <1>;
>             cle = <0>;
>             ale = <1>;
>             bank-width = <1>;
>             compatible = "marvell,orion-nand";
>             reg = <MBUS_ID(0x01, 0x2f) 0 0x400>;
>             chip-delay = <25>;
>             /* set partition map and/or chip-delay in board dts */
>             clocks = <&gate_clk 7>;
>             pinctrl-0 = <&pmx_nand>;
>             pinctrl-names = "default";
>             status = "disabled";
>         };
> 
> The difficulty for me is I have no idea on
> - which clock to use

Orion5x does not have a specific clocks for peripherals. In this case,
the clock is not needed.

> - which mpp pin to use

You need to define a pinmux configuration. Looking at the board file,
we have:

        MPP6_NAND,              /* NAND Flash REn */
        MPP7_NAND,              /* NAND Flash WEn */

So you can add a node to orion5x-mv88f5182.dtsi containing these two
pins.

> - how to set these address

Not so sure here. The data sheet says CS1 uses Target Interface ID 1,
Target Interface Attribute 0x1d.

In the soc ranges you want

reg = <MBUS_ID(0x01, 0x1d) 0 0xfc000000 0x1000000>

and in the nand node

reg = <MBUS_ID(0x01, 0x2f) 0 0x200000>;

    Andrew
