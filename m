From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Mon, 28 Jun 2010 16:27:23 -0700
Subject: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com>
	<AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
Message-ID: <87fx06viuc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

[...]

>
>> This affects many aspects of all drivers, from register and probe (for
>> early devices/drivers too!) to all the plaform_get_resource() usage, all
>> of which assumes a platform_driver and platform_device. ?I didn't look
>> closely, but I didn't see if (or how) OF was handling early devices.
>
> You don't have to reimplement the entire platform bus.  You could
> simply create a new bus type, but reuse all the existing platform bus
> code.  All that changes is the bus type that the device and the driver
> gets registered on.  Then you could easily replace only the functions
> that matter.  (do a git grep platform_bus_type to see how few
> references there actually are.  It looks like there are only 5
> references to it in drivers/base/platform.c that you'd need to work
> around; in platform_device_add(), platform_driver_register(), 2 in
> platform_driver_probe(), and the register in platform_bus_init().  You
> may not even need to reimplement platform_driver_probe().
>
> It might even be as simple as doing this:
> -        pdev->dev.bus = &platform_bus_type;
> +       if (!pdev->dev.bus)
> +                pdev->dev.bus = &platform_bus_type;
>
> So that a different bus type can be selected at device registration
> time 

just FYI...

as a quick proof of concept, I've done a quick hack just to prove to
myself that I could use platform_devices on a custom bus, and it indeed
works.  The small patch below[1] shows the changes required to the
platform code.

Next step was to hack up minimal custom bus code.  The quickest (and
dirtiest) way was to simply memcpy platform_bus_type into my new
omap_bus_type and then override the few dev_pm_ops functions I needed[2].

So, with these in place, and using the dev_pm_ops functions from
$SUBJECT patch, I was able register a platform_device and
platform_driver onto my custom bus and see my custom dev_pm_ops
functions being used as expected.

While admittedly a bit hacky, at least this paves the way in my head
that this is indeed do-able, and I can take my vacation in peace without
this particular problem haunting me (too much.)

Kevin

[1]
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 4d99c8b..2cf55e2 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -241,7 +241,8 @@ int platform_device_add(struct platform_device *pdev)
 	if (!pdev->dev.parent)
 		pdev->dev.parent = &platform_bus;
 
-	pdev->dev.bus = &platform_bus_type;
+	if (!pdev->dev.bus)
+		pdev->dev.bus = &platform_bus_type;
 
 	if (pdev->id != -1)
 		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
@@ -482,7 +483,8 @@ static void platform_drv_shutdown(struct device *_dev)
  */
 int platform_driver_register(struct platform_driver *drv)
 {
-	drv->driver.bus = &platform_bus_type;
+	if (!drv->driver.bus)
+		drv->driver.bus = &platform_bus_type;
 	if (drv->probe)
 		drv->driver.probe = platform_drv_probe;
 	if (drv->remove)
@@ -539,12 +541,12 @@ int __init_or_module platform_driver_probe(struct platform_driver *drv,
 	 * if the probe was successful, and make sure any forced probes of
 	 * new devices fail.
 	 */
-	spin_lock(&platform_bus_type.p->klist_drivers.k_lock);
+	spin_lock(&drv->driver.bus->p->klist_drivers.k_lock);
 	drv->probe = NULL;
 	if (code == 0 && list_empty(&drv->driver.p->klist_devices.k_list))
 		retval = -ENODEV;
 	drv->driver.probe = platform_drv_probe_fail;
-	spin_unlock(&platform_bus_type.p->klist_drivers.k_lock);
+	spin_unlock(&drv->driver.bus->p->klist_drivers.k_lock);
 
 	if (code != retval)
 		platform_driver_unregister(drv);


[2] 
struct bus_type omap_bus_type;
EXPORT_SYMBOL_GPL(omap_bus_type);

static int __init omap_bus_init(void)
{
	int error;
	struct bus_type *bus = &omap_bus_type;

	pr_debug("%s\n", __func__);

	/*
	 * We're just a copy of platform_bus_type with special dev_pm_ops.
	 */
	memcpy(bus, &platform_bus_type, sizeof(struct bus_type));
	bus->name = "omap";
	bus->pm->suspend_noirq = omap_pm_suspend_noirq,
	bus->pm->resume_noirq = omap_pm_resume_noirq,
	bus->pm->runtime_suspend = omap_pm_runtime_suspend,
	bus->pm->runtime_resume = omap_pm_runtime_resume,
	bus->pm->runtime_idle = omap_pm_runtime_idle,

	error = device_register(&omap_bus);
	if (error)
		return error;
	error =  bus_register(&omap_bus_type);
	if (error)
		device_unregister(&omap_bus);

	return error;
}
arch_initcall(omap_bus_init);
