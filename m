From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 7 Dec 2011 16:49:54 +0800
Subject: [PATCH][NET] several cleanups and bugfixes for fec.c: don't
 munge MAC address from platform data
In-Reply-To: <55b78c1766da5b0d0d679f5eae3fb9fc74a6ceef.1323163127.git.LW@KARO-electronics.de>
References: <cover.1323163127.git.LW@KARO-electronics.de>
 <55b78c1766da5b0d0d679f5eae3fb9fc74a6ceef.1323163127.git.LW@KARO-electronics.de>
Message-ID: <20111207084953.GD5550@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2011 at 11:27:13AM +0100, Lothar Wa?mann wrote:
> When the MAC address is supplied via platform_data it should be OK as
> it is and should not be modified in case of a dual FEC setup.
> Also copying the MAC from platform_data to the single 'macaddr'
> variable will overwrite the MAC for the first interface in case of a
> dual FEC setup.

Hmm, I do not follow that.  If 'macaddr' holds a valid mac address,
the code path has no chance to be hit at all.  Otherwise, 'macaddr'
is just a place holder for copying mac address from pdata, in which
case the mac address will be fixed up at the end of the function for
dual FEC setup.

Regards,
Shawn

> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/net/ethernet/freescale/fec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index e2b5ce6..11534b9 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -818,7 +818,7 @@ static void __inline__ fec_get_mac(struct net_device *ndev)
>  			iap = (unsigned char *)FEC_FLASHMAC;
>  #else
>  		if (pdata)
> -			memcpy(iap, pdata->mac, ETH_ALEN);
> +			iap = (unsigned char *)&pdata->mac;
>  #endif
>  	}
>  
> -- 
> 1.5.6.5
