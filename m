From: peng.fan@nxp.com (Peng Fan)
Date: Sat, 30 Dec 2017 14:20:20 +0000
Subject: [PATCH V2] ARM: imx: introduce imx_l2c310_write_sec
In-Reply-To: <CAOFm3uGL=zyxj5VzKAKsAcU6bcL2bJQCcvP9eg4qYAKN00iwJg@mail.gmail.com>
References: <1514637243-20111-1-git-send-email-peng.fan@nxp.com>
 <CAOFm3uGL=zyxj5VzKAKsAcU6bcL2bJQCcvP9eg4qYAKN00iwJg@mail.gmail.com>
Message-ID: <DB6PR04MB3221B2DCEE2F198D309CEBA8881A0@DB6PR04MB3221.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Philippe Ombredanne [mailto:pombredanne at nexb.com]
> Sent: Saturday, December 30, 2017 10:17 PM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; moderated list:ARM/FREESCALE IMX
> / MXC ARM ARCHITECTURE <linux-arm-kernel@lists.infradead.org>; LKML
> <linux-kernel@vger.kernel.org>; Peng Fan <van.freenix@gmail.com>; Sascha
> Hauer <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>;
> A.s. Dong <aisheng.dong@nxp.com>
> Subject: Re: [PATCH V2] ARM: imx: introduce imx_l2c310_write_sec
> 
> On Sat, Dec 30, 2017 at 1:34 PM, Peng Fan <peng.fan@nxp.com> wrote:
> > Some PL310 registers could only be wrote in secure world, so introduce
> > imx_l2c310_write_sec to support Linux running in non-secure world
> > configure PL310.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: Fabio Estevam <fabio.estevam@nxp.com>
> > Cc: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >
> > V2:
> >  Use SPDX Tag
> >  Use CONFIG_HAVE_ARM_SMCCC to fix build error for armv5.
> >  Add IS_ENABLED(CONFIG_OPTEE) check when assigning write_sec
> >
> >  arch/arm/mach-imx/system.c    | 27 ++++++++++++++++++++++++++-
> >  include/soc/imx/imx_sip_smc.h | 21 +++++++++++++++++++++
> >  2 files changed, 47 insertions(+), 1 deletion(-)  create mode 100644
> > include/soc/imx/imx_sip_smc.h
> >
> > diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> > index c06af650e6b1..2c27e52d8c7d 100644
> > --- a/arch/arm/mach-imx/system.c
> > +++ b/arch/arm/mach-imx/system.c
> > @@ -23,11 +23,13 @@
> >  #include <linux/delay.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> > +#include <soc/imx/imx_sip_smc.h>
> >
> >  #include <asm/system_misc.h>
> >  #include <asm/proc-fns.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/hardware/cache-l2x0.h>
> > +#include <asm/outercache.h>
> >
> >  #include "common.h"
> >  #include "hardware.h"
> > @@ -92,6 +94,22 @@ void __init imx1_reset_init(void __iomem *base)
> > #endif
> >
> >  #ifdef CONFIG_CACHE_L2X0
> > +#ifdef CONFIG_HAVE_ARM_SMCCC
> > +void imx_l2c310_write_sec(unsigned long val, unsigned int reg) {
> > +       struct arm_smccc_res res;
> > +
> > +       arm_smccc_smc(IMX_SIP_SMC_L2C310, val, reg, 0, 0, 0, 0, 0,
> > + &res);
> > +
> > +       if (res.a0 != 0)
> > +               pr_err("Failed to write l2c310 0x%x: 0x%lx\n", reg,
> > +res.a0); } #else void imx_l2c310_write_sec(unsigned long val,
> > +unsigned int reg) { } #endif
> > +
> >  void __init imx_init_l2cache(void)
> >  {
> >         void __iomem *l2x0_base;
> > @@ -102,6 +120,10 @@ void __init imx_init_l2cache(void)
> >         if (!np)
> >                 return;
> >
> > +       if (IS_ENABLED(CONFIG_OPTEE) &&
> > +           of_find_compatible_node(NULL, NULL, "linaro,optee-tz"))
> > +               outer_cache.write_sec = imx_l2c310_write_sec;
> > +
> >         l2x0_base = of_iomap(np, 0);
> >         if (!l2x0_base)
> >                 goto put_node;
> > @@ -117,7 +139,10 @@ void __init imx_init_l2cache(void)
> >                 val &= ~L310_PREFETCH_CTRL_OFFSET_MASK;
> >                 val |= 15;
> >
> > -               writel_relaxed(val, l2x0_base + L310_PREFETCH_CTRL);
> > +               if (outer_cache.write_sec)
> > +                       outer_cache.write_sec(val, L310_PREFETCH_CTRL);
> > +               else
> > +                       writel_relaxed(val, l2x0_base +
> > + L310_PREFETCH_CTRL);
> >         }
> >
> >         iounmap(l2x0_base);
> > diff --git a/include/soc/imx/imx_sip_smc.h
> > b/include/soc/imx/imx_sip_smc.h new file mode 100644 index
> > 000000000000..c35ae69e0d2f
> > --- /dev/null
> > +++ b/include/soc/imx/imx_sip_smc.h
> > @@ -0,0 +1,21 @@
> > +/*
> > + * Copyright 2017 NXP
> > + *
> > + * SPDX-License-Identifier: GPL-2.0
> > + */
> > +
> 
> Thanks! but the SPDX tag should be on the first line as its own comment. So this
> would come out something like this
> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/* Copyright 2017 NXP */
> 
> or
> 
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2017 NXP
> > + */
> 

Thanks. I'll correct in V3. Before that, I would like to see if more comments
about the code. Then I'll address them all in V3.

Thanks,
Peng.

> 
> 
> > +#ifndef __IMX_SIP_SMC_H_
> > +#define __IMX_SIP_SMC_H_
> > +
> > +#include <linux/arm-smccc.h>
> > +
> > +#define IMX_SIP_SMC_VAL(func)
> ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, \
> > +                                                ARM_SMCCC_SMC_32, \
> > +                                                ARM_SMCCC_OWNER_SIP, \
> > +                                                (func))
> > +
> > +#define IMX_L2C310             0x1
> > +
> > +#define IMX_SIP_SMC_L2C310     IMX_SIP_SMC_VAL(IMX_L2C310)
> > +
> > +#endif
> > --
> > 2.14.1
> >
> 
> 
> 
> --
> Cordially
> Philippe Ombredanne
