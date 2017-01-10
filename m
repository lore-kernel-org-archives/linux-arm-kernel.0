From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 09:17:56 +0800
Subject: [PATCH v4 3/3] drm: zte: add overlay plane support
In-Reply-To: <CAOw6vbLrHuEa_L9uW6X-_ZMkfXyGjaFACFoedVYN1epeMW+9=w@mail.gmail.com>
References: <1483972544-12731-1-git-send-email-shawnguo@kernel.org>
 <1483972544-12731-4-git-send-email-shawnguo@kernel.org>
 <CAOw6vbLrHuEa_L9uW6X-_ZMkfXyGjaFACFoedVYN1epeMW+9=w@mail.gmail.com>
Message-ID: <20170110011754.GO20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Mon, Jan 09, 2017 at 11:27:44AM -0500, Sean Paul wrote:
> > +static inline void zx_osd_int_update(struct zx_crtc *zcrtc)
> > +{
> > +       struct zx_vou_hw *vou = zcrtc->vou;
> > +       int i;
> > +
> > +       vou_chn_set_update(zcrtc);
> > +       zx_plane_set_update(zcrtc->primary);
> > +
> > +       for (i = 0; i < VL_NUM; i++) {
> > +               struct drm_plane *overlay = vou->overlays[i];
> > +
> > +               if (overlay)
> > +                       zx_plane_set_update(overlay);
> > +       }
> 
> Hi Shawn,
> Thanks so much for revving this patch, it's looking really good. I
> just have one (1.5, really) suggestion.
> 
> I don't think we need to keep vou->overlays around. You should be able
> to loop through all the planes registered with drm core and use
> crtc->state->plane_mask to determine which are active for a given crtc
> (this would also encapsulate the zcrtc->primary update above).
> 
> I think you can also use if (plane->state->crtc) as your
> enable/disable check in zx_plane_set_update() and eliminate the new
> enabled flag.

Great.  Since I'm still quite new to DRM subsystem, such core
infrastructural usage guide are really helpful for me.  I tested the
changes as you suggested, and they worked just fine.  So happy to see my
code gets cleaned up further.

> I fully realize this was my suggestion, and I apologize
> for the churn. I'll try not to do reviews past midnight again :-)

I'm so grateful to you for helping review my code, especially in
midnight time :)

Shawn
