From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 19 May 2017 18:34:01 +0100
Subject: [PATCH] arm: boot/compressed: fix decompressor header layout for
 v7-M
In-Reply-To: <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
References: <20170519145959.26569-1-ard.biesheuvel@linaro.org>
 <20170519164603.GH3559@e103592.cambridge.arm.com>
 <CAKv+Gu-yAT+kZ_oMT_+n6_RSOKOoqkZtGYjBKq=Wwhj31BgUgQ@mail.gmail.com>
 <67bd95eb-1f4b-d9d2-9a68-3574d03ac072@arm.com>
Message-ID: <20170519173400.GJ3559@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 06:16:36PM +0100, Robin Murphy wrote:
> On 19/05/17 17:59, Ard Biesheuvel wrote:
> > On 19 May 2017 at 17:46, Dave Martin <Dave.Martin@arm.com> wrote:

[...]

> >> Spelling it out might be more readable:
> >>
> >>    ARM(                 mov     r0, r0          )
> >>    ARM(                 mov     r0, r0          )
> >>
> >>  THUMB( AR_CLASS(       sub     pc, pc, #3      ))
> >>  THUMB( M_CLASS(        nop.w                   ))
> >>  THUMB(                 .thumb                  )
> >>  THUMB(                 b.w     1f              )
> >>
> >> But I guess it works either way.
> >>
> > 
> > Indeed. Apart from the error in the second line, this sequence should
> > be equivalent, but the nested macro invocations don't make it clearer
> > imo.
> > 
> > I could add some more comments as well if that helps?
> 
> Hmm, couldn't it be ISA-agnostic?
> 
> 	ldr pc, 1f
> 	.ltorg
> THUMB(	.thumb	)
> 	...
> 
> given that that should be interworking on anything where THUMB() is
> valid in the first place.

Did you mean

	ldr	pc, =BSYM(1f)
?

Otherwise this is quite neat: providing there are no pending literals
when the assembler reaches the ldr pc, and providing that the ldr pc is
word-aligned (it certainly should be) then that sequence should always
expand to two words.

Cheers
---Dave
