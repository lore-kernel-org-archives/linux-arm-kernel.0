From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Tue, 6 Mar 2018 06:02:08 +0000
Subject: [PATCH 2/2][v5] driver: mtd: update struct map_info's swap as per
 map requirement
In-Reply-To: <20180228073335.1758-2-prabhakar.kushwaha@nxp.com>
References: <20180228073335.1758-1-prabhakar.kushwaha@nxp.com>
 <20180228073335.1758-2-prabhakar.kushwaha@nxp.com>
Message-ID: <HE1PR04MB1241B7EE0E3905E20214C2A797D90@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boris,

> -----Original Message-----
> From: Prabhakar Kushwaha
> Sent: Wednesday, February 28, 2018 1:04 PM
> To: linux-mtd at lists.infradead.org; devicetree at vger.kernel.org;
> robh at kernel.org; mark.rutland at arm.com; shawnguo at kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; boris.brezillon at free-
> electrons.com; cyrille.pitchen at wedev4u.fr; computersforpeace at gmail.com;
> oss at buserror.net; Leo Li <leoyang.li@nxp.com>; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; Jagdish Gediya
> <jagdish.gediya@nxp.com>
> Subject: [PATCH 2/2][v5] driver: mtd: update struct map_info's swap as per
> map requirement
> 
> It is not necessary for all device's maps to be CFI_HOST_ENDIAN.
> Maps device can be Big endian or little endian.
> 
> Currently it is being taken care using CONFIG_MTD_CFI_LE_BYTE_SWAP or
> CONFIG_MTD_CFI_BE_BYTE_SWAP i.e. compile time.
> 
> Now update struct map_info's swap field based on device characteristics
> defined in device tree.
> 
> Signed-off-by: Jagdish Gediya <jagdish.gediya@nxp.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
> Changes for v2: Incorporated review comments from Boris Brezillon
> http://patchwork.ozlabs.org/patch/758381/
> Changes for v3: None
> Changes for v4: Updated code as per new defined binding of physmap.txt
> Changes for v5: Avoid map.swap set in case of endiannes not defined in dts
> file
> 
>  drivers/mtd/maps/physmap_of_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/maps/physmap_of_core.c
> b/drivers/mtd/maps/physmap_of_core.c
> index b1bd4faecfb2..527b1682381f 100644
> --- a/drivers/mtd/maps/physmap_of_core.c
> +++ b/drivers/mtd/maps/physmap_of_core.c
> @@ -20,6 +20,7 @@
>  #include <linux/mtd/map.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/concat.h>
> +#include <linux/mtd/cfi_endian.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_platform.h>
> @@ -233,6 +234,11 @@ static int of_flash_probe(struct platform_device
> *dev)
>  		info->list[i].map.bankwidth = be32_to_cpup(width);
>  		info->list[i].map.device_node = dp;
> 
> +		if (of_property_read_bool(dp, "big-endian"))
> +			info->list[i].map.swap = CFI_BIG_ENDIAN;
> +		else if (of_property_read_bool(dp, "little-endian"))
> +			info->list[i].map.swap = CFI_LITTLE_ENDIAN;
> +
>  		err = of_flash_probe_gemini(dev, dp, &info->list[i].map);
>  		if (err)
>  			goto err_out;
> --
> 2.14.1

Is this patch correct with respect to device binding (http://patchwork.ozlabs.org/patch/878974/)
May I go ahead and send device tree patches for other NXP platforms

will http://patchwork.ozlabs.org/patch/878974/  along with this patch be send via linux-mtd repo?

--pk
