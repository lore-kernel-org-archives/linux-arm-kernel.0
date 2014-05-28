From: horms@verge.net.au (Simon Horman)
Date: Wed, 28 May 2014 10:08:50 +0900
Subject: [PATCH v6 1/2] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <201405271131.42301.arnd@arndb.de>
References: <1397775951-30992-1-git-send-email-horms+renesas@verge.net.au>
 <1397775951-30992-2-git-send-email-horms+renesas@verge.net.au>
 <201405271131.42301.arnd@arndb.de>
Message-ID: <20140528010850.GH7374@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 11:31:42AM +0200, Arnd Bergmann wrote:
> On Friday 18 April 2014, Simon Horman wrote:
> > diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
> > new file mode 100644
> > index 0000000..652ecac
> > --- /dev/null
> > +++ b/drivers/clk/shmobile/clk-r8a7779.c
> > @@ -0,0 +1,180 @@
> > +/*
> > + * r8a7779 Core CPG Clocks
> > + *
> > + * Copyright (C) 2013, 2014 Horms Solutions Ltd.
> > + *
> > + * Contact: Simon Horman <horms@verge.net.au>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; version 2 of the License.
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/clkdev.h>
> > +#include <linux/clk/shmobile.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include <dt-bindings/clock/r8a7779-clock.h>
> 
> This currently causes a build error in Linux-next, since the header file
> has not been merged along with the driver.

Hi Arnd,

I'm a little unsure what combination of Kernel config options you
are using to compile this driver in linux-next but I do agree
that the header is missing and that would cause the compile to fail.
I apologise for that oversight.

I believe that a good fix is to add the header, which I already have queued-up
in the renesas tree for v3.17. I wonder if Mike would consider taking
the following patch for v3.16. Alternatively I would be happy to send
it it to arm-soc as a fix for v3.16.

Naturally I will drop it from my v3.17 queue if it its accepted for v3.16
one way or another.

From: Simon Horman <horms+renesas@verge.net.au>

[PATCH] ARM: shmobile: r8a7779: Add clock index macros for DT sources

Add macros usable by device tree sources to reference r8a7779 clocks by
index.

Based on work for the r8a7791 SoC by Laurent Pinchart.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7779-clock.h | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

diff --git a/include/dt-bindings/clock/r8a7779-clock.h b/include/dt-bindings/clock/r8a7779-clock.h
new file mode 100644
index 0000000..381a611
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7779-clock.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2013  Horms Solutions Ltd.
+ *
+ * Contact: Simon Horman <horms@verge.net.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7779_H__
+#define __DT_BINDINGS_CLOCK_R8A7779_H__
+
+/* CPG */
+#define R8A7779_CLK_PLLA	0
+#define R8A7779_CLK_Z		1
+#define R8A7779_CLK_ZS		2
+#define R8A7779_CLK_S		3
+#define R8A7779_CLK_S1		4
+#define R8A7779_CLK_P		5
+#define R8A7779_CLK_B		6
+#define R8A7779_CLK_OUT		7
+
+/* MSTP 0 */
+#define R8A7779_CLK_HSPI	7
+#define R8A7779_CLK_TMU2	14
+#define R8A7779_CLK_TMU1	15
+#define R8A7779_CLK_TMU0	16
+#define R8A7779_CLK_HSCIF1	18
+#define R8A7779_CLK_HSCIF0	19
+#define R8A7779_CLK_SCIF5	21
+#define R8A7779_CLK_SCIF4	22
+#define R8A7779_CLK_SCIF3	23
+#define R8A7779_CLK_SCIF2	24
+#define R8A7779_CLK_SCIF1	25
+#define R8A7779_CLK_SCIF0	26
+#define R8A7779_CLK_I2C3	27
+#define R8A7779_CLK_I2C2	28
+#define R8A7779_CLK_I2C1	29
+#define R8A7779_CLK_I2C0	30
+
+/* MSTP 1 */
+#define R8A7779_CLK_USB01	0
+#define R8A7779_CLK_USB2	1
+#define R8A7779_CLK_DU		3
+#define R8A7779_CLK_VIN2	8
+#define R8A7779_CLK_VIN1	9
+#define R8A7779_CLK_VIN0	10
+#define R8A7779_CLK_ETHER	14
+#define R8A7779_CLK_SATA	15
+#define R8A7779_CLK_PCIE	16
+#define R8A7779_CLK_VIN3	20
+
+/* MSTP 3 */
+#define R8A7779_CLK_SDHI3	20
+#define R8A7779_CLK_SDHI2	21
+#define R8A7779_CLK_SDHI1	22
+#define R8A7779_CLK_SDHI0	23
+#define R8A7779_CLK_MMC1	30
+#define R8A7779_CLK_MMC0	31
+
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7779_H__ */
-- 
1.8.5.2
