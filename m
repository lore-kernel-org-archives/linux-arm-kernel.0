From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 26 Sep 2017 10:58:40 -0400
Subject: [PATCH 05/10] clk: bcm: Add Broadcom Hurricane 2 clock support
In-Reply-To: <20170926000931.670-6-f.fainelli@gmail.com>
References: <20170926000931.670-1-f.fainelli@gmail.com>
 <20170926000931.670-6-f.fainelli@gmail.com>
Message-ID: <CAC3K-4rdV=z1TBtBmw9ngP4rNyvtTgtss23vaY3ZjbTgf8aycA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 8:09 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Add support for the Broadcom Hurricane 2 SoC clock controller. We can
> re-use the existing iProc clock library since the SoC's architecture is
> largely the same as its predecessors.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/clk/bcm/Kconfig   |  9 +++++++++
>  drivers/clk/bcm/Makefile  |  1 +
>  drivers/clk/bcm/clk-hr2.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>  create mode 100644 drivers/clk/bcm/clk-hr2.c
>
> diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
> index 1d9187df167b..4c4bd85f707c 100644
> --- a/drivers/clk/bcm/Kconfig
> +++ b/drivers/clk/bcm/Kconfig
> @@ -30,6 +30,15 @@ config CLK_BCM_CYGNUS
>         help
>           Enable common clock framework support for the Broadcom Cygnus SoC
>
> +config CLK_BCM_HR2
> +       bool "Broadcom Hurricane 2 clock support"
> +       depends on ARCH_BCM_HR2 || COMPILE_TEST
> +       select COMMON_CLK_IPROC
> +       default ARCH_BCM_HR2
> +       help
> +         Enable common clock framework support for the Broadcom Hurricane 2
> +         SoC
> +
>  config CLK_BCM_NSP
>         bool "Broadcom Northstar/Northstar Plus clock support"
>         depends on ARCH_BCM_5301X || ARCH_BCM_NSP || COMPILE_TEST
> diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
> index a0c14fa4aa1e..755144195541 100644
> --- a/drivers/clk/bcm/Makefile
> +++ b/drivers/clk/bcm/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_BCM2835)      += clk-bcm2835.o
>  obj-$(CONFIG_ARCH_BCM2835)     += clk-bcm2835-aux.o
>  obj-$(CONFIG_ARCH_BCM_53573)   += clk-bcm53573-ilp.o
>  obj-$(CONFIG_CLK_BCM_CYGNUS)   += clk-cygnus.o
> +obj-$(CONFIG_CLK_BCM_HR2)      += clk-hr2.o
>  obj-$(CONFIG_CLK_BCM_NSP)      += clk-nsp.o
>  obj-$(CONFIG_CLK_BCM_NS2)      += clk-ns2.o
>  obj-$(CONFIG_CLK_BCM_SR)       += clk-sr.o
> diff --git a/drivers/clk/bcm/clk-hr2.c b/drivers/clk/bcm/clk-hr2.c
> new file mode 100644
> index 000000000000..f7c5b7379475
> --- /dev/null
> +++ b/drivers/clk/bcm/clk-hr2.c
> @@ -0,0 +1,27 @@
> +/*
> + * Copyright (C) 2017 Broadcom
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/err.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +
> +#include "clk-iproc.h"
> +
> +static void __init hr2_armpll_init(struct device_node *node)
> +{
> +       iproc_armpll_setup(node);
> +}
> +CLK_OF_DECLARE(hr2_armpll, "brcm,hr2-armpll", hr2_armpll_init);
> --
> 2.14.1

Per our offline conversation, the LCPLL in HR2 looks to be completely
different than anything on NS/NSP/NS2 product line.  So, that will
need a new driver.  Given that this is sufficient to get the HR2 board
working, then it is acceptable to me.

Thanks,
Jon
