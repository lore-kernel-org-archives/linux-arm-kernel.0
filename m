From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Feb 2014 11:17:54 +0000
Subject: [PATCH V2] arm64: add DSB after icache flush in
 __flush_icache_all()
In-Reply-To: <20140131104850.GG15937@n2100.arm.linux.org.uk>
References: <1390892813-30407-1-git-send-email-vkale@apm.com>
 <20140128161402.GI2885@mudshark.cambridge.arm.com>
 <CAPrCYkfpGJD+GQBmxqNZ8NM+9LhRvf5HiJrpMxHQzjrmPRhonA@mail.gmail.com>
 <20140130180706.GO7575@mudshark.cambridge.arm.com>
 <alpine.LFD.2.11.1401301640500.1652@knanqh.ubzr>
 <20140131001647.GA5525@mudshark.cambridge.arm.com>
 <20140131104850.GG15937@n2100.arm.linux.org.uk>
Message-ID: <20140203111754.GB14112@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nico, Russell,

Thanks for the replies.

On Fri, Jan 31, 2014 at 10:48:50AM +0000, Russell King - ARM Linux wrote:
> On Fri, Jan 31, 2014 at 12:16:48AM +0000, Will Deacon wrote:
> > On Thu, Jan 30, 2014 at 09:42:29PM +0000, Nicolas Pitre wrote:
> > > I don't think they would be reordered at all with the 
> > > volatile qualifiers.
> > 
> > Whilst that may be the case in current compilers (i.e. I've not actually
> > seen the above sequence get re-ordered), the GCC documentation states that:
> > 
> >   Similarly, you can't expect a sequence of volatile asm instructions to remain
> >   perfectly consecutive. If you want consecutive output, use a single asm. Also,
> >   GCC performs some optimizations across a volatile asm instruction; GCC does not
> >   `forget everything' when it encounters a volatile asm instruction the way some
> >   other compilers do.
> > 
> > so I really think that the "memory" clobbers are needed to ensure strict
> > ordering. This matches my understanding from discussions with the compiler
> > engineers at ARM.
> 
> What it means is that the compiler may introduce additional instructions
> between your consecutive asm() statements.  So there's no guarantee that
> the ISB will immediately follow the MSR instruction - there may be other
> instructions which the compiler may decide to schedule between the two.
> 
> For example, instructions to load the address of the variable(s) may be
> inserted between the assembly specified in the asm() statements which
> may involve loading from a literal pool.

That matches what Nicolas said and, to be honest, makes a lot of sense. I'm
just slightly concerned that it doesn't match the explanation I received
from some compiler guys, but I can chase that down separately.

Vinayak: sorry for leading you down the garden path on this. Please can you
stick with your original patch, but adding something equivalent for
arch/arm?

Cheers,

Will
