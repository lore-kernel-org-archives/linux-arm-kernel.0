From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 5 Nov 2015 15:34:53 +0000
Subject: [PATCH v11 2/5] missing include asm/paravirt.h in cputime.c
In-Reply-To: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1511051502270.13541@kaball.uk.xensource.com>
Message-ID: <1446737696-9749-2-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add include asm/paravirt.h to cputime.c, as steal_account_process_tick
calls paravirt_steal_clock, which is defined in asm/paravirt.h.

The ifdef CONFIG_PARAVIRT is necessary because not all archs have an
asm/paravirt.h to include.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: mingo at redhat.com
CC: peterz at infradead.org

---

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
