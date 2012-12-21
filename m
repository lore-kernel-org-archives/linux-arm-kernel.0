From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Dec 2012 15:32:18 +0530
Subject: [RFC PATCH 2/5] clockevents: Add generic timer broadcast receiver
In-Reply-To: <1355832418-31692-3-git-send-email-mark.rutland@arm.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-3-git-send-email-mark.rutland@arm.com>
Message-ID: <50D433AA.6070606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012 05:36 PM, Mark Rutland wrote:
> Currently the broadcast mechanism used for timers is abstracted by a
> function pointer on struct clock_event_device. As the fundamental
> mechanism for broadcast is architecture-specific, this ties each
> clock_event_device driver to a single architecture, even where the
> driver is otherwise generic.
>
> This patch adds a standard path for the receipt of timer broadcasts, so
> drivers and/or architecture backends need not manage redundant lists of
> timers for the purpose of routing broadcast timer ticks.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>   include/linux/clockchips.h   |    4 ++++
>   kernel/time/tick-broadcast.c |   15 +++++++++++++++
>   2 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index 8a7096f..e1089aa 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -161,6 +161,10 @@ clockevents_calc_mult_shift(struct clock_event_device *ce, u32 freq, u32 minsec)
>   extern void clockevents_suspend(void);
>   extern void clockevents_resume(void);
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +extern int tick_receive_broadcast(void);
> +#endif
> +
As mentioned in earlier patch, CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
isn't must for SMP kernel and hence when build with
!GENERIC_CLOCKEVENTS_BROADCAST, $subject patch will break the build.

Below is the fix for the same. Feel free to fold it if you agree.

diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
index 6634652..921568b 100644
--- a/include/linux/clockchips.h
+++ b/include/linux/clockchips.h
@@ -168,6 +168,11 @@ extern void tick_broadcast(const struct cpumask *mask);
  #define tick_broadcast	NULL
  #endif
  extern int tick_receive_broadcast(void);
+#else
+static inline int tick_receive_broadcast(void)
+{
+	return 0;
+}
  #endif

  #ifdef CONFIG_GENERIC_CLOCKEVENTS
