From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 15:45:55 +0530
Subject: [PATCH 02/40] clk: add a fixed factor clock
In-Reply-To: <1334065553-7565-3-git-send-email-s.hauer@pengutronix.de>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4F8D42DB.3080406@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/10/2012 7:15 PM, Sascha Hauer wrote:
> Having fixed factors/dividers in hardware is a common pattern, so
> add a basic clock type doing this. It basically describes a fixed
> factor clock using a nominator and a denominator.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/clk/Makefile           |    2 +-
>  drivers/clk/clk-fixed-factor.c |   97 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk-provider.h   |    4 ++
>  3 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/clk/clk-fixed-factor.c

Please see if below changes look fine to you. They would be required once
you rebase over latest patches floated by Mike:

---
 drivers/clk/clk-fixed-factor.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 7c5e1fc..45a4823 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -16,7 +16,7 @@ struct clk_fixed_factor {
        struct clk_hw   hw;
        unsigned int    mult;
        unsigned int    div;
-       char            *parent[1];
+       const char      *parent[1];
 };
 
 #define to_clk_fixed_factor(_hw) container_of(_hw, struct clk_fixed_factor, hw)
@@ -86,11 +86,13 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
                        fix->parent,
                        (parent_name ? 1 : 0),
                        flags);
+
+       if (parent_name)
+               kfree(fix->parent[0]);
+
        if (clk)
                return clk;
-
 out:
-       kfree(fix->parent[0]);
        kfree(fix);
 
        return NULL;


-- 
viresh
