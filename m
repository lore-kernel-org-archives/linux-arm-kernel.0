From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 22 May 2014 09:41:44 -0400
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140522134144.GL8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 12:08:16AM +0200, Linus Walleij wrote:
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
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
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
>  Documentation/devicetree/bindings/arm/arm-boards |  57 ++++++
>  Documentation/devicetree/bindings/arm/gic.txt    |   1 +
>  arch/arm/boot/dts/Makefile                       |   1 +
>  arch/arm/boot/dts/arm-realview-pb1176.dts        | 177 ++++++++++++++++++
>  arch/arm/mach-realview/Kconfig                   |  10 +
>  arch/arm/mach-realview/Makefile                  |   1 +
>  arch/arm/mach-realview/realview-dt.c             | 225 +++++++++++++++++++++++
>  arch/arm/mm/Kconfig                              |   2 +-
>  drivers/irqchip/irq-gic.c                        |   1 +
>  9 files changed, 474 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
>  create mode 100644 arch/arm/mach-realview/realview-dt.c
> 
...
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08d3180..539420194efd 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -16,6 +16,7 @@ Main node required properties:
>  	"arm,cortex-a9-gic"
>  	"arm,cortex-a7-gic"
>  	"arm,arm11mp-gic"
> +	"arm,arm1176jzf-gic"
>  - interrupt-controller : Identifies the node as an interrupt controller
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source.  The type shall be a <u32> and the value shall be 3.
...
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 57d165e026f4..70281b38c73b 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -1073,6 +1073,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(arm1176jzf_gic, "arm,arm1176jzf-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

Please place in alphabetical order.  We're starting to collect
compatible strings for this driver...

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
