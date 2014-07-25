From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 25 Jul 2014 16:24:02 +0100
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <1406294628-16079-7-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140725152401.GA21830@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Fri, Jul 25, 2014 at 02:23:48PM +0100, Linus Walleij wrote:
> This implements basic device tree boot support for the RealView
> platforms, with a basic device tree for ARM PB1176 as an example.
>
> The implementation is done with a new DT-specific board file
> using only pre-existing bindings for the basic IRQ, timer and
> serial port drivers. A new compatible type is added to the GIC
> for the ARM1176.
>
> This implementation uses the MFD syscon handle from day one to
> access the system controller registers, and register the devices
> using the SoC bus.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh@kernel.org>
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Switch the LEDs to usa a new syscon-LEDs driver so we can
>   use the syscon as a hub for all these registers
> - Split out the SoC driver to its own file in drivers/soc
> ChangeLog v2->v3:
> - Rename uart at 0x12345678 to serial at 0x12345678 in DTS file
> - Drop static remapping for the LEDs, using my new invention
>   syscon-leds instead
> - Drop the hunk selecting ARM_DMA_MEM_BUFFERABLE for the DT
>   version of the RealView platform. We think this is a local
>   optimization we can live without.
> - Split off the reset driver to a separate syscon-based reset
>   driver in drivers/power/reset, add separate device tree
>   bindings for this driver.
> - To make sure the reset driver is always available for this
>   system a few extra select statements are needed in Kconfig
> - Split off the SoC bus driver to an easily identifiable chunk
>   inside the mach-realview/realview-dt.c file. This *can* be
>   spun off as a separate driver under drivers/soc for example
>   but we need some separate discussion on this subject.
> - Augment the SoC driver to display some system info so it's
>   clear why this driver is there.
> - Drop surplus string "with device tree" from machine
>   description in the DTS file.
> - Move the new GIC compatible string in alphabetic order.
> ChangeLog v1->v2:
> - Adjust timer clock names to be the same as the example in the
>   device tree binding.
> - Remove all memory fixup code - this should be handled by the
>   device tree specification of memory areas or by special MM hacks
>   for the RealView PBX.
> - Fix the documentation around syscon to specify that it can be in
>   any node, need not be the root node.
> - Switch device tree license to the BSD license, taken from
>   arch/powerpc/boot/dts/p1024rdb_32b.dts
> - Add a hunk for the new compatible string to
>   Documentation/devicetree/bindings/arm/gic.txt
> - Move the clocks out of the SoC node, certainly the xtal is not
>   sitting on the SoC...
> - Sort the selects in Kconfig alphabetically
> - Use IS_ENABLED() for the l2x0 code snippet
> - Instead of checking the board variant in the reset routine to
>   figure out how to tweak the reset controller, have a compatible
>   string for each syscon variant, map it to an enum that provides a
>   unique type ID and that way figure out how to handle it in a maybe
>   more elegant way.
> - Open issue: what do to with the l2x0 stuff?
> ---
>  Documentation/devicetree/bindings/arm/arm-boards |  66 +++++++
>  Documentation/devicetree/bindings/arm/gic.txt    |   1 +
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/arm-realview-pb1176.dts        | 240 +++++++++++++++++++++++
>  arch/arm/mach-realview/Kconfig                   |  13 ++
>  arch/arm/mach-realview/Makefile                  |   1 +
>  arch/arm/mach-realview/realview-dt.c             |  72 +++++++
>  drivers/irqchip/irq-gic.c                        |   1 +
>  8 files changed, 395 insertions(+)
>  create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
>  create mode 100644 arch/arm/mach-realview/realview-dt.c
>
> diff --git a/Documentation/devicetree/bindings/arm/arm-boards b/Documentation/devicetree/bindings/arm/arm-boards
> index 3509707f9320..d2399e6f1378 100644
> --- a/Documentation/devicetree/bindings/arm/arm-boards
> +++ b/Documentation/devicetree/bindings/arm/arm-boards
> @@ -86,3 +86,69 @@ Interrupt controllers:
>         compatible = "arm,versatile-sic";
>         interrupt-controller;
>         #interrupt-cells = <1>;
> +
> +
> +ARM RealView Boards
> +-------------------
> +The RealView boards cover tailored evaluation boards that are used to explore
> +the ARM11 and Cortex A-8 and Cortex A-9 processors.
> +
> +Required properties (in root node):
> +       /* RealView Emulation Baseboard */
> +       compatible = "arm,realview-eb";
> +        /* RealView Platform Baseboard for ARM1176JZF-S */
> +       compatible = "arm,realview-pb1176";
> +       /* RealView Platform Baseboard for ARM11 MPCore */
> +       compatible = "arm,realview-pb11mp";
> +       /* RealView Platform Baseboard for Cortex A-8 */
> +       compatible = "arm,realview-pba8";
> +       /* RealView Platform Baseboard Explore for Cortex A-9 */
> +       compatible = "arm,realview-pbx";
> +
> +Required nodes:
> +
> +- soc: some node of the RealView platforms must be the SoC
> +  node that contain the SoC-specific devices, withe the compatible
> +  string set to one of these tuples:
> +   "simple-bus", "arm,realview-eb-soc"
> +   "simple-bus", "arm,realview-pb1176-soc"
> +   "simple-bus", "arm,realview-pb11mp-soc"
> +   "simple-bus", "arm,realview-pba8-soc"
> +   "simple-bus", "arm,realview-pbx-soc"

