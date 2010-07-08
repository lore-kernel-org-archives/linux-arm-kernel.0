From: tony@atomide.com (Tony Lindgren)
Date: Thu, 08 Jul 2010 16:54:55 +0300
Subject: [PATCH 08/13] omap: mux: fix multipath gpio handling
In-Reply-To: <20100708135342.26276.80936.stgit@baageli.muru.com>
References: <20100708135342.26276.80936.stgit@baageli.muru.com>
Message-ID: <20100708135455.26276.13094.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grazvydas Ignotas <notasas@gmail.com>

OMAP3530 CBB package can have GPIO126 muxed on 2 pins: mmc1_dat4 and
cam_strobe. This causes a problem with current multipath GPIO mux
handling, which muxes both pins as GPIO126 and makes the GPIO unusable.

Fix this by not muxing any pins if multipath GPIO is detected and
just print a warning instead. It's up to board files to set correct
mux using omap_mux_init_signal and pin name.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mux.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index be52fab..ab403b2 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -87,6 +87,9 @@ static char *omap_mux_options;
 int __init omap_mux_init_gpio(int gpio, int val)
 {
 	struct omap_mux_entry *e;
+	struct omap_mux *gpio_mux;
+	u16 old_mode;
+	u16 mux_mode;
 	int found = 0;
 
 	if (!gpio)
@@ -95,34 +98,33 @@ int __init omap_mux_init_gpio(int gpio, int val)
 	list_for_each_entry(e, &muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		if (gpio == m->gpio) {
-			u16 old_mode;
-			u16 mux_mode;
-
-			old_mode = omap_mux_read(m->reg_offset);
-			mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
-			if (omap_mux_flags & MUXABLE_GPIO_MODE3)
-				mux_mode |= OMAP_MUX_MODE3;
-			else
-				mux_mode |= OMAP_MUX_MODE4;
-			printk(KERN_DEBUG "mux: Setting signal "
-				"%s.gpio%i 0x%04x -> 0x%04x\n",
-				m->muxnames[0], gpio, old_mode, mux_mode);
-			omap_mux_write(mux_mode, m->reg_offset);
+			gpio_mux = m;
 			found++;
 		}
 	}
 
-	if (found == 1)
-		return 0;
+	if (found == 0) {
+		printk(KERN_ERR "mux: Could not set gpio%i\n", gpio);
+		return -ENODEV;
+	}
 
 	if (found > 1) {
-		printk(KERN_ERR "mux: Multiple gpio paths for gpio%i\n", gpio);
+		printk(KERN_INFO "mux: Multiple gpio paths (%d) for gpio%i\n",
+				found, gpio);
 		return -EINVAL;
 	}
 
-	printk(KERN_ERR "mux: Could not set gpio%i\n", gpio);
+	old_mode = omap_mux_read(gpio_mux->reg_offset);
+	mux_mode = val & ~(OMAP_MUX_NR_MODES - 1);
+	if (omap_mux_flags & MUXABLE_GPIO_MODE3)
+		mux_mode |= OMAP_MUX_MODE3;
+	else
+		mux_mode |= OMAP_MUX_MODE4;
+	printk(KERN_DEBUG "mux: Setting signal %s.gpio%i 0x%04x -> 0x%04x\n",
+			gpio_mux->muxnames[0], gpio, old_mode, mux_mode);
+	omap_mux_write(mux_mode, gpio_mux->reg_offset);
 
-	return -ENODEV;
+	return 0;
 }
 
 int __init omap_mux_init_signal(char *muxname, int val)
