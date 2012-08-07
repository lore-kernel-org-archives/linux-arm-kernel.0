From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 07 Aug 2012 22:57:38 +1000
Subject: [PATCH] ARM: ep93xx: Use HW MAC filter in ethernet driver
In-Reply-To: <1344338818.18237.9.camel@localhost>
References: <1344338818.18237.9.camel@localhost>
Message-ID: <502110C2.400@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/12 21:26, Yan Burman wrote:

> ARM: ep93xx: Use HW MAC filter in ethernet driver
> Use HW MAC filtering for broadcasts and multicasts.
> Do not always work in promiscuous mode.
> Partially based on kernel 2.6.20.4 driver from cirrus logic.
> Tested on 9302 and 9315 based boards.
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>


Hi Yan,

Just a quick scan through, mostly style comments. Will try
to review properly tomorrow.

~Ryan

> 
> diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> index 78c5521..28bdf96 100644
> --- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
> +++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
> @@ -29,7 +29,7 @@
>  #include <mach/hardware.h>
>  
>  #define DRV_MODULE_NAME		"ep93xx-eth"
> -#define DRV_MODULE_VERSION	"0.1"
> +#define DRV_MODULE_VERSION	"0.2"

Don't bother with this, the driver version isn't really used anyway.

>  #define RX_QUEUE_ENTRIES	64
>  #define TX_QUEUE_ENTRIES	8
> @@ -38,7 +38,29 @@
>  #define PKT_BUF_SIZE		2048
>  
>  #define REG_RXCTL		0x0000
> -#define  REG_RXCTL_DEFAULT	0x00073800
> +#define  REG_RXCTL_PauseA  (1<<20)
> +#define  REG_RXCTL_RxFCE1  (1<<19)
> +#define  REG_RXCTL_RxFCE0  (1<<18)
> +#define  REG_RXCTL_BCRC    (1<<17)
> +#define  REG_RXCTL_SRxON   (1<<16)
> +#define  REG_RXCTL_RCRCA   (1<<13)
> +#define  REG_RXCTL_RA      (1<<12)
> +#define  REG_RXCTL_PA      (1<<11)
> +#define  REG_RXCTL_BA      (1<<10)
> +#define  REG_RXCTL_MA      (1<<9)
> +#define  REG_RXCTL_IAHA    (1<<8)
> +#define  REG_RXCTL_IA3     (1<<3)
> +#define  REG_RXCTL_IA2     (1<<2)
> +#define  REG_RXCTL_IA1     (1<<1)
> +#define  REG_RXCTL_IA0     (1<<0)


Nitpick - spaces either side of the << operator.

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
> @@ -57,6 +79,12 @@
>  #define  REG_INTSTS_RX		0x00000004
>  #define REG_INTSTSC		0x002c
>  #define REG_AFP			0x004c
> +#define  REG_AFP_AFP_IA0	0
> +#define  REG_AFP_AFP_IA1	1
> +#define  REG_AFP_AFP_IA2	2
> +#define  REG_AFP_AFP_IA3	3
> +#define  REG_AFP_AFP_DTxP	6
> +#define  REG_AFP_AFP_HASH	7


Why AFP_AFP?

>  #define REG_INDAD0		0x0050
>  #define REG_INDAD1		0x0051
>  #define REG_INDAD2		0x0052
> @@ -386,6 +414,83 @@ static int ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +#define CRC_PRIME 0xFFFFFFFF
> +#define CRC_POLYNOMIAL 0x04C11DB6


Lower case for hex constants.

