From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Nov 2018 13:57:37 -0700
Subject: [RFC PATCH 1/3] drivers: amba: Updates to component
 identification for driver matching.
In-Reply-To: <20181115012842.2353-2-mike.leach@linaro.org>
References: <20181115012842.2353-1-mike.leach@linaro.org>
 <20181115012842.2353-2-mike.leach@linaro.org>
Message-ID: <20181120205737.GA17267@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Thu, Nov 15, 2018 at 01:28:40AM +0000, Mike Leach wrote:
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
>  drivers/amba/bus.c       | 48 ++++++++++++++++++++++++++++++++++++----
>  include/linux/amba/bus.h | 33 +++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 41b706403ef7..6eab977f4314 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -26,6 +26,28 @@
>  
>  #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
>  
> +/* called on periphid match and class 0x9 coresight device. */
> +static int amba_uci_match(const struct amba_id *table, struct amba_device *dev)
> +{
> +	int ret = 0;
> +	struct amba_cs_uci_id *uci;
> +
> +	uci = table->data;
> +
> +	/* no table data - return match on periphid */
> +	if (!uci)
> +		return 1;
> +
> +	if (uci->devarch) {
> +		ret = (dev->uci.devtype == uci->devtype) &&
> +		       ((dev->uci.devarch & uci->mask) == uci->devarch);
> +	} else {
> +		/* devtype only if devarch set to 0 */
> +		ret = dev->uci.devtype == uci->devtype;
> +	}
> +	return ret;
> +}
> +
>  static const struct amba_id *
>  amba_lookup(const struct amba_id *table, struct amba_device *dev)
>  {
> @@ -33,11 +55,17 @@ amba_lookup(const struct amba_id *table, struct amba_device *dev)
>  
>  	while (table->mask) {
>  		ret = (dev->periphid & table->mask) == table->id;
> -		if (ret)
> -			break;
> +		/* matched on periphid - check UCI if CoreSight */
> +		if (ret) {
> +			if (dev->cid == CORESIGHT_CID)	{
> +				ret = amba_uci_match(table, dev);
> +				if (ret)
> +					break;
> +			} else
> +				break;
> +		}
>  		table++;
>  	}
> -

Carefull with the line removal.

>  	return ret ? table : NULL;
>  }
>  
> @@ -399,10 +427,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>  			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
>  				(i * 8);
>  
> +		if (cid == CORESIGHT_CID) {
> +			/* set the base to the start of the last 4k block */
> +			void __iomem *csbase = tmp + size - 4096;
> +
> +			dev->uci.devarch =
> +				readl(csbase + UCI_REG_DEVARCH_OFFSET);
> +			dev->uci.devtype =
> +				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;

Any reason for not masking @devarch the same way you're doing for @devtype?  If
we were to mask here we wouldn't have to carry the mask in struct amba_cs_uci_id
and deal with it in amba_uci_match().

Russell King maintains AMBA.  Please address your next revision to him and CC
the rest of us, as specified by get_maintainer.pl.

Thanks,
Mathieu

> +		}
> +
>  		amba_put_disable_pclk(dev);
>  
> -		if (cid == AMBA_CID || cid == CORESIGHT_CID)
> +		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
>  			dev->periphid = pid;
> +			dev->cid = cid;
> +		}
>  
>  		if (!dev->periphid)
>  			ret = -ENODEV;
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index d143c13bed26..a83a0a3dece8 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -25,6 +25,36 @@
>  #define AMBA_CID	0xb105f00d
>  #define CORESIGHT_CID	0xb105900d
>  
> +/*
> + * CoreSight Architecture specification updates the ID specification
> + * for components on the AMBA bus. (ARM IHI 0029E)
> + *
> + * Bits 11:8 of the CID are the device class.
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
> +	unsigned int mask;
> +	unsigned int devtype;
> +};
> +
> +#define UCI_REG_DEVTYPE_OFFSET	0xFCC
> +#define UCI_REG_DEVARCH_OFFSET	0xFBC
> +
>  struct clk;
>  
>  struct amba_device {
> @@ -32,6 +62,8 @@ struct amba_device {
>  	struct resource		res;
>  	struct clk		*pclk;
>  	unsigned int		periphid;
> +	unsigned int		cid;
> +	struct amba_cs_uci_id	uci;
>  	unsigned int		irq[AMBA_NR_IRQS];
>  	char			*driver_override;
>  };
> @@ -61,6 +93,7 @@ enum amba_vendor {
>  	(((conf) & 0xff) << 24 | ((rev) & 0xf) << 20 | \
>  	AMBA_VENDOR_LINUX << 12 | ((part) & 0xfff))
>  
> +
>  extern struct bus_type amba_bustype;
>  
>  #define to_amba_device(d)	container_of(d, struct amba_device, dev)
> -- 
> 2.19.1
> 
