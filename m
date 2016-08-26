From: anson.huang@nxp.com (Yongcai Huang)
Date: Fri, 26 Aug 2016 12:25:34 +0000
Subject: [PATCH 2/3] ARM: imx: add gpcv2 support
In-Reply-To: <20160826111758.GN1041@n2100.armlinux.org.uk>
References: <1472209971-32469-1-git-send-email-Anson.Huang@nxp.com>
 <1472209971-32469-3-git-send-email-Anson.Huang@nxp.com>
 <20160826111758.GN1041@n2100.armlinux.org.uk>
Message-ID: <AM3PR04MB131555F86F300E9B544069D6F5EC0@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> Sent: 2016-08-26 7:18 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; shawnguo at kernel.org; kernel at pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; robh+dt at kernel.org;
> mark.rutland at arm.com
> Subject: Re: [PATCH 2/3] ARM: imx: add gpcv2 support
> 
> On Fri, Aug 26, 2016 at 07:12:50PM +0800, Anson Huang wrote:
> > diff --git a/arch/arm/mach-imx/gpcv2.c b/arch/arm/mach-imx/gpcv2.c new
> > file mode 100644 index 0000000..98577c4
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/gpcv2.c
> > @@ -0,0 +1,66 @@
> > +/*
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +
> > +#include "common.h"
> > +
> > +#define GPC_CPU_PGC_SW_PUP_REQ	0xf0
> > +#define GPC_CPU_PGC_SW_PDN_REQ	0xfc
> > +#define GPC_PGC_C1		0x840
> > +
> > +#define BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7	0x2
> > +#define BM_GPC_PGC_PCG				0x1
> > +
> > +static void __iomem *gpcv2_base;
> > +
> > +static void imx_gpcv2_set_m_core_pgc(bool enable, u32 offset) {
> > +	u32 val = readl_relaxed(gpcv2_base + offset) & (~BM_GPC_PGC_PCG);
> 
> Unnecessary parens, and the code doesn't flow with the bit clearance here...
> 
> > +
> > +	if (enable)
> > +		val |= BM_GPC_PGC_PCG;
> 
> My first read of this lead me to think "okay, so what's the point of
> enable=false".  It would be clearer with:
> 
> 	u32 val = readl_relaxed(gpcv2_base + offset);
> 
> 	if (enable)
> 		val |= BM_GPC_PGC_PCG;
> 	else
> 		val &= ~BM_GPC_PGC_PCG;
> 
> here.

Agree, will improve it in V2 patch.

> 
> > +
> > +	writel_relaxed(val, gpcv2_base + offset); }
> > +
> > +void imx_gpcv2_set_core1_pdn_pup_by_software(bool pdn) {
> > +	u32 val = readl_relaxed(gpcv2_base + (pdn ?
> > +		GPC_CPU_PGC_SW_PDN_REQ :
> GPC_CPU_PGC_SW_PUP_REQ));
> > +
> > +	imx_gpcv2_set_m_core_pgc(true, GPC_PGC_C1);
> > +	val |= BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7;
> > +	writel_relaxed(val, gpcv2_base + (pdn ?
> > +		GPC_CPU_PGC_SW_PDN_REQ :
> GPC_CPU_PGC_SW_PUP_REQ));
> > +
> > +	while ((readl_relaxed(gpcv2_base + (pdn ?
> > +		GPC_CPU_PGC_SW_PDN_REQ :
> GPC_CPU_PGC_SW_PUP_REQ)) &
> > +		BM_CPU_PGC_SW_PDN_PUP_REQ_CORE1_A7) != 0)
> > +		;
> > +	imx_gpcv2_set_m_core_pgc(false, GPC_PGC_C1); }
> > +
> > +void __init imx_gpcv2_check_dt(void)
> > +{
> > +	struct device_node *np;
> > +
> > +	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-gpc");
> > +	if (WARN_ON(!np))
> > +		return;
> > +
> > +	gpcv2_base = of_iomap(np, 0);
> > +	WARN_ON(!gpcv2_base);
> 
> What happens if gpcv2_base is NULL (apart from the obvious warning from the
> above line)?  I guess a bit later in the boot,
> imx_gpcv2_set_core1_pdn_pup_by_software() oopses the kernel, probably
> before the console has been initialised.  Probably not nice behaviour.
>

Yes, normal console is NOT ready at this stage, unless early console is enabled.

Could you please advise how to handle such case if gpcv2_base is NULL and console is NOT
ready? Checking gpcv2_base everywhere before using it? Normally gpcv2_base
should NOT be NULL. 

Thanks.
Anson
 
> > +}
> > --
> > 1.9.1
> >
> 
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
