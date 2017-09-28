From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Sep 2017 12:52:53 +0100
Subject: [PATCH] arm64: consistently log boot/secondary CPU IDs
In-Reply-To: <20170928085446.GB19060@arm.com>
References: <1506520238-8306-1-git-send-email-mark.rutland@arm.com>
 <20170928085446.GB19060@arm.com>
Message-ID: <20170928115253.GB11310@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 09:54:47AM +0100, Will Deacon wrote:
> On Wed, Sep 27, 2017 at 02:50:38PM +0100, Mark Rutland wrote:
> > Currently we inconsistently log identifying information for the boot CPU
> > and secondary CPUs. For the boot CPU, we log the MIDR and MPIDR across
> > separate messages, whereas for the secondary CPUs we only log the MIDR.
> > 
> > In some cases, it would be useful to know the MPIDR of secondary CPUs,
> > and it would be nice for these messages to be consistent.
> > 
> > This patch ensures that in the primary and secondary boot paths, we log
> > both the MPIDR and MIDR in a single message, with a consistent format.
> > the MPIDR is consistently padded to 10 hex characters to cover Aff3 in
> > bits 39:32, so that IDs can be compared easily.
> > 
> > The newly redundant message in setup_arch() is removed.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Al Stone <ahs3@redhat.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm64/kernel/setup.c | 5 ++---
> >  arch/arm64/kernel/smp.c   | 6 ++++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index d4b7405..819c1d1 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -103,7 +103,8 @@ void __init smp_setup_processor_id(void)
> >  	 * access percpu variable inside lock_release
> >  	 */
> >  	set_my_cpu_offset(0);
> > -	pr_info("Booting Linux on physical CPU 0x%lx\n", (unsigned long)mpidr);
> > +	pr_info("Booting Linux on physical CPU 0x%010lx [%08x]\n",
> > +		(unsigned long)mpidr, read_cpuid_id());
> 
> We should probably be consistent in whether or not we include the '0x'
> prefix for these hex numbers, otherwise it could get confusing. I don't mind
> which way we go.

Sure.

My preference would be to add the 0x in both cases so that there's no
ambiguity.

I can send a new version with that fixed up, unless you're happy to do
that locally?

Thanks,
Mark.
