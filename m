From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 23 Feb 2012 14:47:40 +0530
Subject: [PATCH] arm/io.h: add macros to read/write big/little endian register
Message-ID: <734349b4b6a4548703c723583d8ee1253184df37.1329988640.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <pratyush.anand@st.com>

There are some peripheral (e.g dwc otg) whose registers can be configured to
work in either little or big endian mode. Therefore macros like out_be32,
in_be32, out_le32 and in_le32 have been added to support such peripherals.

Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/io.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 9275828..a1ccac0 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -192,6 +192,16 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 #define insw_p(port,to,len)	insw(port,to,len)
 #define insl_p(port,to,len)	insl(port,to,len)
 
+/* Big Endian */
+#define out_be32(v, p)	({ __iowmb(); __raw_writel((__force __u32) \
+					cpu_to_be32(v), __io(p)); })
+#define in_be32(p)	({ __u32 __v = be32_to_cpu((__force __be32) \
+			__raw_readl(__io(p))); __iormb(); __v; })
+
+/* Little endian */
+#define out_le32(v, p)		outl(v, p)
+#define in_le32(p)		inl(p)
+
 /*
  * String version of IO memory access ops:
  */
-- 
1.7.8.110.g4cb5d
