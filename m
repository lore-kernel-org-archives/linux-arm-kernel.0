From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jun 2017 11:47:03 +0100
Subject: [PATCH v3 1/2] arm64: ftrace: don't validate branch via PLT in
 ftrace_make_nop()
In-Reply-To: <CAKv+Gu9d6R5naDgd4uEpmSFPvFykopRWMFjDtb4BedsopZX4nA@mail.gmail.com>
References: <20170606170022.11461-1-ard.biesheuvel@linaro.org>
 <20170606170022.11461-2-ard.biesheuvel@linaro.org>
 <20170607104218.GV30263@arm.com>
 <CAKv+Gu9d6R5naDgd4uEpmSFPvFykopRWMFjDtb4BedsopZX4nA@mail.gmail.com>
Message-ID: <20170607104703.GW30263@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 10:45:09AM +0000, Ard Biesheuvel wrote:
> On 7 June 2017 at 10:42, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jun 06, 2017 at 05:00:21PM +0000, Ard Biesheuvel wrote:
> >> When turning branch instructions into NOPs, we attempt to validate the
> >> action by comparing the old value at the call site with the opcode of
> >> a direct relative branch instruction pointing at the old target.
> >>
> >> However, these call sites are statically initialized to call _mcount(),
> >> and may be redirected via a PLT entry if the module is loaded far away
> >> from the kernel text, leading to false negatives and spurious errors.
> >>
> >> So skip the validation if CONFIG_ARM64_MODULE_PLTS is configured.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/kernel/ftrace.c | 46 ++++++++++++++++++--
> >>  1 file changed, 43 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> >> index 40ad08ac569a..4cb576374b82 100644
> >> --- a/arch/arm64/kernel/ftrace.c
> >> +++ b/arch/arm64/kernel/ftrace.c
> >> @@ -84,12 +84,52 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >>                   unsigned long addr)
> >>  {
> >>       unsigned long pc = rec->ip;
> >> -     u32 old, new;
> >> +     long offset = (long)pc - (long)addr;
> >> +     bool validate = true;
> >> +     u32 old = 0, new;
> >> +
> >> +     if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> >> +         (offset < -SZ_128M || offset >= SZ_128M)) {
> >> +             u32 replaced;
> >> +
> >> +             /*
> >> +              * 'mod' is only set at module load time, but if we end up
> >> +              * dealing with an out-of-range condition, we can assume it
> >> +              * is due to a module being loaded far away from the kernel.
> >> +              */
> >> +             if (!mod) {
> >> +                     preempt_disable();
> >> +                     mod = __module_text_address(pc);
> >> +                     preempt_enable();
> >
> > The comment in __module_text_address says that preempt must be disabled so
> > that the module doesn't get freed under its feet, but if that's a
> > possibility here then it feels really dangerous to re-enable preemption
> > before we've done the patching. Shouldn't we take module_mutex or something?
> >
> 
> Ah yes. I added a comment only in patch #2, on another instance in
> ftrace_make_call(), and I thought it was redundant to duplicate it
> here: ftrace_lock is held here, which will prevent the module from
> being unloaded in the mean time, so disabling preemption is only
> necessary to prevent an assert from firing.

I suppose !lockdep_is_held(&ftrace_lock) should be added to the WARN_ON_ONCE
in module_assert_mutex_or_preempt, but that's a separate patch so I'll queue
these as-is.

Thanks for the quick explanation!

Will
