From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 30 Jul 2015 15:47:37 +0530
Subject: [PATCH 05/10] opp: Add support to parse "operating-points-v2"
 bindings
In-Reply-To: <55B80A34.1010805@codeaurora.org>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <1b5a393f2162752cbb773956dff15739e7525a1d.1434369079.git.viresh.kumar@linaro.org>
 <2910042.ys2zsBBKt2@amdc1976> <20150727030239.GG19944@linux>
 <55B80A34.1010805@codeaurora.org>
Message-ID: <20150730101737.GB9121@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-07-15, 16:03, Stephen Boyd wrote:
> There is talk about moving to 64 bits for the frequency in the clk API.
> It's not actively being developed though and I'm not sure when we'll get
> there. From a DT perspective though, I don't see why it would be bad to
> have two cells instead of one cell for the frequency here. It would
> allow up to 64 bits of frequency so that when we change the clk API we
> won't need to do anything in the OPP bindings to handle it. Just because
> we have problems in the kernel doesn't mean we should put the same
> problems into DT.

Updated the code as:

diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index d9ebbd739b23..73e4e1ce60a1 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -743,6 +743,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 {
        struct device_opp *dev_opp;
        struct dev_pm_opp *new_opp;
+       u64 rate;
        int ret;
 
        /* Hold our list modification lock here */
@@ -754,12 +755,18 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
                goto unlock;
        }
 
-       ret = of_property_read_u32(np, "opp-hz", (u32 *)&new_opp->rate);
+       ret = of_property_read_u64(np, "opp-hz", &rate);
        if (ret < 0) {
                dev_err(dev, "%s: opp-hz not found\n", __func__);
                goto free_opp;
        }
 
+       /*
+        * Rate is defined as an unsigned long in clk API, and so casting
+        * explicitly to its type. Must be fixed once rate is 64 bit
+        * guaranteed in clk API.
+        */
+       new_opp->rate = (unsigned long)rate;
        new_opp->turbo = of_property_read_bool(np, "turbo-mode");
 
        new_opp->np = np;


-- 
viresh
