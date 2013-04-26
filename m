From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 26 Apr 2013 13:41:28 +0100
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <20130426121433.GA16249@amd.pavel.ucw.cz>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
Message-ID: <20130426124128.GB6946@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On Fri, Apr 26, 2013 at 02:14:34PM +0200, Pavel Machek wrote:
> diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
> index 70b441a..22759f5 100644
> --- a/arch/arm/mach-picoxcell/common.c
> +++ b/arch/arm/mach-picoxcell/common.c
> @@ -84,11 +84,39 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
>  	}
>  }
>  
> +static const struct of_device_id picochip_rtc_ids[] __initconst = {
> +        { .compatible = "picochip,pc3x2-rtc" },
> +        { /* Sentinel */ },
> +};
> +
> +static void __iomem *sched_io_base;
> +
> +static u32 read_sched_clock(void)
> +{
> +        return __raw_readl(sched_io_base);
> +}
> +
> +static void __init timer_init(void)
> +{
> +	u32 rate;
> +
> +	dw_apb_timer_init(0);
> +
> +	sched_timer = of_find_matching_node(timer, osctimer_ids);
> +	if (!sched_timer)
> +		panic("No suitable timer for scheduler clock\n");
> +
> +	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
> +	of_node_put(sched_timer);

This doesn't work as osctimer_ids is private to the dw_apb_timer files 
as is timer_get_base_and_rate.  The other timer is unused in picoxcell 
though so dw_apb_timer_init(1), something like the patch below on top of 
yours.

Thanks,

Jamie


diff --git i/arch/arm/mach-picoxcell/common.c w/arch/arm/mach-picoxcell/common.c
index 1484841..a92d203 100644
--- i/arch/arm/mach-picoxcell/common.c
+++ w/arch/arm/mach-picoxcell/common.c
@@ -82,32 +82,9 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
 	}
 }
 
-static const struct of_device_id picochip_rtc_ids[] __initconst = {
-        { .compatible = "picochip,pc3x2-rtc" },
-        { /* Sentinel */ },
-};
-
-static void __iomem *sched_io_base;
-
-static u32 read_sched_clock(void)
-{
-        return __raw_readl(sched_io_base);
-}
-
 static void __init timer_init(void)
 {
-	u32 rate;
-
-	dw_apb_timer_init(0);
-
-	sched_timer = of_find_matching_node(timer, osctimer_ids);
-	if (!sched_timer)
-		panic("No suitable timer for scheduler clock\n");
-
-	timer_get_base_and_rate(sched_timer, &sched_io_base, &rate);
-	of_node_put(sched_timer);
-
-	setup_sched_clock(read_sched_clock, 32, rate);
+	dw_apb_timer_init(1);
 }
 
 DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
