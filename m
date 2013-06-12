From: r64343@freescale.com (Jason Liu)
Date: Thu, 13 Jun 2013 07:19:40 +0800
Subject: [PATCH] ARM: smp_twd: twd_update_frequency need be run on all online
 CPUs
Message-ID: <1371079180-22344-1-git-send-email-r64343@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the local timer freq changed, the twd_update_frequency function
should be run all the CPUs include itself, otherwise, the twd freq will
not get updated and the local timer will not run correcttly.

smp_call_function will run functions on all other CPUs, but not include
himself, this is not correct,use on_each_cpu instead to fix this issue.

Signed-off-by: Jason Liu <r64343@freescale.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: stable at vger.kernel.org
---
 arch/arm/kernel/smp_twd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 90525d9..f6fd1d4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -120,7 +120,7 @@ static int twd_rate_change(struct notifier_block *nb,
 	 * changing cpu.
 	 */
 	if (flags == POST_RATE_CHANGE)
-		smp_call_function(twd_update_frequency,
+		on_each_cpu(twd_update_frequency,
 				  (void *)&cnd->new_rate, 1);
 
 	return NOTIFY_OK;
-- 
1.7.10.4
