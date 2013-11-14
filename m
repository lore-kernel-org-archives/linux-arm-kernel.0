From: alex.shi@linaro.org (Alex Shi)
Date: Thu, 14 Nov 2013 21:08:29 +0800
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <20131114120845.GA16735@n2100.arm.linux.org.uk>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
 <52848547.9080604@linaro.org>
 <CANHzE=0yshUSnxRRhQ_hBjo8ze4pSzuWQq+SAWdosq+wdP8hFg@mail.gmail.com>
 <20131114115313.GC16501@localhost.localdomain>
 <20131114120845.GA16735@n2100.arm.linux.org.uk>
Message-ID: <5284CB4D.3050902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2013 08:08 PM, Russell King - ARM Linux wrote:
> On Thu, Nov 14, 2013 at 12:53:15PM +0100, Frederic Weisbecker wrote:
>> BTW, support for ARM's full dynticks is uncomplete without
>> "[PATCH] ARM: Support arch_irq_work_raise() via self IPIs"
>>
>> ...which I'm not sure is applied upstream, or even any ARM tree yet.
> 
> It's in mainline as of last night, along with a fix to the above patch.
> 

I saw this in linus tree and in tip/master. According to content, it
seems no effort on this issue. The following testing base on latest code.

btw, the full_all do cause more interrupts.

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
# CONFIG_NO_HZ_FULL_ALL is not set
CONFIG_NO_HZ_FULL_SYSIDLE=y
CONFIG_NO_HZ_FULL_SYSIDLE_SMALL=2
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

alexs at alex-panda:~$ head -2 /proc/interrupts; sleep 10 ; head -2
/proc/interrupts
           CPU0       CPU1
 29:      12567       9783       GIC  29  twd
           CPU0       CPU1
 29:      12814       9942       GIC  29  twd

Then enabled CONFIG_NO_HZ_FULL_ALL. more than 200/second interrupt
increased.

alexs at alex-panda:~$ head -2 /proc/interrupts; sleep 10 ; head -2
/proc/interrupts
           CPU0       CPU1
 29:      34969       6384       GIC  29  twd
           CPU0       CPU1
 29:      37172       6646       GIC  29  twd


-- 
Thanks
    Alex
