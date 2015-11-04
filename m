From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Nov 2015 13:19:53 +0100
Subject: [PATCH v2 0/3] let Marvell Berlin SoCs make use of the best delay
 timer
In-Reply-To: <5639E9DD.1080309@linaro.org>
References: <1446560917-6318-1-git-send-email-jszhang@marvell.com>
 <4359736.Q4L68M2aRW@wuerfel> <5639E9DD.1080309@linaro.org>
Message-ID: <3751534.M13UnSz6gv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 November 2015 12:19:57 Daniel Lezcano wrote:
> On 11/04/2015 11:30 AM, Arnd Bergmann wrote:
> > On Wednesday 04 November 2015 10:46:49 Daniel Lezcano wrote:
> >> On 11/03/2015 03:28 PM, Jisheng Zhang wrote:
> >>> In case there are several possible delay timers, we purely base the
> >>> selection on the frequency, which is suboptimal in some cases. Take
> >>> one Marvell Berlin platform for example: we have arch timer and dw-apb
> >>> timer. The arch timer freq is 25MHZ while the dw-apb timer freq is
> >>> 100MHZ, current selection would choose the dw-apb timer. But the dw
> >>> apb timer is on the APB bus while arch timer sits in CPU, the cost
> >>> of accessing the apb timer is higher than the arch timer.
> >>>
> >>> This series firstly modifies register_current_timer_delay() to choose
> >>> the highest rating delay timer: use the rating as a primary indication
> >>> and fall back to comparing the frequency if the rating is not set or
> >>> the same. Then we set the arch_delay_timer rating as 400, finally
> >>> Implement ARM delay timer for the dw_apb_timer and set its rating as 300.
> >>
> >> Hi Jisheng, Arnd,
> >>
> >> I don't feel comfortable with the rating / freq think. I am afraid this
> >> approach based on heuristic will bring a lot of complexity and
> >> workarounds in the code for a small benefit.
> >>
> >> Why don't we define a DT entry for the delay timer ? So we delegate the
> >> choice to the platform DT definition.
> >
> > That would be wrong, because the fact that Linux uses a timer to
> > optimize its udelay() function is not a feature of the hardware.
> 
> True.
> 
> Any ideas / suggestions for an alternative ?

How about simply hardcoding the fact that we prefer the arch timer
over any other one for delay as I suggested earlier?

Another idea I just had is to do nothing: According to Jisheng's
description for this series, the reason for preferring the arch
timer is that it is faster to access. However, we could argue
that this actually doesn't matter at all, because the entire
point of the ndelay()/udelay()/mdelay() functions is to waste
CPU cycles doing not much at all, so we can just as well waste
them reading the timer register than spinning on the CPU reading
the arch timer more often.

	Arnd
