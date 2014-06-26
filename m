From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 26 Jun 2014 16:52:30 +0200
Subject: [PATCH] ARM: mvebu: Enable SCU Speculative linefills to L2 for
 Armada 375/38x
In-Reply-To: <1403790178-23902-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403790178-23902-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140626165230.374f285e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 26 Jun 2014 15:42:58 +0200, Gregory CLEMENT wrote:

> +#define SCU_CTRL		0x00
> +#define SCU_SPEC_LINEFILL_EN	    BIT(3)
> +
> +
>  /*
>   * Enables the SCU when available. Obviously, this is only useful on
>   * Cortex-A based SOCs, not on PJ4B based ones.
> @@ -44,7 +48,15 @@ static void __init mvebu_scu_enable(void)
>  	struct device_node *np =
>  		of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
>  	if (np) {
> +		u32 scu_ctrl;
>  		scu_base = of_iomap(np, 0);
> +		/* already enabled? */
> +		scu_ctrl = __raw_readl(scu_base + SCU_CTRL);

Unless the SCU uses the native endianess of the system, and therefore
switches to big endian when the system is running big endian, using
__raw_{readl,writel} is wrong here, and will break big endian
configurations.

> +		if (!(scu_ctrl & 1)) {

What is this bit 0 you're checking here? How does it relate to the bit
3 you're setting when bit 0 is not set?

A broader question is: if this feature is generic to all Cortex-A9, why
not offer a function in smp_scu.c to enable it? It seems weird to have
the offset and bit definitions for something as generic as the SCU
present deep into a Marvell-specific file.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
