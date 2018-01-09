From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jan 2018 14:44:48 +0000
Subject: [PATCH net-next v3 4/4] net: mvpp2: 2500baseX support
In-Reply-To: <20180109085945.11916-5-antoine.tenart@free-electrons.com>
References: <20180109085945.11916-1-antoine.tenart@free-electrons.com>
 <20180109085945.11916-5-antoine.tenart@free-electrons.com>
Message-ID: <20180109144447.GI17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 09:59:45AM +0100, Antoine Tenart wrote:
> This patch adds the 2500Base-X PHY mode support in the Marvell PPv2
> driver. 2500Base-X is quite close to 1000Base-X and SGMII modes and uses
> nearly the same code path.

Sorry, also...

> @@ -4668,6 +4692,10 @@ static void mvpp2_port_mii_gmac_configure_mode(struct mvpp2_port *port)
>  		 */
>  		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
>  		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;
> +	else if (port->phy_interface == PHY_INTERFACE_MODE_2500BASEX)
> +		val |= MVPP2_GMAC_CONFIG_GMII_SPEED |
> +		       MVPP2_GMAC_CONFIG_MII_SPEED |
> +		       MVPP2_GMAC_CONFIG_FULL_DUPLEX;

I think you'll find you don't need to set MII_SPEED here, since
MII_SPEED selects between 10 and 100, GMII_SPEED always takes
precidence selecting 1000, and 2500 is done by the comphy
increasing the clocks by 2.5x.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
