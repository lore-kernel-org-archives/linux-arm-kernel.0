From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jan 2018 16:06:22 -0200
Subject: [PATCH v2] ARM: vfp: Go back to clearing vfp_current_hw_state[]
Message-ID: <1516039582-5905-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Commit 384b38b66947 ("ARM: 7873/1: vfp: clear vfp_current_hw_state
for dying cpu") fixed the cpu dying notifier by clearing
vfp_current_hw_state[]. However commit e5b61bafe704 ("arm: Convert VFP
hotplug notifiers to state machine") incorrectly used the original
vfp_force_reload() function in the cpu dying notifier.

Fix it by going back to clearing vfp_current_hw_state[].

Fixes: e5b61bafe704 ("arm: Convert VFP hotplug notifiers to state machine")
Cc: linux-stable <stable@vger.kernel.org>
Reported-by: Kohji Okuno <okuno.kohji@jp.panasonic.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Improve the commit message

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
