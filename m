From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 10 Jul 2018 15:13:57 +0100
Subject: [PATCH 3/6] ARM: oabi-compat: copy semops using __copy_from_user()
In-Reply-To: <20180710141322.GL17271@n2100.armlinux.org.uk>
References: <20180710141322.GL17271@n2100.armlinux.org.uk>
Message-ID: <E1fctOv-0005v8-FF@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using __get_user_error(), copy each semops element using
__copy_from_user().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/sys_oabi-compat.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index b9786f491873..4abe4909417f 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -329,9 +329,11 @@ asmlinkage long sys_oabi_semtimedop(int semid,
 		return -ENOMEM;
 	err = 0;
 	for (i = 0; i < nsops; i++) {
-		__get_user_error(sops[i].sem_num, &tsops->sem_num, err);
-		__get_user_error(sops[i].sem_op,  &tsops->sem_op,  err);
-		__get_user_error(sops[i].sem_flg, &tsops->sem_flg, err);
+		struct oabi_sembuf osb;
+		err |= __copy_from_user(&osb, tsops, sizeof(osb));
+		sops[i].sem_num = osb.sem_num;
+		sops[i].sem_op = osb.sem_op;
+		sops[i].sem_flg = osb.sem_flg;
 		tsops++;
 	}
 	if (timeout) {
-- 
2.7.4
