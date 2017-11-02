From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 2 Nov 2017 14:56:16 +0800
Subject: [PATCH V3 01/11] drivers: move clock common macros out from vendor
 directories
In-Reply-To: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
References: <20171102065626.21835-1-chunyan.zhang@spreadtrum.com>
Message-ID: <20171102065626.21835-2-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These macros are used by more than one SoC vendor platforms, avoid to
have many copies of these code, this patch moves them to the common
clock directory which every clock drivers can access to.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 drivers/clk/clk_common.h | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 drivers/clk/clk_common.h

diff --git a/drivers/clk/clk_common.h b/drivers/clk/clk_common.h
new file mode 100644
index 0000000..21e93d2
--- /dev/null
+++ b/drivers/clk/clk_common.h
@@ -0,0 +1,60 @@
+/*
+ * drivers/clk/clk_common.h
+ *
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#ifndef _CLK_COMMON_H_
+#define _CLK_COMMON_H_
+
+#include <linux/clk-provider.h>
+
+#define CLK_HW_INIT(_name, _parent, _ops, _flags)		\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= (const char *[]) { _parent },	\
+		.num_parents	= 1,				\
+		.ops		= _ops,				\
+	})
+
+#define CLK_HW_INIT_PARENTS(_name, _parents, _ops, _flags)	\
+	(&(struct clk_init_data) {				\
+		.flags		= _flags,			\
+		.name		= _name,			\
+		.parent_names	= _parents,			\
+		.num_parents	= ARRAY_SIZE(_parents),		\
+		.ops		= _ops,				\
+	})
+
+#define CLK_HW_INIT_NO_PARENT(_name, _ops, _flags)     \
+	(&(struct clk_init_data) {                      \
+		.flags          = _flags,               \
+		.name           = _name,                \
+		.parent_names   = NULL,                 \
+		.num_parents    = 0,                    \
+		.ops            = _ops,                 \
+	})
+
+#define CLK_FIXED_FACTOR(_struct, _name, _parent,			\
+			_div, _mult, _flags)				\
+	struct clk_fixed_factor _struct = {				\
+		.div		= _div,					\
+		.mult		= _mult,				\
+		.hw.init	= CLK_HW_INIT(_name,			\
+					      _parent,			\
+					      &clk_fixed_factor_ops,	\
+					      _flags),			\
+	}
+
+#define CLK_FIXED_RATE(_struct, _name, _flags,				\
+		       _fixed_rate, _fixed_accuracy)			\
+	struct clk_fixed_rate _struct = {				\
+		.fixed_rate	= _fixed_rate,				\
+		.fixed_accuracy	= _fixed_accuracy,			\
+		.hw.init	= CLK_HW_INIT_NO_PARENT(_name,		\
+					  &clk_fixed_rate_ops,		\
+							_flags),	\
+	}
+
+#endif /* _CLK_COMMON_H_ */
-- 
2.7.4