> +static unsigned char ep93xx_calculate_hash_index(char *mcast_addr)
> +{


This looks like the sort of function which might already have a 
generic implementation somewhere?

> +	unsigned long crc;
> +	unsigned char hash_idx;
> +	unsigned char addr_byte;
> +	unsigned char *addr;
> +	unsigned long high_bit;
> +	int byte;
> +	int bit;
> +
> +	crc = CRC_PRIME;
> +	addr = mcast_addr;
> +
> +	for (byte = 0; byte < 6; byte++) {
> +		addr_byte = *addr;
> +		addr++;
> +
> +		for (bit = 8; bit > 0; bit--) {
> +			high_bit = crc >> 31;
> +			crc <<= 1;
> +
> +			if (high_bit ^ (addr_byte & 1)) {
> +				crc ^= CRC_POLYNOMIAL;
> +				crc |= 1;
> +			}
> +
> +			addr_byte >>= 1;
> +		}
> +	}
> +
> +	for (bit = 0, hash_idx = 0; bit < 6; bit++) {
> +		hash_idx <<= 1;
> +		hash_idx |= (unsigned char)(crc & 1);
> +		crc >>= 1;
> +	}
> +
> +	return hash_idx;
> +}
> +
> +static void ep93xx_set_mcast_tbl(struct net_device *dev, u8 *pBuf)
> +{


pbuf. No camel-case please.

> +	unsigned char position;
> +	struct netdev_hw_addr *ha;
> +
> +	netdev_hw_addr_list_for_each(ha, &dev->mc) {
> +		if (ha->addr[0] & 1)
> +			continue;
> +		position = ep93xx_calculate_hash_index(ha->addr);
> +		pBuf[position >> 3] |= 1 << (position & 0x07);
> +	}
> +}
> +
> +static int ep93xx_ind_addr_write(struct net_device *dev, int afp, char *pBuf)
> +{
> +	u32 rxctl;
> +	int i, len;
> +	struct ep93xx_priv *ep = netdev_priv(dev);
> +
> +	afp &= 0x07;
> +	if (afp == 4 || afp == 5) {
> +		pr_crit("invalid afp value\n");
> +		return -1;
> +	}
> +	len = (afp == REG_AFP_AFP_HASH) ? 8 : 6;

Lots of magic numbers here.

> +	rxctl = rdl(ep, REG_RXCTL);
> +	wrl(ep, REG_RXCTL, ~REG_RXCTL_SRxON & rxctl);
> +	wrl(ep, REG_AFP, afp);
> +	for (i = 0; i < len; i++)
> +		wrb(ep, REG_INDAD0 + i, pBuf[i]);
> +	wrl(ep, REG_RXCTL, rxctl);
> +
> +	return 0;
> +}
> +
>  static void ep93xx_tx_complete(struct net_device *dev)
>  {
>  	struct ep93xx_priv *ep = netdev_priv(dev);
> @@ -615,13 +720,7 @@ static int ep93xx_start_hw(struct net_device *dev)
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
> +	ep93xx_ind_addr_write(dev, REG_AFP_AFP_IA0, dev->dev_addr);
>  
>  	wrl(ep, REG_MAXFRMLEN, (MAX_PKT_SIZE << 16) | MAX_PKT_SIZE);
>  
> @@ -647,6 +746,31 @@ static void ep93xx_stop_hw(struct net_device *dev)
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
> +		ep93xx_ind_addr_write(dev, REG_AFP_AFP_HASH,
> +			      "\xff\xff\xff\xff\xff\xff\xff\xff");
> +	} else if (netdev_hw_addr_list_count(&dev->mc)) {
> +		u8 tblMulti[8 + 1];
> +		memset(tblMulti, 0, sizeof(tblMulti));


Nitpick - leave a blank line between variable declarations and code.

> +
> +		wrl(ep, REG_RXCTL, REG_RXCTL_MA |
> +			(~REG_RXCTL_PA & rdl(ep, REG_RXCTL)));
> +		ep93xx_set_mcast_tbl(dev, tblMulti);
> +		ep93xx_ind_addr_write(dev, REG_AFP_AFP_HASH, tblMulti);
> +	} else {
> +		wrl(ep, REG_RXCTL,
> +			~(REG_RXCTL_PA | REG_RXCTL_MA) & rdl(ep, REG_RXCTL));
> +	}
> +}
> +
>  static int ep93xx_open(struct net_device *dev)
>  {
>  	struct ep93xx_priv *ep = netdev_priv(dev);
> @@ -754,6 +878,7 @@ static const struct net_device_ops ep93xx_netdev_ops = {
>  	.ndo_validate_addr	= eth_validate_addr,
>  	.ndo_change_mtu		= eth_change_mtu,
>  	.ndo_set_mac_address	= eth_mac_addr,
> +	.ndo_set_rx_mode	= ep93xx_set_multicast_list,
>  };
>  
>  static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
> 
> 
