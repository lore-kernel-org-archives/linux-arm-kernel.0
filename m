From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 1 Sep 2015 13:12:05 +0530
Subject: about system time incorrect after changing cpu frequency
In-Reply-To: <CAOVJa8Hh0i05M7f39Pd9bXQmJA9n8tKTwNQoSmwAdUSSGtP_3w@mail.gmail.com>
References: <CAOVJa8GTDj3UJpgUd4nH1wknUKa6fgac=1SsqC8g=UCG0MGuDw@mail.gmail.com>
 <CAOh2x=ky8_uwqvdH-krKxgMSby5jgovJp7odK6x=MpqNL+YoGg@mail.gmail.com>
 <CAOVJa8HNQ-s=yDfADCcoL+r22ALpHFtTjWZ=oxTkBUriYbCk+Q@mail.gmail.com>
 <20150901060236.GB1456@linux>
 <CAOVJa8Hh0i05M7f39Pd9bXQmJA9n8tKTwNQoSmwAdUSSGtP_3w@mail.gmail.com>
Message-ID: <20150901074205.GC1456@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01-09-15, 15:21, vichy wrote:
> and I add  PLAT_gt_change_freq in arm_global_timer.c like below:
>  PLAT_gt_change_freq calling() {
>     gt_clk_rate = get_periph_clk();
>     clockevents_update_freq(this_cpu_ptr(gt_evt), gt_clk_rate);

In earlier versions of kernel, this had a problem that it works only
for ONESHOT mode and simply returns in PERIODIC mode. I do see that
your's mode is ONESHOT only, and so it should have worked.

Anyway, few prints into that routine to see where we are reaching
might help.

>     __clocksource_updatefreq_hz(&gt_clocksource, gt_clk_rate);

AFAIR, there is a difference between how different mdelay/udelay are
implemented. One of them is using the loops_per_jiffie variable to
calculate the time, other uses clkevt device. I am not 100% sure about
the theory, but that's what I remember. So, have a look from that
perspective as well..

-- 
viresh
