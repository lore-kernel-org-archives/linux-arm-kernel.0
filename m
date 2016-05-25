From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:06:37 +0200
Subject: [PATCH 08/20] drm/sun4i: rgb: panel is an error pointer
In-Reply-To: <CAGb2v6485nF_e9GeANLsy2Rq1XOn4nV5wD_eWskTmL2ME316+w@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-9-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v6485nF_e9GeANLsy2Rq1XOn4nV5wD_eWskTmL2ME316+w@mail.gmail.com>
Message-ID: <20160525120637.GB9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 11:51:36AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > In case of an error, our pointer to the drm_panel structure attached to our
> > encoder will hold an error pointer, not a NULL pointer.
> >
> > Make sure we check the right thing.
> >
> > Fixes: 29e57fab97fc ("drm: sun4i: Add RGB output")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_rgb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > index 923f55039cb1..b46d2c15dc95 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> > @@ -217,7 +217,7 @@ int sun4i_rgb_init(struct drm_device *drm)
> >         int ret;
> >
> >         /* If we don't have a panel, there's no point in going on */
> > -       if (!tcon->panel)
> > +       if (IS_ERR(tcon->panel))
> 
> Without the next patch, tcon->panel could be the result of of_drm_find_panel(),
> which could be NULL.
> 
> Use IS_ERR_OR_NULL here, or reorder/squash the patches.

Switched the order, and applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/c766743b/attachment.sig>
