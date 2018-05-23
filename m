From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 May 2018 15:56:57 +0100
Subject: [PATCH v10 07/18] arm64: fpsimd: Eliminate task->mm checks
In-Reply-To: <20180523133158.GJ13470@e103592.cambridge.arm.com>
References: <1527005119-6842-1-git-send-email-Dave.Martin@arm.com>
 <1527005119-6842-8-git-send-email-Dave.Martin@arm.com>
 <20180523114812.GH55598@C02W217FHV2R.local>
 <20180523133158.GJ13470@e103592.cambridge.arm.com>
Message-ID: <20180523145657.g7b6v2q2vxfqpoc4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 02:31:59PM +0100, Dave P Martin wrote:
> On Wed, May 23, 2018 at 01:48:12PM +0200, Christoffer Dall wrote:
> > On Tue, May 22, 2018 at 05:05:08PM +0100, Dave Martin wrote:
> > > This is true by construction however: TIF_FOREIGN_FPSTATE is never
> > > cleared except when returning to userspace or returning from a
> > > signal: thus, for a true kernel thread no FPSIMD context is ever
> > > loaded, TIF_FOREIGN_FPSTATE will remain set and no context will
> > > ever be saved.
> > 
> > I don't understand this construction proof; from looking at the patch
> > below it is not obvious to me why fpsimd_thread_switch() can never have
> > !wrong_task && !wrong_cpu and therefore clear TIF_FOREIGN_FPSTATE for a
> > kernel thread?
> 
> Looking at this again, I think it is poorly worded.  This patch aims to
> make it true by construction, but it isn't prior to the patch.
> 
> I'm tempted to delete the paragraph: the assertion of both untrue and
> not the best way to justify that this patch works.
> 
> 
> How about:
> 
> -8<-
> 
> The context switch logic already isolates user threads from each other.
> This, it is sufficient for isolating user threads from the kernel,
> since the goal either way is to ensure that code executing in userspace
> cannot see any FPSIMD state except its own.  Thus, there is no special
> property of kernel threads that we care about except that it is
> pointless to save or load FPSIMD register state for them.
> 
> At worst, the removal of all the kernel thread special cases by this
> patch would thus spuriously load and save state for kernel threads when
> unnecessary.
> 
> But the context switch logic is already deliberately optimised to defer
> reloads of the regs until ret_to_user (or sigreturn as a special case),
> which kernel threads by definition never reach.
> 
> ->8-

The "at worst" paragraph makes it look like it could happen (at least
until you reach the last paragraph). Maybe you can just say that
wrong_task and wrong_cpu (with the fpsimd_cpu = NR_CPUS addition) are
always true for kernel threads. You should probably mention this in a
comment in the code as well.

-- 
Catalin
