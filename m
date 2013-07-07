From: jogo@openwrt.org (Jonas Gorski)
Date: Sun, 7 Jul 2013 23:43:41 +0200
Subject: [PATCH] net: mv643xx_eth: fix DT port device name
In-Reply-To: <1373229231-8838-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1373229231-8838-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130707234341.0000721b@unknown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  7 Jul 2013 22:33:51 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> Device tree support added to Marvell MV643xx ethernet driver registers
> port devices from port device nodes found on the corresponding controller
> node. The current port device name will cause the second controller to
> fail on registration because of two identical device names. This fixes
> the issue by taking the device node's name also as port device name.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Jonas Gorski <jogo@openwrt.org>
> ---
> Cc: Lennert Buytenhek <buytenh@wantstofly.org>
> Cc: Jonas Gorski <jogo@openwrt.org>
> Cc: netdev at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 6495bea..1f3a03d 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2521,7 +2521,7 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>  		of_property_read_u32(pnp, "duplex", &ppd.duplex);
>  	}
>  
> -	ppdev = platform_device_alloc(MV643XX_ETH_NAME, ppd.port_number);
> +	ppdev = platform_device_alloc(pnp->name, ppd.port_number);
>  	if (!ppdev)
>  		return -ENOMEM;
>  	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);

This breaks ethernet completely, as there is no platform driver
registered for pnp->name ("ethernetX-port"), only for MV643XX_ETH_NAME.

Also since I didn't see a patch for it and no mentioning of it:

There's still one further issue from having two ethernet-ports with
port_number 0, it causes a device leak:

static struct platform_device *port_platdev[3];

mv643xx_eth_shared_of_add_port()
{
	...
	port_platdev[ppd.port_number] = ppdev;
	...
}

The second port at 0 will overwrite the first and thus will never be
deleted in

mv643xx_eth_shared_of_remove()
{
	...
	for (n = 0; n < 3; n++) {
		platform_device_del(port_platdev[n]);
		port_platdev[n] = NULL;
	}
}

I doubt a insmod-rmmod-insmod will go well in that case ;-)


Regards
Jonas
