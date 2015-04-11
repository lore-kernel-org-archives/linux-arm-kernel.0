From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Apr 2015 17:59:08 -0700
Subject: [PATCH 1/4] clk: Propagate prepare and enable when reparenting
 orphans
In-Reply-To: <1427988853-9549-2-git-send-email-heiko@sntech.de>
References: <1427988853-9549-1-git-send-email-heiko@sntech.de>
 <1427988853-9549-2-git-send-email-heiko@sntech.de>
Message-ID: <552871DC.2020400@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/15 08:34, Heiko Stuebner wrote:
> From: Doug Anderson <dianders@chromium.org>
>
> With the existing code, if you find a parent for an orhpan that has
> already been prepared / enabled, you won't enable the parent.  That
> can cause later problems since the clock tree isn't in a consistent
> state.  Fix by propagating the prepare and enable.
>
> NOTE: this does bring up the question about whether the enable of the
> orphan actually made sense.  If the orphan's parent wasn't enabled by
> default (by the bootloader or the default state of the hardware) then
> the original enable of the orphan probably didn't do what the caller
> though it would.  Some users of the orphan might have preferred an
> EPROBE_DEFER be returned until we had a full path to a root clock.
> This patch doesn't address those concerns and really just syncs up the
> state.
>
> Tested on rk3288-evb-rk808 by temporarily considering "sclk_tsadc" as
> a critical clock (to simulate a driver enabling it at bootup).
>
> Before:
>
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin32k                                   0            0       32768          0 0
>     sclk_hdmi_cec                         0            0       32768          0 0
>     sclk_otg_adp                          0            0       32768          0 0
>     sclk_tsadc                            1            1         993          0 0
>
> After:
>
>    clock                         enable_cnt  prepare_cnt        rate   accuracy   phase
> ----------------------------------------------------------------------------------------
>  xin32k                                   1            1       32768          0 0
>     sclk_hdmi_cec                         0            0       32768          0 0
>     sclk_otg_adp                          0            0       32768          0 0
>     sclk_tsadc                            1            1         993          0 0
>
> Note that xin32k on rk808 is a clock that cannot be disabled in
> hardware (it's an always on clock), so really all we needed to do was
> to sync up the state.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
> Adapted to recent clk->clk_core changes and move orphan handling to
> a separate function as the main clk_core_reparent function is already
> also used in other contexts.
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Sorry I don't get this patch at all. We shouldn't be handing out clocks
to consumers if the clock is an orphan. We also have a problem syncing
enable state in the framework with what is there in hardware when we
boot up. These aren't the same problem but they're related. Let's not
conflate the two.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
