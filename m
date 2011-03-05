From: mspang@csclub.uwaterloo.ca (Michael Spang)
Date: Fri,  4 Mar 2011 23:50:57 -0500
Subject: [PATCH v2 2/2] ARM: Enable TS-78XX features in unknown revisions
In-Reply-To: <1299299957-13018-2-git-send-email-mspang@csclub.uwaterloo.ca>
References: <1299299957-13018-2-git-send-email-mspang@csclub.uwaterloo.ca>
Message-ID: <1299300657-17272-1-git-send-email-mspang@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the manufacturer increases the revision number the platform
devices for the RTC, NAND, and RNG disappear. We should assume
new revisions have these devices instead of assuming they do not.

Signed-off-by: Michael Spang <mspang@csclub.uwaterloo.ca>
---
 arch/arm/mach-orion5x/ts78xx-setup.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

Misspelled KERN_WARNING. Oops. This one is tested.

diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index 7bed418..3f8013a 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -343,9 +343,11 @@ static void ts78xx_fpga_supports(void)
 		ts78xx_fpga.supports.ts_rng.present = 1;
 		break;
 	default:
-		ts78xx_fpga.supports.ts_rtc.present = 0;
-		ts78xx_fpga.supports.ts_nand.present = 0;
-		ts78xx_fpga.supports.ts_rng.present = 0;
+		printk(KERN_WARNING "Unrecognized TS-78XX FPGA ID 0x%02x",
+		       ts78xx_fpga.id);
+		ts78xx_fpga.supports.ts_rtc.present = 1;
+		ts78xx_fpga.supports.ts_nand.present = 1;
+		ts78xx_fpga.supports.ts_rng.present = 1;
 	}
 }
 
-- 
1.7.2.3
