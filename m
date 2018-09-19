From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 19 Sep 2018 10:49:02 +0100
Subject: [PATCH 3/5] ARM: clean up per-processor check_bugs method call
In-Reply-To: <20180919094802.GH30658@n2100.armlinux.org.uk>
References: <20180919094802.GH30658@n2100.armlinux.org.uk>
Message-ID: <E1g2Z6U-0003eX-1M@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the per-processor type check_bugs() method in the same way as we
do other per-processor functions - move the "processor." detail into
proc-fns.h.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/proc-fns.h | 1 +
 arch/arm/kernel/bugs.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index e25f4392e1b2..30c499146320 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -99,6 +99,7 @@ extern void cpu_do_suspend(void *);
 extern void cpu_do_resume(void *);
 #else
 #define cpu_proc_init			processor._proc_init
+#define cpu_check_bugs			processor.check_bugs
 #define cpu_proc_fin			processor._proc_fin
 #define cpu_reset			processor.reset
 #define cpu_do_idle			processor._do_idle
diff --git a/arch/arm/kernel/bugs.c b/arch/arm/kernel/bugs.c
index 7be511310191..d41d3598e5e5 100644
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -6,8 +6,8 @@
 void check_other_bugs(void)
 {
 #ifdef MULTI_CPU
-	if (processor.check_bugs)
-		processor.check_bugs();
+	if (cpu_check_bugs)
+		cpu_check_bugs();
 #endif
 }
 
-- 
2.7.4
