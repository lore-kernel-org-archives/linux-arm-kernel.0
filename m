From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Mon, 13 Dec 2010 12:28:40 -0800
Subject: {PATCH] BCMRING maintainer change (was RE: [PATCH 02/24] ARM:
	bcmring: update clock source registration)
In-Reply-To: <9383297B60843144AC17878B479520F1129E584129@SJEXCHCCR01.corp.ad.broadcom.com>
References: <20101213191437.GN8665@n2100.arm.linux.org.uk>
	<E1PSDs3-0008CQ-FW@rmk-PC.arm.linux.org.uk>
	<9383297B60843144AC17878B479520F1129E584129@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADDDEFC6EE00@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is second time I submit this patch because there are complains about Leo 
Chen's email is not valid and reachable.

I am Jiandong Zheng working on BCMRING in Broadcom Canada Ltd. I am replacing 
Leo Chen (leochen at broadcom.com) as " ARM/BCMRING ARM ARCHITECTURE" and "
ARM/BCMRING MTD NAND DRIVER" maintainer from Broadcom as he is no longer the 
maintainer of these components.

Here is the patch to MAINTAINERS file in linux 2.6.36 about this change.

Signed-off-by: Jiandong Zheng <jdzheng@broadcom.com>

Subject: [PATCH] Change bcmring Maintainer list.

---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f2a2b8e..8968ba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -572,14 +572,14 @@ W:	http://maxim.org.za/at91_26.html
 S:	Maintained
 
 ARM/BCMRING ARM ARCHITECTURE
-M:	Leo Chen <leochen@broadcom.com>
+M:	Jiandong Zheng <jdzheng@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-bcmring
 
 ARM/BCMRING MTD NAND DRIVER
-M:	Leo Chen <leochen@broadcom.com>
+M:	Jiandong Zheng <jdzheng@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 L:	linux-mtd at lists.infradead.org
 S:	Maintained
-- 
1.7.1

Thanks,
JD (Jiandong) Zheng

> -----Original Message-----
> From: Russell King [mailto:rmk at arm.linux.org.uk] On Behalf Of Russell
> King - ARM Linux
> Sent: December 13, 2010 11:16 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Leo Chen; Scott Branden
> Subject: [PATCH 02/24] ARM: bcmring: update clock source registration
> 
> In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
> interfaces were added which simplify (and optimize) the selection of
> the
> divisor shift/mult constants.  Switch over to using this new interface.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Changes follow John Stultz' notes from his commit 
Acked-By: Scott Branden <sbranden@broadcom.com>
> ---
>  arch/arm/mach-bcmring/core.c |   14 ++++----------
>  1 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-
> bcmring/core.c
> index d3f959e..b91b1b0 100644
> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -294,7 +294,6 @@ static struct clocksource
> clocksource_bcmring_timer1 = {
>  	.rating = 200,
>  	.read = bcmring_get_cycles_timer1,
>  	.mask = CLOCKSOURCE_MASK(32),
> -	.shift = 20,
>  	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
>  };
> 
> @@ -303,7 +302,6 @@ static struct clocksource
> clocksource_bcmring_timer3 = {
>  	.rating = 100,
>  	.read = bcmring_get_cycles_timer3,
>  	.mask = CLOCKSOURCE_MASK(32),
> -	.shift = 20,
>  	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
>  };
> 
> @@ -316,10 +314,8 @@ static int __init bcmring_clocksource_init(void)
>  	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE |
> TIMER_CTRL_PERIODIC,
>  	       TIMER1_VA_BASE + TIMER_CTRL);
> 
> -	clocksource_bcmring_timer1.mult =
> -	    clocksource_khz2mult(TIMER1_FREQUENCY_MHZ * 1000,
> -				 clocksource_bcmring_timer1.shift);
> -	clocksource_register(&clocksource_bcmring_timer1);
> +	clocksource_register_khz(&clocksource_bcmring_timer1,
> +				 TIMER1_FREQUENCY_MHZ * 1000);
> 
>  	/* setup timer3 as free-running clocksource */
>  	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
> @@ -328,10 +324,8 @@ static int __init bcmring_clocksource_init(void)
>  	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE |
> TIMER_CTRL_PERIODIC,
>  	       TIMER3_VA_BASE + TIMER_CTRL);
> 
> -	clocksource_bcmring_timer3.mult =
> -	    clocksource_khz2mult(TIMER3_FREQUENCY_KHZ,
> -				 clocksource_bcmring_timer3.shift);
> -	clocksource_register(&clocksource_bcmring_timer3);
> +	clocksource_register_khz(&clocksource_bcmring_timer3,
> +				 TIMER3_FREQUENCY_KHZ);
> 
>  	return 0;
>  }
> --
> 1.6.2.5
> 
