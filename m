From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 14 Jan 2014 13:03:19 -0800
Subject: Add .determine_rate to composite clk
In-Reply-To: <CAJiWf8Wvcu0pWBNd7xSm9ES7ApTNp27CXTHWBxbr4msfNd9xCA@mail.gmail.com>
References: <CAJiWf8W6rCnnF9Tv+cpcqqshEb4ALD+J_RnYeLkaNVG-Rcd+QA@mail.gmail.com>
 <20140111102843.GU2941@lukather>
 <CAJiWf8WJxf0S32bPiXGUu3Rwmh36xYdbd0VEpLTG-pwyvVnasg@mail.gmail.com>
 <CAJiWf8Wvcu0pWBNd7xSm9ES7ApTNp27CXTHWBxbr4msfNd9xCA@mail.gmail.com>
Message-ID: <20140114210319.4167.62163@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lemon Dai (2014-01-14 06:08:44)
> Hi Maxime,
> 
> The commit 107f3198 in Mike's clk-next branch shows that:
> (about line 72 in drivers/clk/clk-composite.c)
> 
>         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>                 mux_hw->clk = hw->clk;
>                 return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
>                                                best_parent_p);
> 
> 
>  It should be fixed as follows, at least for reason that  NULL rate_hw
> may be used in the old code,
> 
>         } else if (mux_hw && mux_ops && mux_ops->determine_rate) {
>                 mux_hw->clk = hw->clk;
>  -              return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
>  +             return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
>                                                best_parent_p);

Hi Lemon Dai,

I have applied this fix to clk-next. The patch is below:



>From ca01f3f60aa864d7ee8124ca597d4010378926b5 Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 14 Jan 2014 12:56:01 -0800
Subject: [PATCH] clk: composite: pass mux_hw into determine_rate

The composite clock's .determine_rate implementation can call the
underyling .determine_rate callback corresponding to rate_hw or the
underlying .determine_rate callback corresponding to mux_hw. In both
cases we pass in rate_hw, which is wrong. Fixed by passing mux_hw into
the correct callback.

Reported-by: Lemon Dai <dailemon.gl@gmail.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk-composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 753d0b7..57a078e 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -71,7 +71,7 @@ static long clk_composite_determine_rate(struct clk_hw *hw, unsigned long rate,
 						best_parent_p);
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		mux_hw->clk = hw->clk;
-		return mux_ops->determine_rate(rate_hw, rate, best_parent_rate,
+		return mux_ops->determine_rate(mux_hw, rate, best_parent_rate,
 					       best_parent_p);
 	} else {
 		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
-- 
1.8.3.2
