From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 09 Jan 2018 19:42:26 +0100
Subject: [PATCH 04/11] drm/bridge/synopsys: dw-hdmi: Export some PHY
 related functions
In-Reply-To: <1586880.7NXXgpct7p@avalon>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <10903755.CJpSM8RM5e@jernej-laptop> <1586880.7NXXgpct7p@avalon>
Message-ID: <1523919.I1QF6T1ars@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Dne torek, 09. januar 2018 ob 17:08:55 CET je Laurent Pinchart napisal(a):
> Hello,
> 
> On Tuesday, 9 January 2018 17:58:46 EET Jernej ?krabec wrote:
> > Dne torek, 09. januar 2018 ob 11:43:08 CET je Archit Taneja napisal(a):
> > > On 12/31/2017 02:31 AM, Jernej Skrabec wrote:
> > >> Parts of PHY code could be useful also for custom PHYs. For example,
> > >> Allwinner A83T has custom PHY which is probably Synopsys gen2 PHY
> > >> with few additional memory mapped registers, so most of the Synopsys
> > >> PHY
> > >> related code could be reused.
> > >> 
> > >> It turns out that even completely custom HDMI PHYs, such as the one
> > >> found in Allwinner H3, can reuse some of those functions. This would
> > >> suggest that (some?) functions exported in this commit are actually
> > >> part
> > >> of generic PHY interface and not really specific to Synopsys PHYs.
> > >> 
> > >> Export useful PHY functions.
> > >> 
> > >> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > >> ---
> > >> 
> > >> drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 45 +++++++++++++++++-------
> > >> drivers/gpu/drm/bridge/synopsys/dw-hdmi.h |  2 ++
> > >> include/drm/bridge/dw_hdmi.h              | 10 +++++++
> > >> 3 files changed, 44 insertions(+), 13 deletions(-)
> > >> 
> > >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > >> 7ca14d7325b5..67467d0b683a 100644
> > >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> 
> [snip]
> 
> > >> @@ -1065,6 +1067,23 @@ static void
> > >> dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
> > >> 
> > >>   			 HDMI_PHY_CONF0_SELDIPIF_MASK);
> > >>   
> > >>   }
> > >> 
> > >> +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi, u8 enable)
> > >> +{
> > >> +	hdmi_mask_writeb(hdmi, enable, HDMI_MC_PHYRSTZ,
> > >> +			 HDMI_MC_PHYRSTZ_PHYRSTZ_OFFSET,
> > >> +			 HDMI_MC_PHYRSTZ_PHYRSTZ_MASK);
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_reset);
> 
> I don't remember the details, is the reset signal Gen2-specific ?

According to this comment:

/* PHY reset. The reset signal is active high on Gen2 PHYs. */

I would guess that it is not specific to Gen2, otherwise the comment wouldn't 
be needed. I will remove "gen2" from the name.

> 
> How about asserting and deasserting the reset signal in the same call
> instead of having to call this function twice ?

It works on A83T if reset signal is asserted and deasserted immediately. I 
will change function according to your proposal.

Best regards,
Jernej

> 
> > >> +void dw_hdmi_phy_set_slave_addr(struct dw_hdmi *hdmi)
> > >> +{
> > >> +	hdmi_phy_test_clear(hdmi, 1);
> > >> +	hdmi_writeb(hdmi, HDMI_PHY_I2CM_SLAVE_ADDR_PHY_GEN2,
> > >> +		    HDMI_PHY_I2CM_SLAVE_ADDR);
> > >> +	hdmi_phy_test_clear(hdmi, 0);
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_set_slave_addr);
> > > 
> > > Should this be called dw_hdmi_phy_gen2_set_slave_addr?
> > 
> > Probably. I will rename it in v2 to be consistent with other phy
> > functions.
> 
> The I2C write function is called dw_hdmi_phy_i2c_write(). If we want to be
> conosistent we should either rename this one to dw_hdmi_phy_i2c_set_addr()
> or rename them both to dw_hdmi_phy_gen2_i2c_write() and
> dw_hdmi_phy_gen2_i2c_set_addr(). I think I'd prefer the former, and we could
> even drop gen2 from dw_hdmi_phy_gen2_pddq() and dw_hdmi_phy_gen2_txpwron()
> if desired.
> 
> > > Looks good otherwise. Same for patches 3 and 4 in this series.
> > > 
> > >> +
> > >> 
> > >>   static void dw_hdmi_phy_power_off(struct dw_hdmi *hdmi)
> > >>   {
> > >>   
> > >>   	const struct dw_hdmi_phy_data *phy = hdmi->phy.data;
> 
> [snip]
> 
> --
> Regards,
> 
> Laurent Pinchart
