From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Jun 2017 17:46:23 +0100
Subject: [PATCH] arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
In-Reply-To: <CAKv+Gu-hyWyc3rbuKpOaieqKf=y3mga=DkVviagEBwEFrBgrzg@mail.gmail.com>
References: <1498226261-21204-1-git-send-email-mark.rutland@arm.com>
 <CAKv+Gu-hyWyc3rbuKpOaieqKf=y3mga=DkVviagEBwEFrBgrzg@mail.gmail.com>
Message-ID: <20170623164623.GD21989@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 02:38:31PM +0000, Ard Biesheuvel wrote:
> On 23 June 2017 at 13:57, Mark Rutland <mark.rutland@arm.com> wrote:
> > When a kernel is built without CONFIG_ARM64_MODULE_PLTS, we don't
> > generate the expected branch instruction in ftrace_make_nop(). This
> > means we pass zero (rather than a valid branch) to ftrace_modify_code()
> > as the expected instruction to validate. This causes us to return
> > -EINVAL to the core ftrace code for a valid case, resulting in a splat
> > at boot time.
> >
> > This was an unintended effect of commit:
> >
> >   687644209a6e9557 ("arm64: ftrace: fix building without CONFIG_MODULES")
> >
> > ... which incorrectly moved the generation of the branch instruction
> > into the ifdef for CONFIG_ARM64_MODULE_PLTS.
> >
> > This patch fixes the issue by moving the ifdef inside of the relevant
> > if-else case, and always checking that the branch is in range,
> > regardless of CONFIG_ARM64_MODULE_PLTS. This ensures that we generate
> > the expected branch instruction, and also improves our sanity checks.
> >
> > For consistency, both ftrace_make_nop() and ftrace_make_call() are
> > updated with this pattern.
> >
> > Fixes: 687644209a6e9557 ("arm64: ftrace: fix building without CONFIG_MODULES")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/ftrace.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > Marc spotted this breakage atop of the arm64 for-next/core branch when ftrace
> > was enabled.
> >
> > I've given this fix a go with all combinations of MODULES and RANDOMIZE_BASE,
> > with the ftrace boot time self test, and everything seems happy in all
> > combinations.
> 
> Thanks for cleaning this up. I guess Arnd's original fix didn't suffer
> from this issue.

I haven't gone digging through the (mail) history; I don't know either
way.

> 
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 401aa27..945f506 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -73,10 +73,10 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >         unsigned long pc = rec->ip;
> >         u32 old, new;
> >
> > -#ifdef CONFIG_ARM64_MODULE_PLTS
> >         long offset = (long)pc - (long)addr;
> >
> 
> Could you drop the newline before the #ifdef as well please?

Sure thing.

[...]

> >         old = aarch64_insn_gen_nop();
> >         new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> > @@ -140,10 +142,10 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >         bool validate = true;
> >         u32 old = 0, new;
> >
> > -#ifdef CONFIG_ARM64_MODULE_PLTS
> >         long offset = (long)pc - (long)addr;
> >
> 
> Please drop the newline as well.

Sure.

> With the above addressed:
> 
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Cheers!

Mark.
