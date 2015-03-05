From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 05 Mar 2015 16:29:26 +0100
Subject: [PATCH v2 5/9] ARM: at91: add soc detection infrastructure
In-Reply-To: <1425557486-3534-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425557486-3534-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425557486-3534-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1425580851.g2DuYFu1co@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Thursday 05 March 2015 13:11:22, Alexandre Belloni wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> Add new structures and functions to handle AT91 SoC detection.
> 
> [alexandre.belloni at free-electrons.com: reworked DBGU detection]
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/Kconfig            |   1 +
>  arch/arm/mach-at91/Makefile |   2 +-
>  arch/arm/mach-at91/soc.c    | 111 ++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/soc.h    |  48 +++++++++++++++++++
>  4 files changed, 161 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-at91/soc.c
>  create mode 100644 arch/arm/mach-at91/soc.h
> 
> [...]
> diff --git a/arch/arm/mach-at91/soc.c b/arch/arm/mach-at91/soc.c
> new file mode 100644
> index 000000000000..227872246fd9
> --- /dev/null
> +++ b/arch/arm/mach-at91/soc.c
> @@ -0,0 +1,111 @@
> +/*
> + * Copyright (C) 2015 Atmel
> + *
> + * Alexandre Belloni <alexandre.belloni@free-electrons.com
> + * Boris Brezillon <boris.brezillon@free-electrons.com
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + *
> + */
> +
> +#define pr_fmt(fmt)	"AT91: " fmt
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#include "soc.h"
> +
> +#define AT91_DBGU_CIDR			0x40
> +#define AT91_DBGU_CIDR_ARCH(x)		(((x) >> 20) & 0xff)
> +#define AT91_DBGU_CIDR_VERSION(x)	((x) & 0x1f)
> +#define AT91_DBGU_CIDR_EXT		BIT(31)
> +#define AT91_DBGU_CIDR_MATCH_MASK	0x7fffffe0
> +#define AT91_DBGU_EXID			0x44
> +
> +struct soc_device * __init at91_soc_init(const struct at91_soc_family *families)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	const struct at91_soc_family *family;
> +	const struct at91_soc *soc;
> +	struct soc_device *soc_dev;
> +	struct device_node *np;
> +	void __iomem *regs;
> +	u32 cidr, exid;
> +
> +
> +	np = of_find_compatible_node(NULL, NULL, "atmel,at91rm9200-dbgu");
> +	if (!np)
> +		np = of_find_compatible_node(NULL, NULL,
> +					     "atmel,at91sam9260-dbgu");
> +
> +	if (!np) {
> +		pr_warn("Could not find DBGU node");
> +		return NULL;
> +	}
> +
> +	regs = of_iomap(np, 0);
> +	of_node_put(np);
> +
> +	if (!regs) {
> +		pr_warn("Could not map DBGU iomem range");
> +		iounmap(regs);

I guess if regs == NULL there is no need to iounmap them, no?

> +		return NULL;
> +	}
> +
> +	cidr = readl(regs + AT91_DBGU_CIDR);
> +	exid = readl(regs + AT91_DBGU_EXID);
> +
> +	iounmap(regs);

Best regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein at systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082
