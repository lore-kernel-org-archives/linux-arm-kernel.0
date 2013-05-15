From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 15 May 2013 13:25:24 -0700
Subject: [PATCH v3 2/4] clk: add support for clock reparent on set_rate
In-Reply-To: <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
References: <1368625263-23136-1-git-send-email-james.hogan@imgtec.com>
 <1368625263-23136-3-git-send-email-james.hogan@imgtec.com>
Message-ID: <5193EF34.7070800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/13 06:41, James Hogan wrote:
> Add core support to allow clock implementations to select the best
> parent clock when rounding a rate, e.g. the one which can provide the
> closest clock rate to that requested. This is by way of adding a new
> clock op, determine_rate(), which is like round_rate() but has an extra
> parameter to allow the clock implementation to optionally select a
> different parent clock. The core then takes care of reparenting the
> clock when setting the rate.
>
> The parent change takes place with the help of two new private data
> members. struct clk::new_parent specifies a clock's new parent (NULL
> indicates no change), and struct clk::new_child specifies a clock's new
> child (whose new_parent member points back to it). The purpose of these
> are to allow correct walking of the future tree for notifications prior
> to actually reparenting any clocks, specifically to skip child clocks
> who are being reparented to another clock (they will be notified via the
> new parent), and to include any new child clock. These pointers are set
> by clk_calc_subtree(), and the new_child pointer gets cleared when a
> child is actually reparented to avoid duplicate POST_RATE_CHANGE
> notifications.
>
> Each place where round_rate() is called, determine_rate is checked first
> and called in preference, passing NULL to the new parent argument if not
> needed (e.g. in __clk_round_rate).

That's annoying. Even if we don't care about the pointer in
clk_round_rate(), this requires the ops to check for NULL before
assigning the pointer. Why not just pass an unused pointer that the ops
can assign all the time?

>  This restructures a few of the call
> sites to simplify the logic into if/else blocks.
>
> A new __clk_set_parent_no_recalc() is created similar to
> clk_set_parent() but without calling __clk_recalc_rates(). This is for
> clk_change_rate() to use, where rate recalculation and notifications are
> already handled.
>
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org

With the above change you can add

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
