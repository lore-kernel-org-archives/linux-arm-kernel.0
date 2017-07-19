From: thgarnie@google.com (Thomas Garnier)
Date: Wed, 19 Jul 2017 10:59:00 -0700
Subject: [PATCH 3/3] arm64/syscalls: Move address limit check in loop
In-Reply-To: <20170719175900.124074-1-thgarnie@google.com>
References: <20170719175900.124074-1-thgarnie@google.com>
Message-ID: <20170719175900.124074-3-thgarnie@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original bug was reported on arm but I am fixing arm64 too because
it has a similar code pattern.

The work pending loop can call set_fs after addr_limit_user_check
removed the _TIF_FSCHECK flag. To prevent the infinite loop, move the
addr_limit_user_check call at the beginning of the loop.

Fixes: cf7de27ab351 ("arm64/syscalls: Check address limit on user-mode return")
Reported-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/arm64/kernel/signal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e3e3293d1123..8e2705983e1d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -751,10 +751,10 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 	 */
 	trace_hardirqs_off();
 
-	/* Check valid user FS if needed */
-	addr_limit_user_check();
-
 	do {
+		/* Check valid user FS if needed */
+		addr_limit_user_check();
+
 		if (thread_flags & _TIF_NEED_RESCHED) {
 			schedule();
 		} else {
-- 
2.14.0.rc0.284.gd933b75aa4-goog
