From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 26 Jan 2016 12:25:47 +0000
Subject: [PATCH 3/3] tty: hvc_xen: hide xen_console_remove when unused
In-Reply-To: <56A6AA42.3000705@oracle.com>
References: <1453758918-3577213-1-git-send-email-arnd@arndb.de>
 <1453758918-3577213-3-git-send-email-arnd@arndb.de>
 <56A6AA42.3000705@oracle.com>
Message-ID: <alpine.DEB.2.02.1601261225150.3619@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Jan 2016, Boris Ostrovsky wrote:
> On 01/25/2016 04:54 PM, Arnd Bergmann wrote:
> > xencons_disconnect_backend() is only called from xen_console_remove(),
> 
> and also from xencons_probe()/xencons_resume(). But those two are also under
> the
> same ifdef.

Good point. Aside from this the patch is good.

 
> > which is conditionally compiled, so we get a harmless warning when
> > CONFIG_HVC_XEN_FRONTEND is unset:
> > 
> > hvc/hvc_xen.c:350:12: error: 'xen_console_remove' defined but not used
> > [-Werror=unused-function]
> > 
> > This moves the function down into the same #ifdef section to silence
> > the warning.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >   drivers/tty/hvc/hvc_xen.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> > index fa816b7193b6..11725422dacb 100644
> > --- a/drivers/tty/hvc/hvc_xen.c
> > +++ b/drivers/tty/hvc/hvc_xen.c
> > @@ -323,6 +323,7 @@ void xen_console_resume(void)
> >   	}
> >   }
> >   +#ifdef CONFIG_HVC_XEN_FRONTEND
> >   static void xencons_disconnect_backend(struct xencons_info *info)
> >   {
> >   	if (info->irq > 0)
> > @@ -363,7 +364,6 @@ static int xen_console_remove(struct xencons_info *info)
> >   	return 0;
> >   }
> >   -#ifdef CONFIG_HVC_XEN_FRONTEND
> >   static int xencons_remove(struct xenbus_device *dev)
> >   {
> >   	return xen_console_remove(dev_get_drvdata(&dev->dev));
> 
