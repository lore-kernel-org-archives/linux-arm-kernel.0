From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 20 Jan 2011 12:56:19 +0530
Subject: [PATCH V5 41/63] ST SPEAr: replace readl, writel with readl_relaxed,
	writel_relaxed in uncompress.h
In-Reply-To: <cover.1295499392.git.viresh.kumar@st.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
Message-ID: <c792c9602552d0650cd55c4f724257ad46b79cc8.1295499395.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

readl also calls outer cache maintainance operations which are not available
during Linux uncompression. This patch replaces readl, writel with readl_relaxed
and writel_relaxed.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/uncompress.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 99ba678..6dd455b 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -24,10 +24,10 @@ static inline void putc(int c)
 {
 	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
 
-	while (readl(base + UART01x_FR) & UART01x_FR_TXFF)
+	while (readl_relaxed(base + UART01x_FR) & UART01x_FR_TXFF)
 		barrier();
 
-	writel(c, base + UART01x_DR);
+	writel_relaxed(c, base + UART01x_DR);
 }
 
 static inline void flush(void)
-- 
1.7.3.4
