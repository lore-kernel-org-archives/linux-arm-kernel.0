From: richard.zhao@linaro.org (Richard Zhao)
Date: Tue, 15 Nov 2011 14:47:56 +0800
Subject: [PATCH V4 01/14] clk: add helper functions clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
References: <1321339689-25256-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1321339689-25256-2-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's for migrating to generic clk framework API.

The helper functions  help cases clk_enable/clk_disable is used
in non-atomic context.
For example, Call clk_enable in probe and clk_disable in remove.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 include/linux/clk.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 7213b52..b9d46fa 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -107,6 +107,28 @@ static inline void clk_unprepare(struct clk *clk)
 }
 #endif
 
+/* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
+static inline int clk_prepare_enable(struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare(clk);
+	if (ret)
+		return ret;
+	ret = clk_enable(clk);
+	if (ret)
+		clk_unprepare(clk);
+
+	return ret;
+}
+
+/* clk_disable_unprepare helps cases using clk_disable in non-atomic context. */
+static inline void clk_disable_unprepare(struct clk *clk)
+{
+	clk_disable(clk);
+	clk_unprepare(clk);
+}
+
 /**
  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
  *		  This is only valid once the clock source has been enabled.
-- 
1.7.5.4
