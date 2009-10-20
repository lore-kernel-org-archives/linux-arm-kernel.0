From: mikpe@it.uu.se (Mikael Pettersson)
Date: Wed, 21 Oct 2009 01:02:31 +0200
Subject: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic v2
In-Reply-To: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
References: <1256078002-27919-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <19166.16775.583244.140972@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
 > This moves the clocksource_set_clock() and clockevent_set_clock()
 > from the MIPS timer code into clockchips and clocksource where
 > it belongs. The patch was triggered by code posted by Mikael
 > Pettersson duplicating this code for the IOP ARM system. The
 > function signatures where altered slightly to fit into their
 > destination header files, unsigned int changed to u32 and inlined.
 > 
 > Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
 > Cc: Thomas Gleixner <tglx@linutronix.de>
 > Tested-by: Mikael Pettersson <mikpe@it.uu.se>
 > Reviewed-by: Ralf Baechle <ralf@linux-mips.org>
 > ---
 > Changes v1->v2:
 > - Fixed Mikaels comments: spelling, terminology.
 > - Kept the functions inline: all uses and foreseen uses
 >   are once per kernel and all are in __init or __cpuinit sections.
 > - Unable to break out common code - the code is not common and
 >   implementing two execution paths will be more awkward.
 > - Hoping the tglx likes it anyway.

Very minor spelling nits below.

 > --- a/include/linux/clockchips.h
 > +++ b/include/linux/clockchips.h
 > @@ -115,6 +115,28 @@ static inline unsigned long div_sc(unsigned long ticks, unsigned long nsec,
 >  	return (unsigned long) tmp;
 >  }
 >  
 > +/**
 > + * clockevent_set_clock - calculates an appropriate shift
 > + *			  and mult values for a clockevent given a

can't have 'an' and a plural form, so s/an //

 > --- a/include/linux/clocksource.h
 > +++ b/include/linux/clocksource.h
 > @@ -257,6 +257,28 @@ static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
 >  }
 >  
 >  /**
 > + * clocksource_set_clock - calculates an appropriate shift
 > + *			   and mult values for a clocksource given a

ditto
