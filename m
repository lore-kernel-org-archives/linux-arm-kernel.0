From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:14:05 -0700
Subject: [PATCH v3 13/14] ARM64: KVM: set and get of sys registers in BE case
In-Reply-To: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
References: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1399997646-4716-14-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch addresses issue of reading and writing V8 sys registers in
BE case. Since only register size function deals with is 8 bytes,
existing code works in both little and big endian cases.
Removed comment about little endian. Added BUG_ON that register
size should be always 8 bytes.

If these functions would ever need to support both 8 bytes and 4 bytes
register sizes to deals with them in endian agnostic way code should
do something along these lines:

       unsigned long regsize = KVM_REG_SIZE(id);
       union {
               u32     word;
               u64     dword;
       } tmp = {0};

       if (copy_from_user(&tmp, uaddr, regsize) != 0)
               return -EFAULT;
       switch (regsize) {
       case 4:
               *val = tmp.word;
               break;
       case 8:
               *val = tmp.dword;
               break;
       }

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm64/kvm/sys_regs.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0324458..060c3a9 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -776,18 +776,25 @@ static struct sys_reg_desc invariant_sys_regs[] = {
 	  NULL, get_ctr_el0 },
 };
 
-static int reg_from_user(void *val, const void __user *uaddr, u64 id)
+static int reg_from_user(u64 *val, const void __user *uaddr, u64 id)
 {
-	/* This Just Works because we are little endian. */
-	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
+	unsigned long regsize = KVM_REG_SIZE(id);
+
+	BUG_ON(regsize != 8);
+
+	if (copy_from_user(val, uaddr, regsize) != 0)
 		return -EFAULT;
+
 	return 0;
 }
 
-static int reg_to_user(void __user *uaddr, const void *val, u64 id)
+static int reg_to_user(void __user *uaddr, const u64 *val, u64 id)
 {
-	/* This Just Works because we are little endian. */
-	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
+	unsigned long regsize = KVM_REG_SIZE(id);
+
+	BUG_ON(regsize != 8);
+
+	if (copy_to_user(uaddr, val, regsize) != 0)
 		return -EFAULT;
 	return 0;
 }
-- 
1.8.1.4
