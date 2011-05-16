From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 16 May 2011 13:57:17 +0100
Subject: [patch 0/4] [RFC] mcount address adjustment
In-Reply-To: <BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
References: <20110510081039.241831019@de.ibm.com>
	<BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
	<20110512112454.2fa7e6d6@mschwide>
	<BANLkTinY+gDxoHk4378kXd8WH-hf9CN6ZA@mail.gmail.com>
Message-ID: <20110516125717.GB7715@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2011 at 07:00:13PM +0530, Rabin Vincent wrote:
> On Thu, May 12, 2011 at 14:54, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Wed, 11 May 2011 22:53:55 +0530 Rabin Vincent <rabin@rab.in> wrote:
> >> On Tue, May 10, 2011 at 13:40, Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >> Thumb-2 via recordmcount.pl needs the clearing of the lsb because the
> >> relocation (R_ARM_ABS32) that gets used for the assembly file
> >> that recordmcount.pl generates and assembles dictates that the lsb be
> >> set if the target symbol is Thumb/Thumb-2 function. ?mcount_adjust would
> >> not help here since the ORing is done later, when the relocation is
> >> applied.
> >
> > Hmm, from what I can make out the C version of recordmcount uses R_ARM_ABS32
> > as well.
> 
> Right.  It worked when I initially implemented ARM support there because
> recordmcount.c always found the STT_SECTION symbol as a base and not a
> STT_FUNC symbol.  However, I noticed yesterday that this does not happen
> in some cases, so I sent a patch to avoid STT_FUNC symbol as bases on
> ARM, not because of this relocation, but because of a slightly different
> oddity of Thumb symbols:
> 
> http://lkml.org/lkml/2011/5/11/304
> 
> (The relocation problem alone could be solved by using R_ARM_ABS32_NOI
>  instead.)
> 
> >
> >> Thumb-2 via recordmcount.c does not need the clearing of the lsb in
> >> ftrace_call_adjust.
> >
> > So the clearing of the lsb is only required if the recordmcount.pl script
> > is used?
> 
> Yes.
> 
> >> Building with the ARM instruction set also does not need the clearing
> >> of the lsb.
> >
> > Who does the ORing? I can't find anything in recordmount.pl/recordmcount.c
> > which looks like doing an OR, does the assembler do that based on the
> > symbol type?
> 
> The lsb is set to 1 by the linker, when it applies the relocations as it
> links vmlinux.
> 
> >
> >> > Thumb-2 the offset is -1, correct? If there is a way to distinguish
> >> > the two targets in recordmcount at compile time we could convert arm
> >> > as well. Which would allow us to remove the ftrace_call_adjust function.
> >>
> >> To remove ftrace_call_adjust, we could either deprecate the
> >> recordmcount.pl usage for ARM (you already have to edit the Kconfig to
> >> use it) or modify it to generate specific relocations explicitly instead
> >> of using the assembler data directives.
> >
> > Hmm, it would be a desirable property if the C version and the pearl
> > version of recordmcount would do the same. Or we could remove the arm
> > support from the pearl script, the C version is faster anyway.
> 
> I'm OK with removing the ARM support from recordmcount.pl; it doesn't
> seem needed to make significant modifications to it for ARM when we
> don't use it anyway.

Is there any reason why the recordmcount.pl would ever be used now that the
C implementation exists?

I notice that arch/arm/Kconfig has:

config ARM
...
        select HAVE_C_RECORDMCOUNT

so deprecating ARM support from recordmcount.pl seems unlikely to hurt
anyone.

The C implementation seems to have worked fine when I was testing dynamic
ftrace with Thumb-2 recently.

Cheers
---Dave
