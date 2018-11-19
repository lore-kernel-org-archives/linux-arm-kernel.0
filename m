From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Nov 2018 17:07:32 +0000
Subject: [PATCH v2 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
In-Reply-To: <20181109234755.21687-5-grygorii.strashko@ti.com>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-5-grygorii.strashko@ti.com>
Message-ID: <20181119170732.GB30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 05:47:54PM -0600, Grygorii Strashko wrote:
> Convert mvebu-cp110-comphy PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 19 +-----
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c    | 83 ++++++++++++++-----------
>  2 files changed, 48 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 7a37a37..731793a 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1165,28 +1165,13 @@ static void mvpp22_gop_setup_irq(struct mvpp2_port *port)
>   */
>  static int mvpp22_comphy_init(struct mvpp2_port *port)
>  {
> -	enum phy_mode mode;
>  	int ret;
>  
>  	if (!port->comphy)
>  		return 0;
>  
> -	switch (port->phy_interface) {
> -	case PHY_INTERFACE_MODE_SGMII:
> -	case PHY_INTERFACE_MODE_1000BASEX:
> -		mode = PHY_MODE_SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_2500BASEX:
> -		mode = PHY_MODE_2500SGMII;
> -		break;
> -	case PHY_INTERFACE_MODE_10GKR:
> -		mode = PHY_MODE_10GKR;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	ret = phy_set_mode(port->comphy, mode);
> +	ret = phy_set_mode_ext(port->comphy, PHY_MODE_ETHERNET,
> +			       port->phy_interface);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> index 79b52c3..7dee72b 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> @@ -9,6 +9,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -131,26 +132,26 @@ struct mvebu_comhy_conf {
>  
>  static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
>  	/* lane 0 */
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(0, 1, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 1 */
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(1, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(1, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  	/* lane 2 */
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_2500SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(2, 0, PHY_MODE_10GKR, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_2500BASEX, 0x1),
> +	MVEBU_COMPHY_CONF(2, 0, PHY_INTERFACE_MODE_10GKR, 0x1),
>  	/* lane 3 */
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(3, 1, PHY_MODE_2500SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(3, 1, PHY_INTERFACE_MODE_2500BASEX, 0x2),
>  	/* lane 4 */
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_2500SGMII, 0x2),
> -	MVEBU_COMPHY_CONF(4, 0, PHY_MODE_10GKR, 0x2),
> -	MVEBU_COMPHY_CONF(4, 1, PHY_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_SGMII, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_2500BASEX, 0x2),
> +	MVEBU_COMPHY_CONF(4, 0, PHY_INTERFACE_MODE_10GKR, 0x2),
> +	MVEBU_COMPHY_CONF(4, 1, PHY_INTERFACE_MODE_SGMII, 0x1),
>  	/* lane 5 */
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_SGMII, 0x1),
> -	MVEBU_COMPHY_CONF(5, 2, PHY_MODE_2500SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_SGMII, 0x1),
> +	MVEBU_COMPHY_CONF(5, 2, PHY_INTERFACE_MODE_2500BASEX, 0x1),
>  };
>  
>  struct mvebu_comphy_priv {
> @@ -163,10 +164,12 @@ struct mvebu_comphy_lane {
>  	struct mvebu_comphy_priv *priv;
>  	unsigned id;
>  	enum phy_mode mode;
> +	int submode;
>  	int port;
>  };
>  
> -static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
> +static int mvebu_comphy_get_mux(int lane, int port,
> +				enum phy_mode mode, int submode)
>  {
>  	int i, n = ARRAY_SIZE(mvebu_comphy_cp110_modes);
>  
> @@ -177,7 +180,7 @@ static int mvebu_comphy_get_mux(int lane, int port, enum phy_mode mode)
>  	for (i = 0; i < n; i++) {
>  		if (mvebu_comphy_cp110_modes[i].lane == lane &&
>  		    mvebu_comphy_cp110_modes[i].port == port &&
> -		    mvebu_comphy_cp110_modes[i].mode == mode)
> +		    mvebu_comphy_cp110_modes[i].mode == submode)

This looks like it could be a future source of problems, since we
have both a "mode" and a "submode".  Is there any reason not to
rename mvebu_comphy_cp110_modes's .mode member to be .submode ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
