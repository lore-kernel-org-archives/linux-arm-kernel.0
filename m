From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 17 Mar 2015 15:29:15 +0000
Subject: [PATCH v4 3/5] target-arm: kvm64 sync FP register state
In-Reply-To: <1426503716-13931-4-git-send-email-alex.bennee@linaro.org>
References: <1426503716-13931-1-git-send-email-alex.bennee@linaro.org>
 <1426503716-13931-4-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8VnJgk7gCj5Adedo_eb1Dc=-egf6c5YiyYoaDt-O2GhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2015 at 11:01, Alex Benn?e <alex.bennee@linaro.org> wrote:
> For migration to work we need to sync all of the register state. This is
> especially noticeable when GCC starts using FP registers as spill
> registers even with integer programs.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> ---
>
> v4:
>   - fixed merge conflicts
>   - rm superfluous reg.id++
>
> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> index fed03f2..8fd0c8d 100644
> --- a/target-arm/kvm64.c
> +++ b/target-arm/kvm64.c
> @@ -126,9 +126,17 @@ bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>  #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
>                   KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
>
> +/* The linux headers don't define a 128 bit wide SIMD macro for us */

I'm not clear what this comment is trying to tell me...

> +#define AARCH64_SIMD_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U128 | \
> +                 KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
> +
> +#define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
> +                 KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
> +
>  int kvm_arch_put_registers(CPUState *cs, int level)
>  {
>      struct kvm_one_reg reg;
> +    uint32_t fpr;
>      uint64_t val;
>      int i;
>      int ret;
> @@ -207,15 +215,37 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          }
>      }
>
> +    /* Advanced SIMD and FP registers */
> +    for (i = 0; i < 32; i++) {
> +        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> +        reg.addr = (uintptr_t)(&env->vfp.regs[i]);

env->vfp.regs[] is a 64 entry array, but here we
are only dealing with the first 32 entries (and
furthermore trying to write 128 bits into a 64 bit
element...)

> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);

Does this work right for bigendian? (ie do the kernel and
QEMU agree on which order the two halves of the 128 bit
value go in? I suspect not...)

> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    fpr = vfp_get_fpsr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    fpr = vfp_get_fpcr(env);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      if (!write_list_to_kvmstate(cpu)) {
>          return EINVAL;
>      }
>
>      kvm_arm_sync_mpstate_to_kvm(cpu);
>
> -    /* TODO:
> -     * FP state
> -     */
>      return ret;
>  }
>
> @@ -223,6 +253,7 @@ int kvm_arch_get_registers(CPUState *cs)
>  {
>      struct kvm_one_reg reg;
>      uint64_t val;
> +    uint32_t fpr;
>      int i;
>      int ret;
>
> @@ -304,6 +335,31 @@ int kvm_arch_get_registers(CPUState *cs)
>          }
>      }
>
> +    /* Advanced SIMD and FP registers */
> +    for (i = 0; i < 32; i++) {
> +        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> +        reg.addr = (uintptr_t)(&env->vfp.regs[i]);
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);

Same remarks apply here as for the set loop.

> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    reg.addr = (uintptr_t)(&fpr);
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    vfp_set_fpsr(env, fpr);
> +
> +    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    vfp_set_fpcr(env, fpr);
> +
>      if (!write_kvmstate_to_list(cpu)) {
>          return EINVAL;
>      }
> --
> 2.3.2
>

-- PMM
