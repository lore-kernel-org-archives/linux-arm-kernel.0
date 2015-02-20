From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Fri, 20 Feb 2015 19:01:04 +0100
Subject: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1424455277-29983-6-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms need to initialize the reset controller before the timers.

This patch introduces a reset_controller_of_init() function that can be
called before the timers intialization.

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 drivers/reset/core.c              | 27 +++++++++++++++++++++++++++
 include/asm-generic/vmlinux.lds.h |  4 +++-
 include/linux/reset-controller.h  |  6 ++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 7955e00..7eef63e 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -86,6 +86,33 @@ void reset_controller_unregister(struct reset_controller_dev *rcdev)
 }
 EXPORT_SYMBOL_GPL(reset_controller_unregister);
 
+extern struct of_device_id __reset_ctrl_of_table[];
+
+static const struct of_device_id __reset_ctrl_of_table_sentinel
+	__used __section(__reset_ctrl_of_table_end);
+
+/**
+ * reset_controller_of_init - scan and init reset controllers from the DT
+ *
+ * This function scas the device tree for matching reset controllers. It is
+ * used on machines that need reset controls at early stage. To use it, the
+ * controller driver has to be registred with RESET_CONTROLLER_OF_DECLARE().
+ */
+void __init reset_controller_of_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	of_init_fn_1 init_func;
+
+	for_each_matching_node_and_match(np, __reset_ctrl_of_table, &match) {
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func = match->data;
+		init_func(np);
+	}
+}
+
 /**
  * reset_control_reset - reset the controlled device
  * @rstc: reset controller
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bee5d68..1f96365 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -168,6 +168,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
+#define RESET_CTRL_OF_TABLES()	OF_TABLE(CONFIG_RESET_CONTROLLER, reset_ctrl)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -502,7 +503,8 @@
 	CPU_METHOD_OF_TABLES()						\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
-	EARLYCON_OF_TABLES()
+	EARLYCON_OF_TABLES()						\
+	RESET_CTRL_OF_TABLES()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ce6b962..f8a030a 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -51,4 +51,10 @@ struct reset_controller_dev {
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
 
+
+#define RESET_CONTROLLER_OF_DECLARE(name, compat, fn) \
+	OF_DECLARE_1(reset_ctrl, name, compat, fn)
+
+void reset_controller_of_init(void);
+
 #endif
-- 
1.9.1
