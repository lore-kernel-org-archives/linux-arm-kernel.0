From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 2 Mar 2015 09:22:12 -0800
Subject: [PATCH 5/6] target-arm/kvm64: fix save/restore of SPSR regs
In-Reply-To: <1424880159-29348-7-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-7-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150302172212.GB10137@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

Seems like you accidentally sent out two copies of this patch, hopefully
I'm reviewing the right one...

On Wed, Feb 25, 2015 at 04:02:38PM +0000, Alex Benn?e wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> The current code was negatively indexing the cpu state array and not
> synchronizing banked spsr register state with the current mode's spsr
> state, causing occasional failures with migration.
> 
> Some munging is done to take care of the aarch64 mapping and also to
> ensure the most current value of the spsr is updated to the banked
> registers (relevant for KVM<->TCG migration).
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
> ---
> v2 (ajb)
>   - minor tweaks and clarifications
> 
> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> index c60e989..1e36b0a 100644
> --- a/target-arm/kvm64.c
> +++ b/target-arm/kvm64.c
> @@ -140,6 +140,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>      uint64_t val;
>      int i;
>      int ret;
> +    unsigned int el;
>  
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> @@ -206,9 +207,25 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>  
> +    /* Saved Program State Registers
> +     *
> +     * Before we restore from the banked_spsr[] array we need to
> +     * ensure that any modifications to env->spsr are correctly
> +     * reflected and map aarch64 exception levels if required.
> +     */
> +    el = arm_current_el(env);
> +    if (is_a64(env) && el > 0) {
> +        g_assert(el == 1);
> +        /* KVM maps KVM_SPSR_SVC to KVM_SPSR_EL1 for aarch64 */
> +        env->banked_spsr[1] = env->banked_spsr[0];
> +        env->banked_spsr[aarch64_banked_spsr_index(el)] = env->spsr;
> +    } else {
> +        env->banked_spsr[el] = env->spsr;

is this valid if (is_a64(env) && el == 0)) ?  I thought that if you're
in el == 0, then env->banked_spsr[x] is the most up-to-date one, not
env->spsr ?

for !is_a64(env) this looks wrong, because of the same as above if el ==
0, but also because I think you need
bank_number(env->uncached_cpsr & CPSR_M) to index into the array.

> +    }
> +
>      for (i = 0; i < KVM_NR_SPSR; i++) {
>          reg.id = AARCH64_CORE_REG(spsr[i]);
> -        reg.addr = (uintptr_t) &env->banked_spsr[i - 1];
> +        reg.addr = (uintptr_t) &env->banked_spsr[i+1];
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
> @@ -253,6 +270,7 @@ int kvm_arch_get_registers(CPUState *cs)
>      struct kvm_one_reg reg;
>      uint64_t val;
>      uint32_t fpr;
> +    unsigned int el;
>      int i;
>      int ret;
>  
> @@ -325,15 +343,32 @@ int kvm_arch_get_registers(CPUState *cs)
>          return ret;
>      }
>  
> +    /* Fetch the SPSR registers
> +     *
> +     * KVM has an array of state indexed for all the possible aarch32
> +     * privilage levels. Although not all are valid at all points
> +     * there are some transitions possible which can access old state
> +     * so it is worth keeping them all.
> +     */
>      for (i = 0; i < KVM_NR_SPSR; i++) {
>          reg.id = AARCH64_CORE_REG(spsr[i]);
> -        reg.addr = (uintptr_t) &env->banked_spsr[i - 1];
> +        reg.addr = (uintptr_t) &env->banked_spsr[i+1];
>          ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
>          }
>      }
>  
> +    el = arm_current_el(env);
> +    if (is_a64(env) && el > 0) {
> +        g_assert(el == 1);
> +        /* KVM maps KVM_SPSR_SVC to KVM_SPSR_EL1 for aarch64 */
> +        env->banked_spsr[0] = env->banked_spsr[1];
> +        env->spsr = env->banked_spsr[aarch64_banked_spsr_index(el)];
> +    } else {
> +        env->spsr = env->banked_spsr[el];

same concern with bank_number as above.

> +    }
> +
>      /* Advanced SIMD and FP registers */
>      for (i = 0; i < 32; i++) {
>          reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -- 
> 2.3.0
> 

Thanks,
-Christoffer
