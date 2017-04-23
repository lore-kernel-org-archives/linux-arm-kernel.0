From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:45 +0200
Subject: [PULL 35/79] arm: KVM: Treat CP15 accessors returning false as
 successful
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-36-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

Instead of considering that a CP15 accessor has failed when
returning false, let's consider that it is *always* successful
(after all, we won't stand for an incomplete emulation).

The return value now simply indicates whether we should skip
the instruction (because it has now been emulated), or if we
should leave the PC alone if the emulation has injected an
exception.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 519aac1..2c14b69 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -520,15 +520,15 @@ static int emulate_cp15(struct kvm_vcpu *vcpu,
 		if (likely(r->access(vcpu, params, r))) {
 			/* Skip instruction, since it was emulated */
 			kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-			return 1;
 		}
-		/* If access function fails, it should complain. */
 	} else {
+		/* If access function fails, it should complain. */
 		kvm_err("Unsupported guest CP15 access at: %08lx\n",
 			*vcpu_pc(vcpu));
 		print_cp_instr(params);
+		kvm_inject_undefined(vcpu);
 	}
-	kvm_inject_undefined(vcpu);
+
 	return 1;
 }
 
-- 
2.9.0
