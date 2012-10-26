From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 20:53:11 +0000
Subject: [GIT PULL] at91: fixes for 3.7-rc3
In-Reply-To: <5088F131.5040600@atmel.com>
References: <5088F131.5040600@atmel.com>
Message-ID: <201210262053.11498.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Nicolas Ferre wrote:
>       ARM: at91: fix external interrupts in non-DT case

This patch now leads to build errors with at91x40_defconfig,
which I've fixed up by applying the patch below on top.

Please yell if this is not the right fix.

	Arnd

commit 3a8852afde01682083028ee427e0678f9bbddd75
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Oct 26 22:49:09 2012 +0200

    ARM: at91: fix at91x40 build
    
    patch 738a0fd7 "ARM: at91: fix external interrupts in non-DT case"
    fixed a run-time error on some at91 platforms but did not apply
    the same change to at91x40, which now doesn't build.
    
    This changes at91x40 in the same way that the other platforms
    were changed.
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-at91/at91x40.c b/arch/arm/mach-at91/at91x40.c
index 6bd7300..bb7f544 100644
--- a/arch/arm/mach-at91/at91x40.c
+++ b/arch/arm/mach-at91/at91x40.c
@@ -88,6 +88,6 @@ void __init at91x40_init_interrupts(unsigned int priority[NR_AIC_IRQS])
 	if (!priority)
 		priority = at91x40_default_irq_priority;
 
-	at91_aic_init(priority);
+	at91_aic_init(priority, at91_extern_irq);
 }
 
