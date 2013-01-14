From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 11:35:09 -0500
Subject: [PATCH v5 04/14] KVM: ARM: Hypervisor initialization
In-Reply-To: <20130114151106.GB18935@mudshark.cambridge.arm.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183903.46302.97512.stgit@ubuntu>
 <20130114151106.GB18935@mudshark.cambridge.arm.com>
Message-ID: <CANM98q+wi38dt12GU5EeGwX+qitV0b3KEZWkHhqUZ3crZTQMEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 10:11 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 08, 2013 at 06:39:03PM +0000, Christoffer Dall wrote:
>> Sets up KVM code to handle all exceptions taken to Hyp mode.
>>
>> When the kernel is booted in Hyp mode, calling an hvc instruction with r0
>> pointing to the new vectors, the HVBAR is changed to the the vector pointers.
>> This allows subsystems (like KVM here) to execute code in Hyp-mode with the
>> MMU disabled.
>>
>> We initialize other Hyp-mode registers and enables the MMU for Hyp-mode from
>> the id-mapped hyp initialization code. Afterwards, the HVBAR is changed to
>> point to KVM Hyp vectors used to catch guest faults and to switch to Hyp mode
>> to perform a world-switch into a KVM guest.
>>
>> Also provides memory mapping code to map required code pages, data structures,
>> and I/O regions  accessed in Hyp mode at the same virtual address as the host
>> kernel virtual addresses, but which conforms to the architectural requirements
>> for translations in Hyp mode. This interface is added in arch/arm/kvm/arm_mmu.c
>> and comprises:
>>  - create_hyp_mappings(from, to);
>>  - create_hyp_io_mappings(from, to, phys_addr);
>>  - free_hyp_pmds();
>
> [...]
>
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 82cb338..2dddc58 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -34,11 +34,21 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/mman.h>
>>  #include <asm/cputype.h>
>> +#include <asm/tlbflush.h>
>> +#include <asm/virt.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_asm.h>
>> +#include <asm/kvm_mmu.h>
>>
>>  #ifdef REQUIRES_VIRT
>>  __asm__(".arch_extension       virt");
>>  #endif
>>
>> +static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>> +static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>> +static unsigned long hyp_default_vectors;
>> +
>> +
>>  int kvm_arch_hardware_enable(void *garbage)
>>  {
>>         return 0;
>> @@ -336,9 +346,176 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>         return -EINVAL;
>>  }
>>
>> +static void cpu_init_hyp_mode(void *vector)
>> +{
>> +       unsigned long long pgd_ptr;
>> +       unsigned long hyp_stack_ptr;
>> +       unsigned long stack_page;
>> +       unsigned long vector_ptr;
>> +
>> +       /* Switch from the HYP stub to our own HYP init vector */
>> +       __hyp_set_vectors((unsigned long)vector);
>> +
>> +       pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
>> +       stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
>> +       hyp_stack_ptr = stack_page + PAGE_SIZE;
>> +       vector_ptr = (unsigned long)__kvm_hyp_vector;
>> +
>> +       /*
>> +        * Call initialization code, and switch to the full blown
>> +        * HYP code. The init code corrupts r12, so set the clobber
>> +        * list accordingly.
>> +        */
>> +       asm volatile (
>> +               "mov    r0, %[pgd_ptr_low]\n\t"
>> +               "mov    r1, %[pgd_ptr_high]\n\t"
>> +               "mov    r2, %[hyp_stack_ptr]\n\t"
>> +               "mov    r3, %[vector_ptr]\n\t"
>> +               "hvc    #0\n\t" : :
>> +               [pgd_ptr_low] "r" ((unsigned long)(pgd_ptr & 0xffffffff)),
>> +               [pgd_ptr_high] "r" ((unsigned long)(pgd_ptr >> 32ULL)),
>> +               [hyp_stack_ptr] "r" (hyp_stack_ptr),
>> +               [vector_ptr] "r" (vector_ptr) :
>> +               "r0", "r1", "r2", "r3", "r12");
>> +}
>
> Use kvm_call_hyp here instead.
>
good idea:

commit 00e22196205800ce9caa561e7c806023f4915138
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 11:32:36 2013 -0500

    KVM: ARM: Reuse kvm_call_hyp in vcpu_init_hyp_mode

    Instead of directly and manually callin the hypercall into the KVM init
    code, use the kvm_call_hyp function, which only requires a small abuse
    of the prototype in exchange for much nicer C code.

    Cc: Will Deacon <will.deacon@arm.com>
    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6997326..b5c6ab1 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -971,6 +971,7 @@ long kvm_arch_vm_ioctl(struct file *filp,
 static void cpu_init_hyp_mode(void *vector)
 {
 	unsigned long long pgd_ptr;
+	unsigned long pgd_low, pgd_high;
 	unsigned long hyp_stack_ptr;
 	unsigned long stack_page;
 	unsigned long vector_ptr;
@@ -979,26 +980,20 @@ static void cpu_init_hyp_mode(void *vector)
 	__hyp_set_vectors((unsigned long)vector);

 	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
+	pgd_low = (pgd_ptr & ((1ULL << 32) - 1));
+	pgd_high = (pgd_ptr >> 32ULL);
 	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
 	vector_ptr = (unsigned long)__kvm_hyp_vector;

 	/*
 	 * Call initialization code, and switch to the full blown
-	 * HYP code. The init code corrupts r12, so set the clobber
-	 * list accordingly.
+	 * HYP code. The init code doesn't need to preserve these registers as
+	 * r1-r3 and r12 are already callee save according to the AAPCS.
+	 * Note that we slightly misuse the prototype by casing the pgd_low to
+	 * a void *.
 	 */
-	asm volatile (
-		"mov	r0, %[pgd_ptr_low]\n\t"
-		"mov	r1, %[pgd_ptr_high]\n\t"
-		"mov	r2, %[hyp_stack_ptr]\n\t"
-		"mov	r3, %[vector_ptr]\n\t"
-		"hvc	#0\n\t" : :
-		[pgd_ptr_low] "r" ((unsigned long)(pgd_ptr & 0xffffffff)),
-		[pgd_ptr_high] "r" ((unsigned long)(pgd_ptr >> 32ULL)),
-		[hyp_stack_ptr] "r" (hyp_stack_ptr),
-		[vector_ptr] "r" (vector_ptr) :
-		"r0", "r1", "r2", "r3", "r12");
+	kvm_call_hyp((void *)pgd_low, pgd_high, hyp_stack_ptr, vector_ptr);
 }

 /**
--

Thanks,
-Christoffer
