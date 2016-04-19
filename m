From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Apr 2016 17:03:53 +0100
Subject: [PATCH v7 07/16] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1459529620-22150-8-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-8-git-send-email-james.morse@arm.com>
Message-ID: <571656E9.5050402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 17:53, James Morse wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> The current kvm implementation on arm64 does cpu-specific initialization
> at system boot, and has no way to gracefully shutdown a core in terms of
> kvm. This prevents kexec from rebooting the system at EL2.
> 
> This patch adds a cpu tear-down function and also puts an existing cpu-init
> code into a separate function, kvm_arch_hardware_disable() and
> kvm_arch_hardware_enable() respectively.
> We don't need the arm64 specific cpu hotplug hook any more.
> 
> Since this patch modifies common code between arm and arm64, one stub
> definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
> compilation errors.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> [Rebase, added separate VHE init/exit path, changed resets use of
>  kvm_call_hyp() to the __version, en/disabled hardware in init_subsystems(),
>  added icache maintenance to __kvm_hyp_reset() and removed lr restore]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm/include/asm/kvm_host.h   |  10 ++-
>  arch/arm/include/asm/kvm_mmu.h    |   1 +
>  arch/arm/kvm/arm.c                | 128 +++++++++++++++++++++++---------------
>  arch/arm/kvm/mmu.c                |   5 ++
>  arch/arm64/include/asm/kvm_asm.h  |   1 +
>  arch/arm64/include/asm/kvm_host.h |  13 +++-
>  arch/arm64/include/asm/kvm_mmu.h  |   1 +
>  arch/arm64/kvm/hyp-init.S         |  38 +++++++++++
>  arch/arm64/kvm/reset.c            |  14 +++++
>  9 files changed, 158 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
> index 385070180c25..738d5eee91de 100644
> --- a/arch/arm/include/asm/kvm_host.h
> +++ b/arch/arm/include/asm/kvm_host.h
> @@ -265,6 +265,15 @@ static inline void __cpu_init_stage2(void)
>  	kvm_call_hyp(__init_stage2_translation);
>  }
>  
> +static inline void __cpu_reset_hyp_mode(phys_addr_t boot_pgd_ptr,
> +					phys_addr_t phys_idmap_start)
> +{
> +	/*
> +	 * TODO
> +	 * kvm_call_reset(boot_pgd_ptr, phys_idmap_start);
> +	 */
> +}
> +
>  static inline int kvm_arch_dev_ioctl_check_extension(long ext)
>  {
>  	return 0;
> @@ -277,7 +286,6 @@ void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>  
>  struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
>  
> -static inline void kvm_arch_hardware_disable(void) {}
>  static inline void kvm_arch_hardware_unsetup(void) {}
>  static inline void kvm_arch_sync_events(struct kvm *kvm) {}
>  static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> index da44be9db4fa..f17a8d41822c 100644
> --- a/arch/arm/include/asm/kvm_mmu.h
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -66,6 +66,7 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);
>  phys_addr_t kvm_mmu_get_httbr(void);
>  phys_addr_t kvm_mmu_get_boot_httbr(void);
>  phys_addr_t kvm_get_idmap_vector(void);
> +phys_addr_t kvm_get_idmap_start(void);
>  int kvm_mmu_init(void);
>  void kvm_clear_hyp_idmap(void);
>  
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index b5384311dec4..962904a443be 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -16,7 +16,6 @@
>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
>  
> -#include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> @@ -66,6 +65,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
>  
>  static bool vgic_present;
>  
> +static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
> +
>  static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	BUG_ON(preemptible());
> @@ -90,11 +91,6 @@ struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
>  	return &kvm_arm_running_vcpu;
>  }
>  
> -int kvm_arch_hardware_enable(void)
> -{
> -	return 0;
> -}
> -
>  int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
> @@ -591,7 +587,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		/*
>  		 * Re-check atomic conditions
>  		 */
> -		if (signal_pending(current)) {
> +		if (unlikely(!__this_cpu_read(kvm_arm_hardware_enabled))) {
> +			/* cpu has been torn down */
> +			ret = 0;
> +			run->exit_reason = KVM_EXIT_FAIL_ENTRY;
> +			run->fail_entry.hardware_entry_failure_reason
> +					= (u64)-ENOEXEC;

This hunk makes me feel a bit uneasy. Having to check something that
critical on the entry path is at least a bit weird. If we've reset EL2
already, it means that we must have forced an exit on the guest to do so.

So why do we hand the control back to KVM (or anything else) once we've
nuked a CPU? I'd expect it to be put on some back-burner, never to
return in this lifetime...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
