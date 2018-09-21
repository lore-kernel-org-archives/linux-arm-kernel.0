From: james.morse@arm.com (James Morse)
Date: Fri, 21 Sep 2018 21:49:19 +0100
Subject: [PATCH] arm64: KVM: Guests can skip __install_bp_hardening_cb()s HYP
 work
Message-ID: <20180921204919.5790-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable_smccc_arch_workaround_1() passes NULL as the hyp_vecs start and
end if the HVC conduit is in use, and ARM_SMCCC_ARCH_WORKAROUND_1 is
detected.

If the guest kernel happened to be built with KVM_INDIRECT_VECTORS,
we go on to allocate a slot, memcpy() the empty workaround in and
do the appropriate cache maintenance.

This works as we always tell memcpy() the range is 0, so it never
accesses the NULL src pointer, but we still do the cache maintenance.

If hyp_vecs_start is NULL we know we're a guest, just update the fn
like the !KVM_INDIRECT_VECTORS version.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index dec10898d688..25305f8a8670 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -116,6 +116,15 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 	static DEFINE_SPINLOCK(bp_lock);
 	int cpu, slot = -1;
 
+	/*
+	 * enable_smccc_arch_workaround_1() passes NULL for the hyp_vecs
+	 * start/end if we're a guest. Skip the hyp-vectors work.
+	 */
+	if (!hyp_vecs_start) {
+		__this_cpu_write(bp_hardening_data.fn, fn);
+		return;
+	}
+
 	spin_lock(&bp_lock);
 	for_each_possible_cpu(cpu) {
 		if (per_cpu(bp_hardening_data.fn, cpu) == fn) {
-- 
2.18.0
