From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 9 Jan 2018 13:19:04 -0200
Subject: [PATCH] ARM: vfp: Go back to using vfp_current_hw_state()
Message-ID: <1515511144-23644-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 384b38b66947 ("ARM: 7873/1: vfp: clear vfp_current_hw_state
for dying cpu") fixed the cpu dying notifier by using
vfp_current_hw_state(). However commit e5b61bafe704 ("arm: Convert VFP
hotplug notifiers to state machine") incorrectly used the original
vfp_force_reload() function in the cpu dying notifier.

Fix it by going back to the correct vfp_current_hw_state() usage.

Fixes: e5b61bafe704 ("arm: Convert VFP hotplug notifiers to state machine")
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index a71a48e..aa7496b 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -648,7 +648,7 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
  */
 static int vfp_dying_cpu(unsigned int cpu)
 {
-	vfp_force_reload(cpu, current_thread_info());
+	vfp_current_hw_state[cpu] = NULL;
 	return 0;
 }
 
-- 
2.7.4
