From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Jul 2017 14:58:09 +0800
Subject: [PATCH] ARM: Use WFI when possible when halting a core
In-Reply-To: <CAGb2v674mGsJNcpmbAS-8seNGi=rNsab5a-dRPtujNaOBckRhA@mail.gmail.com>
References: <20170727120803.27848-1-wens@csie.org>
 <20170727121720.GS31807@n2100.armlinux.org.uk>
 <CAGb2v674mGsJNcpmbAS-8seNGi=rNsab5a-dRPtujNaOBckRhA@mail.gmail.com>
Message-ID: <CAGb2v678ux0Aq=HU-DDqBs11o4j_w1hbYL2xSYX4vGTVByirNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 8:45 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Thu, Jul 27, 2017 at 8:17 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Thu, Jul 27, 2017 at 08:08:03PM +0800, Chen-Yu Tsai wrote:
>>> On ARM, the kernel busy loops after cleaning up when a core is to be
>>> halted. This may have the undesired effect of increasing the core
>>> temperature, at a time when no power or thermal management is
>>> available, such as a kernel panic or shutdown to halt.
>>>
>>> x86 uses the more efficient HLT (halt) instruction. The equivalent
>>> instruction on ARM is WFI (wait for interrupt).
>>>
>>> This patch makes the busy loops in the ARM halt/reboot/panic paths
>>> use WFI when available (as defined in arch/arm/include/asm/barrier.h).
>>>
>>> A touch test indicates that this lowers the surface temperature of the
>>> Allwinner H3 SoC, with all 4 cores brought up with SMP, from painfully
>>> hot to just warm to the touch after shutdown to halt.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>
>>> I asked about this some time ago, and the answer was no one had done
>>> it. So here it is. It is somewhat similar to the patch "arm64:
>>> Improve parking of stopped CPUs", for arm64 obviously.
>>
>> There are various errata around the "wfi" instruction on various CPUs
>> which means that this simple implementation isn't going to work
>> reliably.
>>
>> This is where cpu_do_idle() comes in - please use that instead.
>
> Thanks for the tip. Looks like this one is implemented for every
> platform. No need for #ifdefs anymore.

So I've done the modifications and re-tested. Unfortunately it no
longer works, either using wfi() directly or cpu_do_idle(). It worked
back in January this year.

I'm not sure what's happening. The chip is still hot. (Hotter than
when it is idle in userspace.) I added some printk calls around the
wfi() / cpu_do_idle() calls and found it continuously looping, instead
of being parked. But of course printk might add to the problem.

AFAIK all interrupts should be disabled by the time the call is
reached. What could possibly bring the CPU out of WFI?

Regards
ChenYu
