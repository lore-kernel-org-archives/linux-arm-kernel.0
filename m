From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 26 Mar 2015 17:25:28 +0000
Subject: [PATCH v5 5/6] target-arm: kvm64 fix save/restore of SPSR regs
In-Reply-To: <1427130344-27986-6-git-send-email-alex.bennee@linaro.org>
References: <1427130344-27986-1-git-send-email-alex.bennee@linaro.org>
 <1427130344-27986-6-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA-eGLYSF+T8siJKh+N2SZ+9T_pJ-rw80eFByzOT2W1LwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2015 at 17:05, Alex Benn?e <alex.bennee@linaro.org> wrote:
> The current code was negatively indexing the cpu state array and not
> synchronizing banked spsr register state with the current mode's spsr
> state, causing occasional failures with migration.
>
> Some munging is done to take care of the aarch64 mapping and also to
> ensure the most current value of the spsr is updated to the banked
> registers (relevant for KVM<->TCG migration).
>
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
> v5
>  - fix banking index now banking fixed
>  - keep wide spacing on [ ] forms
>  - claimed authorship
>
> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> index 857e970..5270fa7 100644
> --- a/target-arm/kvm64.c
> +++ b/target-arm/kvm64.c
> @@ -139,6 +139,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>      uint64_t val;
>      int i;
>      int ret;
> +    unsigned int el;
>
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> @@ -205,9 +206,24 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>          return ret;
>      }
>
> +    /* Saved Program State Registers
> +     *
> +     * Before we restore from the banked_spsr[] array we need to
> +     * ensure that any modifications to env->spsr are correctly
> +     * reflected in the banks.
> +     */
> +    el = arm_current_el(env);
> +    if (el > 0) {
> +        i = is_a64(env) ?
> +            aarch64_banked_spsr_index(el) :
> +            bank_number(env->uncached_cpsr & CPSR_M);
> +        env->banked_spsr[i] = env->spsr;

This doesn't look right. If we're currently A64 then
env->spsr is unused and this code will trash one of
the banked_spsr[] fields.

> +    }
> +
> +    /* KVM 0-4 map to QEMU banks 1-5 */
>      for (i = 0; i < KVM_NR_SPSR; i++) {
>          reg.id = AARCH64_CORE_REG(spsr[i]);
> -        reg.addr = (uintptr_t) &env->banked_spsr[i - 1];
> +        reg.addr = (uintptr_t) &env->banked_spsr[i + 1];
>          ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
>          if (ret) {
>              return ret;
> @@ -253,11 +269,13 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>      return ret;
>  }
>
> +

Stray extra space.

-- PMM
