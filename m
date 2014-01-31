From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 30 Jan 2014 21:22:05 -0500 (EST)
Subject: [PATCH V2] arm64: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <20140131001647.GA5525@mudshark.cambridge.arm.com>
References: <1390892813-30407-1-git-send-email-vkale@apm.com>
 <20140128161402.GI2885@mudshark.cambridge.arm.com>
 <CAPrCYkfpGJD+GQBmxqNZ8NM+9LhRvf5HiJrpMxHQzjrmPRhonA@mail.gmail.com>
 <20140130180706.GO7575@mudshark.cambridge.arm.com>
 <alpine.LFD.2.11.1401301640500.1652@knanqh.ubzr>
 <20140131001647.GA5525@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1401302112550.1652@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Jan 2014, Will Deacon wrote:

> Hi Nico,
> 
> On Thu, Jan 30, 2014 at 09:42:29PM +0000, Nicolas Pitre wrote:
> > On Thu, 30 Jan 2014, Will Deacon wrote:
> > > On Thu, Jan 30, 2014 at 06:04:43AM +0000, Vinayak Kale wrote:
> > > > Can you please elaborate whether you are referring to lack of memory
> > > > clobber or missing barriers?
> > > 
> > > The clobbers. For example:
> > > 
> > > arch/arm64/kvm/sys_regs.c:
> > > 
> > >         /* Make sure noone else changes CSSELR during this! */
> > >         local_irq_disable();
> > >         /* Put value into CSSELR */
> > >         asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
> > >         isb();
> > >         /* Read result out of CCSIDR */
> > >         asm volatile("mrs %0, ccsidr_el1" : "=r" (ccsidr));
> > >         local_irq_enable();
> > > 
> > > Just about everything can be re-ordered in that block, because the asm
> > > volatile statements don't have "memory" clobbers.
> > 
> > I don't think they would be reordered at all with the 
> > volatile qualifiers.
> 
> Whilst that may be the case in current compilers (i.e. I've not actually
> seen the above sequence get re-ordered), the GCC documentation states that:
> 
>   Similarly, you can't expect a sequence of volatile asm instructions to remain
>   perfectly consecutive. If you want consecutive output, use a single asm. Also,
>   GCC performs some optimizations across a volatile asm instruction; GCC does not
>   `forget everything' when it encounters a volatile asm instruction the way some
>   other compilers do.
> 
> so I really think that the "memory" clobbers are needed to ensure strict
> ordering. This matches my understanding from discussions with the compiler
> engineers at ARM.

Well, the key sentence above is: "you can't expect a sequence of 
volatile asm instructions to remain perfectly consecutive."  That 
doesn't mean the "ordering" won't be respected.

If you need a certain ordering, then a volatile is all that you need.  
If nothing else should happen in between, then just use a single asm 
statement as suggested.

Only if you need ordering with regards to other memory accesses as well 
then yes you need a memory clobber in that case.


Nicolas
