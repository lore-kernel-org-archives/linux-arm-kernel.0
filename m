From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 Feb 2018 21:15:26 +0200
Subject: [PATCH v2 3/8] drm/bridge: dw-hdmi: allow overriding of phy-type
 reading
In-Reply-To: <3085916.UFWCNBIZfU@phil>
References: <20180216204158.29839-1-heiko@sntech.de>
 <16512170.VqSpgYmDPS@avalon> <3085916.UFWCNBIZfU@phil>
Message-ID: <4888467.l85TM0qZuY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Wednesday, 21 February 2018 20:55:12 EET Heiko Stuebner wrote:
> Am Montag, 19. Februar 2018, 20:06:40 CET schrieb Laurent Pinchart:
> > On Monday, 19 February 2018 20:46:46 EET Heiko Stuebner wrote:
> > > Am Montag, 19. Februar 2018, 17:59:02 CET schrieb Laurent Pinchart:
> > > > On Friday, 16 February 2018 22:41:53 EET Heiko Stuebner wrote:
> > > >> In some IP implementations the reading of the phy-type may be broken.
> > > >> One example are the Rockchip rk3228 and rk3328 socs that use a
> > > >> separate
> > > >> phy from Innosilicon but still report the HDMI20_TX type.
> > > >> 
> > > >> So allow the glue driver to force a specific type, like the
> > > >> vendor-phy
> > > >> for these cases.
> > > >> 
> > > >> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > > 
> > > > Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > thanks for testing :-)
> > > 
> > > >> ---
> > > >> 
> > > >>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 4 +++-
> > > >>  include/drm/bridge/dw_hdmi.h              | 1 +
> > > >>  2 files changed, 4 insertions(+), 1 deletion(-)
> > > >> 
> > > >> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > >> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > > >> f9802399cc0d..50d231626c4d 100644
> > > >> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > >> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > >> @@ -2218,7 +2218,9 @@ static int dw_hdmi_detect_phy(struct dw_hdmi
> > > >> *hdmi)
> > > >> 
> > > >>  	unsigned int i;
> > > >>  	u8 phy_type;
> > > >> 
> > > >> -	phy_type = hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> > > >> +	phy_type = (hdmi->plat_data->phy_force_type) ?
> > > >> +				hdmi->plat_data->phy_force_type :
> > > >> +				hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> > > > 
> > > > No need for parentheses. You could even write this
> > > > 
> > > >         phy_type = hdmi->plat_data->phy_force_type ?
> > > >         
> > > >                  : hdmi_readb(hdmi, HDMI_CONFIG2_ID);
> > > > 
> > > > but that's up to you.
> > > > 
> > > > What if a driver wants to force the PHY type to
> > > > DW_HDMI_PHY_DWC_HDMI_TX_PHY ? Or do you expect only the
> > > > DW_HDMI_PHY_VENDOR_PHY type to be forced ? If so, we could also use a
> > > > force_vendor_phy boolean field instead of phy_force_type.
> > > 
> > > Initially I thought of implicitly overriding the phy-type when the
> > > external
> > > phy-ops are set, but decided against it because that might break
> > > (theoretical) cases where phy-ops may be always set but only used when
> > > the ip returns a matching phy-type and thus came to just allow
> > > overriding
> > > that type reading.
> > > 
> > > As for limiting to only allow forcing the vendor type, my personal
> > > feeling
> > > would be to allow glue drivers to just override the type as needed
> > > like done in the patch. As can be seen on the rk3328, the dw-hdmi
> > > reports one of the regular phys (forgot which one) but instead has a
> > > completely separate ip for it, so I'd guess we may very well see
> > > implementations that just report a wrong type (no vendor-type).
> > > 
> > > So I don't see an issue with drivers being allowed to set the type to
> > > DW_HDMI_PHY_DWC_HDMI_TX_PHY, because such cases may exist in the
> > > future and I'd expect driver authors to somewhat know what they're
> > > doing.
> > 
> > My point was that DW_HDMI_PHY_DWC_HDMI_TX_PHY == 0, so trying to force
> > DW_HDMI_PHY_DWC_HDMI_TX_PHY through phy_force_type won't work.
> 
> Argh, ok now I get it.
> 
> So it will need some adaption for that, because allowing everything but
> DW_HDMI_PHY_DWC_HDMI_TX_PHY would be quite counter-intuitive :-) .
> 
> Expecting phy_force_type == -1 for regular reads sounds bad as well,
> because then every glue driver would need to set that, which currently
> gets solves automatically when the field is not explicitly set.
> 
> So going with your force_vendor_phy idea sounds less intrusive for the
> time being and until there is an actual case where there is a different
> internal phy-type necessary?

That's at least what I'd recommend, as I don't see any use case now for 
overriding the hardware-reported PHY type to a standard PHY type. If we ever 
end up needing that in the future we will of course support it.

-- 
Regards,

Laurent Pinchart
