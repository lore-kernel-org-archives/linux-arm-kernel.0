From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Sep 2013 10:34:51 +0100
Subject: [RFT PATCH v1 6/7] amd64: avoid saving and restoring FPSIMD
 registers until threads access them
In-Reply-To: <5245941A.5000805@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
 <1380269087-8520-7-git-send-email-liuj97@gmail.com>
 <20130927105902.GH9057@mudshark.cambridge.arm.com>
 <5245941A.5000805@gmail.com>
Message-ID: <20130930093450.GA26036@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 03:20:10PM +0100, Jiang Liu wrote:
> On 09/27/2013 06:59 PM, Will Deacon wrote:
> > On Fri, Sep 27, 2013 at 09:04:46AM +0100, Jiang Liu wrote:
> >> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> >> index 267e54a..a81af5f 100644
> >> --- a/arch/arm64/kernel/fpsimd.c
> >> +++ b/arch/arm64/kernel/fpsimd.c
> >> @@ -99,7 +99,8 @@ void fpsimd_disable_lazy_restore(void)
> >>   * If lazy mode is enabled, caller needs to disable preemption
> >>   * when calling fpsimd_load_state_lazy() and fpsimd_save_state_lazy().
> >>   */
> >> -static void fpsimd_load_state_lazy(struct fpsimd_state *state)
> >> +static void fpsimd_load_state_lazy(struct fpsimd_state *state,
> >> +				   struct task_struct *tsk)
> >>  {
> >>  	/* Could we reuse the hardware context? */
> >>  	if (state->last_cpu == smp_processor_id() &&
> >> @@ -109,13 +110,19 @@ static void fpsimd_load_state_lazy(struct fpsimd_state *state)
> >>  	if (static_key_false(&fpsimd_lazy_mode)) {
> >>  		fpsimd_clear_on_hw(state);
> >>  		fpsimd_enable_trap();
> >> -	} else {
> >> +	} else if (tsk_used_math(tsk)) {
> >> +		fpsimd_disable_trap();
> >>  		fpsimd_load_state(state);
> >> +	} else {
> >> +		fpsimd_enable_trap();
> > 
> > One thing worth checking in sequences like this is that you have the
> > relevant memory barriers (isb instructions) to ensure that the CPU is
> > synchronised wrt side-effects from the msr instructions. *Some* operations
> > are self-synchronising, but I don't think this is the case for fpsimd in v8
> > (although I haven't re-checked).
> > 
> > Your earlier patch (3/7) doesn't seem to have any of these barriers.
> Hi Will,
> 	Thanks for reminder, I tried to confirm this by scanning over
> ARMv8 reference manual but failed. So how about changing the code as:

Take a look at section D8.1.2 ("General behavior of accesses to the system
registers") and the contained section ("Synchronization requirements for
system registers").

> static inline void fpsimd_enable_trap(void)
> {
>         u32 __val;
> 
>         asm volatile ("mrs %0, cpacr_el1\n"
>                       "tbz %w0, #20, 1f\n"
>                       "and %w0, %w0, #0xFFCFFFFF\n"
>                       "msr cpacr_el1, %0\n"
>                       "isb\n"
>                       "1:"
>                       : "=&r" (__val));
> }
> 
> static inline void fpsimd_disable_trap(void)
> {
>         u32 __val;
> 
>         asm volatile ("mrs %0, cpacr_el1\n"
>                       "tbnz %w0, #20, 1f\n"
>                       "orr %w0, %w0, #0x000300000\n"
>                       "msr cpacr_el1, %0\n"
>                       "isb\n"
>                       "1:"
>                       : "=&r" (__val));
> }

This will work, but if you only care about accesses from userspace, the isb
isn't needed since the exception return will synchronise for you. In which
case, it might be worth refactoring this code to have a conditional isb() if
you're disabling the trap in anticipation of a kernel access.

Will
