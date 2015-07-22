From: will.deacon@arm.com (Will Deacon)
Date: Wed, 22 Jul 2015 18:01:40 +0100
Subject: [PATCH v3 6/6] arm64: kernel: Add support for Privileged Access
 Never
In-Reply-To: <20150721123830.GD25887@localhost>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
 <1437481411-1595-7-git-send-email-james.morse@arm.com>
 <20150721123830.GD25887@localhost>
Message-ID: <20150722170140.GR6650@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On Tue, Jul 21, 2015 at 01:38:31PM +0100, Catalin Marinas wrote:
> On Tue, Jul 21, 2015 at 01:23:31PM +0100, James Morse wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 94d98cd1aad8..149a36ea9673 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -30,9 +30,11 @@
> >  #include <linux/highmem.h>
> >  #include <linux/perf_event.h>
> >  
> > +#include <asm/cpufeature.h>
> >  #include <asm/exception.h>
> >  #include <asm/debug-monitors.h>
> >  #include <asm/esr.h>
> > +#include <asm/sysreg.h>
> >  #include <asm/system_misc.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/tlbflush.h>
> > @@ -147,6 +149,13 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
> >  		__do_kernel_fault(mm, addr, esr, regs);
> >  }
> >  
> > +static bool pan_enabled(struct pt_regs *regs)
> > +{
> > +	if (IS_ENABLED(CONFIG_ARM64_PAN))
> > +		return ((regs->pstate & PSR_PAN_BIT) != 0);
> 
> Nitpick: no brackets needed for return.
> 
> Otherwise the patch looks fine to me:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I've applied your series with the exception of this last one, as it
conflicts with some other patches I have queued for 4.3. Please can you
rebase this against the arm64 "devel" branch? (usually it would be
for-next/core, but I'm holding off stabilising until -rc4 since allmodconfig
build is broken atm).

Thanks,

Will
