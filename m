From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 12 Jan 2015 15:52:26 +0100
Subject: [PATCH] ARM: at91: board-dt-sama5: add phy_fixup to override
 NAND_Tree which improperly strapp-in during the reset period.
In-Reply-To: <1418283069-5648-1-git-send-email-wenyou.yang@atmel.com>
References: <1418283069-5648-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <54B3DFAA.9020804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/12/2014 08:31, Wenyou Yang a ?crit :
> Appearance: On some SAMA5D4EK boards, after power up, the Eth1 doesn't work.
> 
> Reason: The PIOE2 pin is connected to the NAND_Tree# of KSZ8081,
> But it outputs LOW during the reset period, which cause the NAND_Tree# enabled.
> 
> Add phy_fixup() to disable NAND_Tree by overriding the Operation
> Mode Strap Override register(i.e. Register 16h) to clear the NAND_Tree bit.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>

Stacked on top of at91-3.19-fixes.

Bye,


> ---
>  arch/arm/mach-at91/board-dt-sama5.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> index 8fb9ef5..97f7367 100644
> --- a/arch/arm/mach-at91/board-dt-sama5.c
> +++ b/arch/arm/mach-at91/board-dt-sama5.c
> @@ -17,6 +17,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/phy.h>
>  #include <linux/clk-provider.h>
> +#include <linux/phy.h>
>  
>  #include <asm/setup.h>
>  #include <asm/irq.h>
> @@ -26,8 +27,25 @@
>  
>  #include "generic.h"
>  
> +static int ksz8081_phy_fixup(struct phy_device *phy)
> +{
> +	int value;
> +
> +	value = phy_read(phy, 0x16);
> +	value &= ~0x20;
> +	phy_write(phy, 0x16, value);
> +
> +	return 0;
> +}
> +
>  static void __init sama5_dt_device_init(void)
>  {
> +	if (of_machine_is_compatible("atmel,sama5d4ek") &&
> +	   IS_ENABLED(CONFIG_PHYLIB)) {
> +		phy_register_fixup_for_id("fc028000.etherne:00",
> +						ksz8081_phy_fixup);
> +	}
> +
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> 


-- 
Nicolas Ferre
