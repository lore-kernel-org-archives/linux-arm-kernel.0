From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Mar 2013 11:32:35 -0700
Subject: [PATCH] ARM: timer: Shutdown clock event device when stopping
 local timer
In-Reply-To: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
References: <1364549049-29278-1-git-send-email-ning.n.jiang@gmail.com>
Message-ID: <5155DE43.4000601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/13 02:24, ning.n.jiang at gmail.com wrote:
> From: Ning Jiang <ning.n.jiang@gmail.com>
>
> Currently there are two problems when we try to stop local timer.
> First, it calls set_mode function directly so mode state is not
> updated for the clock event device. Second, it makes the device
> unused instead of shutdown.

What device is this a problem on? I believe this only matters to drivers
which enable their timer in their set_next_event() callback? But even
then, does anything actually happen because the interrupt should have
been disabled in the local timer stop callback.

>
> A subtle error will happen because of it. When a cpu is plugged out
> it will stop the local timer. It will call tick_nohz_idle_enter()
> in idle thread afterwards. It will cancel the sched timer and try
> to reprogram the next event. This is wrong since the local timer
> is supposed to be stopped.
>
> The right way to stop the local timer is to shutdown it by calling
> clockevents_set_mode(). Thus when we try to reprogram the clock
> event device, it will return directly without doing anything since
> the clock mode is CLOCK_EVT_MODE_SHUTDOWN.

While this prevents the set_next_event() callback from being called on a
dying CPU, wouldn't it be better to fix this problem in the core code
once instead of fixing it many times in each local timer driver? It
doesn't seem to make much sense to program an event on a CPU that is
about to die, so why do we do that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
