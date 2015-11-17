From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 00:16:55 +0300
Subject: [PATCH v6 15/19] arm64: ilp32: force IPC_64 in msgctl, shmctl, semctl
In-Reply-To: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1447795019-30176-16-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Dakinevich <jan.dakinevich@gmail.com>

Reviewed-by: David Daney <ddaney@caviumnetworks.com>

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
---
 arch/arm64/kernel/sys_ilp32.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index c366d92..a2596f4 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -98,6 +98,25 @@ asmlinkage long compat_sys_statfs64_wrapper(void);
 
 #define compat_sys_pwritev	       compat_sys_pwritev64
 
+/* IPC_64 */
+asmlinkage long ilp32_sys_msgctl(int first, int second, void __user *uptr)
+{
+	return compat_sys_msgctl(first, second | IPC_64, uptr);
+}
+#define compat_sys_msgctl		ilp32_sys_msgctl
+
+asmlinkage long ilp32_sys_shmctl(int first, int second, void __user *uptr)
+{
+	return compat_sys_shmctl(first, second | IPC_64, uptr);
+}
+#define compat_sys_shmctl		ilp32_sys_shmctl
+
+asmlinkage long ilp32_sys_semctl(int first, int second, int third, int arg)
+{
+	return compat_sys_semctl(first, second, third | IPC_64, arg);
+}
+#define compat_sys_semctl	ilp32_sys_semctl
+
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-- 
2.1.4
