From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 28 Nov 2012 15:51:42 +0530
Subject: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
In-Reply-To: <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
 <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
Message-ID: <50B5E5B6.9080107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/28/2012 7:45 AM, Jon Hunter wrote:
> When compiling the kernel with configuration options ...
> 
>  # CONFIG_ARCH_OMAP2 is not set
>  # CONFIG_ARCH_OMAP3 is not set
>  # CONFIG_ARCH_OMAP4 is not set
>  # CONFIG_SOC_OMAP5 is not set
>  CONFIG_SOC_AM33XX=y
> 
>  ... the following build warning is seen.
> 
>   CC      arch/arm/mach-omap2/timer.o
>   arch/arm/mach-omap2/timer.c:395:19: warning: ?omap2_sync32k_clocksource_init?
>   	defined but not used [-Wunused-function]
> 
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
> CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is no
> longer referenced by the timer initialisation function for the AM335x
> device as it has no 32k-sync timer.
> 
> Fix this by only including the omap2_sync32k_clocksource_init() function
> if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.
> 
> Cc: Igor Grinberg <grinberg@compulab.co.il>
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    3 +++
>  1 file changed, 3 insertions(+)
> 

Jon,

I applied all these patches and it fixes build warning and also I have
tested it on Bone platform without any issues.

I also ran parse on this and saw further warning,

  CHECK   arch/arm/mach-omap2/timer.c
arch/arm/mach-omap2/timer.c:193:13: warning: symbol 'omap_dmtimer_init'
was not declared. Should it be static?
arch/arm/mach-omap2/timer.c:213:12: warning: symbol
'omap_dm_timer_get_errata' was not declared. Should it be static?

Below patch fixes that too, feel free to merge it into your's


diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 085c7e7..1d1cfec 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -190,7 +190,7 @@ static struct device_node * __init
omap_get_timer_dt(struct of_device_id *match,
  * kernel registering these devices remove them dynamically from the device
  * tree on boot.
  */
-void __init omap_dmtimer_init(void)
+static void __init omap_dmtimer_init(void)
 {
        struct device_node *np;

@@ -210,7 +210,7 @@ void __init omap_dmtimer_init(void)
  *
  * Get the timer errata flags that are specific to the OMAP device
being used.
  */
-u32 __init omap_dm_timer_get_errata(void)
+static u32 __init omap_dm_timer_get_errata(void)
 {
        if (cpu_is_omap24xx())
                return 0;


Thanks,
Vaibhav
