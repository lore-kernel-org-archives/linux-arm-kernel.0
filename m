From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Jul 2011 11:39:11 -0600
Subject: [PATCH 1/7] ARM: mmp: parse irq from DT
In-Reply-To: <1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
References: <1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACxGe6vGZ1H57NboKU7QnhNwb3RneWmGZjQpAQuzgsyyqLXncQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 8:24 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> Parse irq sepcifier from DT and translate it to Linux irq number.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?.../devicetree/bindings/arm/marvell/intc.txt ? ? ? | ?120 +++++++++++
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mmp/Makefile ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?arch/arm/mach-mmp/common.h ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mmp/intc.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ?223 ++++++++++++++++++++
> ?5 files changed, 347 insertions(+), 0 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/marvell/intc.txt
> ?create mode 100644 arch/arm/mach-mmp/intc.c
>
> diff --git a/Documentation/devicetree/bindings/arm/marvell/intc.txt b/Documentation/devicetree/bindings/arm/marvell/intc.txt
> new file mode 100644
> index 0000000..e730a16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/intc.txt
> @@ -0,0 +1,120 @@
> +* Interrupt Controller Binding for ARCH-MMP
> +
> +This binding specifies what properties must be available in device tree representation of an ARCH-MMP compliant interrupt controller.
> +
> +Required properties:
> +
> + ? ? ? - compatible: Specifies the compatibility list of the interrupt
> + ? ? ? ? controller. The type shall be <string> and the value shall be
> + ? ? ? ? "mrvl,mmp-intc" or "mrvl,mux-intc".
> + ? ? ? ? "mrvl,mmp-intc" is the base interrupt controller. It must be
> + ? ? ? ? included. "mrvl,mux-intc" is the expanded interrupt controller,
> + ? ? ? ? and it's optional.

Please encode the soc name into the compatible property.  Different
SoCs get different versions of IP blocks.  The compatible property is
the easiest way to differentiate between them.  New devices can always
claim compatibility with older ones to avoid needing an exhaustive
list in the device driver.  Both of these should be something like
"mrvl,<soc>-mmp-intc" and "mrvl,<soc>-mux-intc".

> +
> + ? ? ? - reg: Specified the base physical address(s) and size(s) of the
> + ? ? ? ? interrupt controller's addressable register space. The type
> + ? ? ? ? should be <prop-encoded-array>.
> +
> + ? ? ? - interrupt-controller: The presence of this property identifies
> + ? ? ? ? the node as interrupt controller. No property value should be
> + ? ? ? ? defined.
> +
> + ? ? ? - #interrupt-cells: Specifies the number of cells needed to encode
> + ? ? ? ? an interrupt source. The type should be <u32> and the value should
> + ? ? ? ? be 1.
> +
> + ? ? ? - #address-cells: Specifies the number of cells needed to encode an
> + ? ? ? ? address. The type should be <u32> and the value should be 1.
> +
> + ? ? ? - #size-cells: Specifies the number of cells need to encode an
> + ? ? ? ? size. The type should be <u32> and the value should be 1.

This is not a bus node.  It should not have #address-cells or #size-cells.

> +
> + ? ? ? - intc-numbers: Specifies the number of interrupts is supported in
> + ? ? ? ? this interrupt controller. The type should be <u32>.


> +
> +Optional properties:
> +
> + ? ? ? - intc-enable-mask: Specifies the masking value of interrupt
> + ? ? ? ? configuration register. The property is used in mmp-intc. The value
> + ? ? ? ? should be <u32>.

What is the purpose of having a mask register?  I would expect that
unused interrupts simply wouldn't be requested by any devices.

> +
> + ? ? ? - intc-status: Specifies the offset of status register. The property
> + ? ? ? ? is used in mux-intc. The type should be <u32>.
> +
> + ? ? ? - intc-mask: Specifies the offset of mask register. The property
> + ? ? ? ? is used in mux-intc. The type should be <u32>.
> +
> + ? ? ? - intc-mfp-edge: Specifies the address of mfp edge detection register.
> + ? ? ? ? The property is used while acking specified interrupt. The type
> + ? ? ? ? should be <prop-encoded-array>. The first cell indicates the address
> + ? ? ? ? of mfp edge detection register. The second cell indicates the
> + ? ? ? ? index of interrupt in current interrupt controller that should
> + ? ? ? ? handle mfp edge detection.

Use a "mrvl," prefix on the above non-standard properties.  Since the
4 properties above are all register offsets, the name should reflect
that.  Something like "mrvl,status-reg-offset"

