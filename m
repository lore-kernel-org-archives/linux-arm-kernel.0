From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 12 Nov 2011 21:00:07 +0100
Subject: [PATCH 5/5] [orion] Consolidate the address map setup code.
In-Reply-To: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
References: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
Message-ID: <1321128007-3520-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/plat-orion/addr-map.c |  171 +++++++++++++++++++---------------------
 1 files changed, 80 insertions(+), 91 deletions(-)

diff --git a/arch/arm/plat-orion/addr-map.c b/arch/arm/plat-orion/addr-map.c
index cfb9ee3..946a4b0 100644
--- a/arch/arm/plat-orion/addr-map.c
+++ b/arch/arm/plat-orion/addr-map.c
@@ -168,98 +168,83 @@ void __init orion_setup_cpu_mbus_target(const struct orion_addr_map_cfg *cfg,
 	orion_mbus_dram_info.num_cs = cs;
 }
 
-#define XOR_WINDOW_BASE(w)		(0x250 + ((w) << 2))
-#define XOR_WINDOW_SIZE(w)		(0x270 + ((w) << 2))
-#define XOR_WINDOW_REMAP_HIGH(w)	(0x290 + ((w) << 2))
-#define XOR_WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
-
-void
-mv_xor_conf_mbus_windows(void __iomem *base)
-{
-	u32 win_enable = 0;
-	struct mbus_dram_window *cs;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		writel(0, base + XOR_WINDOW_BASE(i));
-		writel(0, base + XOR_WINDOW_SIZE(i));
-		if (i < 4)
-			writel(0, base + XOR_WINDOW_REMAP_HIGH(i));
+#define WIN_X(_X_, _devname_, _off_, _shift_)		\
+	static u32 _devname_ ## _win_ ## _X_(u32 i)	\
+	{						\
+		return _off_ + ((i) << _shift_);	\
+							\
 	}
 
-	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
-		cs = orion_mbus_dram_info.cs + i;
+#define WIN_BASE(_devname_, _off_, _shift_)	\
+	WIN_X(base, _devname_, _off_, _shift_)
 
-		writel((cs->base & 0xffff0000) |
-		       (cs->mbus_attr << 8) |
-		       orion_mbus_dram_info.mbus_dram_target_id,
-		       base + XOR_WINDOW_BASE(i));
-		writel((cs->size - 1) & 0xffff0000, base + XOR_WINDOW_SIZE(i));
+#define WIN_CTRL(_devname_, _off_, _shift_)	\
+	WIN_X(ctrl, _devname_, _off_, _shift_)
 
-		win_enable |= (1 << i);
-		win_enable |= 3 << (16 + (2 * i));
-	}
+#define WIN_SIZE(_devname_, _off_, _shift_)	\
+	WIN_X(size, _devname_, _off_, _shift_)
 
-	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(0));
-	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(1));
-}
+#define WIN_REMAP(_devname_, _off_, _shift_)	\
+	WIN_X(remap, _devname_, _off_, _shift_)
 
-#define USB_WINDOW_CTRL(i)	(0x320 + ((i) << 4))
-#define USB_WINDOW_BASE(i)	(0x324 + ((i) << 4))
-#define rdl(off)	__raw_readl(base + (off))
-#define wrl(off, val)	__raw_writel((val), base + (off))
+WIN_BASE(xor, 0x250, 2);
+WIN_SIZE(xor, 0x270, 2);
+WIN_REMAP(xor, 0x290, 2);
+WIN_CTRL(usb, 0x320, 4);
+WIN_BASE(usb, 0x324, 4);
+WIN_CTRL(sata, 0x20030, 4);
+WIN_BASE(sata, 0x20034, 4);
+WIN_BASE(eth, 0x200, 3);
+WIN_SIZE(eth, 0x204, 3);
+WIN_REMAP(eth, 0x0280, 2);
+WIN_CTRL(mvsd, 0x108, 3);
+WIN_BASE(mvsd, 0x10c, 3);
 
