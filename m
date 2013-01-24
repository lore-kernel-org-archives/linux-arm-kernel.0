From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 24 Jan 2013 07:23:23 +0100
Subject: [RFC PATCH 6/6] ARM: kirkwood: consolidate mv643xx_eth init for DT
In-Reply-To: <20130124013945.GX1758@titan.lakedaemon.net>
References: <cover.1358983578.git.jason@lakedaemon.net>
 <ecb64cdf824399badaf9d659177811d8cb091156.1358983578.git.jason@lakedaemon.net>
 <20130124013945.GX1758@titan.lakedaemon.net>
Message-ID: <20130124062323.GB21297@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static void kirkwood_gige_dt_init(void) {
> > +	int i;
> > +
> > +	for (i = 0; kw_dt_gige[i].compatible != NULL; i++) {
> > +		if (of_machine_is_compatible(kw_dt_gige[i].compatible)) {
> > +
> > +			if (kw_dt_gige[i].phy_addr00 != MV643XX_ETH_PHY_NONE) {
> > +				struct mv643xx_eth_platform_data d = {
> > +					.phy_addr = kw_dt_gige[i].phy_addr00,
> > +				};
> > +				kirkwood_ge00_init(&d);
> > +			}
> > +
> > +			if (kw_dt_gige[i].phy_addr01 != MV643XX_ETH_PHY_NONE) {
> > +				struct mv643xx_eth_platform_data d = {
> > +					.phy_addr = kw_dt_gige[i].phy_addr01,
> > +				};
> > +				kirkwood_ge01_init(&d);
> > +			}
> > +
> > +			break;
> > +		}
> 
> meh, hindsight is 50/50 :-)  Much more readable this way, I think:
> 
> 		if (of_machine_is_compatible(kw_dt_gige[i].compatible)) {
> 			struct mv643xx_eth_platform_data d;
> 
> 			if (kw_dt_gige[i].phy_addr00 != MV643XX_ETH_PHY_NONE) {
> 				d.phy_addr = kw_dt_gige[i].phy_addr00,
> 				kirkwood_ge00_init(&d);
> 			}
> 
> 			if (kw_dt_gige[i].phy_addr01 != MV643XX_ETH_PHY_NONE) {
> 				d.phy_addr = kw_dt_gige[i].phy_addr01,
> 				kirkwood_ge01_init(&d);
> 			}
> 
> 			break;
> 		}
> 
> thx,
> 
> Jason.

Hi Jason

Might it be better still to implement something like:

const struct of_device_id *of_match_machine(const struct of_device_id *matches)
{
        struct device_node *root;
	const struct of_device_id *match;

	if (!matches)
		return NULL;

	root = of_find_node_by_path("/");
	if (!root)
		return NULL;	

	match = of_match_node(matches, root);
	of_node_put(root);

	return match;
}

and then board-dt.c becomes

    match = of_match_machine(ge00_matches);
    if (match)
	krikwood_ge00_init(match->data)

    match = of_match_machine(ge01_matches);
    if (match)
	krikwood_ge01_init(match->data)

	Andrew
