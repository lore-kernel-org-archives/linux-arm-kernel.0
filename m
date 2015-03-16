From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 16 Mar 2015 13:52:04 +0100
Subject: [PATCH v4 4/5] target-arm: kvm64 fix save/restore of SPSR regs
In-Reply-To: <1426503716-13931-5-git-send-email-alex.bennee@linaro.org>
References: <1426503716-13931-1-git-send-email-alex.bennee@linaro.org>
 <1426503716-13931-5-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150316125204.GB26480@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 11:01:55AM +0000, Alex Benn?e wrote:
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
> v3
>   - Use the correct bank index function for setting/getting env->spsr
>   - only deal with spsrs in elevated exception levels
> v4
>  - try and make commentary clearer
>  - ensure env->banked_spsr[0] = env->spsr before we sync
> 
> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> index 8fd0c8d..7ddb1b1 100644
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
> @@ -206,9 +207,29 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
> +    if (el > 0) {
> +        if (is_a64(env)) {
> +            g_assert(el == 1);
> +            env->banked_spsr[0] = env->spsr;
> +            /* QEMUs AARCH64 EL1 SPSR is in bank 0, so map it to
> +             * KVM_SPSR_SVC for syncing to KVM */
> +            env->banked_spsr[1] = env->banked_spsr[0];
> +        } else {
> +            i = bank_number(env->uncached_cpsr & CPSR_M);
> +            env->banked_spsr[i] = env->spsr;
> +        }
> +    }
> +
>      for (i = 0; i < KVM_NR_SPSR; i++) {
>          reg.id = AARCH64_CORE_REG(spsr[i]);
> -        reg.addr = (uintptr_t) &env->banked_spsr[i - 1];
> +        reg.addr = (uintptr_t) &env->banked_spsr[i+1];
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
> @@ -254,6 +275,7 @@ int kvm_arch_get_registers(CPUState *cs)
>      struct kvm_one_reg reg;
>      uint64_t val;
>      uint32_t fpr;
> +    unsigned int el;
>      int i;
>      int ret;
>  
> @@ -326,15 +348,34 @@ int kvm_arch_get_registers(CPUState *cs)
>          return ret;
>      }
>  
> +    /* Fetch the SPSR registers
> +     *
> +     * KVM has an array of state indexed for all the possible aarch32
> +     * privilege levels. These map onto QEMUs aarch32 banks 1 - 4.
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
> +    if (el > 0) {
> +        if (is_a64(env)) {
> +            g_assert(el == 1);
> +            /* KVM_SPSR_SVC holds the AARCH64 EL1 SPSR which QEMU
> +             * keeps in bank 0 so copy it across. */
> +            env->banked_spsr[0] = env->banked_spsr[1];
> +            i = aarch64_banked_spsr_index(el);
> +        } else {
> +            i = bank_number(env->uncached_cpsr & CPSR_M);
> +        }
> +        env->spsr = env->banked_spsr[i];
> +    }
> +
>      /* Advanced SIMD and FP registers */
>      for (i = 0; i < 32; i++) {
>          reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
> -- 
> 2.3.2
> 

looks good!
-Christoffer
