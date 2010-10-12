From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Oct 2010 11:32:25 +0200
Subject: [PATCH 2/2] mx51: add resources for SD/MMC on i.MX51
In-Reply-To: <4CB4216C.8010200@eukrea.com>
References: <20101011170405.GC476@pengutronix.de>
	<1286868685-7825-2-git-send-email-eric@eukrea.com>
	<20101012081804.GD29673@pengutronix.de>
	<4CB4216C.8010200@eukrea.com>
Message-ID: <20101012093225.GF29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, Oct 12, 2010 at 10:50:52AM +0200, Eric B?nard wrote:
> Le 12/10/2010 10:18, Uwe Kleine-K?nig a ?crit :
>> On Tue, Oct 12, 2010 at 09:31:25AM +0200, Eric B?nard wrote:
>>> the attached patch allows SD to work on i.MX51 with Wolfram's drivers
>>> Tested on i.MX51.
>>>
>>> Based on original patch from: Richard Zhu<r65037@freescale.com>
>>> Signed-off-by: Eric B?nard<eric@eukrea.com>
>>> ---
>>>   arch/arm/mach-mx5/clock-mx51.c              |  102 ++++++++++++++++++++++++++-
>>>   arch/arm/mach-mx5/devices-imx51.h           |    9 +++
>>>   arch/arm/plat-mxc/include/mach/iomux-mx51.h |   45 ++++++++----
>>>   3 files changed, 140 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
>>> index 7deb683..9e8b268 100644
>>> --- a/arch/arm/mach-mx5/clock-mx51.c
>>> +++ b/arch/arm/mach-mx5/clock-mx51.c
>>> @@ -41,6 +41,34 @@ static struct clk usboh3_clk;
>>>
>>>   #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>>>
>>> +static void __calc_pre_post_dividers(u32 div, u32 *pre, u32 *post)
>>> +{
>> I asked for a comment here.  E.g. valid ranges of pre and post and the
>> task solved here (I assume it's "Find pre and post with pre * post =
>> div"?).
>>
> will try to write something.
> Richard : do you have a comment in mind for this function ?
>
> >> +		}
> >> +		*post = (div + *pre - 1) / *pre;
> > 		*post = DIV_ROUND_UP(div, *pre);
> >
> > I don't know if DIV_ROUND_UP is sensible, maybe use DIV_ROUND_CLOSEST?
> > I'd look into that when the comment above is in place.
> >
> if you have an opinion before, this would be great to avoid a n+1  
> version of this patch ;-)
I'm lazy.  To analyse this I need to know how pre and post are used.  I
assume you (and/or Richard) already know that so I'm not keen to search
this info in the reference manuals.  See it as a quality test for the
comment I asked for :-)

>>> -#define DEFINE_CLOCK1(name, i, er, es, pfx, p, s)	\
>>> +#define DEFINE_CLOCK_CCGR(name, i, er, es, pfx, p, s)	\
>> This is IMHO a good idea, but it should go in a seperate patch.  These
>> clock changes are very sensible and so a working bisection is important
>> here.
>>
> there is no clock change here only a define rename to avoid having  
> DEFINE_CLOCK1, DEFINE_CLOCK2 ... is a separate patch really needed ?
Yep, please do.  I don't hope your patch breaks anything, but if it
does, it's easier to find out the actual breakage if there is no noise
in the patch.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
