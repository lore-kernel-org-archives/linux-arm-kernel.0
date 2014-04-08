From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 11:14:17 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408175545.1b4d55a5@skate>
References: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
Message-ID: <20140408171417.GB27776@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 05:55:45PM +0200, Thomas Petazzoni wrote:

> mvebu-mbus/devices output:
> 
> # cat /sys/kernel/debug/mvebu-mbus/devices 
> [10] 00000000e0000000 - 00000000e0900000 : 0004:00e8

> I'm not sure why I don't have the non-power-of-two problem for the MBus
> windows.

Well, you do, 0x900000 is not aligned. It converts to size=0b10001111,
which is undefined behavior for mbus. 

It looks like you are lucky, for your system the undefined behavior
creates a window that hits all the BARs, but the others were not so
lucky.

What do you think about this:

>From 235b0bf637242a50ec45c8766d18a942bff601cf Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Tue, 8 Apr 2014 11:12:41 -0600
Subject: [PATCH] bus: mvebu-mbus: Avoid setting an undefined window size

The mbus hardware requires a power of two size, if a non-power
of two is passed in to the low level routines they configure the
register in a way that results in undefined behaviour.

- WARN_ON to make this invalid usage really obvious
- Round down to the nearest power of two so we only stuff a valid
  size into the HW
- When reading interpret undefined values in a conservative way,
  the value is assumed to be the lowest power of two. This avoids
  the debugfs output showing a value that looks 'correct'

All together this makes the recent problems with silent failure
of PCI very obvious, noisy and debuggable.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2ac754e..d26f63c 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -147,7 +148,7 @@ static void mvebu_mbus_read_window(struct mvebu_mbus_state *mbus,
 	*enabled = 1;
 	*base = ((u64)basereg & WIN_BASE_HIGH) << 32;
 	*base |= (basereg & WIN_BASE_LOW);
-	*size = (ctrlreg | ~WIN_CTRL_SIZE_MASK) + 1;
+	*size = 1 << (ffs(~(ctrlreg | ~WIN_CTRL_SIZE_MASK)) - 1);
 
 	if (target)
 		*target = (ctrlreg & WIN_CTRL_TGT_MASK) >> WIN_CTRL_TGT_SHIFT;
@@ -266,6 +267,9 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 		mbus->soc->win_cfg_offset(win);
 	u32 ctrl, remap_addr;
 
+	WARN_ON(!is_power_of_2(size));
+	size = rounddown_pow_of_two(size);
+
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
-- 
1.8.1.2
