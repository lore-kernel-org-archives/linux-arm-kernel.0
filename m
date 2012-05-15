From: richard.zhao@linaro.org (Richard Zhao)
Date: Wed, 16 May 2012 06:31:23 +0800
Subject: [PATCH] clk: Fix CLK_SET_RATE_GATE flag validation in
 clk_set_rate().
In-Reply-To: <1337114622-11292-1-git-send-email-skannan@codeaurora.org>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <1337114622-11292-1-git-send-email-skannan@codeaurora.org>
Message-ID: <258a747f-c7d8-4f15-8446-2c18fe21ccf3@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Saravana Kannan <skannan@codeaurora.org> wrote:

>The clk_set_rate() code shouldn't check the clock's enable count when
>validating CLK_SET_RATE_GATE flag since the enable count could change
>after
>the validation. Similar to clk_set_parent(), it should instead check
>the
>prepare count. The prepare count should go to zero only when the end
>user
>expects the clock to not be enabled in the future. Since the code
>already
>grabs the prepare count before validation, it's not possible for
>prepare
>count to change after validation and by association not possible for a
>well
>behaving end user to enable the clock while the set rate is in
>progress.
>
>Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>---
>Please let me know if you don't want me to directly email or CC you in
>my
>clock related patches. I don't want to spam anyone. Also, let me know
>if
>you want me add you to my standard list of people to cc in my clock
>patches.
>
> drivers/clk/clk.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>index 09b9112..f5b9d3c 100644
>--- a/drivers/clk/clk.c
>+++ b/drivers/clk/clk.c
>@@ -903,7 +903,7 @@ int clk_set_rate(struct clk *clk, unsigned long
>rate)
> 	if (rate == clk->rate)
> 		goto out;
> 
>-	if ((clk->flags & CLK_SET_RATE_GATE) && __clk_is_enabled(clk)) {
>+	if ((clk->flags & CLK_SET_RATE_GATE) && clk->prepare_count) {
The condition becomes more strict. Looks good.

> 		ret = -EBUSY;
> 		goto out;
> 	}
>-- 
>1.7.8.3
>
>Sent by an employee of the Qualcomm Innovation Center, Inc.
>The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>Forum.
