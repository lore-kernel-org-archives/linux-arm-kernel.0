From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  8 Aug 2013 17:59:17 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7779: Update early timer initialisation
 order
Message-ID: <1375952357-22938-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

a894fcc2d01a89e6fe3da0845a4d80a5312e1124 ("ARM: smp_twd: Divorce smp_twd
from local timer API") altered twd_local_timer_common_register() so that it
may make use of late_timer_init.

This is problematic on marzen with Magnus's recent patch "ARM: shmobile:
marzen: Switch to DT_MACHINE_START" which switches marzen around to enable
USE_OF and thus shmobile_timer_init(), which is registered as
late_time_init by shmobile_earlytimer_init() stops being a no-op.

As a work-around I have updated r8a7779_earlytimer_init() so that
shmobile_earlytimer_init() is called after r8a7779_register_twd().
Or in other words, the shmobile_earlytimer_init() setting of
late_time_init overwrites that of twd_local_timer_common_register().

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

This patch was created on top of a merge of next-20130807 from the
linux-next tree and renesas-next-20130807 from my renesas tree.

I expect the problem describe above to be present in the
next version of linux-next as it will include renesas-next-20130807.

I rather suspect that this fix is just papers over the problem
at hand rather than fixing it. But it does at least fix the problem
to the extent where the marzen board at least boots.

For reference the output of /proc/interrupts after such a boot is below.

            CPU0       CPU1       CPU2       CPU3
  29:          0       9365       9363       9359       GIC   29  twd
  59:          0          0          0          0       GIC   59  renesas_intc_irqpin.0
  60:          5          0          0          0       GIC   60  renesas_intc_irqpin.0
  61:          0          0          0          0       GIC   61  renesas_intc_irqpin.0
  62:          0          0          0          0       GIC   62  renesas_intc_irqpin.0
  64:        278          0          0          0       GIC   64  sh_tmu.0
  76:          1          0          0          0       GIC   76  ehci_hcd:usb1, ohci_hcd:usb3
  77:          1          0          0          0       GIC   77  ehci_hcd:usb2, ohci_hcd:usb4
 111:          0          0          0          0       GIC  111  i2c-rcar.0
 112:          0          0          0          0       GIC  112  i2c-rcar.2
 113:          0          0          0          0       GIC  113  i2c-rcar.3
 114:          0          0          0          0       GIC  114  i2c-rcar.1
 122:         45          0          0          0       GIC  122  sh-sci.2:mux
 132:          0          0          0          0       GIC  132  sata_rcar
 173:          0          0          0          0       GIC  173  gpio_rcar.0
 174:          0          0          0          0       GIC  174  gpio_rcar.1
 175:          0          0          0          0       GIC  175  gpio_rcar.2
 176:          0          0          0          0       GIC  176  gpio_rcar.3
 177:          0          0          0          0       GIC  177  gpio_rcar.4
 178:          0          0          0          0       GIC  178  gpio_rcar.5
 179:          0          0          0          0       GIC  179  gpio_rcar.6
2001:          5          0          0          0  renesas_intc_irqpin.0    1  eth0
IPI0:          0          0          0          0  CPU wakeup interrupts
IPI1:          0          0          0          0  Timer broadcast interrupts
IPI2:        314        340         58         33  Rescheduling interrupts
IPI3:         22         56         34         56  Function call interrupts
IPI4:          0          0          0          0  Single function call interrupts
IPI5:          0          0          0          0  CPU stop interrupts
 Err:          0
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index ddee4aa..b0f56d6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -597,8 +597,8 @@ void __init __weak r8a7779_register_twd(void) { }
 void __init r8a7779_earlytimer_init(void)
 {
 	r8a7779_clock_init();
-	shmobile_earlytimer_init();
 	r8a7779_register_twd();
+	shmobile_earlytimer_init();
 }
 
 void __init r8a7779_add_early_devices(void)
-- 
1.8.3.2
