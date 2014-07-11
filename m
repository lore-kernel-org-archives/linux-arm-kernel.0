From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Jul 2014 13:34:44 +0100
Subject: [PATCH] arm64: Get the number of bits in ASID from the CPU
In-Reply-To: <20140710205012.GA21305@nvidia.com>
References: <1404846860-15055-1-git-send-email-amartin@nvidia.com>
 <FDB72495-5071-4A82-A7D0-17BA1DF10D84@arm.com>
 <20140710205012.GA21305@nvidia.com>
Message-ID: <20140711123444.GF11473@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 09:50:12PM +0100, Allen Martin wrote:
> On Tue, Jul 08, 2014 at 02:42:17PM -0700, Catalin Marinas wrote:
> > On 8 Jul 2014, at 20:14, Allen Martin <amartin@nvidia.com> wrote:
> > > --- a/arch/arm64/mm/context.c
> > > +++ b/arch/arm64/mm/context.c
> > [?]
> > > 
> > > @@ -142,9 +141,9 @@ void __new_context(struct mm_struct *mm)
> > > 	 */
> > > 	if (unlikely((asid & ((1 << bits) - 1)) == 0)) {
> > 
> > That?s the part where it uses the actual number of bits supported by
> > the hardware (bits is computed higher up in this function based on
> > ID_AA64MMFR0_EL1).
> > 
> > > 		/* increment the ASID version */
> > > -		cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
> > 
> > And here it bumps the generation at bit 16 onwards.
> 
> So based on your feedback and my read of the code, it looks like on
> CPUs that implement 8 bits of ASID (ID_AA64MMFR0_EL1 & 0xf0 == 0x20),
> bits 7:0 of asid are the real hw ASID, bits 31:16 are the ASID
> "version" which is how hw ASID wrap is counted, and bits 15:8 are
> unused.  

That's correct.

> A few quesions come up: 
> 
> in set_mm_context():
> >        if (likely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS))
> 
> why is this likely() ?  Shouldn't this only happen on an ASID wrap?

set_mm_context() is called when we want to change the ASID because the
old one was from a previous generation. So the check above is the likely
case where generations differ. The unlikely case would be that the
context was already updated by IPI from a roll-over on another CPU.

> in __new_context():
> >                /* increment the ASID version */
> >                cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
> >                if (cpu_last_asid == 0)
> >                        cpu_last_asid = ASID_FIRST_VERSION;
> 
> How do you prevent two processes from having the same context.id in
> the case of ASID version wrap?  Since context.id is 64 bits, should
> asid and cpu_last_asid be 64 bits as well to make this less likely?

context.id is 32-bit. There is indeed a risk of an application not being
scheduled for a long time and ASID version rolling-over. We could make
both variables 64-bit.

> > So unless you find some bug in the existing logic, I don?t think your
> > patch is needed.
> 
> After reading your comments and looking at the code some more I'm not
> sure it's needed either.  I guess the only advantage is that it uses
> bits 15:8 for ASID version instead of having them be unused.  I'll dig
> more on why this patch was added to begin with.

Note that we plan to re-write this algorithm anyway because the IPI
during roll-over doesn't scale well. The 32-bit arm port already has a
new algorithm, the problem on 64-bit would be that the bitmap would be
bigger (64K bits = 8KB) and it needs benchmarking.

-- 
Catalin
