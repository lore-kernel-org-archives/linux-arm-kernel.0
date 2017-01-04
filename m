From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 04 Jan 2017 17:35:19 +0200
Subject: [PATCH v3] i2c: designware: add reset interface
In-Reply-To: <2921529.fKUMSWjgsl@wuerfel>
References: <1482500451-30137-1-git-send-email-zhangfei.gao@linaro.org>
 <2921529.fKUMSWjgsl@wuerfel>
Message-ID: <1483544119.9552.223.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-01-04 at 15:55 +0100, Arnd Bergmann wrote:
> On Friday, December 23, 2016 9:40:51 PM CET Zhangfei Gao wrote:
> > @@ -176,6 +177,14 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> > ????????dev->irq = irq;
> > ????????platform_set_drvdata(pdev, dev);
> > ?
> > +???????dev->rst = devm_reset_control_get_optional_exclusive(&pdev-
> > >dev, NULL);
> > +???????if (IS_ERR(dev->rst)) {
> > +???????????????if (PTR_ERR(dev->rst) == -EPROBE_DEFER)
> > +???????????????????????return -EPROBE_DEFER;
> > +???????} else {
> > +???????????????reset_control_deassert(dev->rst);
> > +???????}
> > +
> 
> Sorry for the late reply, I only now stumbled over this. I think it's
> generally wrong to ignore any error aside from -EPROBE_DEFER. It's
> better to single-out the error conditions you want to ignore (e.g.
> no reset specified) and ignore those but return an error for
> all other problems.

Which means that reset framework whenever work _optional is used should
return error iff (mind two f:s) there is a problem with existing
control.

> 
> > @@ -270,10 +280,18 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> > ????????}
> > ?
> > ????????r = i2c_dw_probe(dev);
> > -???????if (r && !dev->pm_runtime_disabled)
> > -???????????????pm_runtime_disable(&pdev->dev);
> > +???????if (r)
> > +???????????????goto exit_probe;
> > ?
> > ????????return r;
> > +
> > +exit_probe:
> > +???????if (!dev->pm_runtime_disabled)
> > +???????????????pm_runtime_disable(&pdev->dev);
> > +exit_reset:
> > +???????if (!IS_ERR_OR_NULL(dev->rst))
> > +???????????????reset_control_assert(dev->rst);
> > +???????return r;
> > 
> 
> try to avoid the IS_ERR_OR_NULL() check, it usually indicates either
> a bad interface, or that the interface is used wrong.

Please, fix reset framework first than.

For my understanding:
It should return NULL for optional reset control.
It should not fail on NULL argument.


> In this case, I think we can't get here with a NULL dev->rst
> pointer, so it's better to only check IS_ERR, or to explicitly
> set the pointer to NULL in case there is no reset line.
> 
> 	Arnd

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
