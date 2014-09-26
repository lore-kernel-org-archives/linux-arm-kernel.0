From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 15:16:38 +0200
Subject: [PATCH 05/27] KVM: ARM/arm64: avoid returning negative error code as
 bool
In-Reply-To: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
References: <1411737420-9063-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1411737420-9063-6-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

is_valid_cache returns true if the specified cache is valid.
Unfortunately, if the parameter passed it out of range, we return
-ENOENT, which ends up as true leading to potential hilarity.

This patch returns false on the failure path instead.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/coproc.c     | 2 +-
 arch/arm64/kvm/sys_regs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 37a0fe1..7928dbd 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -791,7 +791,7 @@ static bool is_valid_cache(u32 val)
 	u32 level, ctype;
 
 	if (val >= CSSELR_MAX)
-		return -ENOENT;
+		return false;
 
 	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
         level = (val >> 1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5805e7c..4cc3b71 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1218,7 +1218,7 @@ static bool is_valid_cache(u32 val)
 	u32 level, ctype;
 
 	if (val >= CSSELR_MAX)
-		return -ENOENT;
+		return false;
 
 	/* Bottom bit is Instruction or Data bit.  Next 3 bits are level. */
 	level = (val >> 1);
-- 
2.0.0
