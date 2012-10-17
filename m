From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 10:39:16 +0100
Subject: [RFC PATCH v2] prevent top pte being overwritten before flushing
In-Reply-To: <CANj_sbCbdfvgkKXJjk4L_5Rk-4mQ-zqDqMErry-AzHddDb8WYA@mail.gmail.com>
References: <1350236542-96465-1-git-send-email-yanpai.chen@gmail.com>
 <CANj_sbCbdfvgkKXJjk4L_5Rk-4mQ-zqDqMErry-AzHddDb8WYA@mail.gmail.com>
Message-ID: <20121017093916.GA5973@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 09:42:19AM +0100, Andrew Yan-Pai Chen wrote:
> On Mon, Oct 15, 2012 at 1:42 AM, Andrew Yan-Pai Chen
> <yanpai.chen@gmail.com> wrote:
> > +static DEFINE_RAW_SPINLOCK(flush_lock);
> > +
> > +/* Beware that this function is not to be called for SMP setups. */
> >  static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
> >  {
> >         unsigned long to = FLUSH_ALIAS_START + (CACHE_COLOUR(vaddr) <<
> > PAGE_SHIFT);
> >         const int zero = 0;
> >
> > +       preempt_disable();
> >         set_top_pte(to, pfn_pte(pfn, PAGE_KERNEL));
> >
> >         asm(    "mcrr   p15, 0, %1, %0, c14\n"
> > @@ -34,6 +39,8 @@ static void flush_pfn_alias(unsigned long pfn, unsigned
> > long vaddr)
> >             :
> >             : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
> >             : "cc");
> > +
> > +       preempt_enable();
> >  }
> >
> >  static void flush_icache_alias(unsigned long pfn, unsigned long vaddr,
> > unsigned long len)
> > @@ -42,9 +49,13 @@ static void flush_icache_alias(unsigned long pfn,
> > unsigned long vaddr, unsigned
> >         unsigned long offset = vaddr & (PAGE_SIZE - 1);
> >         unsigned long to;
> >
> > +       raw_spin_lock(&flush_lock);
> > +
> >         set_top_pte(va, pfn_pte(pfn, PAGE_KERNEL));
> >         to = va + offset;
> >         flush_icache_range(to, to + len);
> > +
> > +       raw_spin_unlock(&flush_lock);
> >  }
> >
> >  void flush_cache_mm(struct mm_struct *mm)
> > --
> > 1.7.4.1
> >
> 
> Hi all,
> 
> Any ideas?

I wonder if we could use different ptes for each CPU (by hacking
pte_offset_kernel) and then get away with just disabling preemption in both
cases?

Will
