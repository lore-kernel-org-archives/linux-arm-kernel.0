From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Jun 2018 13:20:54 +0100
Subject: [PATCH v3 2/6] arm64: KVM: Handle Set/Way CMOs as NOPs if FWB is
 present
In-Reply-To: <20180627122058.8210-1-marc.zyngier@arm.com>
References: <20180627122058.8210-1-marc.zyngier@arm.com>
Message-ID: <20180627122058.8210-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set/Way handling is one of the ugliest corners of KVM. We shouldn't
have to handle that, but better safe than sorry.

Thankfully, FWB fixes this for us by not requiering any maintenance
(the guest is forced to use cacheable memory, no matter what it says,
and the whole system is garanteed to be cache coherent), which means
we don't have to emulate S/W CMOs, and don't have to track VM ops either.

We still have to trap S/W though, if only to prevent the guest from
doing something bad.

Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a4363735d3f8..774d72155904 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -194,7 +194,16 @@ static bool access_dcsw(struct kvm_vcpu *vcpu,
 	if (!p->is_write)
 		return read_from_write_only(vcpu, p, r);
 
-	kvm_set_way_flush(vcpu);
+	/*
+	 * Only track S/W ops if we don't have FWB. It still indicates
+	 * that the guest is a bit broken (S/W operations should only
+	 * be done by firmware, knowing that there is only a single
+	 * CPU left in the system, and certainly not from non-secure
+	 * software).
+	 */
+	if (!cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
+		kvm_set_way_flush(vcpu);
+
 	return true;
 }
 
-- 
2.17.1
