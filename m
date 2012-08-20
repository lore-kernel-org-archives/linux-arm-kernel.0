From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 21 Aug 2012 09:01:07 +1000
Subject: [PATCH v2] ARM: ep93xx: Use HW MAC filter in ethernet driver
In-Reply-To: <1345406296.20237.4.camel@localhost>
References: <1345406296.20237.4.camel@localhost>
Message-ID: <5032C1B3.4030809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/08/12 05:58, Yan Burman wrote:
> ARM: ep93xx: Use HW MAC filter in ethernet driver
> Use HW MAC filtering for broadcasts and multicasts.
> Do not always work in promiscuous mode.
> Partially based on kernel 2.6.20.4 driver from cirrus logic.
> Tested on 9302 and 9315 based boards.
> 
> Changes from v1:
> * Some minor style fixes
> * Use CRC32 code instead of duplicating code
> * Fixed multicast reception (tested with omping)
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>

Hi Yan,

Some very minor comments below. Otherwise looks fine. Repost with the
changes and I'll get this into my tree.

Thanks,
~Ryan

> 
> diff --git a/drivers/net/ethernet/cirrus/Kconfig b/drivers/net/ethernet/cirrus/Kconfig
> index 8388e36..b7b154f 100644
> --- a/drivers/net/ethernet/cirrus/Kconfig
> +++ b/drivers/net/ethernet/cirrus/Kconfig
> @@ -46,6 +46,7 @@ config EP93XX_ETH
>  	depends on ARM && ARCH_EP93XX
>  	select NET_CORE
>  	select MII
> +	select CRC32
>  	help
>  	  This is a driver for the ethernet hardware included in EP93xx CPUs.
>  	  Say Y if you are building a kernel for EP93xx based devices.
> diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> index 78c5521..27299ce 100644
> --- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
> +++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> @@ -25,6 +25,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/crc32.h>
>  
>  #include <mach/hardware.h>
>  
> @@ -37,8 +38,32 @@
>  #define MAX_PKT_SIZE		2044
>  #define PKT_BUF_SIZE		2048
>  
> +#define HASH_TBL_ENTRIES	8
> +
>  #define REG_RXCTL		0x0000
> -#define  REG_RXCTL_DEFAULT	0x00073800
> +#define  REG_RXCTL_PauseA  (1 << 20)

Please use capitals only for register #defines.

