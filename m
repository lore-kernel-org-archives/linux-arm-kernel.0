From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  7 Dec 2017 18:06:17 +0100
Subject: [PATCH v2 23/36] KVM: arm64: Prepare to handle traps on deferred EL0
 sysregs
In-Reply-To: <20171207170630.592-1-christoffer.dall@linaro.org>
References: <20171207170630.592-1-christoffer.dall@linaro.org>
Message-ID: <20171207170630.592-24-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can trap access to ACTLR_EL1 which we can later defer to only
save/restore during vcpu_load and vcpu_put, so let's read the value
directly from the CPU when necessary.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---

Notes:
    Changes since v1:
     - Fix bug in access_actlr that read the actlr_el1 and threw away the
       value.  Whoops.

 arch/arm64/kvm/sys_regs_generic_v8.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs_generic_v8.c b/arch/arm64/kvm/sys_regs_generic_v8.c
index 969ade1d333d..8df4b4301696 100644
--- a/arch/arm64/kvm/sys_regs_generic_v8.c
+++ b/arch/arm64/kvm/sys_regs_generic_v8.c
@@ -38,7 +38,10 @@ static bool access_actlr(struct kvm_vcpu *vcpu,
 	if (p->is_write)
 		return ignore_write(vcpu, p);
 
-	p->regval = vcpu_sys_reg(vcpu, ACTLR_EL1);
+	if (vcpu->arch.sysregs_loaded_on_cpu)
+		p->regval = read_sysreg(actlr_el1);
+	else
+		p->regval = vcpu_sys_reg(vcpu, ACTLR_EL1);
 	return true;
 }
 
-- 
2.14.2
