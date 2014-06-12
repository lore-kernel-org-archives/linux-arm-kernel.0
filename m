From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 12 Jun 2014 09:30:12 -0700
Subject: [PATCH v4 13/14] ARM64: KVM: set and get of sys registers in BE case
In-Reply-To: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1402590613-3341-14-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since size of all sys registers is always 8 bytes. Current
code is actually endian agnostic. Just clean it up a bit.
Removed comment about little endian. Change type of pointer
from 'void *' to 'u64 *' to enforce stronger type checking.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0324458..8e65e31 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -776,17 +776,15 @@ static struct sys_reg_desc invariant_sys_regs[] = {
 	  NULL, get_ctr_el0 },
 };
 
-static int reg_from_user(void *val, const void __user *uaddr, u64 id)
+static int reg_from_user(u64 *val, const void __user *uaddr, u64 id)
 {
-	/* This Just Works because we are little endian. */
 	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
 		return -EFAULT;
 	return 0;
 }
 
-static int reg_to_user(void __user *uaddr, const void *val, u64 id)
+static int reg_to_user(void __user *uaddr, const u64 *val, u64 id)
 {
-	/* This Just Works because we are little endian. */
 	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
 		return -EFAULT;
 	return 0;
-- 
1.8.1.4
