From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 14:59:31 +0000
Subject: [PATCH v12 2/4] missing include asm/paravirt.h in cputime.c
In-Reply-To: <alpine.DEB.2.02.1511201434520.1107@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511201434520.1107@kaball.uk.xensource.com>
Message-ID: <1448031573-23497-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add include asm/paravirt.h to cputime.c, as steal_account_process_tick
calls paravirt_steal_clock, which is defined in asm/paravirt.h.

The ifdef CONFIG_PARAVIRT is necessary because not all archs have an
asm/paravirt.h to include.

The reason why currently cputime.c compiles, even though include
<asm/paravirt.h> is missing, is that on x86 asm/paravirt.h is included
by one of the other headers included in kernel/sched/cputime.c:

#include <kernel/sched/sched.h>
#include <linux/spinlock.h>
#include <linux/preempt.h>
#include <asm/preempt.h>
#include <linux/thread_info.h>
#include <asm/thread_info.h>
#include <asm/processor.h>
#include <asm/msr.h>
#include <asm/paravirt.h>

On arm and arm64, where I am about to introduce asm/paravirt.h and
stolen time support, without #include <asm/paravirt.h> in cputime.c, I
would get an error.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
CC: mingo at redhat.com
CC: peterz at infradead.org

---

Changes in v12:
- add more info to the commit message

Changes in v11:
- add ifdef CONFIG_PARAVIRT to cputime.c, because not all architectures
  have an asm/paravirt.h header file to include
- drop the removal of ifdef CONFIG_PARAVIRT from kernel/sched/core.c for
  the same reason
---
 kernel/sched/cputime.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 8cbc3db..c7a27c4 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -5,6 +5,9 @@
 #include <linux/static_key.h>
 #include <linux/context_tracking.h>
 #include "sched.h"
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#endif
 
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-- 
1.7.10.4
