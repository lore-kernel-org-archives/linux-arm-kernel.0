From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 13:49:13 -0500
Subject: [PATCH v4 08/14] KVM: ARM: World-switch implementation
In-Reply-To: <20121130171420.GC619@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154306.2836.93473.stgit@chazy-air>
 <20121119145758.GA3205@mudshark.cambridge.arm.com>
 <CANM98qJFFP=2ueyUpbN6x15XwtWXbgZjkMBaq2jVpqik4kT54Q@mail.gmail.com>
 <20121130151500.GC26289@mudshark.cambridge.arm.com>
 <CANM98q+TQZiXe3GLjcPpPVZz40emmizgnEmyZEju1ruKNR6EEQ@mail.gmail.com>
 <20121130171420.GC619@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJQBD3+iW0uCptXBgsPBuBBfuaT1FN3EivMywwD-oNi=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 12:14 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Nov 30, 2012 at 04:47:40PM +0000, Christoffer Dall wrote:
>> On Fri, Nov 30, 2012 at 10:15 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > At this point, VM1 is running and VM0:VCPU1 is running. VM0:VCPU0 is not
>> > running because physical CPU0 is handling an interrupt. The problem is that
>> > when VCPU0 *is* resumed, it will update the VMID of VM0 and could be
>> > scheduled in parallel with VCPU1 but with a different VMID.
>> >
>> > How do you avoid this in the current code?
>> >
>> I don't. Nice catch. Please apply your interesting brain to the following fix:)
>
> I'm far too sober to look at your patch right now, but I'll think about it
> over the weekend [I can't break it at a quick glance] :)
>
> In the meantime, can you think about whether the TLB operations need to run
> on every CPU please?
>
they don't we can invalidate the TLB and the icache using the inner
shareability domain. Here's a patch:

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index ad1390f..df1b753 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -146,6 +146,7 @@ struct kvm_one_reg;
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
 u64 kvm_call_hyp(void *hypfn, ...);
+void force_vm_exit(const cpumask_t *mask);

 #define KVM_ARCH_WANT_MMU_NOTIFIER
 struct kvm;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c4f631e..674592e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -405,9 +405,14 @@ int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
 	return v->mode == IN_GUEST_MODE;
 }

-static void reset_vm_context(void *info)
+/* Just ensure a guest exit from a particular CPU */
+static void exit_vm_noop(void *info)
 {
-	kvm_call_hyp(__kvm_flush_vm_context);
+}
+
+void force_vm_exit(const cpumask_t *mask)
+{
+	smp_call_function_many(mask, exit_vm_noop, NULL, true);
 }

 /**
@@ -445,17 +450,33 @@ static void update_vttbr(struct kvm *kvm)

 	spin_lock(&kvm_vmid_lock);

+	/*
+	 * We need to re-check the vmid_gen here to ensure that if another vcpu
+	 * already allocated a valid vmid for this vm, then this vcpu should
+	 * use the same vmid.
+	 */
+	if (!need_new_vmid_gen(kvm)) {
+		spin_unlock(&kvm_vmid_lock);
+		return;
+	}
+
 	/* First user of a new VMID generation? */
 	if (unlikely(kvm_next_vmid == 0)) {
 		atomic64_inc(&kvm_vmid_gen);
 		kvm_next_vmid = 1;

 		/*
-		 * On SMP we know no other CPUs can use this CPU's or
-		 * each other's VMID since the kvm_vmid_lock blocks
-		 * them from reentry to the guest.
+		 * On SMP we know no other CPUs can use this CPU's or each
+		 * other's VMID after force_vm_exit returns since the
+		 * kvm_vmid_lock blocks them from reentry to the guest.
+		 */
+		force_vm_exit(cpu_all_mask);
+		/*
+		 * Now broadcast TLB + ICACHE invalidation over the inner
+		 * shareable domain to make sure all data structures are
+		 * clean.
 		 */
-		on_each_cpu(reset_vm_context, NULL, 1);
+		kvm_call_hyp(__kvm_flush_vm_context);
 	}

 	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 8a1f2df..91bb9c5 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -63,14 +63,18 @@ ENTRY(__kvm_tlb_flush_vmid)
 ENDPROC(__kvm_tlb_flush_vmid)

 /********************************************************************
- * Flush TLBs and instruction caches of current CPU for all VMIDs
+ * Flush TLBs and instruction caches of all CPUs inside the inner-shareable
+ * domain, for all VMIDs
  *
  * void __kvm_flush_vm_context(void);
  */
 ENTRY(__kvm_flush_vm_context)
 	mov	r0, #0			@ rn parameter for c15 flushes is SBZ
-	mcr     p15, 4, r0, c8, c7, 4   @ Invalidate Non-secure Non-Hyp TLB
-	mcr     p15, 0, r0, c7, c5, 0   @ Invalidate instruction caches
+
+	/* Invalidate NS Non-Hyp TLB Inner Shareable (TLBIALLNSNHIS) */
+	mcr     p15, 4, r0, c8, c3, 4
+	/* Invalidate instruction caches Inner Shareable (ICIALLUIS) */
+	mcr     p15, 0, r0, c7, c1, 0
 	dsb
 	isb				@ Not necessary if followed by eret

-- 
1.7.9.5


-Christoffer
