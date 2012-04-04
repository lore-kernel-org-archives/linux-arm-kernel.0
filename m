From: viresh.linux@gmail.com (viresh kumar)
Date: Wed, 4 Apr 2012 22:54:45 +0530
Subject: [PATCH] clk: clk-private: Add DEFINE_CLK macro
Message-ID: <CAOh2x=kT9OpRy345qqqaKqG=YB01=Bn2j_=BfmJzpMYsXDqcNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh Kumar <viresh.kumar@st.com>

All macros used for creating different kind of clocks have similar code for
initializing struct clk. This patch removes those redundant lines and create
another macro DEFINE_CLK.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 include/linux/clk-private.h |   59 ++++++++++++++----------------------------
 1 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/include/linux/clk-private.h b/include/linux/clk-private.h
index 5e4312b..0164a45 100644
--- a/include/linux/clk-private.h
+++ b/include/linux/clk-private.h
@@ -55,6 +55,18 @@ struct clk {
  * alternative macro for static initialization
  */

+#define DEFINE_CLK(_name, _ops, _flags, _parent_names,		\
+		_parents)					\
+	static struct clk _name = {				\
+		.name = #_name,					\
+		.ops = &_ops,					\
+		.hw = &_name##_hw.hw,				\
+		.parent_names = _parent_names,			\
+		.num_parents = ARRAY_SIZE(_parent_names),	\
+		.parents = _parents,				\
+		.flags = _flags,				\
+	}
+
 extern struct clk_ops clk_fixed_rate_ops;

 #define DEFINE_CLK_FIXED_RATE(_name, _flags, _rate,		\
@@ -68,15 +80,8 @@ extern struct clk_ops clk_fixed_rate_ops;
 		.fixed_rate = _rate,				\
 		.flags = _fixed_rate_flags,			\
 	};							\
-	static struct clk _name = {				\
-		.name = #_name,					\
-		.ops = &clk_fixed_rate_ops,			\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _name##_parent_names,		\
-		.num_parents =					\
-			ARRAY_SIZE(_name##_parent_names),	\
-		.flags = _flags,				\
-	};
+	DEFINE_CLK(_name, clk_fixed_rate_ops, _flags,		\
+			_name##_parent_names, NULL);

 extern struct clk_ops clk_gate_ops;

@@ -99,16 +104,8 @@ extern struct clk_ops clk_gate_ops;
 		.flags = _gate_flags,				\
 		.lock = _lock,					\
 	};							\
-	static struct clk _name = {				\
-		.name = #_name,					\
-		.ops = &clk_gate_ops,				\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _name##_parent_names,		\
-		.num_parents =					\
-			ARRAY_SIZE(_name##_parent_names),	\
-		.parents = _name##_parents,			\
-		.flags = _flags,				\
-	};
+	DEFINE_CLK(_name, clk_gate_ops, _flags,			\
+			_name##_parent_names, _name##_parents);

 extern struct clk_ops clk_divider_ops;

@@ -132,16 +129,8 @@ extern struct clk_ops clk_divider_ops;
 		.flags = _divider_flags,			\
 		.lock = _lock,					\
 	};							\
-	static struct clk _name = {				\
-		.name = #_name,					\
-		.ops = &clk_divider_ops,			\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _name##_parent_names,		\
-		.num_parents =					\
-			ARRAY_SIZE(_name##_parent_names),	\
-		.parents = _name##_parents,			\
-		.flags = _flags,				\
-	};
+	DEFINE_CLK(_name, clk_divider_ops, _flags,		\
+			_name##_parent_names, _name##_parents);

 extern struct clk_ops clk_mux_ops;

@@ -159,16 +148,8 @@ extern struct clk_ops clk_mux_ops;
 		.flags = _mux_flags,				\
 		.lock = _lock,					\
 	};							\
-	static struct clk _name = {				\
-		.name = #_name,					\
-		.ops = &clk_mux_ops,				\
-		.hw = &_name##_hw.hw,				\
-		.parent_names = _parent_names,			\
-		.num_parents =					\
-			ARRAY_SIZE(_parent_names),		\
-		.parents = _parents,				\
-		.flags = _flags,				\
-	};
+	DEFINE_CLK(_name, clk_mux_ops, _flags, _parent_names,	\
+			_parents);

 /**
  * __clk_init - initialize the data structures in a struct clk
-- 
1.7.9
