From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 3 Nov 2015 16:21:01 +0000
Subject: [PATCH v10 2/5] missing include in cputime.c,
 remove #ifdef CONFIG_PARAVIRT from sched/core.c
In-Reply-To: <alpine.DEB.2.02.1511031536540.3438@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511031536540.3438@kaball.uk.xensource.com>
Message-ID: <1446567664-11890-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ifdef CONFIG_PARAVIRT in sched/core.c is redundant, as asm/paravirt.h
is already protected by #ifdef CONFIG_PARAVIRT.

Add include asm/paravirt.h to cputime.c, as steal_account_process_tick
calls paravirt_steal_clock, which is defined in paravirt.h.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org
---
 kernel/sched/core.c    |    2 --
 kernel/sched/cputime.c |    1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcd214e..395fad9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -79,9 +79,7 @@
 #include <asm/tlb.h>
 #include <asm/irq_regs.h>
 #include <asm/mutex.h>
-#ifdef CONFIG_PARAVIRT
 #include <asm/paravirt.h>
-#endif
 
 #include "sched.h"
 #include "../workqueue_internal.h"
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 8cbc3db..a1426fa 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,7 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#include <asm/paravirt.h>
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.10.4
