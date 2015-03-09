From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 9 Mar 2015 13:56:50 +0100
Subject: [PATCH 5/6] target-arm/kvm64: fix save/restore of SPSR regs
In-Reply-To: <874mq27222.fsf@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-7-git-send-email-alex.bennee@linaro.org>
 <20150302172212.GB10137@lvm> <874mq27222.fsf@linaro.org>
Message-ID: <20150309125650.GA20559@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:28:21AM +0000, Alex Benn?e wrote:
> 
> Christoffer Dall <christoffer.dall@linaro.org> writes:
> 
> > Hi Alex,
> >
> > Seems like you accidentally sent out two copies of this patch, hopefully
> > I'm reviewing the right one...
> 
> Oops, perils of not wiping your output directory. I think it was just a
> title tweak!
> 
> > On Wed, Feb 25, 2015 at 04:02:38PM +0000, Alex Benn?e wrote:
> >> From: Christoffer Dall <christoffer.dall@linaro.org>
> >> 
> >> The current code was negatively indexing the cpu state array and not
> >> synchronizing banked spsr register state with the current mode's spsr
> >> state, causing occasional failures with migration.
> >> 
> >> Some munging is done to take care of the aarch64 mapping and also to
> >> ensure the most current value of the spsr is updated to the banked
> >> registers (relevant for KVM<->TCG migration).
> >> 
> >> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> >> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> >> 
> >> ---
> >> v2 (ajb)
> >>   - minor tweaks and clarifications
> >> 
> >> diff --git a/target-arm/kvm64.c b/target-arm/kvm64.c
> >> index c60e989..1e36b0a 100644
> >> --- a/target-arm/kvm64.c
> >> +++ b/target-arm/kvm64.c
> >> @@ -140,6 +140,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> >>      uint64_t val;
> >>      int i;
> >>      int ret;
> >> +    unsigned int el;
> >>  
> >>      ARMCPU *cpu = ARM_CPU(cs);
> >>      CPUARMState *env = &cpu->env;
> >> @@ -206,9 +207,25 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> >>          return ret;
> >>      }
> >>  
> >> +    /* Saved Program State Registers
> >> +     *
> >> +     * Before we restore from the banked_spsr[] array we need to
> >> +     * ensure that any modifications to env->spsr are correctly
> >> +     * reflected and map aarch64 exception levels if required.
> >> +     */
> >> +    el = arm_current_el(env);
> >> +    if (is_a64(env) && el > 0) {
> >> +        g_assert(el == 1);
> >> +        /* KVM maps KVM_SPSR_SVC to KVM_SPSR_EL1 for aarch64 */
> >> +        env->banked_spsr[1] = env->banked_spsr[0];
> >> +        env->banked_spsr[aarch64_banked_spsr_index(el)] = env->spsr;
> >> +    } else {
> >> +        env->banked_spsr[el] = env->spsr;
> >
> > is this valid if (is_a64(env) && el == 0)) ?  I thought that if you're
> > in el == 0, then env->banked_spsr[x] is the most up-to-date one, not
> > env->spsr ?
> 
> Actually they will both be the same (at least for KVM). In the end both:
> 
>         VMSTATE_UINT32(env.spsr, ARMCPU),
>         VMSTATE_UINT64_ARRAY(env.banked_spsr, ARMCPU, 8),
> 
> get serialised in the stream and when we save the stream out we make
> sure everything is in sync (i.e. env->spsr is correct). In reality this
> makes more sense for TCG than KVM which is the only reason env->spsr
> exists.
> 

this function, however, is not used only when migration, but should
generally cover the case where you want to synchronize QEMU's state into
KVM's state, right?  So while it may not be harmful in currently
supported use cases, is there ever a situation where (is_a64(env) && el
== 0) and env->spsr != banked_spsr[el], and where env->spsr is
out-of-date?

If that's the case, I think it would be better to have an assert that
says "don't call the code in this situation" than relying on limited use
cases for callers of this function.

> >
> > for !is_a64(env) this looks wrong, because of the same as above if el ==
> > 0, but also because I think you need
> > bank_number(env->uncached_cpsr & CPSR_M) to index into the array.
> >
> 
> Good catch. For some reason I was treating the number from
> arm_current_el() as equivalent. How about:
> 
>     el = arm_current_el(env);
>     if (is_a64(env) && el > 0) {
>         g_assert(el == 1);
>         /* KVM only maps KVM_SPSR_SVC to KVM_SPSR_EL1 for aarch64 ATM */
>         env->banked_spsr[1] = env->banked_spsr[0];
>     }
>     i = is_a64(env) ?
>         aarch64_banked_spsr_index(el) : bank_number(env->unached_cpsr & CPSR_M);

I think that will fail due to the assert in aarch64_banked_spsr_index()
for el == 0.


-Christoffer
