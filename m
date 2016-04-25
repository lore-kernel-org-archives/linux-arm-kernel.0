From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 25 Apr 2016 17:13:32 +0800
Subject: [PATCH v4] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
In-Reply-To: <1461575235.17131.3.camel@linux.intel.com>
References: <1461314971-5944-1-git-send-email-jszhang@marvell.com>
 <571A2E43.9030109@linux.intel.com>	<1461575235.17131.3.camel@linux.intel.com>
Message-ID: <20160425171332.468f0bc0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andy

On Mon, 25 Apr 2016 12:07:15 +0300 Andy Shevchenko  wrote:

> On Fri, 2016-04-22 at 16:59 +0300, Jarkko Nikula wrote:
> > Hi
> > 
> > On 04/22/2016 11:49 AM, Jisheng Zhang wrote:  
> > > 
> > > If i2c_dw_probe() fails, we should disable and unprepare the clock,
> > > otherwise the clock enable and prepare is left unbalanced.
> > > 
> > > In dw_i2c_plat_remove(), we'd better to not rely on runtime PM to
> > > disable and unprepare the clock since CONFIG_PM may be disabled when
> > > configuring the kernel. So we explicitly disable and unprepare the
> > > clock in dw_i2c_plat_remove() rather than implicitly rely on
> > > pm_runtime_put_sync(). To keep the device usage count balanced, we
> > > call pm_runtime_put_noidle() to decrease the usage count.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > > ? Since v3:
> > > ???- use runtime PM rather than rpm in commit msg
> > > ???- remove duplicated "(" in commit msg
> > > 
> > > ? Since v2:
> > > ???- s/clk/clock
> > > ???- describe why use pm_runtime_put_noidle()
> > > 
> > > ? Since v1:
> > > ???- fix commit msg: "not rely on rpm" rather than "rely on rpm"
> > > ???- call i2c_dw_plat_prepare_clk after pm_rumtime_disable()
> > > ? drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++------
> > > ? 1 file changed, 10 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > index d656657..a771781 100644
> > > --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> > > +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> > > @@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct
> > > platform_device *pdev)
> > > ??	}
> > > 
> > > ??	r = i2c_dw_probe(dev);
> > > -	if (r && !dev->pm_runtime_disabled)
> > > -		pm_runtime_disable(&pdev->dev);
> > > +	if (r) {
> > > +		if (!dev->pm_runtime_disabled)
> > > +			pm_runtime_disable(&pdev->dev);
> > > +		i2c_dw_plat_prepare_clk(dev, false);
> > > +	}
> > > 
> > > ??	return r;
> > > ? }
> > > @@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct
> > > platform_device *pdev)
> > > ??	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
> > > 
> > > ??	pm_runtime_get_sync(&pdev->dev);
> > > +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > +	if (!dev->pm_runtime_disabled)
> > > +		pm_runtime_disable(&pdev->dev);
> > > +	pm_runtime_put_noidle(&pdev->dev);
> > > 
> > > ??	i2c_del_adapter(&dev->adapter);
> > > 
> > > ??	i2c_dw_disable(dev);
> > > 
> > > -	pm_runtime_dont_use_autosuspend(&pdev->dev);
> > > -	pm_runtime_put_sync(&pdev->dev);
> > > -	if (!dev->pm_runtime_disabled)
> > > -		pm_runtime_disable(&pdev->dev);
> > > +	i2c_dw_plat_prepare_clk(dev, false);
> > >   
> > This feels a bit an invasive change to me for unbalanced clock?
> > enable/disable and I noticed this changes semantics how?
> > drivers/acpi/acpi_lpss.c devices are shutdown when removing the
> > driver.?
> > Although I didn't notice does it cause any regression.
> > 
> > Before patch:
> > 1. drivers/base/dd.c: __device_release_driver()
> > ????- pm_runtime_get_sync()
> > ??????-> acpi_device_set_power(D0)
> > ?????????acpi_lpss_restore_ctx()
> > ?????????dw_i2c_plat_resume()
> > 2. dw_i2c_plat_remove()
> > ????- pm_runtime_dont_use_autosuspend()
> > ??????pm_runtime_put_sync()
> > ??????-> dw_i2c_plat_suspend()
> > ?????????acpi_lpss_save_ctx()
> > ?????????acpi_device_set_power(D3)
> > 3. __device_release_driver() continue
> > ????- dev->pm_domain->dismiss(dev)
> > ??????-> acpi_lpss_dismiss() ... -> acpi_device_set_power(D3)
> > 
> > After patch:
> > 1. drivers/base/dd.c: __device_release_driver()
> > ? - pm_runtime_get_sync()
> > ????-> acpi_device_set_power(D0)
> > ???????acpi_lpss_restore_ctx()
> > ???????dw_i2c_plat_resume()
> > 2. dw_i2c_plat_remove()
> > ????- pm_runtime_dont_use_autosuspend()
> > ??????pm_runtime_put_noidle()
> > ??????* no device suspending and acpi_lpss_save_ctx()
> > 3. __device_release_driver() continue
> > ????- dev->pm_domain->dismiss(dev)
> > ????-> acpi_lpss_dismiss() ... -> acpi_device_set_power(D3)
> > ??????* powers down here
> > 
> > So after patch there is no acpi_lpss_save_ctx() call but I don't see?
> > does it cause any issue here. Maybe it's better to track clock only.?
> > What you think Andy?  
> 
> Now it looks like two fixes in one patch. From the commit message I
> didn't get the relation between change runtime PM call (one to the
> other) and clock (un)preparation.
> 

I'm not sure I got your points. There are two unbalanced clk enable and
prepare issues before the patch:

one is in the i2c_dw_probe() failure path. another is in the remove path when
CONFIG_PM is disabled.

The patch addresses this unbalance.

Thanks,
Jisheng
