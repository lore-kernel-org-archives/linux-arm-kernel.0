From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Feb 2012 04:49:13 +0100
Subject: [PATCH 04/18] ARM: at91: make ST (System Timer) soc independent
In-Reply-To: <4F41C29D.2090702@gmail.com>
References: <1329501010-30468-1-git-send-email-nicolas.ferre@atmel.com>
 <957702b1ff83afcc0a8e842f53f05ff3f40b78b3.1329500622.git.nicolas.ferre@atmel.com>
 <4F419246.6080405@gmail.com>
 <20120220013825.GD29599@game.jcrosoft.org>
 <4F41A76D.1070409@gmail.com>
 <20120220030234.GE29599@game.jcrosoft.org>
 <4F41BB20.8000901@gmail.com>
 <20120220032324.GF29599@game.jcrosoft.org>
 <4F41C29D.2090702@gmail.com>
Message-ID: <20120220034913.GG29599@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:48 Mon 20 Feb     , Ryan Mallon wrote:
> On 20/02/12 14:23, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On 14:16 Mon 20 Feb     , Ryan Mallon wrote:
> >> On 20/02/12 14:02, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>
> >>> On 12:52 Mon 20 Feb     , Ryan Mallon wrote:
> >>>> On 20/02/12 12:38, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>>
> >>>>> On 11:22 Mon 20 Feb     , Ryan Mallon wrote:
> >>>>>> On 18/02/12 04:49, Nicolas Ferre wrote:
> >>>>>>
> >>>>>>> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >>>>>>>
> >>>>>>> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> >>>>>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>>>>>> ---
> >>>>>>>  arch/arm/mach-at91/at91rm9200.c              |    4 +-
> >>>>>>>  arch/arm/mach-at91/at91rm9200_time.c         |   37 ++++++++++++++++----------
> >>>>>>>  arch/arm/mach-at91/generic.h                 |    1 +
> >>>>>>>  arch/arm/mach-at91/include/mach/at91_st.h    |   32 +++++++++++++++-------
> >>>>>>>  arch/arm/mach-at91/include/mach/at91rm9200.h |    2 +-
> >>>>>>>  drivers/watchdog/at91rm9200_wdt.c            |    8 +++---
> >>>>>>>  6 files changed, 53 insertions(+), 31 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> >>>>>>
> >>>>>> Hi Jean, Nicolas,
> >>>>>>
> >>>>>> Patch looks mostly good, couple of points below.
> >>>>>>
> >>>>>> ~Ryan
> >>>>>>
> >>>>>> <snip>
> >>>>>>
> >>>>>>>  	/* Cancel any pending alarm; flush any pending IRQ */
> >>>>>>> -	at91_sys_write(AT91_ST_RTAR, alm);
> >>>>>>> -	(void) at91_sys_read(AT91_ST_SR);
> >>>>>>> +	at91_st_write(AT91_ST_RTAR, alm);
> >>>>>>> +	(void) at91_st_read(AT91_ST_SR);
> >>>>>>
> >>>>>>
> >>>>>> Can we please remove the (void) casting of the return value when making
> >>>>>> this change, especially since at91_st_read is now a macro which doesn't
> >>>>>> even have a return value. Same in a few other places.
> >>>>> modification done by script and it's no the scope of this patch
> >>>>
> >>>>
> >>>> That isn't an excuse to leave incorrect code there. It is a simple fix.
> >>> no (void) in c means you don't care of the return so basically it's right
> >>
> >>
> >> Because of the way the __raw_writel is defined you are casting the
> >> result of an assignment, basically you are doing this:
> >>
> >>    int foo, bar;
> >>
> >>   (void)(foo = bar);
> >>
> >> Which is pointless. Don't make excuses for silly, redundant code. Fix
> >> it, please.
> > except it's a read it has nothing to do with that
> 
> 
> It makes no difference, it is still equally pointless. We don't cast
> unused return values to void, for functions or assignments, in the kernel.
> 
> It is pointless, superfluous code, and now is a really good opportunity
> to fix it. You can probably even make your script do it for you :-).
I do not want to do 2 thinks at the same time
[
if there is a need to o fix this, it must be done in other patch bisectable

Best Regards,
J.
