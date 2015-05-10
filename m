From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 10 May 2015 12:29:51 +0200
Subject: [rtc-linux] [PATCH v2 2/4] rtc: sa1100: convert to run-time
 register mapping
In-Reply-To: <1430426233-7461-3-git-send-email-robh@kernel.org>
References: <1430426233-7461-1-git-send-email-robh@kernel.org>
 <1430426233-7461-3-git-send-email-robh@kernel.org>
Message-ID: <20150510102951.GG3338@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/04/2015 at 15:37:11 -0500, Rob Herring wrote :
> SA1100 and PXA differ only in register offsets which are currently
> hardcoded in a machine specific header. Some arm64 platforms (PXA1928)
> have this RTC block as well (and not the PXA270 variant).
> 
> Convert the driver to use ioremap and set the register offsets dynamically.
> Since we are touching all the register accesses, convert them all to
> readl_relaxed/writel_relaxed.
> 
> Currently, the rtc-sa1100 and rtc-pxa drivers co-exist as rtc-pxa has a
> superset of functionality. This commit makes the drivers one step closer
> to being mutually exclusive by using devm_ioremap_resource and claiming
> the resource. The sharing of overlapping resources does not work if both
> drivers claim the resource. That is not done currently, but will be done
> as the drivers are converted to DT and follow proper driver rules.
> Likely, the common portion of the 2 drivers will be made into library
> functions for the SA1100 and PXA drivers to shared.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Cc: rtc-linux at googlegroups.com
> ---
> v2:
> - Rebase to v4.1-rc1
> - Use _relaxed accessors
> - Summarize discussion about supporting both SA1100 and PXA RTC drivers
> 
>  drivers/rtc/rtc-sa1100.c | 86 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
> index b6e1ca0..a21ead5 100644
> --- a/drivers/rtc/rtc-sa1100.c
> +++ b/drivers/rtc/rtc-sa1100.c
> @@ -35,12 +35,10 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> 
> -#include <mach/hardware.h>
> -#include <mach/irqs.h>
> -
> -#if defined(CONFIG_ARCH_PXA) || defined(CONFIG_ARCH_MMP)
> -#include <mach/regs-rtc.h>
> -#endif
> +#define RTSR_HZE	(1 << 3)	/* HZ interrupt enable */
> +#define RTSR_ALE	(1 << 2)	/* RTC alarm interrupt enable */
> +#define RTSR_HZ		(1 << 1)	/* HZ rising-edge detected */
> +#define RTSR_AL		(1 << 0)	/* RTC alarm detected */
> 

While at it, can you use BIT()?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
