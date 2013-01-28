From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 28 Jan 2013 14:46:56 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130128182218.GB9436@obsidianresearch.com>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com>
 <20130128182218.GB9436@obsidianresearch.com>
Message-ID: <20130128194656.GL1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Jason,

A question for Simon below

On Mon, Jan 28, 2013 at 11:22:18AM -0700, Jason Gunthorpe wrote:
> On Sun, Jan 27, 2013 at 11:52:41AM +0100, Sebastian Hesselbarth wrote:
> 
> > I agree that loosing the MAC address _is_ an issue but there must
> > be another way to retain it during gated ge clocks than not gate the
> > clocks at all.
> > 
> > I can think of some ways to retain it but don't know what is the most
> > common with linux:
> > - make u-boot pass it through cmdline and let mv643xx get it from there
> > - have kirkwood's common code grab it before clk gates kick in
> 
> The cannonical solution here is to have a DT attribute
> 'local-mac-address' that is filled in by the bootloader rather than
> attempting to pass the mac address to the kernel through the ethernet
> controller registers.

Simon,

Can you try this in conjunction with enabling ARM_ATAG_DTB_COMPAT ?
Does that solve your issue?

thx,

Jason.

> 
> Until the bootloaders are fixed a reasonable hack is to have the
> platform startup code look for an all-zeros local-mac-address in the
> DT and if found then copy the MAC from the ethernet registers into the
> DT. Then the ethernet driver can safely be a module since the MAC is
> captured in the DT.
> 
> I've been using this patch here on top of the original Ian Molton
> patch.
> 
> Jason: Can you include something like this as well?
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index 7048d7c..2b2cfcb 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2891,6 +2891,8 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  	struct mv643xx_eth_private *mp;
>  	struct net_device *dev;
>  	struct resource *res;
> +	const u8 *mac;
> +	int len;
>  	int err;
>  
>  	if (pdev->dev.of_node) {
> @@ -2912,6 +2914,10 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
>  		else
>  			pd->phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT;
>  
> +		mac = of_get_property(pdev->dev.of_node, "local-mac-address", &len);
> +		if (mac && len == 6)
> +		    memcpy(pd->mac_addr, mac, sizeof pd->mac_addr);
> +
>  		np = of_parse_phandle(pdev->dev.of_node, "mdio", 0);
>  		if (np) {
>  			pd->shared = of_find_device_by_node(np);
> -- 
> 1.7.5.4
> 
