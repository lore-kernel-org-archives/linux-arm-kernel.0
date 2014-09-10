From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 10 Sep 2014 17:39:02 +0200
Subject: [PATCH v2 4/8] net: pxa168_eth: fix Ethernet flow control status
In-Reply-To: <1410273848-24663-5-git-send-email-antoine.tenart@free-electrons.com>
References: <1410273848-24663-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410273848-24663-5-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140910153902.GE13342@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 04:44:04PM +0200, Antoine Tenart wrote:
> IEEE 802.3x Ethernet flow control is disabled when bit (1 << 2) is set
> in the port status register. Fix the flow control detection in the link
> event handling function which was relying on the opposite assumption.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/pxa168_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
> index 953112f87c5f..10422f2df6cc 100644
> --- a/drivers/net/ethernet/marvell/pxa168_eth.c
> +++ b/drivers/net/ethernet/marvell/pxa168_eth.c
> @@ -163,7 +163,7 @@
>  /* Bit definitions for Port status */
>  #define PORT_SPEED_100		(1 << 0)
>  #define FULL_DUPLEX		(1 << 1)
> -#define FLOW_CONTROL_ENABLED	(1 << 2)
> +#define FLOW_CONTROL_DISABLED	(1 << 2)
>  #define LINK_UP			(1 << 3)
>  
>  /* Bit definitions for work to be done */
> @@ -885,7 +885,7 @@ static void handle_link_event(struct pxa168_eth_private *pep)
>  		speed = 10;
>  
>  	duplex = (port_status & FULL_DUPLEX) ? 1 : 0;
> -	fc = (port_status & FLOW_CONTROL_ENABLED) ? 1 : 0;
> +	fc = (port_status & FLOW_CONTROL_DISABLED) ? 0 : 1;
>  	netdev_info(dev, "link up, %d Mb/s, %s duplex, flow control %sabled\n",
>  		    speed, duplex ? "full" : "half", fc ? "en" : "dis");
>  	if (!netif_carrier_ok(dev))

Could this be a hardware bug which has been fixed in a newer version
of the IP? It would be good to have this tested on an old platform
using this driver.

   Andrew
