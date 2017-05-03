From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed,  3 May 2017 17:51:40 +0300
Subject: [PATCH 2/3] asm-generic: don't #include <linux/atomic.h> in
 qspinlock_types.h
In-Reply-To: <20170503145141.4966-1-ynorov@caviumnetworks.com>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
Message-ID: <20170503145141.4966-3-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "qspinlock_types.h" doesn't need linux/atomic.h directly. So
because of this, and because including of it requires the protection
against recursive inclusion, it looks reasonable to move the
inclusion exactly where it is needed. This change affects the x86_64
arch, as the only user of qspinlocks at now. I have build-tested the
change on x86_64 with CONFIG_PARAVIRT enabled and disabled.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 include/asm-generic/qspinlock.h       | 1 +
 include/asm-generic/qspinlock_types.h | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
index 9f0681bf1e87..5f4d42a09175 100644
--- a/include/asm-generic/qspinlock.h
+++ b/include/asm-generic/qspinlock.h
@@ -20,6 +20,7 @@
 #define __ASM_GENERIC_QSPINLOCK_H
 
 #include <asm-generic/qspinlock_types.h>
+#include <linux/atomic.h>
 
 /**
  * queued_spin_unlock_wait - wait until the _current_ lock holder releases the lock
diff --git a/include/asm-generic/qspinlock_types.h b/include/asm-generic/qspinlock_types.h
index 034acd0c4956..a13cc90c87fc 100644
--- a/include/asm-generic/qspinlock_types.h
+++ b/include/asm-generic/qspinlock_types.h
@@ -18,15 +18,7 @@
 #ifndef __ASM_GENERIC_QSPINLOCK_TYPES_H
 #define __ASM_GENERIC_QSPINLOCK_TYPES_H
 
-/*
- * Including atomic.h with PARAVIRT on will cause compilation errors because
- * of recursive header file incluson via paravirt_types.h. So don't include
- * it if PARAVIRT is on.
- */
-#ifndef CONFIG_PARAVIRT
 #include <linux/types.h>
-#include <linux/atomic.h>
-#endif
 
 typedef struct qspinlock {
 	atomic_t	val;
-- 
2.11.0
