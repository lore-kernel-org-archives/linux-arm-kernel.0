From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 19:29:16 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130130230518.GA7395@obsidianresearch.com>
References: <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130129203221.GG7717@titan.lakedaemon.net>
 <51083580.1010900@gmail.com>
 <20130130224300.GU7717@titan.lakedaemon.net>
 <20130130230518.GA7395@obsidianresearch.com>
Message-ID: <20130131002916.GW7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 04:05:18PM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 30, 2013 at 05:43:00PM -0500, Jason Cooper wrote:
> > > On 01/29/2013 09:32 PM, Jason Cooper wrote:
> > > >On Tue, Jan 29, 2013 at 09:08:46PM +0100, Sebastian Hesselbarth wrote:
> > > >>Leaves Issue 3, gbe forgets about its MAC address when gated or powered
> > > >>down. That should be done with local-mac-address passed by DT enabled
> > > >>u-boot or any other (dirty) ATAG hack ;)
> > > >
> > > >A patch to mv643xx_eth to pull this from DT should solve this.
> > 
> > Somewhere, Jason Gunthorpe shared his patch to do this.  I'll poke
> > around for it and try to get it merged in.
> 
> Yes, you asked for the doc update and I haven't had a moment to get a
> tree setup for that..

Ahh, that's right.  Sorry, wasn't trying to put pressure on you.  Just
trying to make a reminder to myself of what to look for when I get to
around to it.  (I have a separate IMAP folder for such things ;-) )

> Here are some words though:
> 
>      - local-mac-address : Optional, the MAC address to assign to the
>        device. If not specified then the MAC address in the HW
>        registers is used, but the driver can not be made modular.

I like it.  If I haven't seen anything when I get to this, I'll add this
to your patch.  Please Ack if it's ok.  I prefer not to change peoples
patches without approval.

thx,

Jason.

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
