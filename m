From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 02:44:00 +0100
Subject: [PATCH 2/8] macb: detect hclk presence from platform data
In-Reply-To: <1299751843-9743-3-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-3-git-send-email-jamie@jamieiles.com>
Message-ID: <20110311014400.GJ9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> Rather than detecting whether we need to do a clk_get() and enable on
> the "hclk" based on the kernel configuration, add an extra field to the
> platform data.  This makes it cleaner to add more supported
> architectures without lots of ifdeffery.
> 
> This requires that all instantiations of the device have platform data
> defined but that is the case currently anyway.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  arch/avr32/mach-at32ap/at32ap700x.c |    2 +
>  drivers/net/macb.c                  |   77 ++++++++++++++++++-----------------
>  include/linux/platform_data/macb.h  |    1 +
>  3 files changed, 43 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
> index 2747cde..2abcafd 100644
> --- a/arch/avr32/mach-at32ap/at32ap700x.c
> +++ b/arch/avr32/mach-at32ap/at32ap700x.c
> @@ -1088,6 +1088,8 @@ at32_add_device_eth(unsigned int id, struct eth_platform_data *data)
>  	struct platform_device *pdev;
>  	u32 pin_mask;
>  
> +	data->have_hclk = 1;
> +
>  	switch (id) {
>  	case 0:
>  		pdev = &macb0_device;
> diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> index bfd3601..ae98fee 100644
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
> @@ -246,9 +246,7 @@ static int macb_mii_init(struct macb *bp)
>  	bp->mii_bus->parent = &bp->dev->dev;
>  	pdata = bp->pdev->dev.platform_data;
>  
> -	if (pdata)
> -		bp->mii_bus->phy_mask = pdata->phy_mask;
> -
> +	bp->mii_bus->phy_mask = pdata->phy_mask;
>  	bp->mii_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
>  	if (!bp->mii_bus->irq) {
>  		err = -ENOMEM;
> @@ -1103,9 +1101,14 @@ static const struct net_device_ops macb_netdev_ops = {
>  #endif
>  };
>  
> +#ifdef CONFIG_ARCH_AT91
> +#define PCLK_NAME	"macb_clk"
> +#else /* CONFIG_ARCH_AT91 */
> +#define PCLK_NAME	"pclk"
> +#endif

we need change the clock name and avoid the ifdef
so this will be generic

nb I work on the switch to clkdev currently for avr32 and at91

Best Regards,
J.