-void __init
-ehci_orion_conf_mbus_windows(void __iomem *base)
+typedef u32 (*woff_t)(u32);
+
+void mbus_windows_base_size(void __iomem *base, woff_t off_base,
+			    woff_t off_size, woff_t off_remap, int maxwin)
 {
 	int i;
 	struct mbus_dram_window *cs;
 
-	for (i = 0; i < 4; i++) {
-		wrl(USB_WINDOW_CTRL(i), 0);
-		wrl(USB_WINDOW_BASE(i), 0);
+	for (i = 0; i < maxwin; i++) {
+		writel(0, base + off_base(i));
+		writel(0, base + off_size(i));
+		if (i < 4)
+			writel(0, base + off_remap(i));
 	}
 
 	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
 		cs = orion_mbus_dram_info.cs + i;
-
-		wrl(USB_WINDOW_CTRL(i),
-		    ((cs->size - 1) & 0xffff0000) |
-		    (cs->mbus_attr << 8) |
-		    (orion_mbus_dram_info.mbus_dram_target_id << 4) | 1);
-		wrl(USB_WINDOW_BASE(i), cs->base);
+		writel((cs->base & 0xffff0000) |
+		       (cs->mbus_attr << 8) |
+		       orion_mbus_dram_info.mbus_dram_target_id,
+		       base + off_base(i));
+		writel((cs->size - 1) & 0xffff0000, base + off_size(i));
 	}
 }
 
-#define SATA_WINDOW_CTRL(i)		(0x20030 + ((i) << 4))
-#define SATA_WINDOW_BASE(i)		(0x20034 + ((i) << 4))
-
+#define XOR_WINDOW_BAR_ENABLE(chan)	(0x240 + ((chan) << 2))
 
-void mv_sata_conf_mbus_windows(void __iomem *base)
+void
+mv_xor_conf_mbus_windows(void __iomem *base)
 {
+	u32 win_enable = 0;
 	int i;
-	struct mbus_dram_window *cs;
 
-	for (i = 0; i < 4; i++) {
-		writel(0, base + SATA_WINDOW_CTRL(i));
-		writel(0, base + SATA_WINDOW_BASE(i));
-	}
+	mbus_windows_base_size(base, xor_win_base, xor_win_size,
+			       xor_win_remap, 8);
 
 	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
-		cs = orion_mbus_dram_info.cs + i;
-
-		writel(((cs->size - 1) & 0xffff0000) |
-			(cs->mbus_attr << 8) |
-			(orion_mbus_dram_info.mbus_dram_target_id << 4) | 1,
-			base + SATA_WINDOW_CTRL(i));
-		writel(cs->base, base + SATA_WINDOW_BASE(i));
+		win_enable |= (1 << i);
+		win_enable |= 3 << (16 + (2 * i));
 	}
-}
 
+	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(0));
+	writel(win_enable, base + XOR_WINDOW_BAR_ENABLE(1));
+}
 
-#define ETH_WINDOW_BASE(w)		(0x0200 + ((w) << 3))
-#define ETH_WINDOW_SIZE(w)		(0x0204 + ((w) << 3))
-#define ETH_WINDOW_REMAP_HIGH(w)	(0x0280 + ((w) << 2))
 #define ETH_WINDOW_BAR_ENABLE		0x0290
 
 u32
@@ -268,26 +253,14 @@ mv643xx_eth_conf_mbus_windows(void __iomem *base)
 	u32 win_enable;
 	u32 win_protect;
 	int i;
-	struct mbus_dram_window *cs;
 
-	for (i = 0; i < 6; i++) {
-		writel(0, base + ETH_WINDOW_BASE(i));
-		writel(0, base + ETH_WINDOW_SIZE(i));
-		if (i < 4)
-			writel(0, base + ETH_WINDOW_REMAP_HIGH(i));
-	}
+	mbus_windows_base_size(base, eth_win_base, eth_win_size,
+			       eth_win_remap, 6);
 
 	win_enable = 0x3f;
 	win_protect = 0;
 
 	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
