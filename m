From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jul 2011 20:13:17 +0300
Subject: [PATCH 2/2 V2] OMAP3+: PM: SR: add suspend/resume handlers
In-Reply-To: <CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
References: <1311526357-7578-1-git-send-email-nm@ti.com>
	<20110725084238.GC18062@legolas.emea.dhcp.ti.com>
	<CAOMWX4dC60SuF9=KDCrQo7zD5_PhTJhwuyqRkqj0ag8FHDQaxw@mail.gmail.com>
Message-ID: <20110725171317.GH18062@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 25, 2011 at 11:59:10AM -0500, Menon, Nishanth wrote:
> > On Sun, Jul 24, 2011 at 11:52:37AM -0500, Nishanth Menon wrote:
> >> SmartReflex should be disabled while entering low power mode due to
> >> the following reasons:
> >> a) SmartReflex values are not defined for retention voltage.
> >> b) With SmartReflex enabled, if the CPU enters low power state, FSM
> >> ? ?will try to bump the voltage to current OPP's voltage for which
> >> ? ?it has entered low power state, causing power loss and potential
> >> ? ?unknown states for the SoC.
> >> Since we are sure to attempt entering the lowest possible power state
> >> during suspend operation, SmartReflex needs to be disabled for the
> >> voltage domains in suspend path before achieving auto retention voltage
> >> on the device.
> >>
> >> Traditionally, this has been done with interrupts disabled as part of
> >> the common code which handles the idle sequence. Instead, by using the
> >> fact that we have to disable SmartReflex for sure during suspend
> >> operations, we can opportunistically disable SmartReflex in device
> >> standard pm ops, instead of disabling it as part of the code which
> >> executes with interrupts disabled and slave CPU{s} shutdown. This
> >> allows the system to do other parallel activities(such as suspending
> >> other devices in the system using slave CPU{s}) and save the time
> >> required to achieve suspend and resume from suspended state as a
> >> sequential activity.
> >>
> >> However, by being opportunistic as described above, we also increase
> >> the likelihood of SmartReflex library access functions being invoked in
> >> parallel contexts *after* SmartReflex driver's suspend handler (during
> >> suspend operation) or *before* resume handler (during resume operation)
> >> have been invoked (Example: DVFS for dependent devices, cpufreq for
> >> MPU etc.). We prevent this by using a flag to reject the callers in
> >> the duration where SmartReflex has been disabled.
> >
> > while at that, SR's IRQ is never freed on exit path, could fix it while
> > you're already there ?
> 
> This is not really related to this patch is it? IMHO IRQ handling is

I didn't say to put it on the same patch ;-) I meant that while at that,
you could add that simple fix before this patch ;-)

> broken badly. Current support is for SmartReflex class3 - which does
> not use the IRQ, Class2 and Class1.5 use it, but the current code
> requires major fixes which I dont intend to support in this series.

And that's exactly what I mean. IMHO it's far better to fix the mess
before adding more stuff, otherwise it just becomes an even bigger mess,
even more difficult to fix in the long run. We've seen that with GPIO
and sDMA drivers _at_least_ ;-(

> >> @@ -998,10 +1020,75 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
> >> ? ? ? return 0;
> >> ?}
> >>
> >> +static int omap_sr_suspend(struct device *dev)
> >> +{
> >> + ? ? struct omap_sr_data *pdata;
> >> + ? ? struct omap_sr *sr_info;
> >> +
> >> + ? ? pdata = dev_get_platdata(dev);
> >
> > I'm not sure you need to use platform data here...
> see below
> >
> >> + ? ? if (!pdata) {
> >> + ? ? ? ? ? ? dev_err(dev, "%s: platform data missing\n", __func__);
> >> + ? ? ? ? ? ? return -EINVAL;
> >> + ? ? }
> >> +
> >> + ? ? sr_info = _sr_lookup(pdata->voltdm);
> >
> > this field is held on struct omap_sr. Can't you:
> >
> > ? ? ? ?struct omap_sr ?*info = dev_get_drvdata(dev);
> >
> > ?? I see that a platform_set_drvdata() is missing from the driver, but
> > maybe you should add that instead of accessing platform_data.
> omap_sr_data is added in arch/arm/mach-omap2/sr_device.c
> 
> With the current handling - it needs sr_data from which sr_info is
> pulled out. in the current implementation, sr_data contains the voltdm
> pointer from which sr_info is pulled out.

but sr_info is allocated on probe() isn't it ? if you add
platform_set_drvdata(pdev, sr_info) on probe, you won't need sr_data to
fetch sr_info, all you need is to use dev_get_drvdata(dev). Am I missing
something ?

> >> ?static struct platform_driver smartreflex_driver = {
> >> ? ? ? .remove ? ? ? ? = omap_sr_remove,
> >> ? ? ? .driver ? ? ? ? = {
> >> ? ? ? ? ? ? ? .name ? = "smartreflex",
> >> + ? ? ? ? ? ? .pm ? ? = &omap_sr_dev_pm_ops,
> >
> > this should not be valid in case CONFIG_PM isn't enabled.
> a) arch/arm/plat-omap/Kconfig
> CONFIG_OMAP_SMARTREFLEX depends on PM.
> b) SmartReflex is PM feature
> 
> I dont see a need to add redundant code here.

fair enough if this will never build without CONFIG_PM ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110725/b13e3df7/attachment.sig>
