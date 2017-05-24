From: ck.hu@mediatek.com (CK Hu)
Date: Wed, 24 May 2017 17:20:45 +0800
Subject: [PATCH] drm/mediatek: hdmi: Filter interlaced resolutions
In-Reply-To: <20170523131243.5bjz5n4uv73r2l7j@phenom.ffwll.local>
References: <1485234604-19889-1-git-send-email-bibby.hsieh@mediatek.com>
 <1495531695.20811.19.camel@mtksdaap41>
 <20170523131243.5bjz5n4uv73r2l7j@phenom.ffwll.local>
Message-ID: <1495617645.15919.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-05-23 at 15:12 +0200, Daniel Vetter wrote:
> On Tue, May 23, 2017 at 05:28:15PM +0800, CK Hu wrote:
> > Hi, Bibby:
> > 
> > I've applied this patch to my branch mediatek-drm-fixes-4.12-rc1,
> > thanks.
> > 
> > Regards,
> > CK
> > 
> > On Tue, 2017-01-24 at 13:10 +0800, Bibby Hsieh wrote:
> > > Current Mediatek DRM driver does not support interlaced mode, and
> > > will hang if such resolution is used: Filter those to prevent
> > > kernel hangs, until the DRM driver is fixed properly.
> > > 
> > > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > index 0e8c4d9..e33678d 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> > > @@ -1244,6 +1244,8 @@ static int mtk_hdmi_conn_mode_valid(struct drm_connector *conn,
> > >  			return MODE_BAD;
> > >  	}
> > >  
> > > +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> > > +		return MODE_NO_INTERLACE;
> > >  	if (mode->clock < 27000)
> > >  		return MODE_CLOCK_LOW;
> > >  	if (mode->clock > 297000)
> 
> You probably want to check out Jose's mode_valid work, since only
> filtering in the connector's ->mode_valid callback isn't enough. You also
> need to filter in ->mode_fixup (or some other place called at atomic_check
> time).
> -Daniel

Hi, Daniel:

Yes, I still need to filter in ->mode_fixup.

Hi, Bibby:

Because Jose's work plan to use mode_valid to replace mode_fixup, so
it's better to refine this patch after Jose's work is done. And I would
now remove this patch from my branch.

Regards,
CK
