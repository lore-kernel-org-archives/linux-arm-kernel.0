From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Apr 2013 18:13:48 +0100
Subject: [PATCH] ARM: KVM: fix unbalanced get_cpu() in access_dcsw
Message-ID: <1365786828-548-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the very unlikely event where a guest would be foolish enough to
*read* from a write-only cache maintainance register, we end up
with preemption disabled, due to a misplaced get_cpu().

Just move the "is_write" test outside of the critical section.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/coproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 94eee8b..8eea97b 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -79,11 +79,11 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
 	unsigned long val;
 	int cpu;
 
-	cpu = get_cpu();
-
 	if (!p->is_write)
 		return read_from_write_only(vcpu, p);
 
+	cpu = get_cpu();
+
 	cpumask_setall(&vcpu->arch.require_dcache_flush);
 	cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
 
-- 
1.8.1.4
