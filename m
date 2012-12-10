From: johnstul@us.ibm.com (John Stultz)
Date: Mon, 10 Dec 2012 11:05:41 -0800
Subject: [PATCH V2] ARM: bcm281xx: Add timer driver
In-Reply-To: <CAOesGMg3-=ywfgp365_zumsBWBKC+ASxwYpobbkV4_x37P0NoQ@mail.gmail.com>
References: <1354954544-21429-1-git-send-email-csd@broadcom.com>
 <CAOesGMg3-=ywfgp365_zumsBWBKC+ASxwYpobbkV4_x37P0NoQ@mail.gmail.com>
Message-ID: <50C63285.1030605@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2012 03:44 PM, Olof Johansson wrote:
> John,
>
> On Sat, Dec 8, 2012 at 12:15 AM, Christian Daudt <csd@broadcom.com> wrote:
>> This adds support for the Broadcom timer, used in the following SoCs:
>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>>
>> This patch needs the arm-soc/soc/next branch
>>
> Given the dependencies on the new platform here, should we just merge
> this through arm-soc? If so, an Acked-by would be appreciated.
>
> Alternatively, we can merge the driver and the device tree updates
> separately if that's easier.

So I'd definitely rather any hardware specific clocksource/clockevent 
drivers be merged through the arch tree, as there's no way I'll be able 
to do proper reviewing or testing of the code given my lack of knowledge 
and access to the various hardware bits (this is why I preferred when 
clocksource drivers stayed in their arch tree - but I've been overruled 
on this :).

And in this case, Thomas has a better sense of the clockevents code then 
I do (I focus more on the clocksource code), and its only been recently 
that folks started dumping clockevent drivers in the clocksource 
directory (usually because its the same hardware backing both).

That said, if there's any non-hardware specific clocksource changes, I 
definitely would like to review it. The clocksource mmio driver for 
instance, snuck by me (likely my fault for ignoring things) and probably 
should be eventually merged into the clocksource core, rather then being 
a meta-driver.

But since you pulled me in here, I've got a bike-shedding nit below 
(Sorry!).

>> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
>> new file mode 100644
>> index 0000000..dbc54c2
>> --- /dev/null
>> +++ b/drivers/clocksource/bcm_kona_timer.c
>>
>> +static void __init timers_init(void)
>> +static int timer_set_next_event(unsigned long clc,
>> +                                 struct clock_event_device *unused)
>> +static void timer_set_mode(enum clock_event_mode mode,
>> +                            struct clock_event_device *unused)
>> +static void __init timer_clockevents_init(void)
>>
>> +static irqreturn_t timer_interrupt(int irq, void *dev_id)
>>

These are all terribly generic function names. I know they're static 
(and plenty of other driver do the same thing), but it makes grepping 
for similar code a pain and can cause confusing backtraces.   Maybe 
consider using the kona_timer_... prefix?

Other then that, for what its worth,
Acked-by: John Stultz <johnstul@us.ibm.com>

thanks
-john