> +#define  REG_RXCTL_RxFCE1  (1 << 19)
> +#define  REG_RXCTL_RxFCE0  (1 << 18)
> +#define  REG_RXCTL_BCRC    (1 << 17)
> +#define  REG_RXCTL_SRxON   (1 << 16)
> +#define  REG_RXCTL_RCRCA   (1 << 13)
> +#define  REG_RXCTL_RA      (1 << 12)
> +#define  REG_RXCTL_PA      (1 << 11)
> +#define  REG_RXCTL_BA      (1 << 10)
> +#define  REG_RXCTL_MA      (1 << 9)
> +#define  REG_RXCTL_IAHA    (1 << 8)
> +#define  REG_RXCTL_IA3     (1 << 3)
> +#define  REG_RXCTL_IA2     (1 << 2)
> +#define  REG_RXCTL_IA1     (1 << 1)
> +#define  REG_RXCTL_IA0     (1 << 0)
> +#define  REG_RXCTL_DEFAULT	(REG_RXCTL_BA | \
> +				REG_RXCTL_RA | \
> +				REG_RXCTL_RCRCA | \
> +				REG_RXCTL_SRxON | \
> +				REG_RXCTL_BCRC | \
> +				REG_RXCTL_RxFCE0 | \
> +				REG_RXCTL_IA0)
> +
>  #define REG_TXCTL		0x0004
>  #define  REG_TXCTL_ENABLE	0x00000001
>  #define REG_MIICMD		0x0010
> @@ -57,6 +82,12 @@
>  #define  REG_INTSTS_RX		0x00000004
>  #define REG_INTSTSC		0x002c
>  #define REG_AFP			0x004c
> +#define  REG_AFP_IA0		0
> +#define  REG_AFP_IA1		1
> +#define  REG_AFP_IA2		2
> +#define  REG_AFP_IA3		3
> +#define  REG_AFP_DTxP		6
> +#define  REG_AFP_HASH		7
>  #define REG_INDAD0		0x0050
>  #define REG_INDAD1		0x0051
>  #define REG_INDAD2		0x0052
> @@ -386,6 +417,51 @@ static int ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static void ep93xx_set_mcast_tbl(struct net_device *dev, u8 *buf)
> +{
> +	struct netdev_hw_addr *ha;
> +	u32 crc;
> +
> +	netdev_for_each_mc_addr(ha, dev) {
> +		crc = ether_crc_le(ETH_ALEN, ha->addr);
> +		buf[crc >> 29] |= (1 << ((crc >> 26) & 7));
> +	}
> +}
> +
> +static int ep93xx_ind_addr_write(struct net_device *dev, int afp, char *buf)
> +{
> +	u32 rxctl;
> +	unsigned int i, len;
> +	struct ep93xx_priv *ep = netdev_priv(dev);
> +
> +	switch (afp) {
> +	case REG_AFP_IA0:
> +	case REG_AFP_IA1:
> +	case REG_AFP_IA2:
> +	case REG_AFP_IA3:
> +	case REG_AFP_DTxP:
> +		len = ETH_ALEN;
> +		break;
> +
> +	case REG_AFP_HASH:
> +		len = HASH_TBL_ENTRIES;
> +		break;
> +
> +	default:
> +		pr_crit("invalid afp value: %d\n", afp);
> +		return -1;

errno code please. Also, the return value of this function is never
checked by its callers. Should it be?

> +	}
> +
> +	rxctl = rdl(ep, REG_RXCTL);
> +	wrl(ep, REG_RXCTL, ~REG_RXCTL_SRxON & rxctl);

Nitpick - I think maybe it is more readable the other way round?

	wrl(ep, REG_RXCTL, rxctl & ~REG_RXCTL_SRXON);

> +	wrl(ep, REG_AFP, afp);
> +	for (i = 0; i < len; i++)
> +		wrb(ep, REG_INDAD0 + i, buf[i]);
> +	wrl(ep, REG_RXCTL, rxctl);
> +
> +	return 0;
> +}
> +
>  static void ep93xx_tx_complete(struct net_device *dev)
>  {
>  	struct ep93xx_priv *ep = netdev_priv(dev);
> @@ -615,13 +691,7 @@ static int ep93xx_start_hw(struct net_device *dev)
>  	wrl(ep, REG_RXDENQ, RX_QUEUE_ENTRIES);
>  	wrl(ep, REG_RXSTSENQ, RX_QUEUE_ENTRIES);
>  
> -	wrb(ep, REG_INDAD0, dev->dev_addr[0]);
> -	wrb(ep, REG_INDAD1, dev->dev_addr[1]);
> -	wrb(ep, REG_INDAD2, dev->dev_addr[2]);
> -	wrb(ep, REG_INDAD3, dev->dev_addr[3]);
> -	wrb(ep, REG_INDAD4, dev->dev_addr[4]);
> -	wrb(ep, REG_INDAD5, dev->dev_addr[5]);
> -	wrl(ep, REG_AFP, 0);
> +	ep93xx_ind_addr_write(dev, REG_AFP_IA0, dev->dev_addr);
>  
>  	wrl(ep, REG_MAXFRMLEN, (MAX_PKT_SIZE << 16) | MAX_PKT_SIZE);
>  
> @@ -647,6 +717,32 @@ static void ep93xx_stop_hw(struct net_device *dev)
>  		pr_crit("hw failed to reset\n");
>  }
>  
> +static void ep93xx_set_multicast_list(struct net_device *dev)
> +{
> +	struct ep93xx_priv *ep = netdev_priv(dev);
> +
> +	if (dev->flags & IFF_PROMISC) {
> +		wrl(ep, REG_RXCTL, REG_RXCTL_PA | rdl(ep, REG_RXCTL));
> +	} else if (dev->flags & IFF_ALLMULTI) {
> +		wrl(ep, REG_RXCTL, REG_RXCTL_MA |
> +			(~REG_RXCTL_PA & rdl(ep, REG_RXCTL)));
> +		ep93xx_ind_addr_write(dev, REG_AFP_HASH,
> +			      "\xff\xff\xff\xff\xff\xff\xff\xff");
> +	} else if (!netdev_mc_empty(dev)) {
> +		u8 tblMulti[HASH_TBL_ENTRIES + 1];
> +
> +		memset(tblMulti, 0, sizeof(tblMulti));

Nitpick - this can be written as:

	u8 tbl_multi[HASH_TBL_ENTRIES + 1] = {0};

Use underscores in variable names, no camel-case please.

> +
> +		ep93xx_set_mcast_tbl(dev, tblMulti);
> +		wrl(ep, REG_RXCTL, REG_RXCTL_MA |
> +			(~REG_RXCTL_PA & rdl(ep, REG_RXCTL)));
> +		ep93xx_ind_addr_write(dev, REG_AFP_HASH, tblMulti);
> +	} else {
> +		wrl(ep, REG_RXCTL,
> +			~(REG_RXCTL_PA | REG_RXCTL_MA) & rdl(ep, REG_RXCTL));
> +	}
> +}
> +
>  static int ep93xx_open(struct net_device *dev)
>  {
>  	struct ep93xx_priv *ep = netdev_priv(dev);
> @@ -754,6 +850,7 @@ static const struct net_device_ops ep93xx_netdev_ops = {
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_change_mtu		= eth_change_mtu,
>  	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_set_rx_mode	= ep93xx_set_multicast_list,
>  };
>  
>  static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
> 
> 
