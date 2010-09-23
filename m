From: olof@lixom.net (Olof Johansson)
Date: Thu, 23 Sep 2010 10:22:33 -0500
Subject: [PATCH v2 3/3] [ARM] tegra: harmony: enable PCI Express
In-Reply-To: <4ca30e894db667875888e55b9281247b398489a9.1285070872.git.mike@compulab.co.il>
References: <cover.1285070872.git.mike@compulab.co.il>
	<4ca30e894db667875888e55b9281247b398489a9.1285070872.git.mike@compulab.co.il>
Message-ID: <20100923152233.GA3966@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 21, 2010 at 02:17:52PM +0200, Mike Rapoport wrote:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> CC: Colin Cross <ccross@google.com>
> CC: Gary King <GKing@nvidia.com>
> ---
>  arch/arm/mach-tegra/Makefile             |    1 +
>  arch/arm/mach-tegra/board-harmony-pcie.c |   52 ++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-tegra/board-harmony-pcie.c
> 
> diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
> index 23c9600..60f73c7 100644
> --- a/arch/arm/mach-tegra/Makefile
> +++ b/arch/arm/mach-tegra/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
>  
>  obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
>  obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
> +obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
> diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
> new file mode 100644
> index 0000000..824c0a1
> --- /dev/null
> +++ b/arch/arm/mach-tegra/board-harmony-pcie.c
> @@ -0,0 +1,52 @@
> +/*
> + * arch/arm/mach-tegra/board-harmony-pcie.c
> + *
> + * Copyright (C) 2010 CompuLab, Ltd.
> + * Mike Rapoport <mike@compulab.co.il>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio.h>
> +#include <linux/err.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <mach/pinmux.h>
> +#include "board.h"
> +
> +#ifdef CONFIG_TEGRA_PCI
> +
> +static int __init harmony_pcie_init(void)
> +{
> +	int err;
> +
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_GPV, TEGRA_TRI_NORMAL);
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXA, TEGRA_TRI_NORMAL);
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXK, TEGRA_TRI_NORMAL);
> +
> +	err = tegra_pcie_init(true, true);
> +	if (err)
> +		goto err_pcie;
> +
> +	return 0;
> +
> +err_pcie:
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_GPV, TEGRA_TRI_TRISTATE);
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXA, TEGRA_TRI_TRISTATE);
> +	tegra_pinmux_set_tristate(TEGRA_PINGROUP_SLXK, TEGRA_TRI_TRISTATE);
> +
> +	return err;
> +}
> +
> +subsys_initcall(harmony_pcie_init);

Hi,

This isn't multiboard-friendly, since this will run on all boards
that are built-in.  Please either check for the platform at the beginning
and abort, or call this explicitly from another board init function.



-Olof
