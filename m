From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 22 Feb 2017 11:47:22 +0000
Subject: [PATCH 2/8] arm64: KVM: Let the vcpu carry a pointer to the sys_reg
 being emulated
In-Reply-To: <20170222114728.2472-1-marc.zyngier@arm.com>
References: <20170222114728.2472-1-marc.zyngier@arm.com>
Message-ID: <20170222114728.2472-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to propagate the pointer to the sys_reg descriptor
being currently emulated without having to rewrite a lot of the sys_reg
handling, let's allow the vcpu structure to have a pointer to the
current sys_reg_params.

The pointer is set in a helper function that calls the trap handler,
and reset just after.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  5 +++++
 arch/arm64/kvm/sys_regs.c         | 40 +++++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4a758cba1262..9dfce56de9c0 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -194,6 +194,8 @@ struct kvm_cpu_context {
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
 
+struct sys_reg_params;
+
 struct kvm_vcpu_arch {
 	struct kvm_cpu_context ctxt;
 
@@ -270,6 +272,9 @@ struct kvm_vcpu_arch {
 
 	/* Detect first run of a vcpu */
 	bool has_run_once;
+
+	/* system register emulation in progress */
+	struct sys_reg_params *sys_reg;
 };
 
 #define vcpu_gp_regs(v)		(&(v)->arch.ctxt.gp_regs)
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 7ac7fb021dde..33bad02c0a00 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1557,6 +1557,26 @@ int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+static bool perform_access(struct kvm_vcpu *vcpu,
+			   struct sys_reg_params *params,
+			   const struct sys_reg_desc *r)
+{
+	bool res;
+
+	/*
+	 * Not having an accessor means that we have configured a trap
+	 * that we don't know how to handle. This certainly qualifies
+	 * as a gross bug that should be fixed right away.
+	 */
+	BUG_ON(!r->access);
+
+	vcpu->arch.sys_reg = params;
+	res = r->access(vcpu, params, r);
+	vcpu->arch.sys_reg = NULL;
+
+	return res;
+}
+
 /*
  * emulate_cp --  tries to match a sys_reg access in a handling table, and
  *                call the corresponding trap handler.
@@ -1580,15 +1600,7 @@ static int emulate_cp(struct kvm_vcpu *vcpu,
 	r = find_reg(params, table, num);
 
 	if (r) {
-		/*
-		 * Not having an accessor means that we have
-		 * configured a trap that we don't know how to
-		 * handle. This certainly qualifies as a gross bug
-		 * that should be fixed right away.
-		 */
-		BUG_ON(!r->access);
-
-		if (likely(r->access(vcpu, params, r))) {
+		if (likely(perform_access(vcpu, params, r))) {
 			/* Skip instruction, since it was emulated */
 			if (!params->exception_pending)
 				kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
@@ -1766,15 +1778,7 @@ static int emulate_sys_reg(struct kvm_vcpu *vcpu,
 		r = find_reg(params, sys_reg_descs, ARRAY_SIZE(sys_reg_descs));
 
 	if (likely(r)) {
-		/*
-		 * Not having an accessor means that we have
-		 * configured a trap that we don't know how to
-		 * handle. This certainly qualifies as a gross bug
-		 * that should be fixed right away.
-		 */
-		BUG_ON(!r->access);
-
-		if (likely(r->access(vcpu, params, r))) {
+		if (likely(perform_access(vcpu, params, r))) {
 			/* Skip instruction, since it was emulated */
 			if (!params->exception_pending)
 				kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
-- 
2.11.0
