From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 26 Jan 2014 08:32:10 +0100
Subject: [PATCH v2 2/3] ata: sata_mv: fix disk hotplug for Armada 370/XP
 SoCs
In-Reply-To: <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <1389711007-7239-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20140126083210.2998ef12@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Tue, 14 Jan 2014 15:50:06 +0100, Simon Guinot wrote:

> +			if (hpriv->hp_flags & MV_HP_FIX_LP_PHY_CTL) {
> +				void __iomem *lp_phy_addr =
> +					mv_ap_base(link->ap) + LP_PHY_CTL;
> +				/*
> +				 * Set PHY speed according to SControl speed.
> +				 */
> +				if ((val & 0xf0) == 0x10)
> +					writelfl(0x7, lp_phy_addr);
> +				else
> +					writelfl(0x227, lp_phy_addr);
> +			}

I think we could do a little bit better than these magical values.

The datasheet says:

 * bits 12:9, PIN_PHY_GEN_RX. Value 0x0 => 1.5 Gbps, value 0x1 => 3 Gbps
 * bits 8:5, PIN_PHY_GEN_TX. Value 0x0 => 1.5 Gbps, value 0x1 => 3 Gbps
 * bit 2, PIN_PU_TX. Value 0x0 => Power down, value 0x1 => Power up.
 * bit 1, PIN_PU_RX. Value 0x0 => Power down, value 0x1 => Power up.
 * bit 0, PIN_PU_PLL. Value 0x0 => Power down, value 0x1 => Power up.

So maybe something like:

#define PIN_PHY_GEN_1_5		0
#define PIN_PHY_GEN_3		1

#define PIN_PHY_GEN_RX(gen)	((gen) << 9)
#define PIN_PHY_GEN_TX(gen)	((gen) << 5)
#define PIN_PU_TX		BIT(2)
#define PIN_PU_RX		BIT(1)
#define PIN_PU_PLL		BIT(0)


		u32 sata_gen;

		if ((val & 0xf0) == 0x10)
			sata_gen = PIN_PHY_GEN_1_5;
		else
			sata_gen = PIN_PHY_GEN_3;

		writelfl(PIN_PHY_GEN_RX(sata_gen) |
			 PIN_PHY_GEN_TX(sata_gen) |
			 PIN_PU_TX | PIN_PU_RX | PIN_PU_PLL,
			 lp_phy_addr);


> +	/*
> +	 * To allow disk hotplug on Armada 370/XP SoCs, the PHY speed must be
> +	 * updated in the LP_PHY_CTL register.
> +	 */
> +	if (pdev->dev.of_node &&
> +		of_device_is_compatible(pdev->dev.of_node,
> +					"marvell,armada-370-xp-sata"))

Testing whether pdev->dev.of_node is not NULL does not seems to be
useful. A quick read of of_device_is_compatible() and the function it's
calling seem to indicate that of_device_is_compatible will return false
if the passed struct device_node * is NULL.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
