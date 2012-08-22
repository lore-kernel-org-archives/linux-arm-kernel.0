From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 22 Aug 2012 22:52:18 +0800
Subject: [PATCH] ARM: fix cpu_relax() in case of doing dmb
Message-ID: <1345647138-8815-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an issue reported on imx6q restart function.  The issue is only
seen with the image building ARMv7 and ARMv6 together, where cpu_relax()
is define to do dmb.  It's been root-caused by Russell as below.

Russell King - ARM Linux wrote:
> I suspect having this dmb inside cpu_relax() is flooding the
> interconnects with traffic, which then prevents other CPUs getting
> a look-in (maybe there's no fairness when it comes to dmb's.

Fix the issue by insert a few NOPs into cpu_relax() where doing dmb.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/include/asm/processor.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 99afa74..7cc67ce 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -80,7 +80,14 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()			smp_mb()
+#define cpu_relax()		do {					\
+					asm("nop");			\
+					asm("nop");			\
+					asm("nop");			\
+					asm("nop");			\
+					asm("nop");			\
+					smp_mb();			\
+				} while (0)
 #else
 #define cpu_relax()			barrier()
 #endif
-- 
1.7.5.4
