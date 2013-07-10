From: balbi@ti.com (Felipe Balbi)
Date: Wed, 10 Jul 2013 19:07:04 +0300
Subject: Boot hang regression 3.10.0-rc4 -> 3.10.0
In-Reply-To: <20130710142633.GV5523@atomide.com>
References: <20130705115959.GQ5523@atomide.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94489@DBDE04.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EE94520@DBDE04.ent.ti.com>
 <20130708112553.GU5523@atomide.com> <51DAB394.3050104@ti.com>
 <20130708131033.GA5523@atomide.com> <51DABC81.3080409@ti.com>
 <20130708133512.GD31221@arwen.pp.htv.fi>
 <87mwpuakod.fsf@linaro.org> <20130710142633.GV5523@atomide.com>
Message-ID: <20130710160704.GH18966@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 10, 2013 at 07:26:34AM -0700, Tony Lindgren wrote:
> * Kevin Hilman <khilman@linaro.org> [130710 01:29]:
> > Felipe Balbi <balbi@ti.com> writes:
> > >> 
> > >> Right, but calling serial_omap_restore_context() even when the context
> > >> is not lost, should not ideally cause an issue.
> > >
> > > it does in one condition. If context hasn't been saved before. And that
> > > can happen in the case of wrong pm runtime status for that device.
> > >
> > > Imagine the device is marked as suspended even though it's fully enabled
> > > (it hasn't been suspended by hwmod due to NO_IDLE flag). In that case
> > > your context structure is all zeroes (context has never been saved
> > > before) then when you call pm_runtime_get_sync() on probe() your
> > > ->runtime_resume() will get called, which will restore context,
> > > essentially undoing anything which was configured by u-boot.
> > >
> > > Am I missing something ?
> > 
> > You're right, the _set_active() is crucial in the case when we prevent
> > the console UART from idling during boot (though that shouldn't be
> > happening in mainline unless the fix for "Issue 1" is done.)
> 
> Felipe is right, looks like all we need is to check if context is
> initialized or not. So no need for mach-omap2/serial.c or hwmod tinkering.
> 
> After that having DEBUG_LL and cmdline with earlyprintk console=ttyO..
> works for me. We could also check for some combination of the context
> save registers being NULL if somebody has a good idea which ones
> should never be 0.
> 
> Regards,
> 
> Tony
> 
> 
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -161,6 +161,7 @@ struct uart_omap_port {
>  	u32			calc_latency;
>  	struct work_struct	qos_work;
>  	struct pinctrl		*pins;
> +	bool			initialized;
>  	bool			is_suspending;
>  };
>  
> @@ -1523,6 +1524,8 @@ static int serial_omap_probe(struct platform_device *pdev)
>  
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
> +	up->initialized = true;
> +
>  	return 0;
>  
>  err_add_port:
> @@ -1584,6 +1587,9 @@ static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
>  #ifdef CONFIG_PM_RUNTIME
>  static void serial_omap_restore_context(struct uart_omap_port *up)
>  {
> +	if (!up->initialized)
> +		return;
> +
>  	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
>  		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
>  	else

how about something like below ? It makes omap_device/hwmod and
pm_runtime agree on the initial state of the device and will prevent
->runtime_resume() from being called on first pm_runtime_get*() done
during probe.

This is similar to what PCI bus does (if you look at pci_pm_init()).

commit 59108a500b4ab4b1a5102648a3360276dbf7df6f
Author: Felipe Balbi <balbi@ti.com>
Date:   Wed Jul 10 18:50:16 2013 +0300

    arm: omap2plus: unidle devices which are about to probe
    
    in order to make HWMOD and pm_runtime agree on the
    initial state of the device, we will unidle the device
    and call pm_runtime_set_active() to tell pm_runtime
    that the device is really active.
    
    By the time driver's probe() is reached, a call to
    pm_runtime_get_sync() will not cause driver's
    ->runtime_resume() method to be called at first, only
    after a successful ->runtime_suspend().
    
    Signed-off-by: Felipe Balbi <balbi@ti.com>

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index e6d2307..1cedf3a 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -181,6 +181,26 @@ odbfd_exit:
 	return ret;
 }
 
+static void omap_device_pm_init(struct platform_device *pdev);
+{
+	/*
+	 * if we reach this function, it's because the device is about to be
+	 * probed. In such cases, we will enable the device, and call
+	 * pm_runtime_set_active() so that the device driver and runtime PM
+	 * framework agree on initial state of the device.
+	 */
+	omap_device_enable(pdev);
+	pm_runtime_set_active(&pdev->dev);
+	device_enable_async_suspend(&pdev->dev);
+}
+
+static void omap_device_pm_exit(struct platform_device *pdev);
+{
+	device_disable_async_suspend(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	omap_device_idle(pdev);
+}
+
 static int _omap_device_notifier_call(struct notifier_block *nb,
 				      unsigned long event, void *dev)
 {
@@ -192,6 +212,12 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 		if (pdev->archdata.od)
 			omap_device_delete(pdev->archdata.od);
 		break;
+	case BUS_NOTIFY_BIND_DRIVER:
+		omap_device_pm_init(pdev);
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		omap_device_pm_exit(pdev);
+		break;
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130710/5f849a70/attachment.sig>
