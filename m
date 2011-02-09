From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Feb 2011 10:20:29 -0000
Subject: [PATCH] ARM: Correct WFE() in asm/spinlock.h for Thumb-2
In-Reply-To: <AANLkTi=XfBjite-xtR8z_+5ATxSb4a9XDNAXdLBowWKY@mail.gmail.com>
References: <1297178414-20983-1-git-send-email-dave.martin@linaro.org>	<20110208164009.GD27521@n2100.arm.linux.org.uk>
	<AANLkTi=XfBjite-xtR8z_+5ATxSb4a9XDNAXdLBowWKY@mail.gmail.com>
Message-ID: <001d01cbc842$fa1aacc0$ee500640$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

> On Tue, Feb 8, 2011 at 4:40 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 08, 2011 at 03:20:14PM +0000, Dave Martin wrote:
> >> The content for ALT_SMP() in the definition of WFE() expands to 6
> >> bytes (IT cc ; WFEcc.W), which breaks the assumptions of the fixup
> >> code, leading to lockups when the affected code gets run.
> >
> > Why does it?  My understanding is that the .w suffix forces the assembler
> > to use the ARM encoding for the instruction.
> 
> The .w suffix forces a 32-bit encoding of Thumb-2 instructions for
> which a 16-bit encoding is available.  Unfortunately, the 32-bit

[...]

> the WFE into the 4 bytes expected by ALT_SMP().  For safety, I write
> it out explicitly: ALT_SMP("wfene", ...) would work sometimes but
> might not work as expected if the previous instruction has an EQ or NE
> condition, because then the assembler wouldn't need to insert an extra
> IT when it generates its output...

That's really horrible! It might be worth commenting the explicit
IT in your WFE macro to explain why we can't rely on the assembler
to generate it for us.

With that minor change:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
