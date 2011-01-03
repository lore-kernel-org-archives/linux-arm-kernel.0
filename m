From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:36:29 +0000
Subject: [PATCH 19/48] ARM: PL08x: ensure loops use cpu_relax()
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZt0v-0001PB-Ta@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tight loops should use cpu_relax() to allow CPUs to reduce power
consumption while waiting for events.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index e8967ff..78c84b3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -191,7 +191,7 @@ static void pl08x_set_cregs(struct pl08x_driver_data *pl08x,
 {
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(ch))
-		;
+		cpu_relax();
 
 	dev_vdbg(&pl08x->adev->dev,
 		"WRITE channel %d: csrc=0x%08x, cdst=0x%08x, "
@@ -255,7 +255,7 @@ static void pl08x_enable_phy_chan(struct pl08x_driver_data *pl08x,
 	 * Do not access config register until channel shows as disabled
 	 */
 	while (readl(pl08x->base + PL080_EN_CHAN) & (1 << ch->id))
-		;
+		cpu_relax();
 
 	/*
 	 * Do not access config register until channel shows as inactive
@@ -288,7 +288,7 @@ static void pl08x_pause_phy_chan(struct pl08x_phy_chan *ch)
 
 	/* Wait for channel inactive */
 	while (pl08x_phy_channel_busy(ch))
-		;
+		cpu_relax();
 }
 
 static void pl08x_resume_phy_chan(struct pl08x_phy_chan *ch)
-- 
1.6.2.5
