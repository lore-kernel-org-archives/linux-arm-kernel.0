From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 07 Jun 2013 11:15:52 +0200
Subject: [PATCH v3 4/6] ARM: kirkwood: move device tree nodes to DT irqchip
 and clocksource
In-Reply-To: <20130607103007.415575c8@skate>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370536034-23956-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130607103007.415575c8@skate>
Message-ID: <51B1A4C8.9070404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/13 10:30, Thomas Petazzoni wrote:
> On Thu,  6 Jun 2013 18:27:12 +0200, Sebastian Hesselbarth wrote:
>> -		wdt at 20300 {
>> +		wdt: watchdog-timer at 20300 {
>>   			compatible = "marvell,orion-wdt";
>>   			reg = <0x20300 0x28>;
>> +			interrupt-parent = <&bridge_intc>;
>> +			interrupts = <3>;
>>   			clocks = <&gate_clk 7>;
>>   			status = "okay";
>>   		};
>
> The watchdog driver is mapping the same registers as the timer driver
> (0x20300) and is poking into the same TIMER_CTRL register that controls
> both the timers and the watchdog.

Thomas,

you are right. I must admit that I forgot to take care of watchdog
driver.

> In addition to this, the watchdog driver also pokes into some other
> registers, such as BRIDGE_CAUSE and RSTOUTn_MASK.

As you can see above, watchdog should depend on chained interrupts but
current implementation doesn't but clears itself in BRIDGE_CAUSE.
Current non-DT timer also does (thread unsafe).

DT timer depends on the chained irq handler introduced with this patch
set. So for the interrupt, watchdog should also depend on the chained
irq handler to clear wdt irq.

Access to TIMER_CTRL should be made thread safe. I suggest to put that
common code into orion clocksource as it will be always compiled in
while wdt is optional.

> As we want to bring watchdog support for Armada 370/XP, I'm wondering
> if we should fix those problems, and if yes, how:
>
>   (1) The timer driver is also responsible for handling the watchdog
>       (probably the easiest solution)

Well, there is drivers/watchdog where current (Orion) wdt is located.
I guess it should stay there. For Armada 370/XP I guess it will need
to clear the watchdog events in common timer registers as for the timer
events? That is why I didn't merge Orion clocksource into Armada 370/XP
clocksource because we would have to check for Orion/Armada 370/XP on
every timer event.

>   (2) Have some sort of 'common code' between the timer driver and the
>       watchdog driver to control the access to the shared TIMER_CTRL
>       register.

Yes. Both should call a common thread-safe timer_en(num) at least.

>   (3) Something else.
>
> And this still does not solve the access to BRIDGE_CAUSE and
> RSTOUTn_MASK.

BRIDGE_CAUSE is taken care of by making wdt depend on chained irq
handler.. RSTOUTn_MASK is only used by current common code on reset,
maybe there is an API for that I have missed yet. But both reset and
watchdog will ultimately cause a reset - maybe we can accept that for
now.

Sebastian
