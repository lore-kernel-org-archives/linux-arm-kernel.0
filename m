From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 17 Jan 2014 10:36:33 -0800
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <52D932B5.7020909@nvidia.com>
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>	<20140115154526.GC3571@mudshark.cambridge.arm.com>	<52D76BC8.6080405@nvidia.com>	<20140116121649.GG30257@mudshark.cambridge.arm.com>
 <878uufyo13.fsf@iki.fi> <52D8F403.9070602@linaro.org>
 <52D901B6.1070800@nvidia.com> <52D902D6.3090208@linaro.org>
 <52D915F3.3030500@nvidia.com> <52D91D3A.80800@linaro.org>
 <52D932B5.7020909@nvidia.com>
Message-ID: <52D97831.6030700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/14 05:40, Prashant Gaikwad wrote:
>
> Another requirement:
>
> We have 3 timers T1, T2, T3 used as wake events for 3 idle states C1,
> C2, C3 respectively.
>
> Rating of T2 is better than T3. If I register T2 and T3 both as
> broadcast timers then T3 will not be used. But ...
>     - T2 is not preserved in C3 idle state.
>     - T3 resolution is very poor (ms) and can not be used as wake
> event for C2.
>
> Possible solution, register only T3 as broadcast device and use T2 as
> per-CPU fallback timer.

We have the same situation on MSM. I've been thinking about proposing we
allow multiple broadcast timers to exist in the system and then have the
clockevents_notify() caller indicate which C state is being entered. The
broadcast timers would need to indicate which C state they don't work in
though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
