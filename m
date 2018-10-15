From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Mon, 15 Oct 2018 19:43:44 +0200
Subject: [linux-sunxi] Re: [PATCH v2 15/29] drm/bridge/synopsys: dw-hdmi:
 Enable workaround for v2.12a
In-Reply-To: <3616158.EzHeIcd69b@avalon>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-16-jernej.skrabec@siol.net> <3616158.EzHeIcd69b@avalon>
Message-ID: <1599508.L0GctDr0rS@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne torek, 09. oktober 2018 ob 19:40:44 CEST je Laurent Pinchart napisal(a):
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Sunday, 7 October 2018 12:38:51 EEST Jernej Skrabec wrote:
> > It turns out that even new DW HDMI controllers exhibits same magenta
> > line issues as older versions.
> > 
> > Enable workaround for v2.12a.
> 
> This doesn't affect the platforms I maintain, so I can't really test this,
> but I'm wondering whether there could be other platforms using a v2.12a DW
> HDMI that wouldn't need the workaround.
> 
> My platforms use a previous version, namely v2.01a. The workaround for that
> version has been enabled by
> 
> commit 9c305eb442f3b371fc722ade827bbf673514123e
> Author: Neil Armstrong <narmstrong@baylibre.com>
> Date:   Fri Feb 23 12:44:37 2018 +0100
> 
>     drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic Meson GX SoCs
> 
> I haven't paid too much attention to the patch back then, and have now
> double- checked the HDMI output on R-Car Gen3. Enabling the workaround
> doesn't cause any regression, and reverting the commit doesn't cause any
> issue either. I thus wonder whether we shouldn't enable the workaround with
> count = 1 in the default case instead of adding new IP core versions to the
> list. It would be nice if someone from Synopsys could comment on this.

I was thinking about that too, or even having parameter in dw_hdmi_plat_data 
which would tell how many times to repeat workaround procedure for a specific 
platform. But this might be an overkill.

Best regards,
Jernej

> 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > 5971976284bf..df1c7a2d6961 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1664,6 +1664,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi
> > 
> > *hdmi) case 0x131a:
> >  	case 0x132a:
> > 
> >  	case 0x201a:
> > +	case 0x212a:
> >  		count = 1;
> >  		break;
> >  	
> >  	default:
