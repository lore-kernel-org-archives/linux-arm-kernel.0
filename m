From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 12:54:11 +0800
Subject: [PATCH 6/9] ARM: mxc: audmux-v2: convert to clk_prepare/clk_unprepare
In-Reply-To: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1320900854-13031-6-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/audmux-v2.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/audmux-v2.c b/arch/arm/plat-mxc/audmux-v2.c
index 8cced35..865e564 100644
--- a/arch/arm/plat-mxc/audmux-v2.c
+++ b/arch/arm/plat-mxc/audmux-v2.c
@@ -72,14 +72,18 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (audmux_clk)
+	if (audmux_clk) {
+		clk_prepare(audmux_clk);
 		clk_enable(audmux_clk);
+	}
 
 	ptcr = readl(audmux_base + MXC_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + MXC_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
+	if (audmux_clk) {
 		clk_disable(audmux_clk);
+		clk_unprepare(audmux_clk);
+	}
 
 	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
@@ -171,14 +175,18 @@ int mxc_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 	if (!audmux_base)
 		return -ENOSYS;
 
-	if (audmux_clk)
+	if (audmux_clk) {
+		clk_prepare(audmux_clk);
 		clk_enable(audmux_clk);
+	}
 
 	writel(ptcr, audmux_base + MXC_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + MXC_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
+	if (audmux_clk) {
 		clk_disable(audmux_clk);
+		clk_unprepare(audmux_clk);
+	}
 
 	return 0;
 }
-- 
1.7.5.4
