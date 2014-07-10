From: amartin@nvidia.com (Allen Martin)
Date: Thu, 10 Jul 2014 13:50:12 -0700
Subject: [PATCH] arm64: Get the number of bits in ASID from the CPU
In-Reply-To: <FDB72495-5071-4A82-A7D0-17BA1DF10D84@arm.com>
References: <1404846860-15055-1-git-send-email-amartin@nvidia.com>
 <FDB72495-5071-4A82-A7D0-17BA1DF10D84@arm.com>
Message-ID: <20140710205012.GA21305@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 02:42:17PM -0700, Catalin Marinas wrote:
> On 8 Jul 2014, at 20:14, Allen Martin <amartin@nvidia.com> wrote:
> > From: Alex Van Brunt <avanbrunt@nvidia.com>
> > 
> > Instead of hard coding the number of ASID bits to 16, read the value
> > from the CPU through the register ID_AA64MMFR0_EL1 at boot time.  This
> > is required on Tegra132 Denver CPU which implements 8 bits.
> 
> Did you actually find a bug in the existing code?

There was an internal bug associated with this patch, but I didn't
author the patch, and it's not clear what if anything fails without
this patch.  I'll dig further.

> > --- a/arch/arm64/mm/context.c
> > +++ b/arch/arm64/mm/context.c
> [?]
> > 
> > @@ -142,9 +141,9 @@ void __new_context(struct mm_struct *mm)
> > 	 */
> > 	if (unlikely((asid & ((1 << bits) - 1)) == 0)) {
> 
> That?s the part where it uses the actual number of bits supported by
> the hardware (bits is computed higher up in this function based on
> ID_AA64MMFR0_EL1).
> 
> > 		/* increment the ASID version */
> > -		cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
> 
> And here it bumps the generation at bit 16 onwards.

So based on your feedback and my read of the code, it looks like on
CPUs that implement 8 bits of ASID (ID_AA64MMFR0_EL1 & 0xf0 == 0x20),
bits 7:0 of asid are the real hw ASID, bits 31:16 are the ASID
"version" which is how hw ASID wrap is counted, and bits 15:8 are
unused.  A few quesions come up: 

in set_mm_context():
>        if (likely((mm->context.id ^ cpu_last_asid) >> MAX_ASID_BITS))

why is this likely() ?  Shouldn't this only happen on an ASID wrap?


in __new_context():
>                /* increment the ASID version */
>                cpu_last_asid += (1 << MAX_ASID_BITS) - (1 << bits);
>                if (cpu_last_asid == 0)
>                        cpu_last_asid = ASID_FIRST_VERSION;

How do you prevent two processes from having the same context.id in
the case of ASID version wrap?  Since context.id is 64 bits, should
asid and cpu_last_asid be 64 bits as well to make this less likely?

> 
> So unless you find some bug in the existing logic, I don?t think your
> patch is needed.

After reading your comments and looking at the code some more I'm not
sure it's needed either.  I guess the only advantage is that it uses
bits 15:8 for ASID version instead of having them be unused.  I'll dig
more on why this patch was added to begin with.

-Allen

nvpublic
