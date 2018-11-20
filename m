From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Tue, 20 Nov 2018 10:18:22 +0100
Subject: [PATCH v3 3/5] phy: ocelot-serdes: convert to use eth phy mode
 and submode
In-Reply-To: <20181120012424.11802-4-grygorii.strashko@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
 <20181120012424.11802-4-grygorii.strashko@ti.com>
Message-ID: <20181120091822.blfreis63eqt6cgg@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

Thanks for the patch!

On Mon, Nov 19, 2018 at 07:24:22PM -0600, Grygorii Strashko wrote:
> Convert ocelot-serdes PHY driver to use recently introduced
> PHY_MODE_ETHERNET and phy_set_mode_ext().
> 
> Cc: Quentin Schulz <quentin.schulz@bootlin.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
Tested-by: Quentin Schulz <quentin.schulz@bootlin.com>

Tested on top of latest master branch of net-next
(e432abfb99e5642a7e7fcaa1c8cb0e80c8fcf58e) on a PCB120 with VSC8584 PHYs
(for reference if we ever find out there is a problem with this patch).

> diff --git a/drivers/phy/mscc/phy-ocelot-serdes.c b/drivers/phy/mscc/phy-ocelot-serdes.c
> index c61a9890..77c46f6 100644
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
> @@ -104,20 +105,24 @@ struct serdes_mux {
>  	u8			idx;
>  	u8			port;
>  	enum phy_mode		mode;
> +	int			submode;
>  	u32			mask;
>  	u32			mux;
>  };
>  
> -#define SERDES_MUX(_idx, _port, _mode, _mask, _mux) {		\
> +#define SERDES_MUX(_idx, _port, _mode, _submode, _mask, _mux) {		\
>  	.idx = _idx,						\
>  	.port = _port,						\
>  	.mode = _mode,						\
> +	.submode = _submode,					\
>  	.mask = _mask,						\
>  	.mux = _mux,						\
>  }
>  
> -#define SERDES_MUX_SGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_SGMII, m, c)
> -#define SERDES_MUX_QSGMII(i, p, m, c) SERDES_MUX(i, p, PHY_MODE_QSGMII, m, c)
> +#define SERDES_MUX_SGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_SGMII, m, c)
> +#define SERDES_MUX_QSGMII(i, p, m, c) \
> +	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
>  
>  static const struct serdes_mux ocelot_serdes_muxes[] = {
>  	SERDES_MUX_SGMII(SERDES1G(0), 0, 0, 0),
> @@ -154,7 +159,7 @@ static const struct serdes_mux ocelot_serdes_muxes[] = {
>  	SERDES_MUX_SGMII(SERDES6G(1), 8, 0, 0),
>  	SERDES_MUX_SGMII(SERDES6G(2), 10, HSIO_HW_CFG_PCIE_ENA |
>  			 HSIO_HW_CFG_DEV2G5_10_MODE, 0),
> -	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, HSIO_HW_CFG_PCIE_ENA,
> +	SERDES_MUX(SERDES6G(2), 10, PHY_MODE_PCIE, 0, HSIO_HW_CFG_PCIE_ENA,
>  		   HSIO_HW_CFG_PCIE_ENA),
>  };
>  
> @@ -164,12 +169,17 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
>  	unsigned int i;
>  	int ret;
>  
> +	/* As of now only PHY_MODE_ETHERNET is supported */
> +	if (mode != PHY_MODE_ETHERNET)
> +		return -EOPNOTSUPP;
> +
>  	for (i = 0; i < ARRAY_SIZE(ocelot_serdes_muxes); i++) {
>  		if (macro->idx != ocelot_serdes_muxes[i].idx ||
> -		    mode != ocelot_serdes_muxes[i].mode)
> +		    mode != ocelot_serdes_muxes[i].mode ||
> +		    submode != ocelot_serdes_muxes[i].submode)
>  			continue;

We will most likely need to rework this to ignore the submode of the
PCIe muxing if the mode is PCIe but let?s figure this out when we add
support for PCIe muxing.

Thanks,
Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/b2c5d0a5/attachment-0001.sig>
