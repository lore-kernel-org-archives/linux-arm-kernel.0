From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:21 +0000
Subject: [RFC v3 PATCH 03/25] ARM: debug: allow debug_ll_addr for NOMMU
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building for NOMMU the following warning shows up:

arch/arm/plat-samsung/pm-debug.c: In function 's3c_pm_uart_base':
arch/arm/plat-samsung/pm-debug.c:61:2: error: implicit declaration of function 'debug_ll_addr' [-Werror=implicit-function-declaration]
  debug_ll_addr(&paddr, &vaddr);
  ^
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/plat-samsung/pm-debug.o] Error 1

It seems that commit a73b59c51ab2 ("ARM: compile fix for DEBUG_LL=y &&
MMU=n") unnecessary disallows debug_ll_addr from being used for !MMU
configurations. Commit message there has a error description:

arch/arm/kernel/debug.S: Assembler messages:
arch/arm/kernel/debug.S:104: Error: too many positional arguments

In fact, the root reason for that problem is likely that machine
dependent addruart macro took less parameters than debug_ll_addr was
passing. For instance, commit 0e17226f7cd2 ("ARM: SAMSUNG: Fixup
commit 4e6d488af37980d224cbf298224db6173673f362") addresses the
similar issue with the same signs.

So, debug_ll_addr has no anti-dependency on NOMMU, but still needs to
be adjusted for NOMMU case. addruart populates first two arguments
with PA and VA of UART. In case of NOMMU the second parameter doesn't
make sense - modify debug_ll_addr that PA is used where VA is
expected.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mach/map.h |    1 +
 arch/arm/kernel/debug.S         |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 6b86b9c..8832dbf 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -63,6 +63,7 @@ extern int ioremap_page(unsigned long virt, unsigned long phys,
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
 #define debug_ll_io_init() do { } while (0)
+extern void debug_ll_addr(unsigned long *paddr, unsigned long *vaddr);
 
 #endif
 
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index ea9646c..681b046 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -100,14 +100,16 @@ ENTRY(printch)
 		b	1b
 ENDPROC(printch)
 
-#ifdef CONFIG_MMU
 ENTRY(debug_ll_addr)
 		addruart r2, r3, ip
 		str	r2, [r0]
+#ifdef CONFIG_MMU
 		str	r3, [r1]
+#else
+		str	r2, [r1]
+#endif
 		ret	lr
 ENDPROC(debug_ll_addr)
-#endif
 
 #else
 
-- 
1.7.9.5
