From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 13:41:11 +0200
Subject: [PATCHv3 5/6] ARM: imx: Add initial support for Freescale LS1021A
In-Reply-To: <1410253952-15631-6-git-send-email-jingchang.lu@freescale.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-6-git-send-email-jingchang.lu@freescale.com>
Message-ID: <3532608.xLS91GQkq4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 17:12:31 Jingchang Lu wrote:
> +#include "common.h"
> +
> +static void __init ls1021a_init_machine(void)
> +{
> +       mxc_arch_reset_init_dt();
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
> +static const char *ls1021a_dt_compat[] __initdata = {
> +       "fsl,ls1021a",
> +       NULL,
> +};

Please don't add any new users of mxc_arch_reset_init_dt(). We now
have infrastructure to register a system-reset handler from the
watchdog driver, so please do that instead, and clean up the
existing users as well.

> +DT_MACHINE_START(LS1021A, "Freescale LS1021A")
> +#ifdef CONFIG_ZONE_DMA
> +       .dma_zone_size  = SZ_128M,
> +#endif
> +       .init_machine   = ls1021a_init_machine,
> +       .dt_compat      = ls1021a_dt_compat,
> +       .restart        = mxc_restart,
> +MACHINE_END

I believe someone recently posted a patch to derive the dma_zone_size
from device tree. Can yo try to find that and see if that will work
for you?

Can you explain what the reason is for needing a DMA zone?

	Arnd
