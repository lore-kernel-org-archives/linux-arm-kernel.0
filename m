From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 6 Dec 2016 15:36:41 +0000
Subject: [RFC PATCH 13/29] arm64/sve: Basic support for KERNEL_MODE_NEON
In-Reply-To: <20161128122937.GI1574@e103592.cambridge.arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
 <1480102762-23647-14-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu-MKdNHNrvSvMeoAoENdfscbAK0==NEMu6KJn8fjxz_tw@mail.gmail.com>
 <20161126113038.GA86651@MBP.local>
 <20161128114723.GG1574@e103592.cambridge.arm.com>
 <20161128120623.GA17125@e104818-lin.cambridge.arm.com>
 <20161128122937.GI1574@e103592.cambridge.arm.com>
Message-ID: <CAKv+Gu_aZnhP43CC-GscorV94c2dB-gxgxJdvRw5ZY0MjAX8vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2016 at 12:29, Dave Martin <Dave.Martin@arm.com> wrote:
> On Mon, Nov 28, 2016 at 12:06:24PM +0000, Catalin Marinas wrote:
>> On Mon, Nov 28, 2016 at 11:47:26AM +0000, Dave P Martin wrote:
>> > On Sat, Nov 26, 2016 at 11:30:42AM +0000, Catalin Marinas wrote:
>> > > On Fri, Nov 25, 2016 at 08:45:02PM +0000, Ard Biesheuvel wrote:
>> > > > On 25 November 2016 at 19:39, Dave Martin <Dave.Martin@arm.com> wrote:
>> > > > > --- a/arch/arm64/kernel/fpsimd.c
>> > > > > +++ b/arch/arm64/kernel/fpsimd.c
>> > > > > @@ -282,11 +282,26 @@ static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
>> > > > >   */
>> > > > >  void kernel_neon_begin_partial(u32 num_regs)
>> > > > >  {
>> > > > > +       preempt_disable();
>> > > > > +
>> > > > > +       /*
>> > > > > +        * For now, we have no special storage for SVE registers in
>> > > > > +        * interrupt context, so always save the userland SVE state
>> > > > > +        * if there is any, even for interrupts.
>> > > > > +        */
>> > > > > +       if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE) &&
>> > > > > +           current->mm &&
>> > > > > +           !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
>> > > > > +               fpsimd_save_state(&current->thread.fpsimd_state);
>> > > > > +               this_cpu_write(fpsimd_last_state, NULL);
>> > > > > +       }
>> > > > > +
>> > > >
>> > > > I am having trouble understanding why we need all of this if we don't
>> > > > support SVE in the kernel. Could you elaborate?
>> > >
>> > > Dave knows all the details but a reason is that touching a Neon register
>> > > zeros the upper SVE state in the same vector register. So we can't
>> > > safely save/restore just the Neon part without corrupting the SVE state.
>> >
>> > This is right -- this also means that EFI services can trash the upper
>> > bits of an SVE vector register (as a side-effect of FPSIMD/NEON usage).
>> >
>> > It's overkill to save/restore absolutely everything -- I ignore num_regs
>> > for example -- but I wanted to keep things as simple as possible
>> > initially.
>>

Actually, I think we could simplify this even further by always
preserving the userland state, instead of having two copies of the
statements above. The reason is that stacking and unstacking, as we do
for softirq/hardirq context, is only required if we happen to be
interrupting a thread while it is executing in the kernel *and* using
the NEON, in all other cases we can simply preserve the userland
context, and let the exit code take care of restoring the state upon
exit to userland (unless we're interrupting kernel mode NEON executing
in softirq context from an interrupt handler).

i will send out a separate RFC with a proposal to optimize this, which
I think will remove the need for this patch entirely.
