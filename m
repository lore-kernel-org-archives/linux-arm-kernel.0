From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 26 Jan 2014 09:17:53 +0100
Subject: [PATCH v4 08/18] watchdog: orion: Make RSTOUT register a
 separate resource
In-Reply-To: <1390431915-5115-9-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-9-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140126091753.2910a39f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Jan 2014 20:05:05 -0300, Ezequiel Garcia wrote:

> +/* RSTOUT mask register physical address for Orion5x, Kirkwood and Dove */
> +#define ORION_RSTOUT_MASK_OFFSET	0x20108
> +
> +/* Internal registers can be configured at any 1 MiB aligned address */
> +#define INTERNAL_REGS_MASK		~(SZ_1M - 1)

I'm not a big fan of hardcoding the internal register window size in a
driver. I would have preferred to have used the offset between the
watchdog registers and the rstout register, but since this one is
*before* the watchdog registers, it would have to be a negative offset.
Not sure how to handle this.

> +/*
> + * The original devicetree binding for this driver specified only
> + * one memory resource, so in order to keep DT backwards compatibility
> + * we try to fallback to a hardcoded register address, if the resource
> + * is missing from the devicetree.
> + */
> +static void __iomem *try_rstout_ioremap(struct platform_device *pdev,
> +					phys_addr_t internal_regs)

Why is it called "try" ? It actually does the mapping. So I would
prefer the function to be named:

	orion_wdt_ioremap_rstout()

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
