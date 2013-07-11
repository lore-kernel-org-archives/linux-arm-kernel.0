From: balbi@ti.com (Felipe Balbi)
Date: Thu, 11 Jul 2013 12:26:12 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <51DE780C.2070701@ti.com>
References: <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com>
 <20130710160704.GH18966@arwen.pp.htv.fi> <51DE780C.2070701@ti.com>
Message-ID: <20130711092612.GG23892@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 11, 2013 at 02:47:00PM +0530, Rajendra Nayak wrote:
> On Wednesday 10 July 2013 09:37 PM, Felipe Balbi wrote:
> > how about something like below ? It makes omap_device/hwmod and
> > pm_runtime agree on the initial state of the device and will prevent
> > ->runtime_resume() from being called on first pm_runtime_get*() done
> > during probe.
> > 
> > This is similar to what PCI bus does (if you look at pci_pm_init()).
> 
> I tried something similar [1] but what I found is that the serial
> runtime resume was called despite it being marked as active using
> pm_runtime_set_active().
> 
> That seems to be because of the pm_runtime_set_autosuspend_delay()
> because we have the autosuspend_delay = -1
> 
> -----
> static void update_autosuspend(struct device *dev, int old_delay, int old_use)
> {
>         int delay = dev->power.autosuspend_delay;
> 
>         /* Should runtime suspend be prevented now? */
>         if (dev->power.use_autosuspend && delay < 0) {
> 
>                 /* If it used to be allowed then prevent it. */
>                 if (!old_use || old_delay >= 0) {
>                         atomic_inc(&dev->power.usage_count);
>                         rpm_resume(dev, 0); <------------------------------- calls serial runtime resume.
>                 }
>         }
> -----
> 
> So we end up with the same issue with serial resume being called before set_termios()

yeah, that part I figured out after I started testing today. It seems
like my latest version is getting closer but I still see problems, diff
below:

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e6d2307..0cc2da9 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -181,6 +181,26 @@ odbfd_exit:
 	return ret;
 }
 
+static void omap_device_pm_init(struct platform_device *pdev)
+{
+	omap_device_enable(pdev);
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	device_enable_async_suspend(&pdev->dev);
+}
+
+static void omap_device_pm_allow(struct platform_device *pdev)
+{
+	pm_runtime_allow(&pdev->dev);
+}
+
+static void omap_device_pm_exit(struct platform_device *pdev)
+{
+	device_disable_async_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	omap_device_idle(pdev);
+}
+
 static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
@@ -192,16 +212,31 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_BIND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_init(pdev);
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_allow(pdev);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		if (pdev->archdata.od)
+			omap_device_pm_exit(pdev);
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
-		/* fall through */
+		break;
 	default:
-		od = to_omap_device(pdev);
-		if (od)
-			od->_driver_status = event;
+		/* nothing */
+		break;
 	}
 
+	od = to_omap_device(pdev);
+	if (od)
+		od->_driver_status = event;
+
 	return NOTIFY_DONE;
 }
 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/01d3f194/attachment.sig>
