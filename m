From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 28 Nov 2018 10:44:54 +0000
Subject: [RFC PATCH v2 1/3] drivers: amba: Updates to component
 identification for driver matching.
In-Reply-To: <20181128101423.15961-2-mike.leach@linaro.org>
References: <20181128101423.15961-1-mike.leach@linaro.org>
 <20181128101423.15961-2-mike.leach@linaro.org>
Message-ID: <16a3cb27-bc7c-36ff-d8fd-bac17f5fc28d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 28/11/2018 10:14, Mike Leach wrote:
> The CoreSight specification (ARM IHI 0029E), updates the ID register
> requirements for components on an AMBA bus, to cover both traditional
> ARM Primecell type devices, and newer CoreSight and other components.
> 
> The Peripheral ID (PID) / Component ID (CID) pair is extended in certain
> cases to uniquely identify components. CoreSight components related to
> a single function can share Peripheral ID values, and must be further
> identified using a Unique Component Identifier (UCI). e.g. the ETM, CTI,
> PMU and Debug hardware of the A35 all share the same PID.
> 
> Bits 11:8 of the CID are defined to be the device class.
> Class 0xF remains for PrimeCell and legacy components.
> Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> at present.
> Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> 
> The specification futher defines which classes of device use the standard
> CID/PID pair, and when additional ID registers are required.
> 
> The patches provide an update of amba_device and matching code to handle
> the additional registers required for the Class 0x9 (CoreSight) UCI.
> The *data pointer in the amba_id is used by the driver to provide extended
> ID register values for matching.
> 
> CoreSight components where PID/CID pair is currently sufficient for
> unique identification need not provide this additional information.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>   drivers/amba/bus.c       | 49 +++++++++++++++++++++++++++++++++-------
>   include/linux/amba/bus.h | 32 ++++++++++++++++++++++++++
>   2 files changed, 73 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..387ee8f7720b 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -26,19 +26,40 @@
>   
>   #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>   
> -static const struct amba_id *
> -amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +/* called on periphid match and class 0x9 coresight device. */
> +static int
> +amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
>   {
>   	int ret = 0;
> +	struct amba_cs_uci_id *uci;
> +
> +	uci = table->data;
> +
> +	/* no table data - return match on periphid */
> +	if (!uci)
> +		return 1;
> +
> +	if (uci->devarch) {

minor nit: It would be good to check the devarch_mask instead, as we
will be covered if at all there is an expected devarch == 0. But the
mask can never be 0, if we have something to check.

> +		ret = (dev->uci.devtype == uci->devtype) &&
> +		       ((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
> +	} else {
> +		/* devtype only if devarch set to 0 */
> +		ret = dev->uci.devtype == uci->devtype;
> +	}
> +	return ret;
> +}
>   
> +static const struct amba_id *
> +amba_lookup(const struct amba_id *table, struct amba_device *dev)
> +{
>   	while (table->mask) {
> -		ret = (dev->periphid & table->mask) == table->id;
> -		if (ret)
> -			break;
> +		if (((dev->periphid & table->mask) == table->id) &&
> +			((dev->cid != CORESIGHT_CID) ||
> +			 (amba_cs_uci_id_match(table, dev))))
> +			return table;
>   		table++;
>   	}
> -
> -	return ret ? table : NULL;
> +	return NULL;
>   }
>   
>   static int amba_match(struct device *dev, struct device_driver *drv)
> @@ -399,10 +420,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>   			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
>   				(i * 8);
>   
> +		if (cid == CORESIGHT_CID) {
> +			/* set the base to the start of the last 4k block */
> +			void __iomem *csbase = tmp + size - 4096;
> +
> +			dev->uci.devarch =
> +				readl(csbase + UCI_REG_DEVARCH_OFFSET);
> +			dev->uci.devtype =
> +				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> +		}
> +
>   		amba_put_disable_pclk(dev);
>   
> -		if (cid == AMBA_CID || cid == CORESIGHT_CID)
> +		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
>   			dev->periphid = pid;
> +			dev->cid = cid;
> +		}
>   
>   		if (!dev->periphid)
>   			ret = -ENODEV;
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index d143c13bed26..ff0ce0587ee9 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -25,6 +25,36 @@
>   #define AMBA_CID	0xb105f00d
>   #define CORESIGHT_CID	0xb105900d
>   
> +/*
> + * CoreSight Architecture specification updates the ID specification
> + * for components on the AMBA bus. (ARM IHI 0029E)
> + *
> + * Bits 11:8 of the CID are the device class.

I think this should be Bits 15:12 ?

> + *
> + * Class 0xF remains for PrimeCell and legacy components. (AMBA_CID above)
> + * Class 0x9 defines the component as CoreSight (CORESIGHT_CID above)
> + * Class 0x0, 0x1, 0xB, 0xE define components that do not have driver support
> + * at present.
> + * Class 0x2-0x8,0xA and 0xD-0xD are presently reserved.
> + *
> + * Remaining CID bits stay as 0xb105-00d
> + */
> +
> +/*
> + * Class 0x9 components use additional values to form a Unique Component
> + * Identifier (UCI), where peripheral ID values are identical for different
> + * components. Passed to the amba bus code from the component driver via
> + * the amba_id->data pointer.
> + */
> +struct amba_cs_uci_id {
> +	unsigned int devarch;
> +	unsigned int devarch_mask;
> +	unsigned int devtype;
> +};
> +
> +#define UCI_REG_DEVTYPE_OFFSET	0xFCC
> +#define UCI_REG_DEVARCH_OFFSET	0xFBC
> +
>   struct clk;
>   
>   struct amba_device {
> @@ -32,6 +62,8 @@ struct amba_device {
>   	struct resource		res;
>   	struct clk		*pclk;
>   	unsigned int		periphid;
> +	unsigned int		cid;
> +	struct amba_cs_uci_id	uci;
>   	unsigned int		irq[AMBA_NR_IRQS];
>   	char			*driver_override;
>   };
> 

Rest looks fine. With the above addressed,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
