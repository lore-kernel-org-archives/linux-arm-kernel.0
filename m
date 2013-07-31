From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 1 Aug 2013 04:17:39 +0900
Subject: [PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP
 broadcast
In-Reply-To: <51F94A35.2020907@codeaurora.org>
References: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
 <51F94A35.2020907@codeaurora.org>
Message-ID: <CANqRtoR0Wwctor1mpM+8nuC0_pZsPHUSShPuZFX4FVtoVKEuNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Thu, Aug 1, 2013 at 2:32 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/30/13 23:25, Simon Horman wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the STI rating from 200 to 80 to fix SMP operation with
>> the ARM broadcast timer. This breakage was introduced by:
>>
>> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over real hardware clock-event
>>
>> Without this fix SMP operation is broken on EMEV2 since no
>> broadcast timer interrupts trigger on the secondary CPU cores.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
>
> This looks suspicious. Are you're purposefully deflating the rating so
> that the STI timer fills in the broadcast position? Why not make the STI
> cpumask be all possible CPUs? Presumably the interrupt can target all
> CPUs since it isn't a per-cpu interrupt and doing this would cause the
> STI to fill in the broadcast slot, leaving the per-cpu dummys in the
> tick position.

While letting the timer broadcast to all CPUs sounds interesting the
STI driver has so far only been used to drive a single CPU core. This
used to work well for us but has since some time unfortunately been
broken. I agree that it may be suboptimal with a single timer like STI
and using IPI for broadcast, but for more efficient SMP we already
have TWD or arch timer.

This particular patch just does what should have been done during
development of the following commit:

f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over
real hardware clock-event

Basically, the f7db706 commit changes the dummy clockevent rating from
400 to 100. Our timers in drivers/clocksource all had a rating higher
than 100 so the commit basically broke everything. I can understand
that the CMT, TMU and MTU2 timers were overlooked due to clock event
rating in platform data, but a simple grep would have saved this
driver..

Anyway, this patch adjusts the STI rating from 200 down to 80 so we
now once again are below the dummy clock event rating. So now SMP is
working again, yay!

Thanks for your comments!

/ magnus
