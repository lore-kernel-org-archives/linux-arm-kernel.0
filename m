From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 25 May 2013 09:26:56 +0200
Subject: [PATCH] ARM: at91: Fix link breakage when !CONFIG_PHY
In-Reply-To: <1369433942-12386-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1369433942-12386-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <51A067C0.4040104@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Scrap that, I'll send a v2.

Regards

On 25/05/2013 00:19, Alexandre Belloni wrote:
> Fixes:
> arch/arm/mach-at91/built-in.o: In function `ksz9021rn_phy_fixup':
> :(.text+0x1174): undefined reference to `mdiobus_write'
> :(.text+0x1188): undefined reference to `mdiobus_write'
> :(.text+0x119c): undefined reference to `mdiobus_write'
> :(.text+0x11b0): undefined reference to `mdiobus_write'
> arch/arm/mach-at91/built-in.o: In function `sama5_dt_device_init':
> :(.init.text+0x1e34): undefined reference to
> `phy_register_fixup_for_uid'
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/board-dt-sama5.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/mach-at91/board-dt-sama5.c b/arch/arm/mach-at91/board-dt-sama5.c
> index 705305e..f510381 100644
> --- a/arch/arm/mach-at91/board-dt-sama5.c
> +++ b/arch/arm/mach-at91/board-dt-sama5.c
> @@ -38,6 +38,7 @@ static void __init at91_dt_init_irq(void)
>  	of_irq_init(irq_of_match);
>  }
>  
> +#ifdef CONFIG_PHY
>  static int ksz9021rn_phy_fixup(struct phy_device *phy)
>  {
>  	int value;
> @@ -59,12 +60,15 @@ static int ksz9021rn_phy_fixup(struct phy_device *phy)
>  
>  	return 0;
>  }
> +#endif
>  
>  static void __init sama5_dt_device_init(void)
>  {
> +#ifdef CONFIG_PHY
>  	if (of_machine_is_compatible("atmel,sama5d3xcm"))
>  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  			ksz9021rn_phy_fixup);
> +#endif
>  
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
