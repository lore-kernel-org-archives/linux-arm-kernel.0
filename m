From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Oct 2014 09:41:40 -0500
Subject: [PATCH 1/3] video: fbdev: omap2: omapfb: remove __exit annotation
In-Reply-To: <543E64EE.4070104@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
 <543E64EE.4070104@ti.com>
Message-ID: <20141015144140.GD10888@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 15, 2014 at 03:13:34PM +0300, Tomi Valkeinen wrote:
> Hi,
> 
> On 14/10/14 21:28, Felipe Balbi wrote:
> > if we leave __exit annotation, driver can't be unbound
> > through sysfs.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > index ec2d132..9cbf1ce 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
> > @@ -2619,7 +2619,7 @@ err0:
> >  	return r;
> >  }
> >  
> > -static int __exit omapfb_remove(struct platform_device *pdev)
> > +static int omapfb_remove(struct platform_device *pdev)
> >  {
> >  	struct omapfb2_device *fbdev = platform_get_drvdata(pdev);
> >  
> > @@ -2636,7 +2636,7 @@ static int __exit omapfb_remove(struct platform_device *pdev)
> >  
> >  static struct platform_driver omapfb_driver = {
> >  	.probe		= omapfb_probe,
> > -	.remove         = __exit_p(omapfb_remove),
> > +	.remove         = omapfb_remove,
> >  	.driver         = {
> >  		.name   = "omapfb",
> >  		.owner  = THIS_MODULE,
> 
> Interesting. I don't know if I'm doing something funny, but without this
> patch, I can unbind omapfb, kind of.
> 
> "echo omapfb > unbind" goes ok, but remove is obviously not called.

remove isn't called because it won't exist if it's built-in. Look at the
definition of __exit_p()

> Somehow omapfb device is still unbound from the driver, as I can then
> bind it again, causing probe to be called. Which breaks everything.
> 
> I would've thought that unbinding is not possible if remove is missing,
> but that doesn't seem to be the case. I guess it just means that remove
> is not called when the driver & device are unbound.

if no remove it provided on platform_driver structure, platform bus
assumes you have nothing to do on your ->remove(), so you end up leaking
all resources you allocated on ->probe() (unless you *really* don't need
to do anything on ->remove).

> We have 18 __exit_p()s in omapdss and related drivers. I guess they are
> all broken the same way.

yup, I should've grepped.

> Note that omapfb unbind & bind does not work even with this patch, but
> results in a crash as some old state is left into omapdss. The same
> happens also with unloading and loading omapfb module (but keeping
> omapdss module loaded).

It worked fine for me. I unbound and bound omapfb multiple times.

> So there seems to be more issues around this.

quite a few more, I'd say

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/2c0f0d39/attachment.sig>
