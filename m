From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 05 Apr 2013 11:56:48 +0200
Subject: [PATCH 1/5 v2] mv643xx_eth: add Device Tree bindings
In-Reply-To: <20130404212906.GA25904@schnuecks.de>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1365071235-11611-2-git-send-email-florian@openwrt.org>
 <20130404212906.GA25904@schnuecks.de>
Message-ID: <515E9FE0.8050402@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

First of all, thanks for getting these patches a try!

Le 04/04/13 23:29, Simon Baatz a ?crit :
> Hi Florian
>

[snip]

>>   	if (!mv643xx_eth_version_printed++)
>>   		pr_notice("MV-643xx 10/100/1000 ethernet driver version %s\n",
>
> This is not related to your change, but there is a problem in this
> function that has already been discussed in the past if I remember
> correctly: The respective clock needs to be enabled here (at least
> on Kirkwood), since accesses to the hardware are done below.
> Enabling the clock only in mv643xx_eth_probe() is too late.
>
> As said, this is not a problem introduced by your changes (and which
> is currently circumvented by enabling the respective clocks in
> kirkwood_legacy_clk_init() and kirkwood_ge0x_init()), but we might
> want to fix this now to get rid of unconditionally enabling the GE
> clocks in the DT case.

I think there may have been some confusion between the "ethernet-group" 
clock and the actual Ethernet port inside the "ethernet-group". The 
mv643xx_eth driver assumes we have a per-port clock gating scheme, while 
I think we have a per "ethernet-group" clock gating scheme instead. Like 
you said, I think this should be addressed separately.

[snip]

>
> You don't change the clk initialization here:
>
> #if defined(CONFIG_HAVE_CLK)
> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
> 	if (!IS_ERR(mp->clk)) {
> 		clk_prepare_enable(mp->clk);
> 		mp->t_clk = clk_get_rate(mp->clk);
> 	}
> #endif
>
> Which, if I understand correctly, works in the DT case because you
> assign "clock-names" to the clocks in the DTS. However, I wonder
> whether this works for any but the first Ethernet device.
>
> In the old platform device setup, the pdev->id was set when
> initialiazing the platform_device structure in common.c.  Where is
> this done in the DT case?

Looks like you are right, in the DT case, I assume that we should lookup 
the clock using NULL instead of "1" or "0" so we match any clock instead 
of a specific one.

[snip]

>
>
> In phy_scan(), the phy is searched like this:
>
> 		snprintf(phy_id, sizeof(phy_id), PHY_ID_FMT,
> 				"orion-mdio-mii", addr);
>
> 		phydev = phy_connect(mp->dev, phy_id, mv643xx_eth_adjust_link,
> 				PHY_INTERFACE_MODE_GMII);
>
> But "orion-mdio-mii:xx" is the name of the PHY if MDIO is setup via a
> platform_device. I could not get this to work if the MDIO device is
> setup via DT. Am I doing something wrong?

I just missed updating this part of the code to probe for PHYs. The 
board I tested with uses a "PHY_NONE" configuration. I will add the 
missing bits for of_phy_connect() to be called here.

>
>
> Additionally, in phy_scan() there is this:
>
> 	if (phy_addr == MV643XX_ETH_PHY_ADDR_DEFAULT) {
> 		start = phy_addr_get(mp) & 0x1f;
> 		num = 32;
> 	} else {
> 	...
>
> MV643XX_ETH_PHY_ADDR_DEFAULT is defined as 0. However, many Kirkwood
> devices use "MV643XX_ETH_PHY_ADDR(0)".  If the module probe is
> deferred in mv643xx_eth because the MDIO driver is not yet loaded,
> all 32 PHY addresses are scanned without success.  This is not needed
> and clutters the log.

Ok, I am not sure how we can circumvent the log cluttering that happens, 
what would be your suggestion?
--
Florian
