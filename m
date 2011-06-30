From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 10:23:49 +0100
Subject: [PATCH net-next] net: am79c961a: Omit check for multicast bit
	in netdev_for_each_mc_addr
In-Reply-To: <1309349686-1506-1-git-send-email-tklauser@distanz.ch>
References: <1309349686-1506-1-git-send-email-tklauser@distanz.ch>
Message-ID: <20110630092349.GR21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 02:14:46PM +0200, Tobias Klauser wrote:
> There is no need to check for the address being a multicast address in
> the netdev_for_each_mc_addr loop, so remove it.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  drivers/net/arm/am79c961a.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/arm/am79c961a.c b/drivers/net/arm/am79c961a.c
> index 7b3e23f..52fe21e 100644
> --- a/drivers/net/arm/am79c961a.c
> +++ b/drivers/net/arm/am79c961a.c
> @@ -199,17 +199,15 @@ am79c961_ramtest(struct net_device *dev, unsigned int val)
>  
>  static void am79c961_mc_hash(char *addr, u16 *hash)
>  {
> -	if (addr[0] & 0x01) {
> -		int idx, bit;
> -		u32 crc;
> +	int idx, bit;
> +	u32 crc;
>  
> -		crc = ether_crc_le(ETH_ALEN, addr);
> +	crc = ether_crc_le(ETH_ALEN, addr);
>  
> -		idx = crc >> 30;
> -		bit = (crc >> 26) & 15;
> +	idx = crc >> 30;
> +	bit = (crc >> 26) & 15;
>  
> -		hash[idx] |= 1 << bit;
> -	}
> +	hash[idx] |= 1 << bit;
>  }
>  
>  static unsigned int am79c961_get_rx_mode(struct net_device *dev, u16 *hash)
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
