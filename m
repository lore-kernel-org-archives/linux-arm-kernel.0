From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 5 Jul 2011 11:35:12 -0600
Subject: [PATCH v2 1/3] dt/net: add helper function of_get_phy_mode
In-Reply-To: <1309878839-25743-2-git-send-email-shawn.guo@linaro.org>
References: <1309878839-25743-1-git-send-email-shawn.guo@linaro.org>
	<1309878839-25743-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACxGe6sA5XRJXpJTYC_ZrFUM_YrQOtzJbXK6ANg5W_E3fi0vEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 9:13 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> It adds the helper function of_get_phy_mode getting phy interface
> from device tree.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Dave, this should probably get merged via your tree since the rest of
this series depends on it.

g.

> ---
> ?drivers/of/of_net.c ? ?| ? 43 +++++++++++++++++++++++++++++++++++++++++++
> ?include/linux/of_net.h | ? ?1 +
> ?2 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> index 86f334a..cc117db 100644
> --- a/drivers/of/of_net.c
> +++ b/drivers/of/of_net.c
> @@ -8,6 +8,49 @@
> ?#include <linux/etherdevice.h>
> ?#include <linux/kernel.h>
> ?#include <linux/of_net.h>
> +#include <linux/phy.h>
> +
> +/**
> + * It maps 'enum phy_interface_t' found in include/linux/phy.h
> + * into the device tree binding of 'phy-mode', so that Ethernet
> + * device driver can get phy interface from device tree.
> + */
> +static const char *phy_modes[] = {
> + ? ? ? [PHY_INTERFACE_MODE_MII] ? ? ? ?= "mii",
> + ? ? ? [PHY_INTERFACE_MODE_GMII] ? ? ? = "gmii",
> + ? ? ? [PHY_INTERFACE_MODE_SGMII] ? ? ?= "sgmii",
> + ? ? ? [PHY_INTERFACE_MODE_TBI] ? ? ? ?= "tbi",
> + ? ? ? [PHY_INTERFACE_MODE_RMII] ? ? ? = "rmii",
> + ? ? ? [PHY_INTERFACE_MODE_RGMII] ? ? ?= "rgmii",
> + ? ? ? [PHY_INTERFACE_MODE_RGMII_ID] ? = "rgmii-id",
> + ? ? ? [PHY_INTERFACE_MODE_RGMII_RXID] = "rgmii-rxid",
> + ? ? ? [PHY_INTERFACE_MODE_RGMII_TXID] = "rgmii-txid",
> + ? ? ? [PHY_INTERFACE_MODE_RTBI] ? ? ? = "rtbi",
> +};
> +
> +/**
> + * of_get_phy_mode - Get phy mode for given device_node
> + * @np: ? ? ? ?Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'phy-mode',
> + * and return its index in phy_modes table, or errno in error case.
> + */
> +const int of_get_phy_mode(struct device_node *np)
> +{
> + ? ? ? const char *pm;
> + ? ? ? int err, i;
> +
> + ? ? ? err = of_property_read_string(np, "phy-mode", &pm);
> + ? ? ? if (err < 0)
> + ? ? ? ? ? ? ? return err;
> +
> + ? ? ? for (i = 0; i < ARRAY_SIZE(phy_modes); i++)
> + ? ? ? ? ? ? ? if (!strcasecmp(pm, phy_modes[i]))
> + ? ? ? ? ? ? ? ? ? ? ? return i;
> +
> + ? ? ? return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(of_get_phy_mode);
>
> ?/**
> ?* Search the device tree for the best MAC address to use. ?'mac-address' is
> diff --git a/include/linux/of_net.h b/include/linux/of_net.h
> index e913081..f474641 100644
> --- a/include/linux/of_net.h
> +++ b/include/linux/of_net.h
> @@ -9,6 +9,7 @@
>
> ?#ifdef CONFIG_OF_NET
> ?#include <linux/of.h>
> +extern const int of_get_phy_mode(struct device_node *np);
> ?extern const void *of_get_mac_address(struct device_node *np);
> ?#endif
>
> --
> 1.7.4.1
>
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
