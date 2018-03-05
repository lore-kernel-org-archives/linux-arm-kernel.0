From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Mar 2018 15:56:29 +0000
Subject: [RFC PATCH] arm64: fault: Don't populate ESR context for user
 fault on kernel VA
In-Reply-To: <dbabd287-2f8e-f1e8-0a2b-8b901f656114@arm.com>
References: <1520245875-32527-1-git-send-email-will.deacon@arm.com>
 <dbabd287-2f8e-f1e8-0a2b-8b901f656114@arm.com>
Message-ID: <20180305155629.GJ6618@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 01:27:47PM +0000, Robin Murphy wrote:
> On 05/03/18 10:31, Will Deacon wrote:
> >User faults on kernel addresses are a good sign that the faulting task
> >is either up to no good or is in deep trouble. In such situations,
> >exposing the optional ESR context on the sigframe as part of the
> >delivered signal is only useful to attackers who are using information
> >about underlying hardware fault (e.g. translation vs permission) as a
> >mechanism to defeat KASLR.
> >
> >Remove the ESR context from the sigframe for user faults on kernel
> >addresses.
> >
> >Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >Cc: Dave Martin <Dave.Martin@arm.com>
> >Signed-off-by: Will Deacon <will.deacon@arm.com>
> >---
> >
> >Here's another one that doesn't make a huge amount of difference when
> >kpti is enabled, but I think is a change worth making all the same.
> >
> >  arch/arm64/mm/fault.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >index 49dfb08a6c4d..b9800395788e 100644
> >--- a/arch/arm64/mm/fault.c
> >+++ b/arch/arm64/mm/fault.c
> >@@ -292,8 +292,10 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> >  static void __do_user_fault(struct siginfo *info, unsigned int esr)
> >  {
> >-	current->thread.fault_address = (unsigned long)info->si_addr;
> >-	current->thread.fault_code = esr;
> >+	unsigned long addr = (unsigned long)info->si_addr;
> >+
> >+	current->thread.fault_address = addr;
> >+	current->thread.fault_code = addr < TASK_SIZE ? esr : 0;
> 
> Nit: there are still non-kernel addresses above TASK_SIZE which would only
> imply a wild pointer rather than nefarious misdeeds, but I guess if you can
> already see that the faulting address is in the hole you don't really need a
> level 0 translation fault spelled out. More generally though, if there's a
> chance that someone might still try to interpret fault_code as an ESR value
> regardless of what happened, should we be setting it to ESR_ELx_IL rather
> than 0, to be consistent with the implied "Unknown reason" EC value?

0 is a magic value, which means that the ESR record gets omitted from the
sigframe entirely (see setup_sigframe_layout).

Will
