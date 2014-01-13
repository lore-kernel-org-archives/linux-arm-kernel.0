From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Jan 2014 20:42:59 +0100
Subject: [GIT PULL] get rid of <mach/timex.h>
In-Reply-To: <CAOesGMgLuR_HSHZjHLGcgQrnaoYHCqGOXE-Tab=DNC5qc2YfGA@mail.gmail.com>
References: <20131213221651.GA10344@perseus.defre.xn--kleine-knig-yfb.de>
 <87bo0clved.fsf@linaro.org> <20131219221758.GS14866@pengutronix.de>
 <20131220184715.GT14866@pengutronix.de>
 <52CBE3DE.5010706@atmel.com>
 <CACRpkdboVtY2nBxGeWj_ReHJ5J8WuyuPHCwHM=yELBdePkX7Vw@mail.gmail.com>
 <CAOesGMgLuR_HSHZjHLGcgQrnaoYHCqGOXE-Tab=DNC5qc2YfGA@mail.gmail.com>
Message-ID: <20140113194259.GG29475@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Mon, Jan 13, 2014 at 10:26:10AM -0800, Olof Johansson wrote:
> On Mon, Jan 13, 2014 at 5:36 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Jan 7, 2014 at 12:24 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> >> On 20/12/2013 19:47, Uwe Kleine-K?nig :
> >
> >>> Please pull
> >>>
> >>>       git://git.pengutronix.de/git/ukl/linux.git tags/dropmachtimexh
> >>>
> >>> which points to 79f08d9ed217318b4f325b7fcf8f26dcd0e41689 now provided
> >>> you are happy with Linus W.'s series, too.
> >>
> >> Hi all,
> >>
> >> Is this pull-request is foreseen to be integrated in arm-soc for 3.14? I
> >> may have some material for Linus W. that I would like to queue that
> >> depend on these patches.
> >
> > I'd like to know the status here. If the <timex.h> material is not
> > going into v3.14 I'd very much like my single patch to the serial
> > driver to go in, and the removal of AT91's <mach/gpio.h>.
> 
> Uwe made it a pain to review these patches, so it's taking a while.
> Instead of removing the header contents in the same commit, he just
> adds to the non-include-file code so I have to manually go find the
> right include file, check the value, and then move to the next one.
> Since he removes the headers in the last change that means checking
> out a different tree back and forth.
It wasn't that hard to create the patches. I had two terminals open, one
to write the patch and the other to check the mainline tree. For you it
would have been your MUA and a mainline tree. Then for a touched driver,
determine the timex.h, and lookup the values there.
Moreover conceptually it's wrong to drop the values in the same patch as
the local definition is added. Consider dropping the timex.h files
results in a regression. Then you would have to revert the whole series.
Now it's only the last patch.

> > In that case I'm requesting an ACK on the ARM portions from the
> > ARM SoC folks, so I can take it through the GPIO tree.
> 
> Most of the series looks OK, but the IXP4xx change looks fishy. This
> is exactly why I wanted to get the header touched at the same time. It
> says:
> 
> 
> /*
>  * We use IXP425 General purpose timer for our timer needs, it runs at
>  * 66.66... MHz. We do a convulted calculation of CLOCK_TICK_RATE b/c the
>  * timer register ignores the bottom 2 bits of the LATCH value.
>  */
> #define IXP4XX_TIMER_FREQ 66666000
> #define CLOCK_TICK_RATE \
>         (((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
> 
> 
> 
> But all he does in the C file now is:
> 
> +#define IXP4XX_TIMER_FREQ 66666000
> +#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, HZ)
> 
> So it seems that this code is now broken. Uwe?
I remember that I wondered about that code and noticing that

	#define IXP4XX_OST_RELOAD_MASK 0x00000003

and IXP4XX_TIMER_FREQ being a multiple from HZ (100)
results in

	IXP4XX_TIMER_FREQ / HZ == IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK

and multiplying that with HZ results in IXP4XX_TIMER_FREQ again. The
only problem I see just now is that I didn't pay attention to the +1.

>From a quick glance I'd say the calculation is wrong, but still it's out
of the scope of my patch to fix that.

The old state is:
	#define IXP4XX_TIMER_FREQ 66666000
	#define CLOCK_TICK_RATE (((IXP4XX_TIMER_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
	#define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)

which results in CLOCK_TICK_RATE = 66666100 and LATCH = 666661 =
0xa2c25 which has one of the two bottom bits set, so I assume this
results in an effective value of 666660 being used resulting in a cycle
time of exactly 0.01s.

I'm using plain 66666000 / 100 so at least it doesn't result in a
regression.

The more correct approach would be:

/*
 * The timer register ignores the bottom 2 bits of the LATCH value
 * i.e. assumes them being zero no matter what is written to them.
 * So make sure IXP4XX_LATCH is the best value with the two least
 * significant bits unset.
 */
#define IXP4XX_TIMER_FREQ 66666000
#define IXP4XX_LATCH DIV_ROUND_CLOSEST(IXP4XX_TIMER_FREQ, 4 * HZ) * 4

As said above for the actuall values it doesn't matter, but if
IXP4XX_TIMER_FREQ was 66665999 that would result in a cycle time of
0.0099999401494 with the old code but
0.01000000015 with my suggestion above.

I think the old calculation of CLOCK_TICK_RATE was more correct back
when LATCH was defined as simply CLOCK_TICK_RATE / HZ. But even that I
think it was wrong.

Imre, Krzysztof: care to comment?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