Do the register offsets change with difference versions of the silicon?

> +
> +* Examples
> +
> +Example 1:
> +
> + ? ? ? /*
> + ? ? ? ?* base INTC
> + ? ? ? ?*/
> + ? ? ? mmp_intc: interrupt-controller at d4282000 {
> + ? ? ? ? ? ? ? /* Compatible with mmp-intc. */
> + ? ? ? ? ? ? ? compatible = "mrvl,mmp-intc";
> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <1>;
> + ? ? ? ? ? ? ? /* Offset address of 0xd4282000 and size of 0x400. */
> + ? ? ? ? ? ? ? reg = <0xd4282000 0x400>;
> +
> + ? ? ? ? ? ? ? #interrupt-cells = <1>;
> + ? ? ? ? ? ? ? interrupt-controller;
> +
> + ? ? ? ? ? ? ? /* 64 interrupts are supported in this INTC. */
> + ? ? ? ? ? ? ? intc-numbers = <64>;
> +
> + ? ? ? ? ? ? ? /* enable bits in configuration register */
> + ? ? ? ? ? ? ? intc-enable-mask = <0x20>;
> + ? ? ? };
> +
> +Example 2:
> +
> + ? ? ? /*
> + ? ? ? ?* mux INTC that is internal wired to base INTC
> + ? ? ? ?*/
> + ? ? ? mux_intc4: interrupt-controller at d4282150 {
> + ? ? ? ? ? ? ? compatible = "mrvl,mux-intc";
> + ? ? ? ? ? ? ? #address-cells = <1>;
> + ? ? ? ? ? ? ? #size-cells = <1>;
> + ? ? ? ? ? ? ? reg = <0xd4282000 0x400>;
> +
> + ? ? ? ? ? ? ? #interrupt-cells = <1>;
> + ? ? ? ? ? ? ? interrupt-controller;
> + ? ? ? ? ? ? ? interrupt-parent = <&mmp_intc>;
> +
> + ? ? ? ? ? ? ? /* interrupt source '4' of parent INTC. */
> + ? ? ? ? ? ? ? interrupts = <4>;
> +
> + ? ? ? ? ? ? ? /* 2 interrupts are supported in this INTC. */
> + ? ? ? ? ? ? ? intc-numbers = <2>;
> +
> + ? ? ? ? ? ? ? /* Status offset address of 0x150. */
> + ? ? ? ? ? ? ? intc-status = <0x150>;
> +
> + ? ? ? ? ? ? ? /* Mask offset address of 0x168. */
> + ? ? ? ? ? ? ? intc-mask = <0x168>;
> +
> + ? ? ? ? ? ? ? /* mfp register of 0xd401e2c4 & interrupt index of 1 */
> + ? ? ? ? ? ? ? intc-mfp-edge = <0xd401e2c4 1>;
> + ? ? ? };
> +
> +Example 3:
> + ? ? ? /*
> + ? ? ? ?* An interrupt generating device that is wired to an INTC.
> + ? ? ? ?*/
> + ? ? ? uart0: uart at d4030000 {
> + ? ? ? ? ? ? ? /* parent's '#interrupt-cells' property. */
> + ? ? ? ? ? ? ? interrupts = <27>;
> +
> + ? ? ? ? ? ? ? /* The INTC that this device is wired to. */
> + ? ? ? ? ? ? ? interrupt-parent = <&mmp_intc>;
> + ? ? ? };
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 17507b8..f18eb14 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -542,6 +542,7 @@ config ARCH_MMP
> ? ? ? ?select ARCH_REQUIRE_GPIOLIB
> ? ? ? ?select CLKDEV_LOOKUP
> ? ? ? ?select GENERIC_CLOCKEVENTS
> + ? ? ? select GENERIC_IRQ_CHIP
> ? ? ? ?select HAVE_SCHED_CLOCK
> ? ? ? ?select TICK_ONESHOT
> ? ? ? ?select PLAT_PXA
> diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
> index 5c68382..e7862ea 100644
> --- a/arch/arm/mach-mmp/Makefile
> +++ b/arch/arm/mach-mmp/Makefile
> @@ -4,6 +4,8 @@
>
> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ?+= common.o clock.o devices.o time.o
>
> +obj-$(CONFIG_OF_IRQ) ? ? ? ? ? += intc.o
> +

Do drivers already exist for the pxa interrupt controllers?  I would
expect the existing driver to be updated to include DT support instead
of writing an entirely new IRQ controller driver.

g.
