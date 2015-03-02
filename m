From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 2 Mar 2015 18:50:27 +0800
Subject: [PATCH] ARM: at91: pm: fix SRAM allocation
In-Reply-To: <1425292978-28135-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425292978-28135-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <7E7AE962-1BBE-4B33-9563-B91351494005@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Mar 2, 2015, at 6:42 PM, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> On some platforms, there are multiple SRAM nodes defined in the device tree but
> some of them are disabled, leading to allocation failure. Try to find the first
> enabled SRAM node and allocate from it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> arch/arm/mach-at91/pm.c | 20 +++++++++-----------
> 1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index 5e34fb143309..97cc529b6fa0 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -272,35 +272,33 @@ static void __init at91_pm_sram_init(void)
> 	struct device_node *node;
> 	struct platform_device *pdev;

pdev not initialised at NULL
> 
> -	node = of_find_compatible_node(NULL, NULL, "mmio-sram");
> -	if (!node) {
> -		pr_warn("%s: failed to find sram node!\n", __func__);
> -		return;
> +	for_each_compatible_node(node, NULL, "mmio-sram") {
> +		pdev = of_find_device_by_node(node);
> +		if (pdev) {
> +			of_node_put(node);
> +			break;
> +		}
> 	}
> 
> -	pdev = of_find_device_by_node(node);
> 	if (!pdev) {
> 		pr_warn("%s: failed to find sram device!\n", __func__);
> -		goto put_node;
> +		return;
> 	}
> 
> 	sram_pool = dev_get_gen_pool(&pdev->dev);
> 	if (!sram_pool) {
> 		pr_warn("%s: sram pool unavailable!\n", __func__);
> -		goto put_node;
> +		return;
> 	}
> 
> 	sram_base = gen_pool_alloc(sram_pool, at91_slow_clock_sz);
> 	if (!sram_base) {
> 		pr_warn("%s: unable to alloc ocram!\n", __func__);
> -		goto put_node;
> +		return;
> 	}
> 
> 	sram_pbase = gen_pool_virt_to_phys(sram_pool, sram_base);
> 	slow_clock = __arm_ioremap_exec(sram_pbase, at91_slow_clock_sz, false);
> -
> -put_node:
> -	of_node_put(node);
> }
> #endif
> 
> -- 
> 2.1.0
> 
