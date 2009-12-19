From: tony@atomide.com (Tony Lindgren)
Date: Sat, 19 Dec 2009 09:54:13 -0800
Subject: [PATCH 3/5] arm: Flush TLB entries in setup_mm_for_reboot()
In-Reply-To: <20091219090607.GB28047@n2100.arm.linux.org.uk>
References: <20091219034151.26198.26570.stgit@localhost>
	<20091219034619.26198.58992.stgit@localhost>
	<20091219090607.GB28047@n2100.arm.linux.org.uk>
Message-ID: <20091219175413.GB11397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [091219 01:04]:
> On Fri, Dec 18, 2009 at 07:46:19PM -0800, Tony Lindgren wrote:
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 8c7fbd1..a2802ea 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1068,4 +1068,7 @@ void setup_mm_for_reboot(char mode)
> >  		pmd[1] = __pmd(pmdval + (1 << (PGDIR_SHIFT - 1)));
> >  		flush_pmd_entry(pmd);
> >  	}
> > +
> > +	local_flush_tlb_all();
> > +	flush_cache_all();
> 
> The cache flush is unnecessary.  The caches should be off at this point.

OK, right, cpu_proc_fin() has already disabled caches by then.

Here's the updated version.

Tony
