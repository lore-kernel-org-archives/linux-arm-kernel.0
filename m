From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Apr 2017 19:37:09 +0200
Subject: [PATCH] arm64: arch_timer: mark errata handlers as __maybe_unused
Message-ID: <20170419173737.3846098-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some rare randconfig builds, we end up with two functions being entirely
unused:

drivers/clocksource/arm_arch_timer.c:342:12: error: 'erratum_set_next_event_tval_phys' defined but not used [-Werror=unused-function]
 static int erratum_set_next_event_tval_phys(unsigned long evt,
drivers/clocksource/arm_arch_timer.c:335:12: error: 'erratum_set_next_event_tval_virt' defined but not used [-Werror=unused-function]
 static int erratum_set_next_event_tval_virt(unsigned long evt,

We could add an #ifdef around them, but we would already have to check for
several symbols there and there is a chance this would get more complicated
over time, so marking them as __maybe_unused is the simplest way to avoid the
harmless warnings.

Fixes: 01d3e3ff2608 ("arm64: arch_timer: Rework the set_next_event workarounds")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 74183a7315ac..968ca3a9ee36 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -332,14 +332,14 @@ static void erratum_set_next_event_tval_generic(const int access, unsigned long
 	arch_timer_reg_write(access, ARCH_TIMER_REG_CTRL, ctrl, clk);
 }
 
-static int erratum_set_next_event_tval_virt(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_tval_virt(unsigned long evt,
 					    struct clock_event_device *clk)
 {
 	erratum_set_next_event_tval_generic(ARCH_TIMER_VIRT_ACCESS, evt, clk);
 	return 0;
 }
 
-static int erratum_set_next_event_tval_phys(unsigned long evt,
+static __maybe_unused int erratum_set_next_event_tval_phys(unsigned long evt,
 					    struct clock_event_device *clk)
 {
 	erratum_set_next_event_tval_generic(ARCH_TIMER_PHYS_ACCESS, evt, clk);
-- 
2.9.0
