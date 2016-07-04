From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 4 Jul 2016 14:31:43 +0200
Subject: [RFC PATCH v2 2/4] net: ethernet: xilinx: Add gmii2rgmii
 converter support
In-Reply-To: <C246CAC1457055469EF09E3A7AC4E11A4A5BB227@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1467623084-15471-1-git-send-email-appanad@xilinx.com>
 <1467623084-15471-3-git-send-email-appanad@xilinx.com>
 <577A323A.4080207@atmel.com>
 <C246CAC1457055469EF09E3A7AC4E11A4A5BB227@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <577A572F.1050004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/07/2016 13:47, Appana Durga Kedareswara Rao a ?crit :
> Hi Nicolas,
> 
> 	Thanks for the review...
> 
>>> diff --git a/include/linux/xilinx_gmii2rgmii.h
>>> b/include/linux/xilinx_gmii2rgmii.h
>>> new file mode 100644
>>> index 0000000..b328ee7
>>> --- /dev/null
>>> +++ b/include/linux/xilinx_gmii2rgmii.h
>>> @@ -0,0 +1,24 @@
>>
>>
>> Here, header of the file seems needed.
> 
> Sure will fix in the next version...
> 
>>
>>> +#ifndef _GMII2RGMII_H
>>> +#define _GMII2RGMII_H
>>> +
>>> +#include <linux/of.h>
>>> +#include <linux/phy.h>
>>> +#include <linux/mii.h>
>>> +
>>> +#define XILINX_GMII2RGMII_FULLDPLX		BMCR_FULLDPLX
>>> +#define XILINX_GMII2RGMII_SPEED1000		BMCR_SPEED1000
>>> +#define XILINX_GMII2RGMII_SPEED100		BMCR_SPEED100
>>> +#define XILINX_GMII2RGMII_REG_NUM			0x10
>>> +
>>> +struct gmii2rgmii {
>>> +	struct net_device	*dev;
>>> +	struct mii_bus		*mii_bus;
>>> +	struct phy_device	*gmii2rgmii_phy_dev;
>>> +	void			*platform_data;
>>> +	int (*mdio_write)(struct mii_bus *bus, int mii_id, int reg,
>>> +			  u16 val);
>>> +	void (*fix_mac_speed)(struct gmii2rgmii *xphy, unsigned int speed);
>>> +};
>>> +
>>> +extern int gmii2rgmii_phyprobe(struct gmii2rgmii *xphy); #endif
>>
>> I see a compilation issue here:
>>
>> You should provide a way to have this function even if the NET_VENDOR_XILINX
>> config option is not selected (test to compile with the sama5_defconfig and
>> you'll see).
> 
> Ok will fix in the next version...
> 
>>
>> What about making this function void in case of !XILINX?
> 
> This is one way to get rid of compilation error. Changes will be look like below
> 
> #ifdef CONFIG_NET_VENDOR_XILINX

You may need to have:
#if defined(CONFIG_NET_VENDOR_XILINX) && defined(CONFIG_XILINX_GMII2RGMII)

>  extern int gmii2rgmii_phyprobe(struct gmii2rgmii *xphy);
> #else
> extern void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy);

No need for the line above...

> void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy)
> {
> }

On one single line, like:

static inline void gmii2rgmii_phyprobe(struct gmii2rgmii *xphy) { }

> #endif
> For me the changes are looking odd...

For me, it's okay...

> 
> Other possible ways 
> 	1)  Put a config check around phyprobe api in the macb driver.
> #ifdef CONFIG_XILINX_GMII2RGMII
>                        gmii2rgmii_phyprobe(&bp->converter_phy);
> #endif

Nope!

> 	2) Select NET_VENDOR_XILINX in the macb Kconfig 
> @ -22,6 +22,7 @@ config MACB
>         tristate "Cadence MACB/GEM support"
>         depends on HAS_DMA
>         select PHYLIB
> +       select NET_VENDOR_XILINX



> Please let me know which one you prefer will fix that and will post v3...

First one with my changes is the best. But maybe wait for more feedback...

Bye,
-- 
Nicolas Ferre
