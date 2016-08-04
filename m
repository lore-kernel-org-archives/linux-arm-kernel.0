From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 4 Aug 2016 13:55:45 +0100
Subject: [PATCH 1/8] ARM: assembler: introduce adr_l, ldr_l and str_l
 macros
In-Reply-To: <20160804121619.GS1041@n2100.armlinux.org.uk>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <1470238730-30038-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160803164940.GC7147@e103592.cambridge.arm.com>
 <CAKv+Gu_3YKfdCyMuTdrk+t16qQOuMiSqWEHf-h1K2ajM5s1rxw@mail.gmail.com>
 <20160804094451.GE7147@e103592.cambridge.arm.com>
 <CAKv+Gu-T9+fhvRk-RroDqr7QvQ24cUTuONL9uT-Ws24n_nHrCw@mail.gmail.com>
 <20160804112229.GG7147@e103592.cambridge.arm.com>
 <20160804121619.GS1041@n2100.armlinux.org.uk>
Message-ID: <20160804125544.GI7147@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 01:16:19PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 04, 2016 at 12:22:29PM +0100, Dave Martin wrote:
> > The more conventional literal-.long approach could still be macro-ised
> > along the same lines, which might make the affected code more readable,
> > but the idiom you'd be replacing is well-understood and not very common.
> 
> I don't see how it could be.  You can't efficiently place the literal
> data alongside the instructions dealing with it.
> 
> The only alternative is to use ldr rd, =foo, but that gets very stupid
> when you want to calculate the relative offset, and you end up with
> something like this for every relative load:
> 
> 	ldr rd, =.
> 	sub rd, rd, #. - 4
> 	ldr r1, =foo
> 	add r1, r1, rd

In theory, it ought to be possible to combine the two approaches:

	ldr	rd, =foo - (1f + 8)	@ or =foo - (. + 12)
1:	add	rd, pc, rd

But gas doesn't like the argument of ldr= to require a reloc (though it
would work perfectly well).


A similar effect to automatic literal pool placement can be achieved by
means of subsections:

	.subsection 1
	.align 2
0:	.long	foo - (1f + 8)
	.previous

	ldr	rd, 0b
1:	add	r0, pc, r0

... though this also has some shortcomings (including that .ltorg
won't flush these literals, and that subsections are a rarely used
assembler feature and will likely confuse people).

> As I've already said, I prefer the existing solution.  It works, it's
> been known to work for the last 22 years.
> 
> If it isn't broken, don't try to fix it.

Indeed... the case for the change isn't very compelling -- just nice
to have if it could be done without any unfortunate side-effects
(which looks unlikely right now).

Cheers
---Dave
