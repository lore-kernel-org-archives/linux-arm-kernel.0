From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 31 Jan 2014 10:48:50 +0000
Subject: [PATCH V2] arm64: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <20140131001647.GA5525@mudshark.cambridge.arm.com>
References: <1390892813-30407-1-git-send-email-vkale@apm.com>
 <20140128161402.GI2885@mudshark.cambridge.arm.com>
 <CAPrCYkfpGJD+GQBmxqNZ8NM+9LhRvf5HiJrpMxHQzjrmPRhonA@mail.gmail.com>
 <20140130180706.GO7575@mudshark.cambridge.arm.com>
 <alpine.LFD.2.11.1401301640500.1652@knanqh.ubzr>
 <20140131001647.GA5525@mudshark.cambridge.arm.com>
Message-ID: <20140131104850.GG15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 12:16:48AM +0000, Will Deacon wrote:
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

What it means is that the compiler may introduce additional instructions
between your consecutive asm() statements.  So there's no guarantee that
the ISB will immediately follow the MSR instruction - there may be other
instructions which the compiler may decide to schedule between the two.

For example, instructions to load the address of the variable(s) may be
inserted between the assembly specified in the asm() statements which
may involve loading from a literal pool.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
