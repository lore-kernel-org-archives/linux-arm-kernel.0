From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Feb 2014 14:22:37 -0800
Subject: [PATCH] sched_clock: Prevent callers from seeing half-updated data
In-Reply-To: <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
References: <52F524A3.3070400@linaro.org>
 <1391806139-20116-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140207222237.GF12815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07, Stephen Boyd wrote:
> If two sched_clock sources are registered we may end up in a
> situation where a call to sched_clock() may be accessing the
> epoch cycle count for the old counter and the cycle count for the
> new counter. This can lead to confusing results where
> sched_clock() values jump and then are reset to 0 (due to the way
> the registration function forces the epoch_ns to be 0). Fix this
> by reorganizing the registration function to hold the seqlock for
> as short a time as possible while we update the clock_data
> structure for a new counter and stop resetting the epoch_ns count
> to 0.

Hmm.. This won't properly accumulate time. We need to put
whatever time has elapsed into epoch_ns when we register the new
counter for this to work. I don't have a board with this
configuration but I'll send a v2 that should fix this. Hopefully
Will can test it.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
