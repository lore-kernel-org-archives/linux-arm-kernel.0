From: panand@redhat.com (Pratyush Anand)
Date: Thu, 18 Jun 2015 09:28:55 +0530
Subject: [RFC PATCH V2 08/10] arm64: rename enum debug_el to enum debug_elx to
 fix "wrong kind of tag"
In-Reply-To: <cover.1434598237.git.panand@redhat.com>
References: <cover.1434598237.git.panand@redhat.com>
Message-ID: <036a4aafb504ee9061c40a2c33592e05ec04f8ee.1434598237.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

asm/debug-monitors.h contains definition for debug opcode. So, it will
be needed by asm/uprobes.h.

With enum debug_el it generates following compilation error, since
asm/uprobes.h is included.

lib/list_sort.c:160:8: error: ?debug_el? defined as wrong kind of tag
 struct debug_el {

Therefore rename enum debug_el to enum debug_elx.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/debug-monitors.h | 6 +++---
 arch/arm64/kernel/debug-monitors.c      | 4 ++--
 arch/arm64/kernel/hw_breakpoint.c       | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 92d7ceac9adf..d9e79b01d09e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -132,13 +132,13 @@ void unregister_break_hook(struct break_hook *hook);
 
 u8 debug_monitors_arch(void);
 
-enum debug_el {
+enum debug_elx {
 	DBG_ACTIVE_EL0 = 0,
 	DBG_ACTIVE_EL1,
 };
 
-void enable_debug_monitors(enum debug_el el);
-void disable_debug_monitors(enum debug_el el);
+void enable_debug_monitors(enum debug_elx el);
+void disable_debug_monitors(enum debug_elx el);
 
 void user_rewind_single_step(struct task_struct *task);
 void user_fastforward_single_step(struct task_struct *task);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 1fe912e77f62..237a21f675fd 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -83,7 +83,7 @@ early_param("nodebugmon", early_debug_disable);
 static DEFINE_PER_CPU(int, mde_ref_count);
 static DEFINE_PER_CPU(int, kde_ref_count);
 
-void enable_debug_monitors(enum debug_el el)
+void enable_debug_monitors(enum debug_elx el)
 {
 	u32 mdscr, enable = 0;
 
@@ -103,7 +103,7 @@ void enable_debug_monitors(enum debug_el el)
 	}
 }
 
-void disable_debug_monitors(enum debug_el el)
+void disable_debug_monitors(enum debug_elx el)
 {
 	u32 mdscr, disable = 0;
 
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index e7d934d3afe0..43b74a3ddaef 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -157,7 +157,7 @@ static void write_wb_reg(int reg, int n, u64 val)
  * Convert a breakpoint privilege level to the corresponding exception
  * level.
  */
-static enum debug_el debug_exception_level(int privilege)
+static enum debug_elx debug_exception_level(int privilege)
 {
 	switch (privilege) {
 	case AARCH64_BREAKPOINT_EL0:
@@ -231,7 +231,7 @@ static int hw_breakpoint_control(struct perf_event *bp,
 	struct perf_event **slots;
 	struct debug_info *debug_info = &current->thread.debug;
 	int i, max_slots, ctrl_reg, val_reg, reg_enable;
-	enum debug_el dbg_el = debug_exception_level(info->ctrl.privilege);
+	enum debug_elx dbg_el = debug_exception_level(info->ctrl.privilege);
 	u32 ctrl;
 
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
@@ -538,7 +538,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
  * exception level at the register level.
  * This is used when single-stepping after a breakpoint exception.
  */
-static void toggle_bp_registers(int reg, enum debug_el el, int enable)
+static void toggle_bp_registers(int reg, enum debug_elx el, int enable)
 {
 	int i, max_slots, privilege;
 	u32 ctrl;
-- 
2.1.0
