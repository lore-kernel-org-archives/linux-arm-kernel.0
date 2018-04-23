From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Mon, 23 Apr 2018 12:38:19 -0500
Subject: [PATCH 02/11] exynos4-is: mipi-csis: fix potential Spectre variant 1
In-Reply-To: <cover.1524499368.git.gustavo@embeddedor.com>
References: <cover.1524499368.git.gustavo@embeddedor.com>
Message-ID: <1d1128bd1e8fd3309ff8e615a06346724281e5b4.1524499368.git.gustavo@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

code->index can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/exynos4-is/mipi-csis.c:549 s5pcsis_enum_mbus_code() warn: potential spectre issue 's5pcsis_formats'

Fix this by sanitizing code->index before using it to index
s5pcsis_formats.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable at vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/exynos4-is/mipi-csis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index cba46a6..60104c1 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -35,6 +35,8 @@
 
 #include "mipi-csis.h"
 
+#include <linux/nospec.h>
+
 static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Debug level (0-2)");
@@ -545,7 +547,8 @@ static int s5pcsis_enum_mbus_code(struct v4l2_subdev *sd,
 {
 	if (code->index >= ARRAY_SIZE(s5pcsis_formats))
 		return -EINVAL;
-
+	code->index = array_index_nospec(code->index,
+					 ARRAY_SIZE(s5pcsis_formats));
 	code->code = s5pcsis_formats[code->index].code;
 	return 0;
 }
-- 
2.7.4
