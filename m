From: plyatov@gmail.com (Igor Plyatov)
Date: Sat, 11 Dec 2010 23:45:26 +0300
Subject: [PATCH v2] ide: at91_ide.c bugfix for high master clock
Message-ID: <1292100326-637-1-git-send-email-plyatov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AT91SAM9 microcontrollers with master clock higher then 105 MHz
and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
does not detect IDE device.

Signed-off-by: Igor Plyatov <plyatov@gmail.com>
---
 drivers/ide/at91_ide.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/ide/at91_ide.c b/drivers/ide/at91_ide.c
index 000a78e..5f97710 100644
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -36,6 +36,8 @@
 #define perr(fmt, args...) pr_err(DRV_NAME ": " fmt, ##args)
 #define pdbg(fmt, args...) pr_debug("%s " fmt, __func__, ##args)
 
+#define NCS_RD_PULSE_LIMIT  0x3f /* maximal value for pulse bitfields */
+
 /*
  * Access to IDE device is possible through EBI Static Memory Controller
  * with Compact Flash logic. For details see EBI and SMC datasheet sections
@@ -70,6 +72,7 @@ static void set_smc_timings(const u8 chipselect, const u16 cycle,
 			    const u16 setup, const u16 pulse,
 			    const u16 data_float, int use_iordy)
 {
+	u16 ncs_rd_pulse;
 	unsigned long mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
 			     AT91_SMC_BAT_SELECT;
 
@@ -81,19 +84,29 @@ static void set_smc_timings(const u8 chipselect, const u16 cycle,
 	if (data_float)
 		mode |= AT91_SMC_TDF_(data_float);
 
+	ncs_rd_pulse = cycle;
+	if (ncs_rd_pulse > NCS_RD_PULSE_LIMIT) {
+		ncs_rd_pulse = NCS_RD_PULSE_LIMIT;
+		pr_warn(DRV_NAME ": ncs_rd_pulse limited to maximal value %d\n",
+			ncs_rd_pulse);
+	}
+
 	at91_sys_write(AT91_SMC_MODE(chipselect), mode);
 
 	/* setup timings in SMC */
-	at91_sys_write(AT91_SMC_SETUP(chipselect), AT91_SMC_NWESETUP_(setup) |
-						   AT91_SMC_NCS_WRSETUP_(0) |
-						   AT91_SMC_NRDSETUP_(setup) |
-						   AT91_SMC_NCS_RDSETUP_(0));
-	at91_sys_write(AT91_SMC_PULSE(chipselect), AT91_SMC_NWEPULSE_(pulse) |
-						   AT91_SMC_NCS_WRPULSE_(cycle) |
-						   AT91_SMC_NRDPULSE_(pulse) |
-						   AT91_SMC_NCS_RDPULSE_(cycle));
-	at91_sys_write(AT91_SMC_CYCLE(chipselect), AT91_SMC_NWECYCLE_(cycle) |
-						   AT91_SMC_NRDCYCLE_(cycle));
+	at91_sys_write(AT91_SMC_SETUP(chipselect),
+			AT91_SMC_NWESETUP_(setup) |
+			AT91_SMC_NCS_WRSETUP_(0) |
+			AT91_SMC_NRDSETUP_(setup) |
+			AT91_SMC_NCS_RDSETUP_(0));
+	at91_sys_write(AT91_SMC_PULSE(chipselect),
+			AT91_SMC_NWEPULSE_(pulse) |
+			AT91_SMC_NCS_WRPULSE_(ncs_rd_pulse) |
+			AT91_SMC_NRDPULSE_(pulse) |
+			AT91_SMC_NCS_RDPULSE_(ncs_rd_pulse));
+	at91_sys_write(AT91_SMC_CYCLE(chipselect),
+			AT91_SMC_NWECYCLE_(cycle) |
+			AT91_SMC_NRDCYCLE_(cycle));
 }
 
 static unsigned int calc_mck_cycles(unsigned int ns, unsigned int mck_hz)
-- 
1.7.0.4
