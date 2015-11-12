From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Nov 2015 11:47:05 +0000
Subject: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
In-Reply-To: <2039611.PJaFlk1sMi@vostro.rjw.lan>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-11-git-send-email-james.morse@arm.com>
 <20151111114039.GA8375@red-moon>
 <2039611.PJaFlk1sMi@vostro.rjw.lan>
Message-ID: <20151112114705.GA2657@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 01:48:32AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, November 11, 2015 11:40:39 AM Lorenzo Pieralisi wrote:
> > Hi Pavel, Rafael,
> > 
> > Do you have any feedback on this patch ?
> > 
> > It is fundamental to this series and affects Hibernate core code so if you
> > have any feedback that would be much appreciated.
> 
> I'm really not familiar with the flush_icache_range() interface.
> 
> What exactly does it do?

It is used to sync a memory range that is written into (eg loading
modules, copying from snapshot is basically the same thing, reads from
storage and restore pages that might well be executable code), in particular
to sync the I-cache and the D-cache, eg on arm64 the page that the snapshot
code is copying might be executable code that has to be cleaned from the
D-cache so that it is made visible to the I-cache.

On x86 it is a NOP AFAIK.

Thanks,
Lorenzo

> 
> Rafael
> 
> 
> > On Tue, Oct 27, 2015 at 05:29:19PM +0000, James Morse wrote:
> > > Some architectures require code written to memory as if it were data to be
> > > 'cleaned' from any data caches so that the processor can fetch them as new
> > > instructions.
> > > 
> > > During resume from hibernate, the snapshot code copies some pages directly,
> > > meaning these architectures do not get a chance to perform their cache
> > > maintenance. Add a call to flush_icache_range(), which is provided by
> > > architectures that require it, to perform the maintenance.
> > > 
> > > This mirrors the kernel's behaviour when loading kernel modules and when
> > > mapping executable pages to user space.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > ---
> > >  kernel/power/snapshot.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> > > index 5235dd4e1e2f..139fc449ad75 100644
> > > --- a/kernel/power/snapshot.c
> > > +++ b/kernel/power/snapshot.c
> > > @@ -31,6 +31,7 @@
> > >  #include <linux/ktime.h>
> > >  
> > >  #include <asm/uaccess.h>
> > > +#include <asm/cacheflush.h>
> > >  #include <asm/mmu_context.h>
> > >  #include <asm/pgtable.h>
> > >  #include <asm/tlbflush.h>
> > > @@ -1196,9 +1197,12 @@ static unsigned int count_data_pages(void)
> > >  static inline void do_copy_page(long *dst, long *src)
> > >  {
> > >  	int n;
> > > +	unsigned long __maybe_unused start = (unsigned long)dst;
> > >  
> > >  	for (n = PAGE_SIZE / sizeof(long); n; n--)
> > >  		*dst++ = *src++;
> > > +
> > > +	flush_icache_range(start, start+PAGE_SIZE);
> > >  }
> > >  
> > >  
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> 
