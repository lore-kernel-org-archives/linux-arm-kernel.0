From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:26:08 +0530
Subject: [PATCH V2 48/69] ST SPEAr: replace readl, writel with __raw_readl,
	__raw_writel in uncompress.h
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <10581ee8e7ad68eabb4421cee448b5f7df983adb.1285933332.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

readl also calls outer cache maintainance operations which are not available
during Linux uncompression. This patch replaces readl, writel with __raw_readl
and __raw_writel.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/plat-spear/include/plat/uncompress.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/uncompress.h b/arch/arm/plat-spear/include/plat/uncompress.h
index 99ba678..963aa5b 100644
--- a/arch/arm/plat-spear/include/plat/uncompress.h
+++ b/arch/arm/plat-spear/include/plat/uncompress.h
@@ -24,10 +24,10 @@ static inline void putc(int c)
 {
 	void __iomem *base = (void __iomem *)SPEAR_DBG_UART_BASE;
 
-	while (readl(base + UART01x_FR) & UART01x_FR_TXFF)
+	while (__raw_readl(base + UART01x_FR) & UART01x_FR_TXFF)
 		barrier();
 
-	writel(c, base + UART01x_DR);
+	__raw_writel(c, base + UART01x_DR);
 }
 
 static inline void flush(void)
-- 
1.7.2.2
