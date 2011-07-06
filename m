From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:37 -0400
Subject: [PATCH 52/52] ARM: remove boot_params from struct machine_desc
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-52-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is no more users, we can remove it from the kernel.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/mach/arch.h |    1 -
 arch/arm/kernel/setup.c          |   19 -------------------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 1bdf6e1..e4e8e39 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -17,7 +17,6 @@ struct sys_timer;
 struct machine_desc {
 	unsigned int		nr;		/* architecture number	*/
 	const char		*name;		/* architecture name	*/
-	unsigned long		boot_params;	/* tagged list		*/
 	unsigned long		atag_offset;	/* tagged list (relative) */
 	const char		**dt_compat;	/* array of device tree
 						 * 'compatible' strings	*/
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4cc3e2b..fc9fc18 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -818,25 +818,6 @@ static struct machine_desc * __init setup_machine_tags(unsigned int nr)
 		tags = phys_to_virt(__atags_pointer);
 	else if(mdesc->atag_offset)
 		tags = PAGE_OFFSET + mdesc->atag_offset;
-	else if (mdesc->boot_params) {
-#ifdef CONFIG_MMU
-		/*
-		 * We still are executing with a minimal MMU mapping created
-		 * with the presumption that the machine default for this
-		 * is located in the first MB of RAM.  Anything else will
-		 * fault and silently hang the kernel at this point.
-		 */
-		if (mdesc->boot_params < PHYS_OFFSET ||
-		    mdesc->boot_params >= PHYS_OFFSET + SZ_1M) {
-			printk(KERN_WARNING
-			       "Default boot params at physical 0x%08lx out of reach\n",
-			       mdesc->boot_params);
-		} else
-#endif
-		{
-			tags = phys_to_virt(mdesc->boot_params);
-		}
-	}
 
 #if defined(CONFIG_DEPRECATED_PARAM_STRUCT)
 	/*
-- 
1.7.4
