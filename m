From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Apr 2014 15:49:28 -0500
Subject: [PATCH V2 12/19] bus: omap_l3_noc: fix masterid detection
In-Reply-To: <1397767775-10965-1-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Message-ID: <1397767775-10965-13-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per Documentation (OMAP4+), then masterid is infact encoded as
follows:
"L3_TARG_STDERRLOG_MSTADDR[7:0] STDERRLOG_MSTADDR stores the NTTP
master address. The master address is the concatenation of Prefix &
Initiator ConnID. It is defined on 8 bits. The 6 MSBs are used to
distinguish the different initiators."

So when we matchup currently with the master ID list, we never get a
proper match other than when MPU is the master (thanks to 0). Fix this
by using the relevant 6MSBits to identify the master ID for standard
and custom errors.

Reported-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

New patch.

 drivers/bus/omap_l3_noc.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 300e168..29d6206 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -127,7 +127,12 @@ static irqreturn_t l3_interrupt_handler(int irq, void *_l3)
 					  L3_TARG_STDERRLOG_MSTADDR;
 
 			std_err_main = readl_relaxed(l3_targ_stderr);
-			masterid = readl_relaxed(l3_targ_mstaddr);
+			/*
+			 * STDERRLOG_MSTADDR Stores the NTTP master address.
+			 * The 6 MSBs are used to distinguish the different
+			 * initiators
+			 */
+			masterid = (readl_relaxed(l3_targ_mstaddr) & 0xFF) >> 2;
 
 			switch (std_err_main & CUSTOM_ERROR) {
 			case STANDARD_ERROR:
-- 
1.7.9.5
