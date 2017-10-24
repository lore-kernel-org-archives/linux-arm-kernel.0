From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 24 Oct 2017 16:02:33 +0100
Subject: [PATCH] drivers/firmware: psci_checker: Add missing
 destroy_timer_on_stack()
Message-ID: <1508857353-3602-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PSCI checker suspend_test_thread() function (ie executed for the
suspend test) requires an on-stack timer to carry out the test it
executes; it sets it up through the setup_timer_on_stack() API.

setup_timer_on_stack() requires its counterpart destroy_timer_on_stack()
to be called when the timer is disposed of but the PSCI checker code is
currently missing that call, leaving the timer object in an incosistent
state when the PSCI checker stops the thread executing the suspend
test.

Add the missing destroy_timer_on_stack() call to fix the omission.

Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Kees Cook <keescook@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 drivers/firmware/psci_checker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci_checker.c
index 6523ce9..56cf825 100644
--- a/drivers/firmware/psci_checker.c
+++ b/drivers/firmware/psci_checker.c
@@ -340,6 +340,7 @@ static int suspend_test_thread(void *arg)
 	 * later.
 	 */
 	del_timer(&wakeup_timer);
+	destroy_timer_on_stack(&wakeup_timer);
 
 	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
 		complete(&suspend_threads_done);
-- 
2.4.12
