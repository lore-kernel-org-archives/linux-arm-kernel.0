From: sean.wang@mediatek.com (Sean Wang)
Date: Mon, 23 Apr 2018 16:58:14 +0800
Subject: [PATCH v1 5/7] soc: mediatek: add a fixed wait for SRAM stable
In-Reply-To: <1524196190.26454.3.camel@mtkswgap22>
References: <cover.1522736996.git.sean.wang@mediatek.com>
 <0fc10b2498c6dbe20141831c722c32cc74330d3d.1522736996.git.sean.wang@mediatek.com>
 <5f2530a0-aee2-39fe-eb5c-56cd4a68c9db@gmail.com>
 <1524196190.26454.3.camel@mtkswgap22>
Message-ID: <1524473894.12322.13.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-04-20 at 11:49 +0800, Sean Wang wrote:
> On Thu, 2018-04-19 at 12:33 +0200, Matthias Brugger wrote:
> > 
> > On 04/03/2018 09:15 AM, sean.wang at mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
> > > stable, which is not like the behavior the other power domains should
> > > have. Therefore, it's necessary for such a power domain to have a fixed
> > > and well-predefined duration to wait until its managed SRAM can be allowed
> > > to access by all functions running on the top.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/mtk-scpsys.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > > index f9b7248..19aceb8 100644
> > > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > > @@ -121,6 +121,7 @@ struct scp_domain_data {
> > >  	u32 bus_prot_mask;
> > >  	enum clk_id clk_id[MAX_CLKS];
> > >  	bool active_wakeup;
> > > +	u32 us_sram_fwait;
> > 
> > Before adding more and more fields to scp_domain_data which get checked in if's,
> > I'd prefer to add a caps field used for bus_prot_mask, active_wakeup in a first
> > patch and add the cap FORCE_WAIT in a second patch.
> > 
> > Can you help to implement this Sean, or shall I give it a try?
> > 
> 
> Sure, I have a willing to do and then see if you're also fond of it.
> 
> thanks!
> 

Hi, Matthias

I have done it in [1], but in the version, I doesn't merge bus_prot_mask
into caps fields because bus_prot_mask is actually mapped into realistic
hardware bitmap like sram_pdn_bits, sram_pdn_ack_bits, sta_mask is
doing.

It should be more straightforward to port a new SoC to scpsys when there
are standalone fields to hold these hardware configuring bitmaps.

[1]
http://lists.infradead.org/pipermail/linux-mediatek/2018-April/012884.html

	Sean

> > Regards,
> > Matthias
> > 
> > >  };
> > >  
> > >  struct scp;
> > > @@ -234,11 +235,16 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> > >  	val &= ~scpd->data->sram_pdn_bits;
> > >  	writel(val, ctl_addr);
> > >  
> > > -	/* wait until SRAM_PDN_ACK all 0 */
> > > -	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> > > -				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > > -	if (ret < 0)
> > > -		goto err_pwr_ack;
> > > +	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> > > +	if (!scpd->data->us_sram_fwait) {
> > > +		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> > > +					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > > +		if (ret < 0)
> > > +			goto err_pwr_ack;
> > > +	} else {
> > > +		usleep_range(scpd->data->us_sram_fwait,
> > > +			     scpd->data->us_sram_fwait + 100);
> > > +	};
> > >  
> > >  	if (scpd->data->bus_prot_mask) {
> > >  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > > @@ -783,6 +789,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
> > >  		.clk_id = {CLK_NONE},
> > >  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
> > >  		.active_wakeup = true,
> > > +		.us_sram_fwait = 12000,
> > >  	},
> > >  };
> > >  
> > > 
> 
