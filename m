From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jan 2012 01:00:00 +0100
Subject: [PATCH v2 00/15] Make SMP timers standalone
In-Reply-To: <20120104214748.GH11810@n2100.arm.linux.org.uk>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
 <20111222193216.GO2577@n2100.arm.linux.org.uk>
 <4F048EC4.40900@arm.com>
 <20120104214748.GH11810@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZPEYc3xNNb1w4st86bLGMW0ePbEA6+V4opHXe6Sk=u2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 10:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 04, 2012 at 05:39:16PM +0000, Marc Zyngier wrote:
>> On 22/12/11 19:32, Russell King - ARM Linux wrote:
>> > You're also aware I assume that local timers are different from the global
>> > timer itself, and require to have additional callbacks for broadcasting
>> > the global timer tick?
>>
>> I was under the impression that we either have the global timer together
>> with broadcasting or the local timers. Completely removing the broadcast
>> callback doesn't seem to generate any ill effect as long as the local
>> timers are used instead of the global timer (which of course requires
>> broadcast in the SMP configuration).
>
> I believe even if you have local timers, there are situations where the
> these will be disabled and the kernel will switch to broadcasting from a
> global timer tick. ?I think such a scenario would be like that encountered
> with OMAP, where suspending a CPU stops its TWD - meaning that the TWD
> can't be used to wake the CPU from one of the deeper idle states.

This is true also for the Ux500.

The situation occurs as soon as you want to gate off or power
down the CPU clock/power domain, in which the TWD is
sythesized.

However IIRC this situation does not occur in the ARM reference
designs, notably Versatile Express since it simply isn't designed to
be power-agressive in this way and does not gate the clock or
power down the CPU power domain, it's always on, always
clocked (albeit with shifting frequency).

The Vexpress seem to register a clockevent for its SP804
timer, and even though I've never used this machine I guess
it would tick a few ticks during boot and then as TWD is
registered it switches to that (due to higher .rate) and
no IRQ is ever fired on the SP804 again.

Does this correspond to what is seen in /proc/interrupts
on the Vexpress?

And does the system really work if you simply delete the
code registering the SP804 clockevent from
mach-vexpress/ct-ca9x4.c?

Yours,
Linus Walleij
