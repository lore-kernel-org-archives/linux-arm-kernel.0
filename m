From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 29 Jun 2016 12:28:58 -0700
Subject: [PATCH 15/21] usb: chipidea: msm: Mux over secondary phy at the
 right time
In-Reply-To: <20160629080852.GJ25236@shlinux2>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-16-stephen.boyd@linaro.org>
 <20160629080852.GJ25236@shlinux2>
Message-ID: <146722853892.16253.6137643683844696922@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-06-29 01:08:52)
> On Sun, Jun 26, 2016 at 12:28:32AM -0700, Stephen Boyd wrote:
> > We need to pick the correct phy at runtime based on how the SoC
> > has been wired onto the board. If the secondary phy is used, take
> > it out of reset and mux over to it by writing into the TCSR
> > register. Make sure to do this on reset too, because this
> > register is reset to the default value (primary phy) after the
> > RESET bit is set in USBCMD.
> > 
> 
> I am curious when you need the secondary phy?
> 
> > Cc: Peter Chen <peter.chen@nxp.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_msm.c | 78 +++++++++++++++++++++++++++++++++++---
> >  1 file changed, 73 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
> > index 40249b0e3e93..df0f8b31db4f 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_msm.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_msm.c
> > @@ -8,30 +8,40 @@
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > -#include <linux/usb/gadget.h>
> >  #include <linux/usb/chipidea.h>
> >  #include <linux/clk.h>
> >  #include <linux/reset.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > +#include <linux/io.h>
> >  
> >  #include "ci.h"
> >  
> >  #define HS_PHY_AHB_MODE                      0x0098
> > +#define HS_PHY_SEC_CTRL                      0x0278
> > +# define HS_PHY_DIG_CLAMP_N          BIT(16)
> >  
> 
> One space at the beginning, and keep alignment.
> 
> >  struct ci_hdrc_msm {
> >       struct platform_device *ci;
> >       struct clk *core_clk;
> >       struct clk *iface_clk;
> > +     bool secondary_phy;
> > +     void __iomem *base;
> >  };
> >  
> >  static void ci_hdrc_msm_notify_event(struct ci_hdrc *ci, unsigned event)
> >  {
> > -     struct device *dev = ci->gadget.dev.parent;
> > +     struct device *dev = ci->dev->parent;
> > +     struct ci_hdrc_msm *msm_ci = dev_get_drvdata(dev);
> >  
> >       switch (event) {
> >       case CI_HDRC_CONTROLLER_RESET_EVENT:
> >               dev_dbg(dev, "CI_HDRC_CONTROLLER_RESET_EVENT received\n");
> >               /* use AHB transactor, allow posted data writes */
> >               hw_write_id_reg(ci, HS_PHY_AHB_MODE, 0xffffffff, 0x8);
> > +             if (msm_ci->secondary_phy)
> > +                     hw_write_id_reg(ci, HS_PHY_SEC_CTRL, HS_PHY_DIG_CLAMP_N,
> > +                                     HS_PHY_DIG_CLAMP_N);
> >               break;
> >       default:
> >               dev_dbg(dev, "unknown ci_hdrc event\n");
> > @@ -49,12 +59,58 @@ static struct ci_hdrc_platform_data ci_hdrc_msm_platdata = {
> >       .notify_event           = ci_hdrc_msm_notify_event,
> >  };
> >  
> > +static int ci_hdrc_msm_mux_phy(struct ci_hdrc_msm *ci,
> > +                            struct platform_device *pdev)
> > +{
> > +     struct regmap *regmap;
> > +     struct device_node *syscon;
> > +     struct device *dev = &pdev->dev;
> > +     u32 off, val;
> > +     int ret;
> > +
> > +     syscon = of_parse_phandle(dev->of_node, "phy-select", 0);
> > +     if (!syscon)
> > +             return 0;
> > +
> > +     regmap = syscon_node_to_regmap(syscon);
> > +     if (IS_ERR(regmap))
> > +             return PTR_ERR(regmap);
> > +
> > +     ret = of_property_read_u32_index(dev->of_node, "phy-select", 1, &off);
> > +     if (ret < 0) {
> > +             dev_err(dev, "no offset in syscon\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = of_property_read_u32_index(dev->of_node, "phy-select", 2, &val);
> > +     if (ret < 0) {
> > +             dev_err(dev, "no value in syscon\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret = regmap_write(regmap, off, val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ci->secondary_phy = !!val;
> > +     if (ci->secondary_phy) {
> > +             val = readl_relaxed(ci->base + HS_PHY_SEC_CTRL);
> > +             val |= HS_PHY_DIG_CLAMP_N;
> > +             writel_relaxed(val, ci->base + HS_PHY_SEC_CTRL);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >  {
> >       struct ci_hdrc_msm *ci;
> >       struct platform_device *plat_ci;
> >       struct clk *clk;
> >       struct reset_control *reset;
> > +     struct resource *res;
> > +     void __iomem *base;
> > +     resource_size_t size;
> >       int ret;
> >  
> >       dev_dbg(&pdev->dev, "ci_hdrc_msm_probe\n");
> > @@ -76,6 +132,15 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> >       if (IS_ERR(clk))
> >               return PTR_ERR(clk);
> >  
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (!res)
> > +             return -ENODEV;
> > +
> > +     size = resource_size(res);
> > +     ci->base = base = devm_ioremap(&pdev->dev, res->start, size);
> > +     if (!base)
> > +             return -ENOMEM;
> > +
> 
> The core will do the ioremap too, you can't remap io address two times.

You can ioremap an address twice, but it's not a great solution. On ARM,
at least, we detect the double mapping and return the same virtual
address the second time.

> The offset larger than 0x200 is vendor specific, you can map it as
> the second io region.

Ok. That would mean we need to adjust the binding then to have to reg
properties? Or we can limit the size of the resource in the core and the
size of the resource here can be bumped up by 0x200. So DT still says
one resource for the entire ci address space but we don't map anything
more than what we use. Something like this?

---8<----
diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 4c70fa6fdc34..1121cf3e3fdc 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -190,8 +190,9 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 
-	size = resource_size(res);
-	ci->base = base = devm_ioremap(&pdev->dev, res->start, size);
+	res->start += 0x200;
+	res->end -= 0x200;
+	ci->base = base = devm_ioremap_resource(&pdev->dev, res);
 	if (!base)
 		return -ENOMEM;
 
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 298029a9ffce..8f5782913b11 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -887,6 +887,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (resource_size(res) > 0x200)
+		res->end = res->start + 0x200;
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
