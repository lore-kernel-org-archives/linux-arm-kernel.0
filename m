From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 22 Apr 2016 16:34:08 +0300
Subject: [PATCH net v2 3/3] drivers: net: cpsw: use of_phy_connect() in
 fixed-link case
In-Reply-To: <1461264066-12358-1-git-send-email-drivshin.allworx@gmail.com>
References: <1461261035-5578-1-git-send-email-drivshin.allworx@gmail.com>
 <1461264066-12358-1-git-send-email-drivshin.allworx@gmail.com>
Message-ID: <571A2850.30700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2016 09:41 PM, David Rivshin (Allworx) wrote:
> From: David Rivshin <drivshin@allworx.com>
>
> If a fixed-link DT subnode is used, the phy_device was looked up so
> that a PHY ID string could be constructed and passed to phy_connect().
> This is not necessary, as the device_node can be passed directly to
> of_phy_connect() instead. This reuses the same codepath as if the
> phy-handle DT property was used.
>
> Signed-off-by: David Rivshin <drivshin@allworx.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> ---
>
> Changes since v1 [1]:
> - Rebased (trivial conflict, e5a03bfd modified the deleted snprintf)
> - Added Tested-by from Nicolas Chauvet
>
> [1] https://patchwork.ozlabs.org/patch/560327/
>

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>
>   drivers/net/ethernet/ti/cpsw.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 3c81413..245f919 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -2038,30 +2038,21 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
>   							"phy-handle", 0);
>   		parp = of_get_property(slave_node, "phy_id", &lenp);
>   		if (slave_data->phy_node) {
>   			dev_dbg(&pdev->dev,
>   				"slave[%d] using phy-handle=\"%s\"\n",
>   				i, slave_data->phy_node->full_name);
>   		} else if (of_phy_is_fixed_link(slave_node)) {
> -			struct device_node *phy_node;
> -			struct phy_device *phy_dev;
> -
>   			/* In the case of a fixed PHY, the DT node associated
>   			 * to the PHY is the Ethernet MAC DT node.
>   			 */
>   			ret = of_phy_register_fixed_link(slave_node);
>   			if (ret)
>   				return ret;
> -			phy_node = of_node_get(slave_node);
> -			phy_dev = of_phy_find_device(phy_node);
> -			if (!phy_dev)
> -				return -ENODEV;
> -			snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
> -				 PHY_ID_FMT, phy_dev->mdio.bus->id,
> -				 phy_dev->mdio.addr);
> +			slave_data->phy_node = of_node_get(slave_node);
>   		} else if (parp) {
>   			u32 phyid;
>   			struct device_node *mdio_node;
>   			struct platform_device *mdio;
>
>   			if (lenp != (sizeof(__be32) * 2)) {
>   				dev_err(&pdev->dev, "Invalid slave[%d] phy_id property\n", i);
>


-- 
regards,
-grygorii
