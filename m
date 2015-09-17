From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 17:05:35 +0200
Subject: [PATCH v2 7/9] rockchip: make sure timer5 is enabled on rk3036
 platforms
In-Reply-To: <1442486244-1833-1-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442486244-1833-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <11125723.j2J5LpAGi4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. September 2015, 18:37:24 schrieb Xing Zheng:
> The timer5 supplies the architected timer and thus as has to run when
> the system clocksource and clockevents drivers are registered.

please kindly ask the people doing uboot development to do this in uboot 
itself in future socs :-) - for example Simon's rk3288 mainline uboot does 
this correctly.


> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  arch/arm/mach-rockchip/rockchip.c |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rockchip.c
> b/arch/arm/mach-rockchip/rockchip.c index b6cf3b4..937047f 100644
> --- a/arch/arm/mach-rockchip/rockchip.c
> +++ b/arch/arm/mach-rockchip/rockchip.c
> @@ -32,6 +32,8 @@
>  #define RK3288_GRF_SOC_CON0 0x244
>  #define RK3288_TIMER6_7_PHYS 0xff810000
> 
> +#define RK3036_TIMER5_PHYS 0x200440a0
> +

#define RK3036_TIMER_PHYS 0x20044000
--> the actual base address of the timer block

As it looks like that we'll need to duplicate that timer init at least for the 
rk3036 and the timer ip in question is actually the same on both, please split 
out the actual work into a separate function like

static void rockchip_init_arch_timer_supply(resource_size_t phys, int offs)
{
		reg_base = ioremap(phys, SZ_16K);
		if (reg_base) {
			writel(0, reg_base + offs + 0x10);
			writel(0xffffffff, reg_base + offs);
			writel(0xffffffff, reg_base + offs + 0x04);
			writel(1, reg_base + offs + 0x10);
			dsb();
			iounmap(reg_base);
		} else {
			pr_err("rockchip: could not map timer registers\n");
		}
}

>  static void __init rockchip_timer_init(void)
>  {
>  	if (of_machine_is_compatible("rockchip,rk3288")) {
> @@ -64,6 +66,25 @@ static void __init rockchip_timer_init(void)

for the rk3288 exchange the timer init against
rockchip_init_arch_timer_supply(RK3288_TIMER6_7_PHYS, 0x20);


>  			regmap_write(grf, RK3288_GRF_SOC_CON0, 0x10000000);
>  		else
>  			pr_err("rockchip: could not get grf syscon\n");
> +	} else if (of_machine_is_compatible("rockchip,rk3036")) {
> +		void __iomem *reg_base;
> +
> +		/*
> +		 * Most/all uboot versions for rk3036 don't enable timer5
> +		 * which is needed for the architected timer to work.
> +		 * So make sure it is running during early boot.
> +		 */
> +		reg_base = ioremap(RK3036_TIMER5_PHYS, SZ_16K);
> +		if (reg_base) {
> +			writel(0, reg_base + 0x10);
> +			writel(0xffffffff, reg_base);
> +			writel(0xffffffff, reg_base + 0x04);
> +			writel(1, reg_base + 0x10);
> +			dsb();
> +			iounmap(reg_base);
> +		} else {
> +			pr_err("rockchip: could not map timer5 registers\n");
> +		}

rockchip_init_arch_timer_supply(RK3036_TIMER_PHYS, 0xa0);

>  	}
> 
>  	of_clk_init(NULL);
> @@ -79,6 +100,7 @@ static void __init rockchip_dt_init(void)
> 
>  static const char * const rockchip_board_dt_compat[] = {
>  	"rockchip,rk2928",
> +	"rockchip,rk3036",
>  	"rockchip,rk3066a",
>  	"rockchip,rk3066b",
>  	"rockchip,rk3188",
