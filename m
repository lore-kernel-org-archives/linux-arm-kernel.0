From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 18 May 2013 09:27:28 +0800
Subject: [PATCH v3 2/4] ARM: imx: add initial support for MVF600
In-Reply-To: <1368684648-20826-3-git-send-email-b35083@freescale.com>
References: <1368684648-20826-1-git-send-email-b35083@freescale.com>
 <1368684648-20826-3-git-send-email-b35083@freescale.com>
Message-ID: <20130518012726.GA18553@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 02:10:46PM +0800, Jingchang Lu wrote:
> +static void __init mvf600_init_irq(void)
> +{
> +	struct device_node *np;
> +	void __iomem *mscm_base;
> +	int i;
> +
> +	l2x0_of_init(0, ~0UL);
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,mvf600-mscm");
> +	mscm_base = of_iomap(np, 0);
> +	if (!mscm_base)
> +		return;
> +
> +	/* route all shared peripheral interrupts to CP0 */
> +	for (i = 0; i < 111; i++)
> +		__raw_writew(1, mscm_base + 0x880 + 2 * i);

I second Arnd's comment on this.  Can we have this setup done in
bootloader?

Shawn

> +
> +	iounmap(mscm_base);
> +
> +	irqchip_init();
> +}
