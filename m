From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 14:19:58 -0500
Subject: [PATCH v5 2/4] ARM: KVM: arch_timers: Add guest timer core support
In-Reply-To: <20130114151837.GC18935@mudshark.cambridge.arm.com>
References: <20130108184259.46758.17939.stgit@ubuntu>
 <20130108184320.46758.56628.stgit@ubuntu>
 <20130114151837.GC18935@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJZH0q-TU942pA363g4h-CENUPiA=b5D0hJyBwrHQ0g7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:18 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 08, 2013 at 06:43:20PM +0000, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Add some the architected timer related infrastructure, and support timer
>> interrupt injection, which can happen as a resultof three possible
>> events:
>>
>> - The virtual timer interrupt has fired while we were still
>>   executing the guest
>> - The timer interrupt hasn't fired, but it expired while we
>>   were doing the world switch
>> - A hrtimer we programmed earlier has fired
>
> [...]
>
>> +void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu)
>> +{
>> +       struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +
>> +       /*
>> +        * We're about to run this vcpu again, so there is no need to
>> +        * keep the background timer running, as we're about to
>> +        * populate the CPU timer again.
>> +        */
>> +       timer_disarm(timer);
>> +}
>> +
>> +void kvm_timer_sync_from_cpu(struct kvm_vcpu *vcpu)
>> +{
>> +       struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
>> +       cycle_t cval, now;
>> +       u64 ns;
>> +
>> +       /* Check if the timer is enabled and unmasked first */
>> +       if ((timer->cntv_ctl & 3) != 1)
>> +               return;
>> +
>> +       cval = timer->cntv_cval;
>> +       now = kvm_phys_timer_read() - vcpu->kvm->arch.timer.cntvoff;
>> +
>> +       BUG_ON(timer_is_armed(timer));
>> +
>> +       if (cval <= now) {
>> +               /*
>> +                * Timer has already expired while we were not
>> +                * looking. Inject the interrupt and carry on.
>> +                */
>> +               kvm_timer_inject_irq(vcpu);
>> +               return;
>> +       }
>> +
>> +       ns = cyclecounter_cyc2ns(timecounter->cc, cval - now);
>> +       timer_arm(timer, ns);
>> +}
>
> Please use flush/sync terminology to match the rest of arch/arm/.
>
ok, the following fixes this for both timers and the vgic:

commit 1b68f39459dbc797f6766c103edf2c1053984161
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 14:16:31 2013 -0500

    KVM: ARM: vgic: use sync/flush terminology

    Use sync/flush for saving state to/from CPUs to be consistent with
    other uses in arch/arm.

    Cc: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/include/asm/kvm_vgic.h b/arch/arm/include/asm/kvm_vgic.h
index 5e81e28..f5f270b 100644
--- a/arch/arm/include/asm/kvm_vgic.h
+++ b/arch/arm/include/asm/kvm_vgic.h
@@ -149,8 +149,8 @@ int kvm_vgic_hyp_init(void);
 int kvm_vgic_init(struct kvm *kvm);
 int kvm_vgic_create(struct kvm *kvm);
 int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu);
-void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu);
+void kvm_vgic_flush(struct kvm_vcpu *vcpu);
+void kvm_vgic_sync(struct kvm_vcpu *vcpu);
 int kvm_vgic_inject_irq(struct kvm *kvm, int cpuid, unsigned int irq_num,
 			bool level);
 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu);
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f986718..7921bc4 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -714,7 +714,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)

 		update_vttbr(vcpu->kvm);

-		kvm_vgic_sync_to_cpu(vcpu);
+		kvm_vgic_flush(vcpu);
 		kvm_timer_flush(vcpu);

 		local_irq_disable();
@@ -730,7 +730,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)
 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
 			kvm_timer_sync(vcpu);
-			kvm_vgic_sync_from_cpu(vcpu);
+			kvm_vgic_sync(vcpu);
 			continue;
 		}

@@ -770,7 +770,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)
 		 *************************************************************/

 		kvm_timer_sync(vcpu);
-		kvm_vgic_sync_from_cpu(vcpu);
+		kvm_vgic_sync(vcpu);

 		ret = handle_exit(vcpu, run, ret);
 	}
diff --git a/arch/arm/kvm/vgic.c b/arch/arm/kvm/vgic.c
index 7eb94fa..25daa07 100644
--- a/arch/arm/kvm/vgic.c
+++ b/arch/arm/kvm/vgic.c
@@ -946,7 +946,7 @@ static bool vgic_queue_hwirq(struct kvm_vcpu *vcpu, int irq)
  * Fill the list registers with pending interrupts before running the
  * guest.
  */
