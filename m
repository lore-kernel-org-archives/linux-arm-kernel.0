From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 15 May 2018 15:56:12 +0200
Subject: [RFC PATCH 00/10] Add persistent clock support
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Message-ID: <20180515135612.GQ29062@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
> Hi,
> 
> We will meet below issues when compensating the suspend time for the timekeeping.
> 
> 1. We have too many different ways of dealing with persistent timekeeping
> across architectures, so it is hard for one driver to compatable with different
> architectures.
> 
> 2. On some platforms (such as Spreadtrum platform), we registered the high
> resolution timer as one clocksource to update the OS time, but the high
> resolution timer will be stopped in suspend state. So we use another one
> always-on timer (but low resolution) to calculate the suspend time to
> compensate the OS time. Though we can register the always-on timer as one
> clocksource, we need re-calculate the mult/shift with one larger conversion
> range to calculate the suspend time and need update the clock in case of
> running over the always-on timer.
> 
> More duplicate code will be added if other platforms meet this case.
> 
> 3. Now we have 3 sources that could be used to compensate the OS time:
> Nonstop clocksource during suspend, persistent clock and rtc device,
> which is complicated. Another hand is that the nonstop clocksource can
> risk wrapping if the suspend time is too long, so we need one mechanism
> to wake up the system before the nonstop clocksource wrapping.
> 
> According to above issues, we can introduce one common persistent clock
> framework to compatable with different architectures, in future we will
> remove the persistent clock implementation for each architecture. Also
> this framework will implement common code to help drivers to register easily.
> Moreover if we converted all SUSPEND_NONSTOP clocksource to register to
> be one persistent clock, we can remove the SUSPEND_NONSTOP clocksource
> accounting in timekeeping, which means we can only compensate the OS time
> from persistent clock and RTC.
> 
> Will be appreciated for any comments. Thank you all.

Why do we need another API ?

Why not remove the present persistent API and rely on the SUSPEND_NONSTOP flag
to do the right action at suspend and resume?

We register different clocksources, the rating does the selection.

When entering 'suspend', we check against the SUSPEND_NONSTOP flag and switch
to the first clocksource with the best rating and the flag set. When resuming,
we switch back to the highest rating.

Having a clocksource out of the always-on domain must be notified with a trace
in the log because this is not a normal situation.


-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
