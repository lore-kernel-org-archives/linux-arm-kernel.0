From: ulrich.prinz@googlemail.com (Ulrich Prinz)
Date: Fri, 12 Jul 2013 00:44:29 +0200
Subject: [PATCH 9/9] clocksource: dw_apb_timer: special variant for
 rockchip rk3188 timers
In-Reply-To: <alpine.DEB.2.02.1307062233480.32106@ionos.tec.linutronix.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060056.29370.heiko@sntech.de>
 <alpine.DEB.2.02.1307060153110.32106@ionos.tec.linutronix.de>
 <51D87E04.3060704@googlemail.com>
 <alpine.DEB.2.02.1307062233480.32106@ionos.tec.linutronix.de>
Message-ID: <51DF354D.6050401@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey guys,

according the dw_apb_timer I need your statement...

Am 06.07.2013 23:00, schrieb Thomas Gleixner:
> Ulrich,
> 
> On Sat, 6 Jul 2013, Ulrich Prinz wrote:
> 
>> I got the message. With modifying the existing driver to support more
>> function pointers in its system struct and assigning them at the
>> beginning, and using them on runtime, these quirks are obsolete.
> 
> Correct.
>  
>>
>> Adding more function pointers to a system relevant structure, doubling
>> the number of functions and such didn't look non-invasive to me.
> 
> Well, it always depends. If there is a single place to deal with some
> oddball hardware, a flag is often the simplest way to go.
> 
> If you have to add 10 conditionals in several functions then in a
> first step converting the existing implementation into function
> pointer calls and then in the next step providing new implementations
> for your hardware is most of the time simpler and cleaner.
> 
>> But, I totally agree with your argumentation and I even wanted to do it
>> in the way you explained in your replies. Just the courage was missing I
>> guess :)
> 
> Gut feelings are often a better guidance than our self-doubting
> intellect. :)

You can look at my github repo for the new driver, rewriting the
interface as discussed above:
https://github.com/Astralix/linux-rockchip/blob/wip/dw_timer64/drivers/clocksource/dw_apb_timer.c

Summary: It is a 90% rewrite of the complete dw_apb_timer.c and
modifications of dw_apb_timer_of.c and dw_apb_timer.h and the related
x86 drivers are needed.
And after that the 64bit functionality is still not given as the
existing structures do not take it. But for now scheduler doesn't
support 64bit either, I guess.

The drivers local struct stays, but instead of carrying pointers to
registers it now consists of function pointers. This could be used to
fit almost any kind of timer.

I would really appreciate your comments. Sure I need to clean up a bit,
but we're still testing. But before investing more time into that code I
need you comment if I should continue or split to a separate driver for
these kind of timers.

Thanks for any comments

Regards
	Ulrich
