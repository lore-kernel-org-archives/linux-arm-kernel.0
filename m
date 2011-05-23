From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 23 May 2011 14:33:27 +0100
Subject: [PATCH] ARM: fix missing 'cpu_relax()' declaration
Message-ID: <1306157607-18406-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM build fails with the following symptom:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:57,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/spinlock.h: In function 'spin_unlock_wait':
include/linux/spinlock.h:360: error: implicit declaration of function 'cpu_relax'
make[1]: *** [arch/arm/kernel/asm-offsets.s] Error 1

Fix it by including <asm/processor.h>.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/spinlock.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index fdd3820..65fa3c8 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -5,6 +5,8 @@
 #error SMP not supported on pre-ARMv6 CPUs
 #endif
 
+#include <asm/processor.h>
+
 /*
  * sev and wfe are ARMv6K extensions.  Uniprocessor ARMv6 may not have the K
  * extensions, so when running on UP, we have to patch these instructions away.
-- 
1.7.0.4
