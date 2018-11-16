From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Fri, 16 Nov 2018 12:15:31 +0100
Subject: [PATCH v2 3/5] phy: ocelot-serdes: convert to use eth phy mode
 and submode
In-Reply-To: <20181109234755.21687-4-grygorii.strashko@ti.com>
References: <20181109234755.21687-1-grygorii.strashko@ti.com>
 <20181109234755.21687-4-grygorii.strashko@ti.com>
Message-ID: <20181116111530.iqqcchtcnmlssvdp@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

On Fri, Nov 09, 2018 at 05:47:53PM -0600, Grygorii Strashko wrote:
> Convert ocelot-serdes PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 

Thanks for the patch, it's annoying to have to map PHY_MODE_SGMII and
PHY_INTERFACE_MODE_SGMII :)

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/mscc/ocelot.c   |  9 ++-------
>  drivers/phy/mscc/phy-ocelot-serdes.c | 14 ++++++++++----
>  2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
> index 3238b9e..3edb608 100644
> --- a/drivers/net/ethernet/mscc/ocelot.c
> +++ b/drivers/net/ethernet/mscc/ocelot.c
> @@ -472,7 +472,6 @@ static int ocelot_port_open(struct net_device *dev)
>  {
>  	struct ocelot_port *port = netdev_priv(dev);
>  	struct ocelot *ocelot = port->ocelot;
> -	enum phy_mode phy_mode;
>  	int err;
>  
>  	/* Enable receiving frames on the port, and activate auto-learning of
> @@ -484,12 +483,8 @@ static int ocelot_port_open(struct net_device *dev)
>  			 ANA_PORT_PORT_CFG, port->chip_port);
>  
>  	if (port->serdes) {
> -		if (port->phy_mode == PHY_INTERFACE_MODE_SGMII)
> -			phy_mode = PHY_MODE_SGMII;
> -		else
> -			phy_mode = PHY_MODE_QSGMII;
> -
> -		err = phy_set_mode(port->serdes, phy_mode);
> +		err = phy_set_mode_ext(port->serdes, PHY_MODE_ETHERNET,
> +				       port->phy_mode);
>  		if (err) {
>  			netdev_err(dev, "Could not set mode of SerDes\n");
>  			return err;
> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
> index c61a9890..f525a21 100644
> --- a/drivers/phy/mscc/phy-ocelot-serdes.c
> +++ b/drivers/phy/mscc/phy-ocelot-serdes.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> +#include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
> @@ -116,8 +117,10 @@ struct serdes_mux {
>  	.mux = _mux,						\
>  }
>  
> -#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
> -#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
> +#define SERDES_MUX_SGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_SGMII, m, c)
> +#define SERDES_MUX_QSGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_INTERFACE_MODE_QSGMII, m, c)
>  
>  static const struct serdes_mux ocelot_serdes_muxes[] = {
>  	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
> @@ -164,12 +167,15 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  	unsigned int i;
>  	int ret;
>  
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EINVAL;
> +

This works for now because we only support Ethernet muxes for now but
this IP also supports PHY_MODE_PCIE.

It seems weird to me that the day we'll add support for PCIE muxing we
will have in ocelot_serdes_muxes[i].mode either a PHY_INTERFACE_MODE_*
or a PHY_MODE_PCIE. This is not an issue for now since you do the mode
!= PHY_MODE_ETHERNET just above but once we get rid of this, we only
test for submode != ocelot_serdes_muxes[i].mode and both
PHY_INTERFACE_MODE_1000BASEX and PHY_MODE_PCIE will have the same index
thus might be confused.

Should we add a submode to the SERDES_MUX macro, move PHY_MODE_*MII to
this submode and have PHY_MODE_ETHERNET/PCIE in the mode field?

Thanks,
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181116/c7e612a6/attachment.sig>
