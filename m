From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 27 Apr 2016 14:33:43 +0800
Subject: [RESEND PATCH v2 5/7] usb: xhci: plat: Remove checks for
 optional clock in error/remove path
In-Reply-To: <87h9enpqdb.fsf@intel.com>
References: <1461675460-2295-1-git-send-email-jszhang@marvell.com>
 <1461675460-2295-6-git-send-email-jszhang@marvell.com>
 <87h9enpqdb.fsf@intel.com>
Message-ID: <20160427143343.6510ff57@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Felipe,

On Wed, 27 Apr 2016 08:33:52 +0300 Felipe Balbi wrote:

> Jisheng Zhang <jszhang@marvell.com> writes:
> > Commit 63589e92c2d9 ("clk: Ignore error and NULL pointers passed to
> > clk_{unprepare, disable}()") allows NULL or error pointer to be passed
> > unconditionally.
> >
> > This patch is to simplify probe error and remove code paths.  
> 
> this seems wrong to me. xhci->clk isn't initialized to NULL, it's either
> initialized to a valid struct clk * or some ERR_PTR() value.

Commit 63589e92c2d9 could also ignore error value ;)

> 
> Care to explain ?
> 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/usb/host/xhci-plat.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 0e69712..83669d0 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -266,8 +266,7 @@ put_usb3_hcd:
> >  	usb_put_hcd(xhci->shared_hcd);
> >  
> >  disable_clk:
> > -	if (!IS_ERR(clk))
> > -		clk_disable_unprepare(clk);
> > +	clk_disable_unprepare(clk);
> >  
> >  put_hcd:
> >  	usb_put_hcd(hcd);
> > @@ -287,8 +286,7 @@ static int xhci_plat_remove(struct platform_device *dev)
> >  	usb_remove_hcd(hcd);
> >  	usb_put_hcd(xhci->shared_hcd);
> >  
> > -	if (!IS_ERR(clk))
> > -		clk_disable_unprepare(clk);
> > +	clk_disable_unprepare(clk);
> >  	usb_put_hcd(hcd);
> >  
> >  	return 0;
> > -- 
> > 2.8.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html  
> 
