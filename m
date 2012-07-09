From: pavel@denx.de (Pavel Machek)
Date: Mon, 9 Jul 2012 14:10:57 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <4FF483D2.70000@gmail.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <4FF483D2.70000@gmail.com>
Message-ID: <20120709121057.GE12130@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > diff --git a/arch/arm/mach-socfpga/localtimer.c b/arch/arm/mach-socfpga/localtimer.c
> > new file mode 100644
> > index 0000000..4aa9221
> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/localtimer.c
> > @@ -0,0 +1,34 @@
> > +/*
> > + *  Copyright (C) 2012 Altera Corporation
> > + *  Copyright (C) 2002 ARM Ltd.
> > + *  All Rights Reserved
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +#include <linux/init.h>
> > +#include <linux/clockchips.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +#include <asm/smp_twd.h>
> > +
> > +/*
> > + * Setup the local clock events for a CPU.
> > + */
> > +int __cpuinit socfpga_local_timer_setup(struct clock_event_device *evt)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "arm,smp-twd");
> 
> This compatible string is wrong (it changed). See the documentation.

Thanks,
									Pavel

commit 9ca5b68dc73249cc17f296237b81abc2fa82b9fd
Author: Pavel <pavel@ucw.cz>
Date:   Mon Jul 9 14:07:29 2012 +0200

    Remove unneccessary localtimer.c. dts bindings already do the right
    thing.
    
    Signed-off-by: Pavel Machek <pavel@denx.de>

diff --git a/arch/arm/mach-socfpga/localtimer.c b/arch/arm/mach-socfpga/localtimer.c
deleted file mode 100644
index a616488..0000000
--- a/arch/arm/mach-socfpga/localtimer.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- *  Copyright (C) 2012 Altera Corporation
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/clockchips.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-
-#include <asm/smp_twd.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit socfpga_local_timer_setup(struct clock_event_device *evt)
-{
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-twd-timer");
-	if (!twd_base) {
-		twd_base = of_iomap(np, 0);
-		WARN_ON(!twd_base);
-	}
-	evt->irq = irq_of_parse_and_map(np, 0);
-	twd_timer_setup(evt);
-	return 0;
-}
-

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
