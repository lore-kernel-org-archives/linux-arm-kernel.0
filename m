From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sun, 20 Jan 2013 18:35:51 -0500
Subject: [PATCH v6 14/15] KVM: ARM: Power State Coordination Interface
 implementation
In-Reply-To: <50F81EF4.4020507@arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130116175918.29147.318.stgit@ubuntu> <50F81EF4.4020507@arm.com>
Message-ID: <CANM98q+z2tj72qFtjDF1ZpKMGs876=hRLpKTEwYKnpCMzdpErg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 10:55 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 16/01/13 17:59, Christoffer Dall wrote:
>> From: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Implement the PSCI specification (ARM DEN 0022A) to control
>> virtual CPUs being "powered" on or off.
>>
>> PSCI/KVM is detected using the KVM_CAP_ARM_PSCI capability.
>>
>> A virtual CPU can now be initialized in a "powered off" state,
>> using the KVM_ARM_VCPU_POWER_OFF feature flag.
>>
>> The guest can use either SMC or HVC to execute a PSCI function.
>>
>> Reviewed-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> A few bits went wrong when you reworked this patch. See below.
>
>> ---
>>  Documentation/virtual/kvm/api.txt  |    4 +
>>  arch/arm/include/asm/kvm_emulate.h |    5 ++
>>  arch/arm/include/asm/kvm_host.h    |    5 +-
>>  arch/arm/include/asm/kvm_psci.h    |   23 ++++++++
>>  arch/arm/include/uapi/asm/kvm.h    |   16 +++++
>>  arch/arm/kvm/Makefile              |    2 -
>>  arch/arm/kvm/arm.c                 |   28 +++++++++-
>>  arch/arm/kvm/psci.c                |  105 ++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/kvm.h           |    1
>>  9 files changed, 184 insertions(+), 5 deletions(-)
>>  create mode 100644 arch/arm/include/asm/kvm_psci.h
>>  create mode 100644 arch/arm/kvm/psci.c
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 38066a7a..c25439a 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2185,6 +2185,10 @@ return ENOEXEC for that vcpu.
>>  Note that because some registers reflect machine topology, all vcpus
>>  should be created before this ioctl is invoked.
>>
>> +Possible features:
>> +     - KVM_ARM_VCPU_POWER_OFF: Starts the CPU in a power-off state.
>> +       Depends on KVM_CAP_ARM_PSCI.
>> +
>>
>>  4.78 KVM_GET_REG_LIST
>>
>> diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
>> index 4c1a073..ba07de9 100644
>> --- a/arch/arm/include/asm/kvm_emulate.h
>> +++ b/arch/arm/include/asm/kvm_emulate.h
>> @@ -32,6 +32,11 @@ void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>>  void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>  void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
>>
>> +static inline bool vcpu_mode_is_32bit(struct kvm_vcpu *vcpu)
>> +{
>> +     return 1;
>> +}
>> +
>>  static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
>>  {
>>       return (u32 *)&vcpu->arch.regs.usr_regs.ARM_pc;
>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>> index e65fc96..c9ba918 100644
>> --- a/arch/arm/include/asm/kvm_host.h
>> +++ b/arch/arm/include/asm/kvm_host.h
>> @@ -30,7 +30,7 @@
>>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
>>  #define KVM_HAVE_ONE_REG
>>
>> -#define KVM_VCPU_MAX_FEATURES 0
>> +#define KVM_VCPU_MAX_FEATURES 1
>>
>>  /* We don't currently support large pages. */
>>  #define KVM_HPAGE_GFN_SHIFT(x)       0
>> @@ -100,6 +100,9 @@ struct kvm_vcpu_arch {
>>       int last_pcpu;
>>       cpumask_t require_dcache_flush;
>>
>> +     /* Don't run the guest: see copy_current_insn() */
>
> Now that you made this field PSCI-specific, how about rewording the comment?
>

yeah, that would work. And actually it's kind of broken, because if we
sent a paused VCPU a signal and that VCPU is never woken up using the
PSCI call we'll busy spin in the kernel, which is sad :(

This should eventually be moved to the vcpu requests infrastructure,
but I'll send some preparatory patches to the kvm first, so let's fix
it in the right way later on (requires reworking the run loop quite a
bit), and for now simply fix the pause clause, see patch below.

>> +     bool pause;
>> +
>>       /* IO related fields */
>>       struct kvm_decode mmio_decode;
>>
>> diff --git a/arch/arm/include/asm/kvm_psci.h b/arch/arm/include/asm/kvm_psci.h
>> new file mode 100644
>> index 0000000..9a83d98
>> --- /dev/null
>> +++ b/arch/arm/include/asm/kvm_psci.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Copyright (C) 2012 - ARM Ltd
>> + * Author: Marc Zyngier <marc.zyngier@arm.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#ifndef __ARM_KVM_PSCI_H__
>> +#define __ARM_KVM_PSCI_H__
>> +
>> +bool kvm_psci_call(struct kvm_vcpu *vcpu);
>> +
>> +#endif /* __ARM_KVM_PSCI_H__ */
>> diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
>> index bbb6b23..3303ff5 100644
>> --- a/arch/arm/include/uapi/asm/kvm.h
>> +++ b/arch/arm/include/uapi/asm/kvm.h
>> @@ -65,6 +65,8 @@ struct kvm_regs {
>>  #define KVM_ARM_TARGET_CORTEX_A15    0
>>  #define KVM_ARM_NUM_TARGETS          1
>>
>> +#define KVM_ARM_VCPU_POWER_OFF               0 /* CPU is started in OFF state */
>> +
>>  struct kvm_vcpu_init {
>>       __u32 target;
>>       __u32 features[7];
>> @@ -145,4 +147,18 @@ struct kvm_arch_memory_slot {
>>  /* Highest supported SPI, from VGIC_NR_IRQS */
>>  #define KVM_ARM_IRQ_GIC_MAX          127
>>
>> +/* PSCI interface */
>> +#define KVM_PSCI_FN_BASE             0x95c1ba5e
>> +#define KVM_PSCI_FN(n)                       (KVM_PSCI_FN_BASE + (n))
>> +
>> +#define KVM_PSCI_FN_CPU_SUSPEND              KVM_PSCI_FN(0)
>> +#define KVM_PSCI_FN_CPU_OFF          KVM_PSCI_FN(1)
>> +#define KVM_PSCI_FN_CPU_ON           KVM_PSCI_FN(2)
>> +#define KVM_PSCI_FN_MIGRATE          KVM_PSCI_FN(3)
>> +
>> +#define KVM_PSCI_RET_SUCCESS         0
>> +#define KVM_PSCI_RET_NI                      ((unsigned long)-1)
>> +#define KVM_PSCI_RET_INVAL           ((unsigned long)-2)
>> +#define KVM_PSCI_RET_DENIED          ((unsigned long)-3)
>> +
>>  #endif /* __ARM_KVM_H__ */
>> diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
>> index 1e45cd9..ea27987 100644
>> --- a/arch/arm/kvm/Makefile
>> +++ b/arch/arm/kvm/Makefile
>> @@ -18,4 +18,4 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
>>
>>  obj-y += kvm-arm.o init.o interrupts.o
>>  obj-y += arm.o guest.o mmu.o emulate.o reset.o
>> -obj-y += coproc.o coproc_a15.o mmio.o
>> +obj-y += coproc.o coproc_a15.o mmio.o psci.o
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 3168b9d..6ff5337 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -43,6 +43,7 @@
>>  #include <asm/kvm_mmu.h>
>>  #include <asm/kvm_emulate.h>
>>  #include <asm/kvm_coproc.h>
>> +#include <asm/kvm_psci.h>
>>  #include <asm/opcodes.h>
>>
>>  #ifdef REQUIRES_VIRT
>> @@ -160,6 +161,7 @@ int kvm_dev_ioctl_check_extension(long ext)
>>       case KVM_CAP_SYNC_MMU:
>>       case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
>>       case KVM_CAP_ONE_REG:
>> +     case KVM_CAP_ARM_PSCI:
>>               r = 1;
>>               break;
>>       case KVM_CAP_COALESCED_MMIO:
>> @@ -443,13 +445,17 @@ static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>       trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
>>                     vcpu->arch.hsr & HSR_HVC_IMM_MASK);
>>
>> +     if (kvm_psci_call(vcpu))
>> +             return 1;
>> +
>>       return 1;
>
> No undef injection if there is no PSCI match?
>
>>  }
>>
>>  static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
>>  {
>> -     /* We don't support SMC; don't do that. */
>> -     kvm_debug("smc: at %08x", *vcpu_pc(vcpu));
>> +     if (!kvm_psci_call(vcpu))
>
> Looks like you got the return value backward here.
>

yeah, I missed that call completely.

>> +             return 1;
>> +
>>       kvm_inject_undefined(vcpu);
>>       return 1;
>>  }
>
Thanks, see this patch:

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 751aa86..d1736a5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -113,7 +113,7 @@ struct kvm_vcpu_arch {
 	int last_pcpu;
 	cpumask_t require_dcache_flush;

-	/* Don't run the guest: see copy_current_insn() */
+	/* Don't run the guest on this vcpu */
 	bool pause;

 	/* IO related fields */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index a67392a..2819575 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -502,7 +502,7 @@ static int handle_hvc(struct kvm_vcpu *vcpu,
struct kvm_run *run)

 static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
 {
-	if (!kvm_psci_call(vcpu))
+	if (kvm_psci_call(vcpu))
 		return 1;

 	kvm_inject_undefined(vcpu);
@@ -667,6 +667,13 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
 	return 0;
 }

+static void vcpu_pause(struct kvm_vcpu *vcpu)
+{
+	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
+
+	wait_event_interruptible(*wq, !vcpu->arch.pause);
+}
+
 /**
  * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute guest code
  * @vcpu:	The VCPU pointer
@@ -710,6 +717,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu,
struct kvm_run *run)

 		update_vttbr(vcpu->kvm);

+		if (vcpu->arch.pause)
+			vcpu_pause(vcpu);
+
 		kvm_vgic_flush_hwstate(vcpu);
 		kvm_timer_flush_hwstate(vcpu);

@@ -737,13 +747,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu
*vcpu, struct kvm_run *run)
 		kvm_guest_enter();
 		vcpu->mode = IN_GUEST_MODE;

-		smp_mb(); /* set mode before reading vcpu->arch.pause */
-		if (unlikely(vcpu->arch.pause)) {
-			/* This means ignore, try again. */
-			ret = ARM_EXCEPTION_IRQ;
-		} else {
-			ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
-		}
+		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);

 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->arch.last_pcpu = smp_processor_id();
diff --git a/arch/arm/kvm/psci.c b/arch/arm/kvm/psci.c
index 6be3687..d833604 100644
--- a/arch/arm/kvm/psci.c
+++ b/arch/arm/kvm/psci.c
@@ -28,11 +28,7 @@

 static void kvm_psci_vcpu_off(struct kvm_vcpu *vcpu)
 {
-	wait_queue_head_t *wq = kvm_arch_vcpu_wq(vcpu);
-
 	vcpu->arch.pause = true;
-
-	wait_event_interruptible(*wq, !vcpu->arch.pause);
 }

 static unsigned long kvm_psci_vcpu_on(struct kvm_vcpu *source_vcpu)
-- 
1.7.9.5
