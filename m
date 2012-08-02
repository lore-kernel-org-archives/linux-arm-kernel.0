From: mturquette@ti.com (Mike Turquette)
Date: Thu, 2 Aug 2012 14:20:25 -0700
Subject: [PATCH] arm:davinci: clk - migrate to new common clock API
In-Reply-To: <1343926428-5210-1-git-send-email-m-karicheri2@ti.com>
References: <1343926428-5210-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <20120802212025.GI29410@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120802-12:53, Murali Karicheri wrote:
> As a first step towards migrating davinci platforms to use common clock
> framework, replace all instances of clk_enable() with clk_prepare_enable()
> and clk_disable() with clk_disable_unprepare(). Until the platform is
> switched to use the CONFIG_HAVE_CLK_PREPARE Kconfig variable, this just
> adds a might_sleep() call and would work without any issues.
> 
> This will make it easy later to switch to common clk based implementation
> of clk driver from DaVinci specific driver.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

Murali,

The important thing to know about clk_prepare is that it might sleep.
All of the functions below look like initialization functions for code
that is never run in interrupt context.  If you can confirm that this is
true then feel free to add my,

Reviewed-by: Mike Turquette <mturquette@linaro.org>

Regards,
Mike

> ---
>  arch/arm/mach-davinci/board-dm355-evm.c     |    2 +-
>  arch/arm/mach-davinci/board-dm355-leopard.c |    2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c     |    4 ++--
>  arch/arm/mach-davinci/board-dm644x-evm.c    |    2 +-
>  arch/arm/mach-davinci/board-neuros-osd2.c   |    2 +-
>  arch/arm/mach-davinci/devices-da8xx.c       |    6 +++---
>  arch/arm/mach-davinci/serial.c              |    2 +-
>  arch/arm/mach-davinci/time.c                |    4 ++--
>  8 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
> index 1c7b1f4..4821fba 100644
> --- a/arch/arm/mach-davinci/board-dm355-evm.c
> +++ b/arch/arm/mach-davinci/board-dm355-evm.c
> @@ -324,7 +324,7 @@ static __init void dm355_evm_init(void)
>  	if (IS_ERR(aemif))
>  		WARN("%s: unable to get AEMIF clock\n", __func__);
>  	else
> -		clk_enable(aemif);
> +		clk_prepare_enable(aemif);
>  
>  	platform_add_devices(davinci_evm_devices,
>  			     ARRAY_SIZE(davinci_evm_devices));
> diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
> index 8e77032..b754ccf 100644
> --- a/arch/arm/mach-davinci/board-dm355-leopard.c
> +++ b/arch/arm/mach-davinci/board-dm355-leopard.c
> @@ -246,7 +246,7 @@ static __init void dm355_leopard_init(void)
>  	if (IS_ERR(aemif))
>  		WARN("%s: unable to get AEMIF clock\n", __func__);
>  	else
> -		clk_enable(aemif);
> +		clk_prepare_enable(aemif);
>  
>  	platform_add_devices(davinci_leopard_devices,
>  			     ARRAY_SIZE(davinci_leopard_devices));
> diff --git a/arch/arm/mach-davinci/board-dm365-evm.c b/arch/arm/mach-davinci/board-dm365-evm.c
> index 2830692..3a4743b 100644
> --- a/arch/arm/mach-davinci/board-dm365-evm.c
> +++ b/arch/arm/mach-davinci/board-dm365-evm.c
> @@ -481,7 +481,7 @@ static void __init evm_init_cpld(void)
>  	aemif_clk = clk_get(NULL, "aemif");
>  	if (IS_ERR(aemif_clk))
>  		return;
> -	clk_enable(aemif_clk);
> +	clk_prepare_enable(aemif_clk);
>  
>  	if (request_mem_region(DM365_ASYNC_EMIF_DATA_CE1_BASE, SECTION_SIZE,
>  			"cpld") == NULL)
> @@ -492,7 +492,7 @@ static void __init evm_init_cpld(void)
>  				SECTION_SIZE);
>  fail:
>  		pr_err("ERROR: can't map CPLD\n");
> -		clk_disable(aemif_clk);
> +		clk_disable_unprepare(aemif_clk);
>  		return;
>  	}
>  
> diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
> index d34ed55..04ef708 100644
> --- a/arch/arm/mach-davinci/board-dm644x-evm.c
> +++ b/arch/arm/mach-davinci/board-dm644x-evm.c
> @@ -775,7 +775,7 @@ static __init void davinci_evm_init(void)
>  	struct davinci_soc_info *soc_info = &davinci_soc_info;
>  
>  	aemif_clk = clk_get(NULL, "aemif");
> -	clk_enable(aemif_clk);
> +	clk_prepare_enable(aemif_clk);
>  
>  	if (HAS_ATA) {
>  		if (HAS_NAND || HAS_NOR)
> diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
> index 5de69f2..7fdd0a7b 100644
> --- a/arch/arm/mach-davinci/board-neuros-osd2.c
> +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
> @@ -221,7 +221,7 @@ static __init void davinci_ntosd2_init(void)
>  	int	status;
>  
>  	aemif_clk = clk_get(NULL, "aemif");
> -	clk_enable(aemif_clk);
> +	clk_prepare_enable(aemif_clk);
>  
>  	if (HAS_ATA) {
>  		if (HAS_NAND)
> diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
> index d1624a3..20141f5 100644
> --- a/arch/arm/mach-davinci/devices-da8xx.c
> +++ b/arch/arm/mach-davinci/devices-da8xx.c
> @@ -905,7 +905,7 @@ static int da850_sata_init(struct device *dev, void __iomem *addr)
>  	if (IS_ERR(da850_sata_clk))
>  		return PTR_ERR(da850_sata_clk);
>  
> -	ret = clk_enable(da850_sata_clk);
> +	ret = clk_prepare_enable(da850_sata_clk);
>  	if (ret)
>  		goto err0;
>  
> @@ -936,7 +936,7 @@ static int da850_sata_init(struct device *dev, void __iomem *addr)
>  	return 0;
>  
>  err1:
> -	clk_disable(da850_sata_clk);
> +	clk_disable_unprepare(da850_sata_clk);
>  err0:
>  	clk_put(da850_sata_clk);
>  	return ret;
> @@ -944,7 +944,7 @@ err0:
>  
>  static void da850_sata_exit(struct device *dev)
>  {
> -	clk_disable(da850_sata_clk);
> +	clk_disable_unprepare(da850_sata_clk);
>  	clk_put(da850_sata_clk);
>  }
>  
> diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
> index 1875740..24ddb0d 100644
> --- a/arch/arm/mach-davinci/serial.c
> +++ b/arch/arm/mach-davinci/serial.c
> @@ -95,7 +95,7 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
>  			continue;
>  		}
>  
> -		clk_enable(uart_clk);
> +		clk_prepare_enable(uart_clk);
>  		p->uartclk = clk_get_rate(uart_clk);
>  
>  		if (!p->membase && p->mapbase) {
> diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
> index 75da315..9847938 100644
> --- a/arch/arm/mach-davinci/time.c
> +++ b/arch/arm/mach-davinci/time.c
> @@ -379,7 +379,7 @@ static void __init davinci_timer_init(void)
>  
>  	timer_clk = clk_get(NULL, "timer0");
>  	BUG_ON(IS_ERR(timer_clk));
> -	clk_enable(timer_clk);
> +	clk_prepare_enable(timer_clk);
>  
>  	/* init timer hw */
>  	timer_init();
> @@ -429,7 +429,7 @@ void davinci_watchdog_reset(struct platform_device *pdev)
>  	wd_clk = clk_get(&pdev->dev, NULL);
>  	if (WARN_ON(IS_ERR(wd_clk)))
>  		return;
> -	clk_enable(wd_clk);
> +	clk_prepare_enable(wd_clk);
>  
>  	/* disable, internal clock source */
>  	__raw_writel(0, base + TCR);
> -- 
> 1.7.9.5
> 
