From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:09:15 +0200
Subject: [PATCH 09/20] drm/sun4i: defer only if we didn't find our panel
In-Reply-To: <CAGb2v655q_w8s7Eg8xnpzdX9PDxSEhRLvMu3bNOd==U4APgg0Q@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-10-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v655q_w8s7Eg8xnpzdX9PDxSEhRLvMu3bNOd==U4APgg0Q@mail.gmail.com>
Message-ID: <20160525120915.GC9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 11:52:10AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Our code currently defers our probe on any error, even if we were not
> > expecting to have one at all.
> >
> > Make sure we return -EPROBE_DEFER only when we were supposed to have a
> > panel, but it's not probed yet.
> >
> > Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index 9f19b0e08560..eed6a9e8d9a6 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -429,7 +429,7 @@ static struct drm_panel *sun4i_tcon_find_panel(struct device_node *node)
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       return of_drm_find_panel(remote);
> > +       return of_drm_find_panel(remote) ?: ERR_PTR(-EPROBE_DEFER);
> 
> There's also a typo in the DRM_DEBUG_DRIVER call a few lines up. Could you
> fix it as well?

Done, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/7695e4da/attachment.sig>
