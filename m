From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Nov 2010 11:38:25 +0000
Subject: [PATCH 1/5] ARM: pgtable: switch order of Linux vs hardware
	page tables
In-Reply-To: <AANLkTik043UX-cXyriVAwzFTNNTtCTcxYd6VN_gYqCFe@mail.gmail.com>
References: <20101117172717.GF5308@n2100.arm.linux.org.uk>
	<E1PIloA-0007qU-ME@rmk-PC.arm.linux.org.uk>
	<AANLkTik043UX-cXyriVAwzFTNNTtCTcxYd6VN_gYqCFe@mail.gmail.com>
Message-ID: <20101126113825.GK9310@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 11:48:31AM +0000, Catalin Marinas wrote:
> On 17 November 2010 17:28, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -158,7 +156,7 @@ ENTRY(cpu_v7_set_pte_ext)
> > ? ? ? ?tstne ? r1, #L_PTE_PRESENT
> > ? ? ? ?moveq ? r3, #0
> >
> > - ? ? ? str ? ? r3, [r0]
> > + ? ? ? str ? ? r3, [r0, #2048]!
> 
> Thumb-2 build gives "offset out of range".  We need to do a separate
> ADD for this case.

Do we have any clues about the typical timing of:

	str	r3, [r0, #2048]!
	mcr	p15, 0, r0, c7, c10, 1

vs:
	add	r0, r0, #2048
	str	r3, [r0]
	mcr	p15, 0, r0, c7, c10, 1

or
	str	r3, [r0, #2048]
	add	r0, r0, #2048
	mcr	p15, 0, r0, c7, c10, 1

on ARMv7?
