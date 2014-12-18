From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Dec 2014 14:48:33 -0800
Subject: [PATCH] clk: invoke clk_disable_unused() after resume
In-Reply-To: <1418941106-5930-1-git-send-email-jim2101024@gmail.com>
References: <1418941106-5930-1-git-send-email-jim2101024@gmail.com>
Message-ID: <549359C1.3010301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2014 02:18 PM, Jim Quinlan wrote:
> In a discussion[1], mturquette made the suggestion that
>
>     "It might be a good idea to call clk_disable_unused()
>      from the clk core after resuming from suspend."
>
> This commit does exactly that.  For Broadcom STB chips, clocks
> may come up after resume in an "on" state, so calling
> clk_disable_unused() again will turn off clocks that should
> be off.
>
> [1] https://lkml.org/lkml/2014/11/17/666
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>

It would be better to use the driver core or syscore suspend/resume
hooks to restore the state of the clocks as they were when the system
was suspended. Plus it would make more sense to do this on a
case-by-case basis instead of assuming that all platforms have clocks
that are left on out of resume. It could still be generic by exporting
the clk_disable_unused() function to drivers so they can call it if they
need to but I don't see why we want to force this on every platform for
every suspend/resume cycle.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
