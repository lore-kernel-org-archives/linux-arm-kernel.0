From: Barry.Song@csr.com (Barry Song)
Date: Mon, 16 Jul 2012 02:15:29 +0000
Subject: [PATCH v2 2/2] clk: prima2: move from arch/arm/mach to drivers/clk
In-Reply-To: <1342404403-12703-3-git-send-email-Barry.Song@csr.com>
References: <1342404403-12703-1-git-send-email-Barry.Song@csr.com>
 <1342404403-12703-3-git-send-email-Barry.Song@csr.com>
Message-ID: <5EB3BFCD089AD643B9BB63439F5FD5E90119B9D21D@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,
Sorry for the disoperation, this one is wrong, pls drop this and use:

"
From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-prima2/Makefile                      |    1 -
 drivers/clk/Makefile                               |    1 +
 .../mach-prima2/clock.c => drivers/clk/clk-sirf.c  |    0
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-prima2/clock.c => drivers/clk/clk-sirf.c (100%)
"

-barry

> -----Original Message-----
> From: Barry Song
> Sent: Monday, July 16, 2012 10:07 AM
> To: mturquette at ti.com
> Cc: linux-arm-kernel at lists.infradead.org; DL-SHA-WorkGroupLinux
> Subject: [PATCH v2 2/2] clk: prima2: move from arch/arm/mach to drivers/clk
> 
> -#define SIRFSOC_CLOCK_VA_BASE		SIRFSOC_VA(0x005000)
> +static void *sirfsoc_clk_vbase;
> 
>  #define KHZ     1000
>  #define MHZ     (KHZ * KHZ)
> @@ -91,12 +91,12 @@ static void std_clk_disable(struct clk_hw *hw);
> 
>  static inline unsigned long clkc_readl(unsigned reg)
>  {
> -	return readl(SIRFSOC_CLOCK_VA_BASE + reg);
> +	return readl(sirfsoc_clk_vbase + reg);
>  }
> 
>  static inline void clkc_writel(u32 val, unsigned reg)
>  {
> -	writel(val, SIRFSOC_CLOCK_VA_BASE + reg);
> +	writel(val, sirfsoc_clk_vbase + reg);
>  }
> 
>  /*
> @@ -944,9 +944,25 @@ static struct clk_std clk_security = {
>  	},
>  };
> 
> +static struct of_device_id clkc_ids[] = {
> +	{ .compatible = "sirf,prima2-clkc" },
> +	{},
> +};
> +
>  void __init sirfsoc_clk_init(void)
>  {
>  	struct clk *clk;
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, clkc_ids);
> +	if (!np)
> +		panic("unable to find compatible clkc node in dtb\n");
> +
> +	sirfsoc_clk_vbase = of_iomap(np, 0);
> +	if (!sirfsoc_clk_vbase)
> +		panic("unable to map clkc registers\n");
> +
> +	of_node_put(np);
> 
>  	/* These are always available (RTC and 26MHz OSC)*/
>  	clk = clk_register_fixed_rate(NULL, "rtc", NULL,
> @@ -1063,32 +1079,8 @@ void __init sirfsoc_clk_init(void)
>  	clkc_writel(0xFFFFFFFF, SIRFSOC_CLKC_CLK_EN1);
>  }
> 
> -static struct of_device_id clkc_ids[] = {
> -	{ .compatible = "sirf,prima2-clkc" },
> -	{},
> -};
> -
>  void __init sirfsoc_clk_map(void)
>  {
> -	struct device_node *np;
> -	struct resource res;
> -	struct map_desc sirfsoc_clkc_iodesc = {
> -		.virtual = SIRFSOC_CLOCK_VA_BASE,
> -		.type    = MT_DEVICE,
> -	};
> -
> -	np = of_find_matching_node(NULL, clkc_ids);
> -	if (!np)
> -		panic("unable to find compatible clkc node in dtb\n");
> -
> -	if (of_address_to_resource(np, 0, &res))
> -		panic("unable to find clkc range in dtb");
> -	of_node_put(np);
> -
> -	sirfsoc_clkc_iodesc.pfn = __phys_to_pfn(res.start);
> -	sirfsoc_clkc_iodesc.length = 1 + res.end - res.start;
> -
> -	iotable_init(&sirfsoc_clkc_iodesc, 1);
>  }
> 
>  /*


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
