From: linux@prisktech.co.nz (Linux Mailing List Email Account)
Date: Sun, 27 Feb 2011 00:05:55 -0000
Subject: [PATCH 1/3] VIA/Wondermedia clock support
Message-ID: <76F764B079F92A4E843589C893D0A0228CB5@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
--- /dev/null   2011-02-26 19:04:30.530140059 +1300
+++ arch/arm/mach-vt8500/clock.h     2011-02-27 12:31:39.000000000 +1300
@@ -0,0 +1,136 @@
+/*
+ *  arch/arm/mach-vt8500/clock.h
+ *
+ *  Copyright (C) 2011 Tony Prisk
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef __WMT_CLOCK_H
+#define __WMT_CLOCK_H
+
+#include <linux/list.h>
+#include <linux/clkdev.h>
+
+#define CLK_PRIMARY       0x00
+#define CLK_PROGRAMABLE        0x01
+#define CLK_ENABLE        0x02
+#define CLK_NO_PROPAGATE  0x04
+
+#define DEFINE_CKREF(_name, _rate)        \
+struct clk clk_##_name = {                \
+    .name = #_name,            \
+    .parent = NULL,                 \
+    .ops = NULL,                    \
+    .rate = _rate,             \
+    .type = CLK_PRIMARY,             \
+    .delay  = 0,                    \
+    .en_reg = 0,                    \
+    .en_bit = 0                     \
+}
+
+#define DEFINE_CKEN(_name, _ops, _enreg, _enbit)    \
+struct clk clk_##_name = {                     \
+    .name = #_name,                  \
+    .parent = NULL,                      \
+    .ops = _ops,                         \
+    .rate = 0,                       \
+    .type = CLK_ENABLE,                   \
+    .delay  = 0,                         \
+    .en_reg = _enreg,                    \
+    .en_bit = _enbit,                    \
+    .div_reg = 0                         \
+}
+
+#define DEFINE_CKPG(_name, _parent, _delay, _ops, _reg)   \
+struct clk clk_##_name = {                     \
+    .name = #_name,                  \
+    .parent = _parent,                   \
+    .ops = _ops,                         \
+    .rate = 0,                       \
+    .type = CLK_PROGRAMABLE,              \
+    .delay  = _delay,                    \
+    .en_reg = 0,                         \
+    .en_bit = 0,                         \
+    .div_reg = _reg                      \
+}
+
+#define DEFINE_CKPGNP(_name, _parent, _delay, _ops, _reg) \
+struct clk clk_##_name = {                     \
+    .name = #_name,                  \
+    .parent = _parent,                   \
+    .ops = _ops,                         \
+    .rate = 0,                       \
+    .type = CLK_PROGRAMABLE | CLK_NO_PROPAGATE, \
+    .delay  = _delay,                    \
+    .en_reg = 0,                         \
+    .en_bit = 0,                         \
+    .div_reg = _reg                      \
+}
+
+#define DEFINE_CKPGEN(_name, _parent, _delay, _ops, _reg, _enreg, _enbit) \
+struct clk clk_##_name = {                     \
+    .name = #_name,                  \
+    .parent = _parent,                   \
+    .ops = _ops,                         \
+    .rate = 0,                       \
+    .type = CLK_PROGRAMABLE | CLK_ENABLE,      \
+    .delay  = _delay,                    \
+    .en_reg = _enreg,                    \
+    .en_bit = _enbit,                    \
+    .div_reg = _reg                      \
+}
+
+
+#define INIT_CLKREG(_clk, _devid, _conid)      \
+{                                   \
+    .clk = _clk,                         \
+    .dev_id = _devid,                    \
+    .con_id = _conid                     \
+}
+
+struct clkops {
+    void       (*enable)(struct clk *);
+    void       (*disable)(struct clk *);
+
+    unsigned long   (*getrate)(struct clk *);
+    int        (*setrate)(struct clk *, unsigned long rate);
+};
+
+struct clk {
+    struct list_head     node;
+    struct clk      *parent;
+    const struct clkops  *ops;
+    const char      *name;
+    unsigned long        rate;
+    unsigned int         type;
+    unsigned int         delay;
+    unsigned int         usecount;
+
+    unsigned int         en_reg;
+    unsigned int         en_bit;
+
+    unsigned int         div_reg;
+
+    struct list_head     children;
+    struct list_head     childnode;
+};
+
+/* wm8505-clocks.c */
+extern int wmt_clock_init(void);
+
+int clk_register(struct clk *clk);
+
+#endif


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110227/f0e8e49d/attachment.html>
