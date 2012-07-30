From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 30 Jul 2012 04:58:10 -0700
Subject: [PATCH 01/11] kernel/debug: Make use of KGDB_REASON_NMI
In-Reply-To: <20120730115719.GA5742@lizard>
References: <20120730115719.GA5742@lizard>
Message-ID: <1343649500-18491-1-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently kernel never set KGDB_REASON_NMI. We do now, when we enter
KGDB/KDB from an NMI.

This is not to be confused with kgdb_nmicallback(), NMI callback is
an entry for the slave CPUs during CPUs roundup, but REASON_NMI is the
entry for the master CPU.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 kernel/debug/kdb/kdb_debugger.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/debug/kdb/kdb_debugger.c b/kernel/debug/kdb/kdb_debugger.c
index 8b68ce7..be7b33b 100644
--- a/kernel/debug/kdb/kdb_debugger.c
+++ b/kernel/debug/kdb/kdb_debugger.c
@@ -12,6 +12,7 @@
 #include <linux/kdb.h>
 #include <linux/kdebug.h>
 #include <linux/export.h>
+#include <linux/hardirq.h>
 #include "kdb_private.h"
 #include "../debug_core.h"
 
@@ -52,6 +53,9 @@ int kdb_stub(struct kgdb_state *ks)
 	if (atomic_read(&kgdb_setting_breakpoint))
 		reason = KDB_REASON_KEYBOARD;
 
+	if (in_nmi())
+		reason = KDB_REASON_NMI;
+
 	for (i = 0, bp = kdb_breakpoints; i < KDB_MAXBPT; i++, bp++) {
 		if ((bp->bp_enabled) && (bp->bp_addr == addr)) {
 			reason = KDB_REASON_BREAK;
-- 
1.7.10.4
