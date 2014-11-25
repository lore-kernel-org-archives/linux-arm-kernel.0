From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 25 Nov 2014 23:23:04 +0100
Subject: (bisected) Lock up on sh73a0/kzm9g on cpuidle initialization
In-Reply-To: <CAMuHMdUMpmdYe+ED=M8FVvMMWNmrs8o4WzQ-uc2nFHNdL99HNQ@mail.gmail.com>
References: <CAMuHMdXaaa2t6+sH2egGacVxkAPeTUkAgwdYsOnMnEPnuLdB5Q@mail.gmail.com>	<545BE1DE.6060900@linaro.org>	<CAMuHMdXQr65g4He0D0ZRN923OJ2A7WNgwbiTru_1dGWnvbvCJA@mail.gmail.com>	<CAMuHMdUjYMC8i2F9n6fWdPBOQVSohKA3ZxJJyq8h808Z9tEypw@mail.gmail.com>	<20141125180159.GI5050@linux.vnet.ibm.com>
 <CAMuHMdUMpmdYe+ED=M8FVvMMWNmrs8o4WzQ-uc2nFHNdL99HNQ@mail.gmail.com>
Message-ID: <54750148.207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2014 10:27 PM, Geert Uytterhoeven wrote:

[ ... ]

>> Does any sort of system activity (keyboard, network, etc.) unstick the
>> system?
>
> Thanks! Unfortunately none of the above helped.
>
> However, I found the culprit. It turned out to be a platform issue, not an
> issue in the generic cpu idle or RCU code. Read on below if you're
> interested in the gory details. Else just skip, and sleep well again tonight ;-)
>
>> If you have tried all those things without good effect, could you please
>> send along your .config and an alt-sysrq-t dump of all tasks' stacks?
>
> As I didn't manage to trigger a sysrq dump over the serial console,
> I just called __handle_sysrq() right before the wait_for_completion(), after
> a small delay. The dump didn't show anything suspicious. Everything
> looked the same as on the dual-core Cortex A15, where the problem
> doesn't manifest.
>
> Then I noticed the sched debug output on the A15, which was missing
> on the CA9 build. Enabling it on the A9 gave:
>
> Sched Debug Version: v0.11,
> 3.18.0-rc6-kzm9g-reference-04913-gedc89a2a2059c7ff-dirty #101
> ktime                                   : 0.000000
> sched_clk                               : 0.000000
> cpu_clk                                 : 0.000000
> jiffies                                 : 4294928896
>
> Oops, time is not advancing?
>
> Dmesg also shows (early):
>
>      clocksource_of_init: no matching clocksources found
>
> and the timer is only initialized much later, after cpu idle initialization:
>
>      sh_cmt e6138000.timer: ch0: used for periodic clock events
>
> Hacking up a timer node for "arm,cortex-a9-twd-timer" in sh73a0.dtsi
> (with some "guessed" values) made it work.
>
> Thanks!
>
> Gr{oetje,eeting}s,

Hi Geert,

thanks for sharing this information.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
