From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 29 Aug 2013 09:52:18 -0700
Subject: [PATCH] clocksource: em_sti: Adjust clock event rating to fix
 SMP broadcast
In-Reply-To: <CANqRtoT=gMKBHG8qJWc7FjcYFaaf5hBzzv8=AOLneoveasmKoA@mail.gmail.com>
References: <1375251940-7809-1-git-send-email-horms+renesas@verge.net.au>
 <51F94A35.2020907@codeaurora.org>
 <CANqRtoR0Wwctor1mpM+8nuC0_pZsPHUSShPuZFX4FVtoVKEuNw@mail.gmail.com>
 <51F9777B.2080500@codeaurora.org>
 <CANqRtoT=gMKBHG8qJWc7FjcYFaaf5hBzzv8=AOLneoveasmKoA@mail.gmail.com>
Message-ID: <521F7C42.7060108@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/13 01:41, Magnus Damm wrote:
> Thanks for your suggestion. Yes, there was indeed some confusion. Now
> after diving into the code a bit deeper I can finally understand what
> you mean.
>
> Instead of adjusting the rating I've changed the cpumask member like this:
>
> --- 0001/drivers/clocksource/em_sti.c
> +++ work/drivers/clocksource/em_sti.c    2013-08-29 17:33:16.000000000 +0900
> @@ -301,7 +301,7 @@ static void em_sti_register_clockevent(s
>      ced->name = dev_name(&p->pdev->dev);
>      ced->features = CLOCK_EVT_FEAT_ONESHOT;
>      ced->rating = 200;
> -    ced->cpumask = cpumask_of(0);
> +    ced->cpumask = cpu_all_mask;

It would be better to use cpu_possible_mask.

>      ced->set_next_event = em_sti_clock_event_next;
>      ced->set_mode = em_sti_clock_event_mode;
>
> Without the cpumask fix or without the earlier rating fix the
> following interrupt count can be seen in /proc/interrupts on KZM9D:
>
> 157:        140          0       GIC 157  e0180000.sti
> 160:          0          0  e0050000.gpio   1  eth0
> IPI0:          0          0  CPU wakeup interrupts
> IPI1:          0          0  Timer broadcast interrupts
>
> Above, notice how no IPI1 interrupts seem to be arriving.
>
> With the cpumask fix above the interrupt count becomes like this:
>
>  157:        559          0       GIC 157  e0180000.sti
> 160:          0          0  e0050000.gpio   1  eth0
> IPI0:          0          0  CPU wakeup interrupts
> IPI1:          0        601  Timer broadcast interrupts
>
> Would this be in line with your expectation?

Yes that is what I'm saying. What is the output of cat /proc/timer_list?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
