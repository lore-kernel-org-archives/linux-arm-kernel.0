From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 11 Jun 2014 17:30:10 +0200
Subject: [PATCH 3/5] ARM: mm: cache-l2x0: Use l2c_write_sec() for LATENCY_CTRL
 registers
In-Reply-To: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
References: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Message-ID: <1402500612-4778-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the documentation, TAG_LATENCY_CTRL and DATA_LATENCY_CTRL
registers of L2C-310 can be written only in secure mode, so
l2c_write_sec() should be used to change them, instead of plain
writel_relaxed().

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mm/cache-l2x0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 1695eab..0180eb7 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -1024,20 +1024,20 @@ static void __init l2c310_of_parse(const struct device_node *np,
 
 	of_property_read_u32_array(np, "arm,tag-latency", tag, ARRAY_SIZE(tag));
 	if (tag[0] && tag[1] && tag[2])
-		writel_relaxed(
+		l2c_write_sec(
 			L310_LATENCY_CTRL_RD(tag[0] - 1) |
 			L310_LATENCY_CTRL_WR(tag[1] - 1) |
 			L310_LATENCY_CTRL_SETUP(tag[2] - 1),
-			l2x0_base + L310_TAG_LATENCY_CTRL);
+			l2x0_base, L310_TAG_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,data-latency",
 				   data, ARRAY_SIZE(data));
 	if (data[0] && data[1] && data[2])
-		writel_relaxed(
+		l2c_write_sec(
 			L310_LATENCY_CTRL_RD(data[0] - 1) |
 			L310_LATENCY_CTRL_WR(data[1] - 1) |
 			L310_LATENCY_CTRL_SETUP(data[2] - 1),
-			l2x0_base + L310_DATA_LATENCY_CTRL);
+			l2x0_base, L310_DATA_LATENCY_CTRL);
 
 	of_property_read_u32_array(np, "arm,filter-ranges",
 				   filter, ARRAY_SIZE(filter));
-- 
1.9.3
