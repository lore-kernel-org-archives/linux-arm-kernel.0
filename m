From: yu.c.chen@intel.com (Chen, Yu C)
Date: Thu, 12 Nov 2015 02:53:35 +0000
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
In-Reply-To: <20151111114039.GA8375@red-moon>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
 <20151111114039.GA8375@red-moon>
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028672FF5@shsmsx102.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -----Original Message-----
> From: linux-pm-owner at vger.kernel.org [mailto:linux-pm-
> owner at vger.kernel.org] On Behalf Of Lorenzo Pieralisi
> Sent: Wednesday, November 11, 2015 7:41 PM
> To: James Morse; Rafael J. Wysocki; Pavel Machek
> Cc: linux-arm-kernel at lists.infradead.org; linux-pm at vger.kernel.org; Will
> Deacon; Sudeep Holla; Kevin Kang; Geoff Levand; Catalin Marinas; Mark
> Rutland; AKASHI Takahiro; wangfei; Marc Zyngier
> Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
> architectures that require it
> 
> Hi Pavel, Rafael,
> 
> Do you have any feedback on this patch ?
> 
> It is fundamental to this series and affects Hibernate core code so if you have
> any feedback that would be much appreciated.
> 
> Thanks a lot,
> Lorenzo
> 
> On Tue, Oct 27, 2015 at 05:29:19PM +0000, James Morse wrote:
> > Some architectures require code written to memory as if it were data
> > to be 'cleaned' from any data caches so that the processor can fetch
> > them as new instructions.
> >
> > During resume from hibernate, the snapshot code copies some pages
> > directly, meaning these architectures do not get a chance to perform
> > their cache maintenance. Add a call to flush_icache_range(), which is
> > provided by architectures that require it, to perform the maintenance.
> >
> > This mirrors the kernel's behaviour when loading kernel modules and
> > when mapping executable pages to user space.
> >
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  kernel/power/snapshot.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c index
> > 5235dd4e1e2f..139fc449ad75 100644
> > --- a/kernel/power/snapshot.c
> > +++ b/kernel/power/snapshot.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/ktime.h>
> >
> >  #include <asm/uaccess.h>
> > +#include <asm/cacheflush.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/tlbflush.h>
> > @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
> > static inline void do_copy_page(long *dst, long *src)  {
> >  	int n;
> > +	unsigned long __maybe_unused start = (unsigned long)dst;
> >
> >  	for (n = PAGE_SIZE / sizeof(long); n; n--)
> >  		*dst++ = *src++;
> > +
> > +	flush_icache_range(start, start+PAGE_SIZE);
> >  }
How about invalid all icache lines before doing do_copy_page, since
do_copy_page might deal with both data pages and execute pages, that might be
redundant to do it for every page?

Yu
