From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 16:45:45 +0530
Subject: [PATCH 13/13] SPEAr: Call clk_prepare() before calling clk_enable
In-Reply-To: <cover.1334660431.git.viresh.kumar@st.com>
References: <cover.1334660431.git.viresh.kumar@st.com>
Message-ID: <0c2dc6d1f11ac1cc4965b8e902d19fb356f0324b.1334660432.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With common clock framework, it is must to call clk_{un}prepare() before/after
clk_{dis}enable. This patch fixes this for SPEAr timer.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/time.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
index a3164d1..4f05d26 100644
--- a/arch/arm/plat-spear/time.c
+++ b/arch/arm/plat-spear/time.c
@@ -218,10 +218,10 @@ void __init spear_setup_timer(resource_size_t base, int irq)
 		goto err_iomap;
 	}
 
-	ret = clk_enable(gpt_clk);
+	ret = clk_prepare_enable(gpt_clk);
 	if (ret < 0) {
-		pr_err("%s:couldn't enable gpt clock\n", __func__);
-		goto err_clk;
+		pr_err("%s:couldn't prepare-enable gpt clock\n", __func__);
+		goto err_prepare_enable_clk;
 	}
 
 	spear_clockevent_init(irq);
@@ -229,7 +229,7 @@ void __init spear_setup_timer(resource_size_t base, int irq)
 
 	return;
 
-err_clk:
+err_prepare_enable_clk:
 	clk_put(gpt_clk);
 err_iomap:
 	iounmap(gpt_base);
-- 
1.7.9
