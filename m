From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue,  8 Apr 2014 17:44:14 -0600
Subject: [PATCH v2] bus: mvebu-mbus: Avoid setting an undefined window size
Message-ID: <1397000654-10849-1-git-send-email-jgunthorpe@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mbus hardware requires a power of two size, and size aligned base.
Currently, if a non-power of two is passed in to the low level routines
they configure the register in a way that results in undefined behaviour.

Call WARN and return EINVAL instead.

Also, update the debugfs routines to show a message if there is an
invalid register setting.

All together this makes the recent problems with silent failure
of PCI very obvious, noisy and debuggable.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
---
 drivers/bus/mvebu-mbus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

It would be good to see that these warn's trigger, my system here has
everything aligned..

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2ac754e..9578ae3 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -266,6 +267,17 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 		mbus->soc->win_cfg_offset(win);
 	u32 ctrl, remap_addr;
 
+	if (!is_power_of_2(size)) {
+		WARN(true, "Invalid MBus window size: 0x%zx\n", size);
+		return -EINVAL;
+	}
+
+	if ((base & (phys_addr_t)(size - 1)) != 0) {
+		WARN(true, "Invalid MBus base/size: %pa len 0x%zx\n", &base,
+		     size);
+		return -EINVAL;
+	}
+
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
@@ -413,6 +425,10 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 			   win, (unsigned long long)wbase,
 			   (unsigned long long)(wbase + wsize), wtarget, wattr);
 
+		if (!is_power_of_2(wsize) ||
+		    ((wbase & (u64)(wsize - 1)) != 0))
+			seq_puts(seq, " (Invalid base/size!!)");
+
 		if (win < mbus->soc->num_remappable_wins) {
 			seq_printf(seq, " (remap %016llx)\n",
 				   (unsigned long long)wremap);
-- 
1.8.1.2
