From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sat, 4 Nov 2017 14:49:51 +0530
Subject: [PATCH 2/3] clk: owl: add clock driver for Actions S900 SoC
In-Reply-To: <7c87aee4-dde4-ab3d-06b0-75f3686ab5dd@suse.de>
References: <1509479663-8985-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509479663-8985-3-git-send-email-manivannan.sadhasivam@linaro.org>
 <7c87aee4-dde4-ab3d-06b0-75f3686ab5dd@suse.de>
Message-ID: <20171104091949.GB14705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,
On Sat, Nov 04, 2017 at 04:36:30PM +0800, Andreas F?rber wrote:
> Hi Mani,
> 
> Still on travels, but some quick comments:
> 
> Please compare the CC list from my patch series - you seem to be missing
> some Actions Semi people.
> 
Sure will do.
> Am 01.11.2017 um 03:54 schrieb Manivannan Sadhasivam:
> > This patch adds clock driver for Actions Semi OWL
> > series S900 SoC.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS                                    |   5 +
> >  drivers/clk/Makefile                           |   1 +
> >  drivers/clk/owl/Makefile                       |   2 +
> >  drivers/clk/owl/clk-factor.c                   | 270 ++++++++++++
> >  drivers/clk/owl/clk-pll.c                      | 346 +++++++++++++++
> >  drivers/clk/owl/clk-s900.c                     | 587 +++++++++++++++++++++++++
> >  drivers/clk/owl/clk.c                          | 318 ++++++++++++++
> >  drivers/clk/owl/clk.h                          | 301 +++++++++++++
> 
> Taking into account previous arm/DT side comments I received, we should
> use clk/actions/ rather than clk/owl/. We can still use owl- or -owl
> inside actions/ if necessary.
> 
Initially I thought about using actions/ but looking at the frequently added
supports like Socionext (they used Uniphier), I decided to use the SoC series
name.

But anyway, we can go for the vendor name actions/ and use owl- prefix for
the source files. 
> >  include/dt-bindings/clock/actions,s900-clock.h | 141 ++++++
> >  9 files changed, 1971 insertions(+)
> >  create mode 100644 drivers/clk/owl/Makefile
> >  create mode 100644 drivers/clk/owl/clk-factor.c
> >  create mode 100644 drivers/clk/owl/clk-pll.c
> >  create mode 100644 drivers/clk/owl/clk-s900.c
> >  create mode 100644 drivers/clk/owl/clk.c
> >  create mode 100644 drivers/clk/owl/clk.h
> >  create mode 100644 include/dt-bindings/clock/actions,s900-clock.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2d3d750..beae8aa 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1098,6 +1098,11 @@ F:	arch/arm/mach-*/
> >  F:	arch/arm/plat-*/
> >  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> >  
> > +ARM/ACTIONS SEMI SoC CLOCK SUPPORT
> > +L:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> You're not a mailing list. If you want to be the maintainer (M:), fine
> with me, but I'd like to be CC'ed please - either via R: here or by
> extending the section below.
> 
Sure. Will add you as the Designated Reviewer (R:).
> > +S:	Maintained
> > +F:	drivers/clk/owl/
> 
> This is lacking the binding.
> 
My bad. Will add it.
> > +
> >  ARM/ACTIONS SEMI ARCHITECTURE
> >  M:	Andreas F?rber <afaerber@suse.de>
> >  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index c99f363..821c1e1 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -75,6 +75,7 @@ endif
> >  obj-y					+= mvebu/
> >  obj-$(CONFIG_ARCH_MXS)			+= mxs/
> >  obj-$(CONFIG_COMMON_CLK_NXP)		+= nxp/
> > +obj-$(CONFIG_ARCH_ACTIONS)		+= owl/
> >  obj-$(CONFIG_MACH_PISTACHIO)		+= pistachio/
> >  obj-$(CONFIG_COMMON_CLK_PXA)		+= pxa/
> >  obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
> > diff --git a/drivers/clk/owl/Makefile b/drivers/clk/owl/Makefile
> > new file mode 100644
> > index 0000000..dbba0af
> > --- /dev/null
> > +++ b/drivers/clk/owl/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-y				+= clk.o clk-pll.o clk-factor.o
> > +obj-$(CONFIG_ARCH_ACTIONS)	+= clk-s900.o
> 
> $(CONFIG_ARCH_ACTIONS) is superfluous here.
> 
Okay. Since, we haven't added ARCH_ACTIONS to defconfig yet I intentionally
made this conditional compilation.

Would like a suggestion from you on this!
> > diff --git a/drivers/clk/owl/clk-factor.c b/drivers/clk/owl/clk-factor.c
> > new file mode 100644
> > index 0000000..6429acd
> > --- /dev/null
> > +++ b/drivers/clk/owl/clk-factor.c
> > @@ -0,0 +1,270 @@
> > +/*
> > + * Copyright (c) 2014 Actions Semi Inc.
> > + * David Liu <liuwei@actions-semi.com>
> > + *
> > + * Copyright (c) 2017 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License v2 as published by
> > + * the Free Software Foundation.
> 
> I had found that S500 code was licensed under GPLv2+ but some S900 parts
> were GPLv2 only. I personally have a bias towards GPLv2+ - any chance we
> can use that here?
> 
If Actions Semi people don't have any objections for sure we can go for GPLv2+.
> Implementation not yet reviewed.
> 
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
