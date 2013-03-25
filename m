From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 15:04:36 +0100
Subject: [PATCH 2/3] ARM: zynq: get slcr base earlier
In-Reply-To: <1364043450-18700-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1364043450-18700-1-git-send-email-s.trumtrar@pengutronix.de>
 <1364043450-18700-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3dJDTvs4UXoTa_8u4M83fQ9N2n96ecZzFjaXLsXkp_vWjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> The slcr is needed for pinctrl, clocks and reset. Therefore we want it as early
> as possible. As there is no driver that handles it and instead a pointer needs
> to be passed around, rename the variable to something a little more obvious.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>  arch/arm/mach-zynq/common.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 014131c..1b9bb3d 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -38,6 +38,7 @@
>
>  #include "common.h"
>
> +void __iomem *slcr_base_addr;
>  void __iomem *scu_base;
>
>  static struct of_device_id zynq_of_bus_ids[] __initdata = {
> @@ -61,19 +62,21 @@ static void __init xilinx_init_machine(void)
>
>  static void __init xilinx_zynq_timer_init(void)
>  {
> -       struct device_node *np;
> -       void __iomem *slcr;
> -
> -       np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
> -       slcr = of_iomap(np, 0);
> -       WARN_ON(!slcr);
> -
> -       xilinx_zynq_clocks_init(slcr);
> +       xilinx_zynq_clocks_init(slcr_base_addr);
>
>         twd_local_timer_of_register();
>         xttcps_timer_init();
>  }
>
> +static void zynq_slcr_init(void)
> +{
> +       struct device_node *np;
> +
> +       np = of_find_compatible_node(NULL, NULL, "xlnx,zynq-slcr");
> +       slcr_base_addr = of_iomap(np, 0);
> +       WARN_ON(!slcr_base_addr);
> +}

Xilinx is using separate driver for slcr and IMHO make sense to have it
like that because this IP can handle more things which will be just messy
to have it in one file.
What do you think?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
