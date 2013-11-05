From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Tue,  5 Nov 2013 14:15:46 +0530
Subject: [PATCH v4 4/4] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
References: <1383641146-27274-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1383641146-27274-5-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

The function kgdb_breakpoint() sets up break point at
compile time by calling arch_kgdb_breakpoint();
Though this call is surrounded by wmb() barrier,
the compile can still re-order the break point,
because this scheduling barrier is not a code motion
barrier in gcc.

Making kgdb_breakpoint() as noinline solves this problem
of code reording around break point instruction and also
avoids problem of being called as inline function from
other places

More details about discussion on this can be found here
http://comments.gmane.org/gmane.linux.ports.arm.kernel/269732

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 kernel/debug/debug_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0506d44..359ce6a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1006,7 +1006,7 @@ int dbg_io_get_char(void)
  * otherwise as a quick means to stop program execution and "break" into
  * the debugger.
  */
-void kgdb_breakpoint(void)
+noinline void kgdb_breakpoint(void)
 {
 	atomic_inc(&kgdb_setting_breakpoint);
 	wmb(); /* Sync point before breakpoint */
-- 
1.7.9.5