-		cs = orion_mbus_dram_info.cs + i;
-		writel((cs->base & 0xffff0000) |
-		       (cs->mbus_attr << 8) |
-		       orion_mbus_dram_info.mbus_dram_target_id,
-		       base + ETH_WINDOW_BASE(i));
-		writel((cs->size - 1) & 0xffff0000, base + ETH_WINDOW_SIZE(i));
-
 		win_enable &= ~(1 << i);
 		win_protect |= 3 << (2 * i);
 	}
@@ -296,29 +269,45 @@ mv643xx_eth_conf_mbus_windows(void __iomem *base)
 	return win_protect;
 }
 
-#define MVSD_WINDOW_CTRL(i)			(0x108 + ((i) << 3))
-#define MVSD_WINDOW_BASE(i)			(0x10c + ((i) << 3))
-
-void mvsd_conf_mbus_windows(void __iomem *base)
+void
+mbus_windows_ctrl_base(void __iomem *base, woff_t off_ctrl, woff_t off_base)
 {
 	int i;
 	struct mbus_dram_window *cs;
 
 	for (i = 0; i < 4; i++) {
-		writel(0, base + MVSD_WINDOW_CTRL(i));
-		writel(0, base + MVSD_WINDOW_BASE(i));
+		writel(0, base + off_ctrl(i));
+		writel(0, base + off_base(i));
 	}
 
 	for (i = 0; i < orion_mbus_dram_info.num_cs; i++) {
 		cs = orion_mbus_dram_info.cs + i;
+
 		writel(((cs->size - 1) & 0xffff0000) |
 		       (cs->mbus_attr << 8) |
 		       (orion_mbus_dram_info.mbus_dram_target_id << 4) | 1,
-		       base + MVSD_WINDOW_CTRL(i));
-		writel(cs->base, base + MVSD_WINDOW_BASE(i));
+		       base + off_ctrl(i));
+		writel(cs->base, base + off_base(i));
 	}
 }
 
+void __init
+ehci_orion_conf_mbus_windows(void __iomem *base)
+{
+	mbus_windows_ctrl_base(base, usb_win_ctrl, usb_win_base);
+}
+
+void mv_sata_conf_mbus_windows(void __iomem *base)
+{
+	mbus_windows_ctrl_base(base, sata_win_ctrl, sata_win_base);
+}
+
+void mvsd_conf_mbus_windows(void __iomem *base)
+{
+	mbus_windows_ctrl_base(base, mvsd_win_ctrl, mvsd_win_base);
+}
+
+
 #define KIRKWOOD_AUDIO_WIN_BASE_REG(win)	(0xA00 + ((win)<<3))
 #define KIRKWOOD_AUDIO_WIN_CTRL_REG(win)	(0xA04 + ((win)<<3))
 
@@ -337,12 +326,12 @@ void kirkwood_dma_conf_mbus_windows(void __iomem *base, int win,
 		cs = orion_mbus_dram_info.cs + i;
 		if ((cs->base & 0xffff0000) < (dma & 0xffff0000)) {
 			writel(cs->base & 0xffff0000,
-				base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
+			       base + KIRKWOOD_AUDIO_WIN_BASE_REG(win));
 			writel(((cs->size - 1) & 0xffff0000) |
-				(cs->mbus_attr << 8) |
-				(orion_mbus_dram_info.mbus_dram_target_id << 4)
+			       (cs->mbus_attr << 8) |
+			       (orion_mbus_dram_info.mbus_dram_target_id << 4)
 			       | 1,
-				base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
+			       base + KIRKWOOD_AUDIO_WIN_CTRL_REG(win));
 		}
 	}
 }
-- 
1.7.7.1
