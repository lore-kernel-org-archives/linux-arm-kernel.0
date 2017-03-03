From: shiju.jose@huawei.com (Shiju Jose)
Date: Fri, 3 Mar 2017 15:34:59 +0000
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
Message-ID: <86258A5CC0A3704780874CF6004BA8A62DCAD116@lhreml502-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

> -----Original Message-----
> From: Tyler Baicar [mailto:tbaicar at codeaurora.org]
> Sent: 21 February 2017 21:22
> To: christoffer.dall at linaro.org; marc.zyngier at arm.com;
> pbonzini at redhat.com; rkrcmar at redhat.com; linux at armlinux.org.uk;
> catalin.marinas at arm.com; will.deacon at arm.com; rjw at rjwysocki.net;
> lenb at kernel.org; matt at codeblueprint.co.uk; robert.moore at intel.com;
> lv.zheng at intel.com; nkaje at codeaurora.org; zjzhang at codeaurora.org;
> mark.rutland at arm.com; james.morse at arm.com; akpm at linux-foundation.org;
> eun.taik.lee at samsung.com; sandeepa.s.prabhu at gmail.com;
> labbott at redhat.com; shijie.huang at arm.com; rruigrok at codeaurora.org;
> paul.gortmaker at windriver.com; tn at semihalf.com; fu.wei at linaro.org;
> rostedt at goodmis.org; bristot at redhat.com; linux-arm-
> kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; linux-kernel at vger.kernel.org; linux-
> acpi at vger.kernel.org; linux-efi at vger.kernel.org; devel at acpica.org;
> Suzuki.Poulose at arm.com; punit.agrawal at arm.com; astone at redhat.com;
> harba at codeaurora.org; hanjun.guo at linaro.org; John Garry; Shiju Jose;
> joe at perches.com
> Cc: Tyler Baicar
> Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
> 
> Currently external aborts are unsupported by the guest abort handling.
> Add handling for SEAs so that the host kernel reports SEAs which occur
> in the guest kernel.
> 
> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  arch/arm/include/asm/kvm_arm.h       |  1 +
>  arch/arm/include/asm/system_misc.h   |  5 +++++
>  arch/arm/kvm/mmu.c                   | 18 ++++++++++++++++--
>  arch/arm64/include/asm/kvm_arm.h     |  1 +
>  arch/arm64/include/asm/system_misc.h |  2 ++
>  arch/arm64/mm/fault.c                | 18 ++++++++++++++++++
>  6 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arm.h
> b/arch/arm/include/asm/kvm_arm.h index e22089f..33a77509 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -187,6 +187,7 @@
>  #define FSC_FAULT	(0x04)
>  #define FSC_ACCESS	(0x08)
>  #define FSC_PERM	(0x0c)
> +#define FSC_EXTABT	(0x10)
> 
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~0xf)
> diff --git a/arch/arm/include/asm/system_misc.h
> b/arch/arm/include/asm/system_misc.h
> index a3d61ad..ea45d94 100644
> --- a/arch/arm/include/asm/system_misc.h
> +++ b/arch/arm/include/asm/system_misc.h
> @@ -24,4 +24,9 @@
> 
>  #endif /* !__ASSEMBLY__ */
> 
> +static inline int handle_guest_sea(unsigned long addr, unsigned int
> +esr) {
> +	return -1;
> +}
> +
>  #endif /* __ASM_ARM_SYSTEM_MISC_H */
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c index
> a5265ed..04f1dd50 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -29,6 +29,7 @@
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/virt.h>
> +#include <asm/system_misc.h>
> 
>  #include "trace.h"
> 
> @@ -1444,8 +1445,21 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu,
> struct kvm_run *run)
> 
>  	/* Check the stage-2 fault is trans. fault or write fault */
>  	fault_status = kvm_vcpu_trap_get_fault_type(vcpu);
> -	if (fault_status != FSC_FAULT && fault_status != FSC_PERM &&
> -	    fault_status != FSC_ACCESS) {
> +
> +	/* The host kernel will handle the synchronous external abort.
> There
> +	 * is no need to pass the error into the guest.
> +	 */
> +	if (fault_status == FSC_EXTABT) {
> +		if(handle_guest_sea((unsigned long)fault_ipa,
> +				    kvm_vcpu_get_hsr(vcpu))) {
> +			kvm_err("Failed to handle guest SEA, FSC: EC=%#x
> xFSC=%#lx ESR_EL2=%#lx\n",
> +				kvm_vcpu_trap_get_class(vcpu),
> +				(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
> +				(unsigned long)kvm_vcpu_get_hsr(vcpu));
> +			return -EFAULT;
> +		}
> +	} else if (fault_status != FSC_FAULT && fault_status != FSC_PERM
> &&
> +		   fault_status != FSC_ACCESS) {
>  		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
>  			kvm_vcpu_trap_get_class(vcpu),
>  			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
> diff --git a/arch/arm64/include/asm/kvm_arm.h
> b/arch/arm64/include/asm/kvm_arm.h
> index 2a2752b..2b11d59 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -201,6 +201,7 @@
>  #define FSC_FAULT	ESR_ELx_FSC_FAULT
>  #define FSC_ACCESS	ESR_ELx_FSC_ACCESS
>  #define FSC_PERM	ESR_ELx_FSC_PERM
> +#define FSC_EXTABT	ESR_ELx_FSC_EXTABT
> 
>  /* Hyp Prefetch Fault Address Register (HPFAR/HDFAR) */
>  #define HPFAR_MASK	(~UL(0xf))
> diff --git a/arch/arm64/include/asm/system_misc.h
> b/arch/arm64/include/asm/system_misc.h
> index bc81243..5b2cecd1 100644
> --- a/arch/arm64/include/asm/system_misc.h
> +++ b/arch/arm64/include/asm/system_misc.h
> @@ -58,4 +58,6 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned
> long, unsigned int,
> 
>  #endif	/* __ASSEMBLY__ */
> 
> +int handle_guest_sea(unsigned long addr, unsigned int esr);
> +
>  #endif	/* __ASM_SYSTEM_MISC_H */
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c index
> b2d57fc..403277b 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -602,6 +602,24 @@ static const char *fault_name(unsigned int esr)  }
> 
>  /*
> + * Handle Synchronous External Aborts that occur in a guest kernel.
> + */
> +int handle_guest_sea(unsigned long addr, unsigned int esr) {
> +	/*
> +	 * synchronize_rcu() will wait for nmi_exit(), so no need to
> +	 * rcu_read_lock().
> +	 */
> +	if(IS_ENABLED(HAVE_ACPI_APEI_SEA)) {
IS_ENABLED(HAVE_ACPI_APEI_SEA) to be changed to IS_ENABLED(ACPI_APEI_SEA) same
as in the patch "acpi: apei: handle SEA notification type for ARMv8"?

Thanks,
Shiju

> +		nmi_enter();
> +		ghes_notify_sea();
> +		nmi_exit();
> +	}
> +
> +	return 0;
> +}
> +
> +/*
>   * Dispatch a data abort to the relevant handler.
>   */
>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned
> int esr,
> --
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a
> Linux Foundation Collaborative Project.
