From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Wed, 22 Jan 2014 20:12:51 +0530
Subject: [PATCH v7 4/6] KGDB: make kgdb_breakpoint() as noinline
In-Reply-To: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
References: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1390401773-12100-5-git-send-email-vijay.kilari@gmail.com>
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
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Jason Wessel <jason.wessel@windriver.com>
---
 kernel/debug/debug_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 7d2f35e..cf04798 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1034,7 +1034,7 @@ int dbg_io_get_char(void)
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
