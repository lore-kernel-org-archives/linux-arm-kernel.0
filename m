From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Dec 2013 13:56:18 -0600
Subject: [PATCH 7/7] usb: dwc3: exynos: add pm_runtime support
In-Reply-To: <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-8-git-send-email-balbi@ti.com>
 <000301cef7c0$640c1ce0$2c2456a0$%tikhomirov@samsung.com>
Message-ID: <20131213195618.GG5292@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:01:32PM +0900, Anton Tikhomirov wrote:
> Hi Felipe,
> 
> > -static int dwc3_exynos_suspend(struct device *dev)
> > +static int __dwc3_exynos_suspend(struct dwc3_exynos *exynos)
> >  {
> > -	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > -
> >  	clk_disable(exynos->clk);
> > 
> >  	return 0;
> >  }
> > 
> > +static int __dwc3_exynos_resume(struct dwc3_exynos *exynos)
> > +{
> > +	return clk_enable(exynos->clk);
> > +}
> > +
> > +static int dwc3_exynos_suspend(struct device *dev)
> > +{
> > +	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
> > +
> > +	return __dwc3_exynos_suspend(exynos);
> 
> If dwc3-exynos is runtime suspended, the clock will be disabled
> second time here (unbalanced clk_enable/clk_disable).

I don't get what you mean but there is something that probably needs
fixing, I guess below makes it better:

diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
index c93919a..1e5720a 100644
--- a/drivers/usb/dwc3/dwc3-exynos.c
+++ b/drivers/usb/dwc3/dwc3-exynos.c
@@ -218,6 +218,9 @@ static int dwc3_exynos_suspend(struct device *dev)
 {
 	struct dwc3_exynos *exynos = dev_get_drvdata(dev);
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	return __dwc3_exynos_suspend(exynos);
 }
 

Is that what you meant ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/b6321c93/attachment-0001.sig>