-static void __kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
+static void __kvm_vgic_flush(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1009,7 +1009,7 @@ static bool vgic_process_maintenance(struct
kvm_vcpu *vcpu)
 	 * We do not need to take the distributor lock here, since the only
 	 * action we perform is clearing the irq_active_bit for an EOIed
 	 * level interrupt.  There is a potential race with
-	 * the queuing of an interrupt in __kvm_sync_to_cpu(), where we check
+	 * the queuing of an interrupt in __kvm_vgic_flush(), where we check
 	 * if the interrupt is already active. Two possibilities:
 	 *
 	 * - The queuing is occurring on the same vcpu: cannot happen,
@@ -1055,7 +1055,7 @@ static bool vgic_process_maintenance(struct
kvm_vcpu *vcpu)
  * the distributor here (the irq_pending_on_cpu bit is safe to set),
  * so there is no need for taking its lock.
  */
-static void __kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
+static void __kvm_vgic_sync(struct kvm_vcpu *vcpu)
 {
 	struct vgic_cpu *vgic_cpu = &vcpu->arch.vgic_cpu;
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
@@ -1085,7 +1085,7 @@ static void __kvm_vgic_sync_from_cpu(struct
kvm_vcpu *vcpu)
 		set_bit(vcpu->vcpu_id, &dist->irq_pending_on_cpu);
 }

-void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
+void kvm_vgic_flush(struct kvm_vcpu *vcpu)
 {
 	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;

@@ -1093,16 +1093,16 @@ void kvm_vgic_sync_to_cpu(struct kvm_vcpu *vcpu)
 		return;

 	spin_lock(&dist->lock);
-	__kvm_vgic_sync_to_cpu(vcpu);
+	__kvm_vgic_flush(vcpu);
 	spin_unlock(&dist->lock);
 }

-void kvm_vgic_sync_from_cpu(struct kvm_vcpu *vcpu)
+void kvm_vgic_sync(struct kvm_vcpu *vcpu)
 {
 	if (!irqchip_in_kernel(vcpu->kvm))
 		return;

-	__kvm_vgic_sync_from_cpu(vcpu);
+	__kvm_vgic_sync(vcpu);
 }

 int kvm_vgic_vcpu_pending_irq(struct kvm_vcpu *vcpu)
--

commit b9e08fdd32b7f3da3ad0b287c4da575b3b6c23d7
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 14:15:31 2013 -0500

    KVM: ARM: timers: use sync/flush terminology

    Use sync/flush for saving state to/from CPUs to be consistent with other
    uses in arch/arm.

    Cc: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/include/asm/kvm_arch_timer.h
b/arch/arm/include/asm/kvm_arch_timer.h
index aed1c42..2af5096 100644
--- a/arch/arm/include/asm/kvm_arch_timer.h
+++ b/arch/arm/include/asm/kvm_arch_timer.h
@@ -62,8 +62,8 @@ struct arch_timer_cpu {
 int kvm_timer_hyp_init(void);
 int kvm_timer_init(struct kvm *kvm);
 void kvm_timer_vcpu_init(struct kvm_vcpu *vcpu);
-void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu);
-void kvm_timer_sync_from_cpu(struct kvm_vcpu *vcpu);
+void kvm_timer_flush(struct kvm_vcpu *vcpu);
+void kvm_timer_sync(struct kvm_vcpu *vcpu);
 void kvm_timer_vcpu_terminate(struct kvm_vcpu *vcpu);
 #else
 static inline int kvm_timer_hyp_init(void)
diff --git a/arch/arm/kvm/arch_timer.c b/arch/arm/kvm/arch_timer.c
index 6cb9aa3..3f2580f 100644
--- a/arch/arm/kvm/arch_timer.c
+++ b/arch/arm/kvm/arch_timer.c
@@ -101,7 +101,14 @@ static enum hrtimer_restart
kvm_timer_expire(struct hrtimer *hrt)
 	return HRTIMER_NORESTART;
 }

-void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu)
+/**
+ * kvm_timer_flush - prepare to move the virt timer to the cpu
+ * @vcpu: The vcpu pointer
+ *
+ * Disarm any pending soft timers, since the world-switch code will write the
+ * virtual timer state back to the physical CPU.
+ */
+void kvm_timer_flush(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;

@@ -113,7 +120,14 @@ void kvm_timer_sync_to_cpu(struct kvm_vcpu *vcpu)
 	timer_disarm(timer);
 }

-void kvm_timer_sync_from_cpu(struct kvm_vcpu *vcpu)
+/**
+ * kvm_timer_sync - sync timer state from cpu
+ * @vcpu: The vcpu pointer
+ *
+ * Check if the virtual timer was armed and either schedule a corresponding
+ * soft timer or inject directly if already expired.
+ */
+void kvm_timer_sync(struct kvm_vcpu *vcpu)
 {
 	struct arch_timer_cpu *timer = &vcpu->arch.timer_cpu;
 	cycle_t cval, now;
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index fdd4a7c..f986718 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -715,7 +715,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)
 		update_vttbr(vcpu->kvm);

 		kvm_vgic_sync_to_cpu(vcpu);
-		kvm_timer_sync_to_cpu(vcpu);
+		kvm_timer_flush(vcpu);

 		local_irq_disable();

@@ -729,7 +729,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)

 		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
 			local_irq_enable();
-			kvm_timer_sync_from_cpu(vcpu);
+			kvm_timer_sync(vcpu);
 			kvm_vgic_sync_from_cpu(vcpu);
 			continue;
 		}
@@ -769,7 +769,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)
 		 * Back from guest
 		 *************************************************************/

-		kvm_timer_sync_from_cpu(vcpu);
+		kvm_timer_sync(vcpu);
 		kvm_vgic_sync_from_cpu(vcpu);

 		ret = handle_exit(vcpu, run, ret);
--

Thanks,
-Christoffer
