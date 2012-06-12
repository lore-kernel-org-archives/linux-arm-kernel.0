From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Jun 2012 23:28:49 -0700
Subject: am33xx: pin modes
In-Reply-To: <4FD600AF.9070204@visionsystems.de>
References: <4FD5E268.7030105@visionsystems.de>
 <1BAFE6F6C881BF42822005164F1491C33EA1E6F0@DBDE01.ent.ti.com>
 <20120611140417.GC12766@atomide.com>
 <4FD600AF.9070204@visionsystems.de>
Message-ID: <20120612062849.GD12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Yegor Yefremov <yegor_sub1@visionsystems.de> [120611 07:33]:
> Am 11.06.2012 16:04, schrieb Tony Lindgren:
> > * Hebbar, Gururaja <gururaja.hebbar@ti.com> [120611 06:48]:
> >> On Mon, Jun 11, 2012 at 17:49:52, Yegor Yefremov wrote:
> >>> I'm working with Koen's repo (https://github.com/koenkooi/linux.git) and have a question. There are two places, where pin's function is defined:
> >>>
> >>>
> >>> arch/arm/mach-omap2/mux33xx.c:
> >>> static struct omap_mux __initdata am33xx_muxmodes[] = {
> >>> /**/    _AM33XX_MUXENTRY(GPMC_AD0, 0,
> >>>                 "gpmc_ad0", "mmc1_dat0", NULL, NULL,
> >>>                 NULL, NULL, NULL, "gpio1_0"),
> >>>
> >> This is the big AM33XX pin mux super set table. Here, Entire Mux entries for AM335x SOC
> >> are defined.
> > Please note that we're moving to the generic pinctrl framework,
> > and using device tree and pinctrl-single driver. So the old style
> > pinmux data or board-*.c files will not get merged upstream.
> 
> O.K. Where can I see examples?

I posted the latest version of the driver yesterday, then the
documentation part has an example.

Here's also a little patch to make the old mux framework dump out
new format DT entries using debugfs when you examine debugfs with
cat /sys/kernel/debug/omap_mux/board/core or wkup. You probably need
to also add a call for omap3_mux_init into board-generic.c to also
initialize the old mux fwk if you want them both at the same time
for debugging. From the output you can grep for pins for each device.

Note that omap3 old mux fwk is not setting up separate core + wkup
domains in the old mux framework, so it only shows core.

Regards,

Tony

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -35,9 +35,10 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 
-
 #include <plat/omap_hwmod.h>
 
+#include <mach/id.h>
+
 #include "control.h"
 #include "mux.h"
 #include "prm.h"
@@ -570,15 +571,26 @@ static inline void omap_mux_decode(struct seq_file *s, u16 val)
 static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 {
 	struct omap_mux_partition *partition = s->private;
+	int pbase = (int)partition->base;
 	struct omap_mux_entry *e;
-	u8 omap_gen = omap_rev() >> 28;
+
+	if (!(pbase & 0xfff))
+		pbase = 0x40;
+	else
+		pbase = 0;
+
+	seq_printf(s, "\t\tpinctrl-single,cells = <\n");
 
 	list_for_each_entry(e, &partition->muxmodes, node) {
 		struct omap_mux *m = &e->mux;
 		char m0_def[OMAP_MUX_DEFNAME_LEN];
 		char *m0_name = m->muxnames[0];
 		u16 val;
-		int i, mode;
+		int padconf_offset, i, mode;
+
+		padconf_offset = m->reg_offset - pbase;
+		if (cpu_is_omap3630() && padconf_offset > 0x5ca)
+			continue;
 
 		if (!m0_name)
 			continue;
@@ -593,18 +605,14 @@ static int omap_mux_dbg_board_show(struct seq_file *s, void *unused)
 		}
 		val = omap_mux_read(partition, m->reg_offset);
 		mode = val & OMAP_MUX_MODE7;
-		if (mode != 0)
-			seq_printf(s, "/* %s */\n", m->muxnames[mode]);
-
-		/*
-		 * XXX: Might be revisited to support differences across
-		 * same OMAP generation.
-		 */
-		seq_printf(s, "OMAP%d_MUX(%s, ", omap_gen, m0_def);
+		seq_printf(s, "\t\t\t0x%x 0x%x\t/* %s.%s gpio%i ",
+			   padconf_offset, val, m->muxnames[0], m->muxnames[mode], m->gpio);
 		omap_mux_decode(s, val);
-		seq_printf(s, "),\n");
+		seq_printf(s, " */\n");
 	}
 
+	seq_printf(s, "\t\t>;\n");
+
 	return 0;
 }
 