If you have simple-bus in a compatible list, it should come last. The
list is meant to go from most specific to least specific.

That'll need to be swapped in the example and dts too.

[...]

> +       soc {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               compatible = "simple-bus", "arm,realview-pb1176-soc";
> +               regmap = <&syscon>;
> +               ranges;
> +
> +               syscon: syscon at 10000000 {
> +                       compatible = "arm,realview-pb1176-syscon", "syscon";
> +                       reg = <0x10000000 0x1000>;
> +               };
> +
> +               reboot: reboot at 0x40 {
> +                       compatible = "arm,realview-pb1176-reboot";
> +                       regmap = <&syscon>;
> +               };

What's the @0x40 for?

Why don't we just have a property on the arm,realview-pb1176-syscon node
to say it can do reset (or just assume that it can)?

This looks like a leak of Linux internals, this isn't really a device.

[...]

> +               /* Primary DevChip GIC synthesized with the CPU */
> +               intc_dc1176: interrupt-controller at 10120000 {
> +                       compatible = "arm,arm1176jzf-gic";

As far as I am aware, the JZF flags haven nothing to do with the GIC
implementation. I think they can be dropped from this string (following
the example of "arm,arm1176-pmu").

> +                       #interrupt-cells = <3>;
> +                       #address-cells = <1>;
> +                       interrupt-controller;
> +                       reg = <0x10121000 0x1000>,
> +                             <0x10120000 0x100>;
> +               };
> +
> +               /* This GIC on the board is cascaded off the DevChip GIC */
> +               intc_pb1176: interrupt-controller at 10040000 {
> +                       compatible = "arm,arm1176jzf-gic";

And this isn't part of the CPU, so that string doesn't look right. I'd
at least like to see an additional string earlier in the list

> +                       #interrupt-cells = <3>;
> +                       #address-cells = <1>;
> +                       interrupt-controller;
> +                       reg = <0x10041000 0x1000>,
> +                             <0x10040000 0x100>;
> +                       interrupt-parent = <&intc_dc1176>;
> +                       interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
> +               };

[...]

> +static void __init realview_dt_init_machine(void)
> +{
> +       int ret;
> +
> +#if IS_ENABLED(CONFIG_CACHE_L2X0)
> +       if (of_machine_is_compatible("arm,realview-eb"))
> +               /*
> +                * 1MB (128KB/way), 8-way associativity,
> +                * evmon/parity/share enabled
> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +                */
> +               l2x0_of_init(0x00790000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pb1176"))
> +               /*
> +                * 128Kb (16Kb/way) 8-way associativity.
> +                * evmon/parity/share enabled.
> +                */
> +               l2x0_of_init(0x00730000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pb11mp"))
> +               /*
> +                * 1MB (128KB/way), 8-way associativity,
> +                * evmon/parity/share enabled
> +                * Bits:  .... ...0 0111 1001 0000 .... .... ....
> +                */
> +               l2x0_of_init(0x00730000, 0xfe000fff);
> +       else if (of_machine_is_compatible("arm,realview-pbx"))
> +               /*
> +                * 16KB way size, 8-way associativity, parity disabled
> +                * Bits:  .. 0 0 0 0 1 00 1 0 1 001 0 000 0 .... .... ....
> +                */
> +               l2x0_of_init(0x02520000, 0xc0000fff);
> +#endif

Are these just copied form what we already have for non-DT?

Do we know that these are all necessary?

> +DT_MACHINE_START(REALVIEW_DT, "ARM RealView Machine (Device Tree Support)")

As a general point, we seem to have so many different ways of formatting
this, and we should standardise.

Thanks,
Mark.
