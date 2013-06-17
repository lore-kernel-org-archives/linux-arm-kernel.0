From: john.stultz@linaro.org (John Stultz)
Date: Mon, 17 Jun 2013 15:58:28 -0700
Subject: [PATCH v2] ARM: sched_clock: Load cycle count after epoch
 stabilizes
In-Reply-To: <1371508858-23371-1-git-send-email-sboyd@codeaurora.org>
References: <1371508858-23371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51BF9494.9000209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17/2013 03:40 PM, Stephen Boyd wrote:
> There is a small race between when the cycle count is read from
> the hardware and when the epoch stabilizes. Consider this
> scenario:
>
>   CPU0                           CPU1
>   ----                           ----
>   cyc = read_sched_clock()
>   cyc_to_sched_clock()
>                                   update_sched_clock()
>                                    ...
>                                    cd.epoch_cyc = cyc;
>    epoch_cyc = cd.epoch_cyc;
>    ...
>    epoch_ns + cyc_to_ns((cyc - epoch_cyc)
>
> The cyc on cpu0 was read before the epoch changed. But we
> calculate the nanoseconds based on the new epoch by subtracting
> the new epoch from the old cycle count. Since epoch is most likely
> larger than the old cycle count we calculate a large number that
> will be converted to nanoseconds and added to epoch_ns, causing
> time to jump forward too much.
>
> Fix this problem by reading the hardware after the epoch has
> stabilized.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks for the resend here.

I've got this in my tree and unless I get an objection in the next day 
or so, I'll send it on to Thomas.

thanks
-john
