From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 2 Nov 2015 21:33:13 +0800
Subject: [PATCH] clocksource: dw_apb_timer_of: support timer-based delay
In-Reply-To: <56372366.6090905@linaro.org>
References: <1446193659-1698-1-git-send-email-jszhang@marvell.com>
 <56334A1E.7060709@linaro.org>	<20151030190929.4c46066c@xhacker>
 <5633646D.7030206@linaro.org>	<20151102105113.72aade85@xhacker>
 <56372366.6090905@linaro.org>
Message-ID: <20151102213313.60ee2261@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Daniel,

On Mon, 2 Nov 2015 09:48:38 +0100
Daniel Lezcano  wrote:

> On 11/02/2015 03:51 AM, Jisheng Zhang wrote:
> > Dear Daniel,
> >
> > On Fri, 30 Oct 2015 13:37:01 +0100
> > Daniel Lezcano wrote:
> >  
> >> On 10/30/2015 12:09 PM, Jisheng Zhang wrote:  
> >>> Dear Daniel,
> >>>
> >>> On Fri, 30 Oct 2015 11:44:46 +0100
> >>> Daniel Lezcano <daniel.lezcano@....> wrote:
> >>>  
> >>>> On 10/30/2015 09:27 AM, Jisheng Zhang wrote:  
> >>>>> Implement an ARM delay timer to be used for udelay(). This allows us to
> >>>>> skip the delay loop calibration at boot on Marvell BG2, BG2Q, BG2CD
> >>>>> platforms. And after this patch, udelay() will be unaffected by CPU
> >>>>> frequency changes.
> >>>>>
> >>>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> >>>>> ---
> >>>>>     drivers/clocksource/Kconfig           | 10 ++++++++++
> >>>>>     drivers/clocksource/dw_apb_timer_of.c | 16 ++++++++++++++++
> >>>>>     2 files changed, 26 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> >>>>> index a7726db..7b081805 100644
> >>>>> --- a/drivers/clocksource/Kconfig
> >>>>> +++ b/drivers/clocksource/Kconfig
> >>>>> @@ -29,6 +29,16 @@ config DW_APB_TIMER_OF
> >>>>>     	select DW_APB_TIMER
> >>>>>     	select CLKSRC_OF
> >>>>>
> >>>>> +config DW_APB_TIMER_BASED_DELAY
> >>>>> +	bool "DW APB timer based delay"
> >>>>> +	depends on ARM && DW_APB_TIMER_OF
> >>>>> +	default n
> >>>>> +	help
> >>>>> +	  This option enables support for using the DW APB timer to
> >>>>> +	  implement timer-based delay. It is useful for skiping the
> >>>>> +	  delay loop calibration at boot on some platforms. And the
> >>>>> +	  udelay() will be unaffected by CPU frequency changes.
> >>>>> +  
> >>>>
> >>>> Why do you want it to be optional ?
> >>>>  
> >>>
> >>> Because in some platforms which has arm arch timer, this dw apb timer
> >>> delay isn't needed, the arch timer is better. So we want it be optional
> >>> so that the platforms which need this feature select it manually when config
> >>> the kernel.  
> >>
> >> Correct me if I am wrong. If you have the arch timer, you don't need the  
> >
> > Yes, I don't need the dw apb timer if we have arch timer,
> >  
> >> dw apb timer at all, no ? So the selection would be arch arm timer *or*
> >> dw_apb_timer ? not arch_arm_timer for delay and dw_apb_timer for
> >> clockevents, right ?  
> >
> > Yes, if we have arch timer, I prefer to use it for clockevent and delay.
> >
> > Could you please provide suggestion how to handle this case?  
> 
> If I follow the logic of arch_arm_timer is better than dw_apb timer.
> 
> 1. The arch_arm_timer is present
> 
>   => dw_apb timer is not used at all  
> 
>   CONFIG_ARM_ARCH_TIMER=y
>   # CONFIG_DW_APB_TIMER is not set
> 
> 2. The arch_arm_timer is *not* present
> 
>   => dw_apb_timer is used with delay code  
> 
>   # CONFIG_ARM_ARCH_TIMER is not set
>   CONFIG_DW_APB_TIMER=y
> 
> In both cases, DW_APB_TIMER_BASED_DELAY is not needed.
> 

The problem is register_current_timer_delay() is only available in ARM but
DW APB timer isn't only used in ARM platforms, but also ARM64 etc. where the
register_current_timer_delay() isn't defined. so I used DW_APB_TIMER_BASED_DELAY
to 

1. distinguish whether we need the dw apb timer based delay

2. distinguish whether we have register_current_timer_delay()

I have a solution which doesn't need DW_APB_TIMER_BASED_DELAY symbol -- put
all timer based delay code under CONFIG_ARM, I'm not sure whether this is
better. Could you please give suggestion?

Thanks in advance,
Jisheng
