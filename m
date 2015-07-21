From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jul 2015 14:16:30 -0700
Subject: [PATCH] clk: rockchip: Fix PLL bandwidth
In-Reply-To: <1437511283-14216-1-git-send-email-dianders@chromium.org>
References: <1437511283-14216-1-git-send-email-dianders@chromium.org>
Message-ID: <55AEB6AE.2070006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 01:41 PM, Douglas Anderson wrote:
> In the TRM we see that BWADJ is "a 12-bit bus that selects the values
> 1-4096 for the bandwidth divider (NB)":
>   NB = BWADJ[11:0] + 1
> The recommended setting of NB: NB = NF / 2.
>
> So:
>    NB = NF / 2
>    BWADJ[11:0] + 1 = NF / 2
>    BWADJ[11:0] = NF / 2 - 1
>
> Right now, we have:
>
> {                                               \
>          .rate   = _rate##U,                     \
>          .nr = _nr,                              \
>          .nf = _nf,                              \
>          .no = _no,                              \
>          .bwadj = (_nf >> 1),                    \
> }
>
> That means we set bwadj to NF / 2, not NF / 2 - 1
>
> All of this is a bit confusing because we specify "NR" (the 1-based
> value), "NF" (the 1-based value), "NO" (the 1-based value), but
> "BWADJ" (the 0-based value) instead of "NB" (the 1-based value).
>
> Let's change to working with "NB" and fix the off by one error.  This
> may affect PLL jitter in a small way (hopefully for the better).
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>

There's no Fixes tag or stable Cc so I take it this isn't fixing any 
manifesting regression, more of a visual inspection bug find?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
