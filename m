From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 16 Aug 2012 14:40:02 +0200
Subject: [PATCH 5/6] ARM: integrator: convert AMBA devices to device tree
In-Reply-To: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
References: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120816124002.GB7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:16 Thu 16 Aug     , Linus Walleij wrote:
> This converts the AMBA (PrimeCell) devices on the Integrator/AP
> and Integrator/CP over to probing from the Device Tree if the
> kernel is compiled for Device Tree support.
> 
> We continue to #ifdef out all non-DT code and vice versa on
> respective boot type to get a clean cut.
> 
> We need to add a bunch of auxdata (compare to the Versatile)
> to handle bus names and callbacks alike.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/integratorap.dts       |  47 +++++++++++++
>  arch/arm/boot/dts/integratorcp.dts       |  64 ++++++++++++++++++
>  arch/arm/mach-integrator/common.h        |   2 +
>  arch/arm/mach-integrator/core.c          |   8 ++-
>  arch/arm/mach-integrator/integrator_ap.c | 109 ++++++++++++++++++++++---------
>  arch/arm/mach-integrator/integrator_cp.c |  97 +++++++++++++++++----------
>  6 files changed, 261 insertions(+), 66 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
> index a40d1ec0..303d001 100644
> --- a/arch/arm/boot/dts/integratorap.dts
> +++ b/arch/arm/boot/dts/integratorap.dts
> @@ -23,4 +23,51 @@
>  		clear-mask = <0xffffffff>;
>  		valid-mask = <0x003fffff>;
>  	};
> +
> +	fpga {
> +		compatible = "arm,amba-bus", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rtc: rtc at 15000000 {
> +			compatible = "arm,pl031", "arm,primecell";
> +			reg = <0x15000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <8>;
> +			arm,primecell-periphid = <0x00041030>;
> +		};
> +
> +		uart0: uart at 16000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x16000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <1>;
> +			arm,primecell-periphid = <0x00041010>;
> +		};
> +
> +		uart1: uart at 17000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x17000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <2>;
> +			arm,primecell-periphid = <0x00041010>;
> +		};
> +
> +		kmi0: kmi at 18000000 {
> +			compatible = "arm,pl050", "arm,primecell";
> +			reg = <0x18000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <3>;
> +			arm,primecell-periphid = <0x00041050>;
> +		};
> +
> +		kmi1: kmi at 19000000 {
> +			compatible = "arm,pl050", "arm,primecell";
> +			reg = <0x19000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <4>;
> +			arm,primecell-periphid = <0x00041050>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
> index b6ca10f..517d420 100644
> --- a/arch/arm/boot/dts/integratorcp.dts
> +++ b/arch/arm/boot/dts/integratorcp.dts
> @@ -43,4 +43,68 @@
>  		clear-mask = <0x00000fff>;
>  		valid-mask = <0x00000fff>;
>  	};
> +
> +	fpga {
> +		compatible = "arm,amba-bus", "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		rtc: rtc at 15000000 {
> +			compatible = "arm,pl031", "arm,primecell";
> +			reg = <0x15000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <8>;
> +		};
> +
> +		uart0: uart at 16000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x16000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <1>;
> +		};
> +
> +		uart1: uart at 17000000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x17000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <2>;
> +		};
> +
> +		kmi0: kmi at 18000000 {
> +			compatible = "arm,pl050", "arm,primecell";
> +			reg = <0x18000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <3>;
> +		};
> +
> +		kmi1: kmi at 19000000 {
> +			compatible = "arm,pl050", "arm,primecell";
> +			reg = <0x19000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <4>;
> +		};
> +
> +		mmci: mmc at 1C000000 {
> +			compatible = "arm,pl180", "arm,primecell";
> +			reg = <0x1C000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <23 24>;
> +			max-frequency = <515633>;
> +		};
> +
> +		aaci: aaci at 1D000000 {
> +			compatible = "arm,pl041", "arm,primecell";
> +			reg = <0x1D000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <25>;
> +		};
> +
> +		clcd: clcd at c0000000 {
> +			compatible = "arm,pl110", "arm,primecell";
> +			reg = <0xC0000000 0x1000>;
> +			interrupt-parent = <&pic>;
> +			interrupts = <22>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
> index c4338e2..c3ff21b 100644
> --- a/arch/arm/mach-integrator/common.h
> +++ b/arch/arm/mach-integrator/common.h
> @@ -1,3 +1,5 @@
> +#include <linux/amba/serial.h>
> +extern struct amba_pl010_data integrator_uart_data;
>  void integrator_init_early(void);
>  int integrator_init(bool is_cp);
>  void integrator_reserve(void);
> diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
> index 67ea181..42890c8 100644
> --- a/arch/arm/mach-integrator/core.c
> +++ b/arch/arm/mach-integrator/core.c
> @@ -33,7 +33,9 @@
>  #include <asm/mach/time.h>
>  #include <asm/pgtable.h>
>  
> -static struct amba_pl010_data integrator_uart_data;
> +#include "common.h"
> +
> +#ifndef CONFIG_OF
>  
>  #define INTEGRATOR_RTC_IRQ	{ IRQ_RTCINT }
>  #define INTEGRATOR_UART0_IRQ	{ IRQ_UARTINT0 }
> @@ -86,6 +88,8 @@ int __init integrator_init(bool is_cp)
>  	return 0;
>  }
>  
> +#endif
> +
>  /*
>   * On the Integrator platform, the port RTS and DTR are provided by
>   * bits in the following SC_CTRLS register bits:
> @@ -122,7 +126,7 @@ static void integrator_uart_set_mctrl(struct amba_device *dev, void __iomem *bas
>  	__raw_writel(ctrlc, SC_CTRLC);
>  }
>  
> -static struct amba_pl010_data integrator_uart_data = {
> +struct amba_pl010_data integrator_uart_data = {
>  	.set_mctrl = integrator_uart_set_mctrl,
>  };
>  
> diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
> index 58b0a58..ff20173 100644
> --- a/arch/arm/mach-integrator/integrator_ap.c
> +++ b/arch/arm/mach-integrator/integrator_ap.c
> @@ -35,6 +35,7 @@
>  #include <linux/clk.h>
>  #include <linux/platform_data/clk-integrator.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  #include <video/vga.h>
>  
>  #include <mach/hardware.h>
> @@ -270,36 +271,6 @@ static struct platform_device cfi_flash_device = {
>  	.resource	= &cfi_flash_resource,
>  };
>  
> -static void __init ap_init(void)
> -{
> -	unsigned long sc_dec;
> -	int i;
> -
> -	platform_device_register(&cfi_flash_device);
> -
> -	sc_dec = readl(VA_SC_BASE + INTEGRATOR_SC_DEC_OFFSET);
> -	for (i = 0; i < 4; i++) {
> -		struct lm_device *lmdev;
> -
> -		if ((sc_dec & (16 << i)) == 0)
> -			continue;
> -
> -		lmdev = kzalloc(sizeof(struct lm_device), GFP_KERNEL);
> -		if (!lmdev)
> -			continue;
> -
> -		lmdev->resource.start = 0xc0000000 + 0x10000000 * i;
> -		lmdev->resource.end = lmdev->resource.start + 0x0fffffff;
> -		lmdev->resource.flags = IORESOURCE_MEM;
> -		lmdev->irq = IRQ_AP_EXPINT0 + i;
> -		lmdev->id = i;
> -
> -		lm_device_register(lmdev);
> -	}
> -
> -	integrator_init(false);
> -}
> -
>  /*
>   * Where is the timer (VA)?
>   */
> @@ -472,6 +443,52 @@ static void __init ap_init_irq_of(void)
>  	integrator_clk_init(false);
>  }
>  
> +/* For the Device Tree, add in the UART callbacks as AUXDATA */
> +static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
> +		"rtc", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
> +		"uart0", &integrator_uart_data),
> +	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
> +		"uart1", &integrator_uart_data),
> +	OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
> +		"kmi0", NULL),
> +	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
> +		"kmi1", NULL),
> +	{ /* sentinel */ },
why that?

Best Regards,
J.
