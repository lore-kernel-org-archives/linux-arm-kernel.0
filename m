From: enash54@gmail.com (Ed Nash)
Date: Sun, 21 Apr 2013 13:50:46 +0000 (UTC)
Subject: [PATCH 1/3] ARM/MVF600: add Vybrid Family platform support
References: <1365749825-20601-1-git-send-email-b35083@freescale.com>
 <1365749825-20601-2-git-send-email-b35083@freescale.com>
Message-ID: <loom.20130421T154042-216@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingchang Lu <b35083 <at> freescale.com> writes:

Hi- I'm new to participating so please be kind if I break protocol.

> diff --git a/arch/arm/mach-imx/mach-mvf600.c 
> b/arch/arm/mach-imx/mach-mvf600.c
> +
> +static void __init mvf_of_init_irq(void)
> +{
> +	struct device_node *np;
> +	void __iomem *mscm_base;
> +	int i;
> +
> +	l2x0_of_init(0, ~0UL);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf-mscm");
> +	mscm_base = of_iomap(np, 0);
> +	if (!mscm_base)
> +		return;
> +
> +	for (i = 0; i < 128; i++)
> +		__raw_writew(1, mscm_base + 0x880 + 2 * i);

This is a problem if the M4 core program boots first and routes any interrupts
to itself. This should be an OR function with the existing bits so as not to
reset M4 bits.
