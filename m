From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 26 Nov 2016 11:30:42 +0000
Subject: [RFC PATCH 13/29] arm64/sve: Basic support for KERNEL_MODE_NEON
In-Reply-To: <CAKv+Gu-MKdNHNrvSvMeoAoENdfscbAK0==NEMu6KJn8fjxz_tw@mail.gmail.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
 <1480102762-23647-14-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu-MKdNHNrvSvMeoAoENdfscbAK0==NEMu6KJn8fjxz_tw@mail.gmail.com>
Message-ID: <20161126113038.GA86651@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 08:45:02PM +0000, Ard Biesheuvel wrote:
> On 25 November 2016 at 19:39, Dave Martin <Dave.Martin@arm.com> wrote:
> > In order to enable CONFIG_KERNEL_MODE_NEON and things that rely on
> > it to be configured together with Scalable Vector Extension support
> > in the same kernel, this patch implements basic support for
> > saving/restoring the SVE state around kernel_neon_begin()...
> > kernel_neon_end().
> >
> > This patch is not optimal and will generally save more state than
> > necessary, more often than necessary.  Further optimisations can be
> > implemented in future patches.
> >
> > This patch is not intended to allow general-purpose _SVE_ code to
> > execute in the kernel safely.  That functionality may also follow
> > in later patches.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/Kconfig         |  1 -
> >  arch/arm64/kernel/fpsimd.c | 22 ++++++++++++++++++----
> >  2 files changed, 18 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index e8d04dd..7266761 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -880,7 +880,6 @@ endmenu
> >  config ARM64_SVE
> >         bool "ARM Scalable Vector Extension support"
> >         default y
> > -       depends on !KERNEL_MODE_NEON    # until it works with SVE
> >         help
> >           The Scalable Vector Extension (SVE) is an extension to the AArch64
> >           execution state which complements and extends the SIMD functionality
> > diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> > index 81cfdb5..cb947dd 100644
> > --- a/arch/arm64/kernel/fpsimd.c
> > +++ b/arch/arm64/kernel/fpsimd.c
> > @@ -282,11 +282,26 @@ static DEFINE_PER_CPU(struct fpsimd_partial_state, softirq_fpsimdstate);
> >   */
> >  void kernel_neon_begin_partial(u32 num_regs)
> >  {
> > +       preempt_disable();
> > +
> > +       /*
> > +        * For now, we have no special storage for SVE registers in
> > +        * interrupt context, so always save the userland SVE state
> > +        * if there is any, even for interrupts.
> > +        */
> > +       if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE) &&
> > +           current->mm &&
> > +           !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
> > +               fpsimd_save_state(&current->thread.fpsimd_state);
> > +               this_cpu_write(fpsimd_last_state, NULL);
> > +       }
> > +
> 
> I am having trouble understanding why we need all of this if we don't
> support SVE in the kernel. Could you elaborate?

Dave knows all the details but a reason is that touching a Neon register
zeros the upper SVE state in the same vector register. So we can't
safely save/restore just the Neon part without corrupting the SVE state.

-- 
Catalin
