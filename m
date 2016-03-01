From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 1 Mar 2016 14:14:23 +0100
Subject: [PATCH] arm64: KVM: Move kvm_call_hyp back to its original
 localtion
In-Reply-To: <1456837964-10325-1-git-send-email-marc.zyngier@arm.com>
References: <1456837964-10325-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAKv+Gu-nVVoSLNrv21R23zqZQCKzJGXifMkyHAZ7DKMp9u5xrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2016 at 14:12, Marc Zyngier <marc.zyngier@arm.com> wrote:
> In order to reduce the risk of a bad merge, let's move the new
> kvm_call_hyp back to its original location in the file. This has
> zero impact from a code point of view.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
> Catalin,
>
> Would you mind merging this on top of arm64/for-next/core? I just
> verified that this prevents yet another mismerge between the arm64 and
> KVM trees.
>
> Thanks,
>
>         M.
>
>  arch/arm64/include/asm/kvm_host.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e3d67ff..e465b6d 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -308,6 +308,8 @@ struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
>  struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
>
>  u64 __kvm_call_hyp(void *hypfn, ...);
> +#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
> +
>  void force_vm_exit(const cpumask_t *mask);
>  void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
>
> @@ -343,6 +345,4 @@ void kvm_arm_setup_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_clear_debug(struct kvm_vcpu *vcpu);
>  void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu);
>
> -#define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
> -
>  #endif /* __ARM64_KVM_HOST_H__ */
> --
> 2.1.4
>
