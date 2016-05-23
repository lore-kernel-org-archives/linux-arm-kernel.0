From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 May 2016 09:50:56 +0100
Subject: [PATCH] drivers: nvmem: atmel-secumod: New driver for Atmel
 Secumod nvram
In-Reply-To: <1463605564-14397-1-git-send-email-davidm@egauge.net>
References: <20160518164259.GA28954@rob-hp-laptop>
 <1463605564-14397-1-git-send-email-davidm@egauge.net>
Message-ID: <5742C470.9080708@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the patch,
Few minors comments below.

On 18/05/16 22:06, David Mosberger-Tang wrote:
> Signed-off-by: David Mosberger <davidm@egauge.net>
> ---
>   .../devicetree/bindings/nvmem/atmel-secumod.txt    |  47 +++++++
>   drivers/nvmem/Kconfig                              |   7 +
>   drivers/nvmem/Makefile                             |   2 +
>   drivers/nvmem/atmel-secumod.c                      | 143 +++++++++++++++++++++
>   4 files changed, 199 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
>   create mode 100644 drivers/nvmem/atmel-secumod.c
>
> diff --git a/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> new file mode 100644
> index 0000000..d65cad5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/atmel-secumod.txt
> @@ -0,0 +1,47 @@
> += Atmel Secumod device tree bindings =
> +

Can you split the dt-bindings into separate patch.

> +This binding is intended to represent Atmel's Secumod which is found
> +in SAMA5D2 and perhaps others.
> +
> +Required properties:
> +- compatible: should be "atmel,sama5d2-secumod"
> +- reg: Should contain RAM location and length, followed
> +       by register location and length of the Secumod controller.
> +
> += Data cells =
> +Are child nodes of secumod, bindings of which as described in
> +bindings/nvmem/nvmem.txt
> +
> +Example:
> +
> +    secumod at fc040000 {
> +            compatible = "atmel,sama5d2-secumod";
> +            reg = <0xf8044000 0x1420>, <0xfc040000 0x4000>;
> +            reg-names = "SECURAM", "SECUMOD";
> +            status = "okay";
> +
> +            #address-cells = <1>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            secram-auto-erasable at 0 {
> +                    reg = <0x0000 0x1000>;
> +            };
> +            secram at 1000 {
> +                    reg = <0x1000 0x400>;
> +            };
> +            ram at 1400 {
> +                    reg = <0x1400 0x20>;
> +            };
> +    };
> +
> += Data consumers =
> +Are device nodes which consume nvmem data cells.
> +
> +For example:
> +
> +	ram {
> +		...
> +		nvmem-cells = <&ram>;
> +		nvmem-cell-names = "RAM";
> +	};
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 3041d48..88b21e3 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -101,4 +101,11 @@ config NVMEM_VF610_OCOTP
>   	  This driver can also be build as a module. If so, the module will
>   	  be called nvmem-vf610-ocotp.
>
> +config NVMEM_ATMEL_SECUMOD
> +       tristate "Atmel Secure Module driver"
> +       depends on ARCH_AT91

COMPILE_TEST ?
Also please add
depends on HAS_IOMEM

> +       help
> +         Select this to get support for the secure module (SECUMOD) built
> +	 into the SAMA5D2 chips.
> +
>   endif
...

> index 0000000..fc5a96b
> --- /dev/null
> +++ b/drivers/nvmem/atmel-secumod.c

...
> +
> +/*
> + * Security-module register definitions:
> + */
> +#define SECUMOD_RAMRDY	0x0014
> +
> +/*
> + * Since the secure module may need to automatically erase some of the
> + * RAM, it may take a while for it to be ready.  As far as I know,
> + * it's not documented how long this might take in the worst-case.
> + */
> +static void
> +secumod_wait_ready (void *regs)
> +{
> +	unsigned long start, stop;
> +
> +	start = jiffies;
> +	while (!(readl(regs + SECUMOD_RAMRDY) & 1))
> +		msleep_interruptible(1);

Worst case would be the system loop here forever, Can we add worst case 
timeout for this, and get out of this loop.

> +	stop = jiffies;
> +	if (stop != start)
> +		pr_info("nvmem-atmel-secumod: it took %u msec for SECUMOD "
> +			"to become ready...\n", jiffies_to_msecs(stop - start));
> +	else
> +		pr_info("nvmem-atmel-secumod: ready\n");
I dont see any use of this prints, We should probably remove these and 
add just a one dev_dbg.

> +}
> +
...
thanks,
srini
