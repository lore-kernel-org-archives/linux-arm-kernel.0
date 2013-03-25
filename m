From: monstr@monstr.eu (Michal Simek)
Date: Mon, 25 Mar 2013 14:57:18 +0100
Subject: [PATCH] ARM: zynq: add smp_twd timer
In-Reply-To: <1364042233-16583-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1364042233-16583-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <CAHTX3d+Fv22h2P9tpYEW6cK=qF3Zjo=hvKDYkOGYd6nfW5hRVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

nice to see patches from you.
I have created bunch of patches last week which targets the similar
areas as you.
I have sent them and you are also in CC.
I will comment your patches and I hope you will also review my patches
and we find out a way how to add them together.

Look below.

Thanks,
Michal




2013/3/23 Steffen Trumtrar <s.trumtrar@pengutronix.de>:
> The zynq has a Cortex-A9 with the corresponding smp_twd timers. Use them.
>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Josh Cartwright <josh.cartwright@ni.com>
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 7 +++++++
>  arch/arm/mach-zynq/common.c      | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
> index 5914b56..0dd2dc7 100644
> --- a/arch/arm/boot/dts/zynq-7000.dtsi
> +++ b/arch/arm/boot/dts/zynq-7000.dtsi
> @@ -162,5 +162,12 @@
>                                 interrupts = <0 39 4>;
>                         };
>                 };
> +
> +               timer: timer at f8f00600 {
> +                       compatible = "arm,cortex-a9-twd-timer";
> +                       reg = <0xf8f00600 0x20>;
> +                       clocks = <&cpu_clk 1>;
> +                       interrupts = <1 13 0xf01>;
> +               };

There is proposal from Soren about clock description but should be ok
just to use what it is in the tree. If you have any comments about
managing zynq clock
please look at that thread too.


>         };
>  };
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 5c89832..920e20a 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -32,6 +32,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/page.h>
>  #include <asm/pgtable.h>
> +#include <asm/smp_twd.h>
>  #include <asm/hardware/cache-l2x0.h>
>
>  #include "common.h"
> @@ -77,6 +78,7 @@ static void __init xilinx_zynq_timer_init(void)
>
>         xilinx_zynq_clocks_init(slcr);
>
> +       twd_local_timer_of_register();

This is wrong because smp_twd has been moved to CLOCKSOURCE_OF_DECLARE
by Rob and it is in the arm-next tree.
Look at my patch. It is solved there.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
