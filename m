From: balbi@ti.com (Felipe Balbi)
Date: Tue, 21 Aug 2012 16:01:36 +0300
Subject: [PATCH v2 00/13] OMAP Serial patches
In-Reply-To: <1345551371-18862-1-git-send-email-balbi@ti.com>
References: <1345540555-24359-1-git-send-email-balbi@ti.com>
 <1345551371-18862-1-git-send-email-balbi@ti.com>
Message-ID: <20120821130134.GH10347@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2012 at 03:15:58PM +0300, Felipe Balbi wrote:
> Hi guys,
> 
> here's a series of cleanup patches to the OMAP serial
> driver. A later series could be made re-implementing
> DMA using the DMA Engine API. Note that for RX DMA
> we could be using RX Timeout IRQ as a hint that we better
> use PIO instead ;-)
> 
> All patches were tested on my pandaboard, but I'd really
> like to receive Tested-by on other platforms.
> 
> After this goes in, I'll probably try to get UART wakeup
> working again and only after that look at DMA.
> 
> Changes since v1:
> 
> 	. improved commit log on patch 9/13 (formerly 10/13)
> 	. removed patch 2/13
> 	. added a new patch switching from spin_lock_irqsave() to spin_lock and
> 		spin_unlock_irqrestore to spin_unlock
> 
> Retested with my pandaboard, UART continues to work:
> 
>  # grep -i uart /proc/interrupts
>  106:        124          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        189          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        255          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        321          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        387          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        453          0       GIC  OMAP UART2
>  #  grep -i uart /proc/interrupts
>  106:        519          0       GIC  OMAP UART2
> 
> cheers
> 
> ps: if anyone knows a better test for UART, let me know.
> 
> for convenience of anyone testing, patches are available on my git tree [1] on
> branch uart
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git uart

I have added one extra patch to this series:

>From 6921efdb13dda7af216b331bb35535d4b53f004a Mon Sep 17 00:00:00 2001
From: Felipe Balbi <balbi@ti.com>
Date: Tue, 21 Aug 2012 15:48:35 +0300
Subject: [PATCH] serial: omap: drop pm_runtime_irq_safe() usage

pm_runtime_irq_safe() will essentially do an
unbalanced pm_runtime_get_sync() on our parent
device, which might cause problems when trying
to suspend.

In order to prevent that we drop pm_runtime_irq_safe
usage in exchange for a little performance hit
when we enter our IRQ handler while still suspended.

If that happens, what we will do is set the irq_pending
flag, do an asynchronous pm_runtime_get() call and
return IRQ_HANDLED. When our runtime_resume() callback
is executed, we check for that flag, and run our
IRQ handler so that we receive/transmit the pending
characters.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

One extra patch to OMAP UART driver. This seems to be working
pretty well even after echo mem > /sys/power/state. I can
see that I can even wake my pandaboard up by sending a character
through serial:

 #  echo mem > /sys/power/state
 [ 1335.679260] PM: Syncing filesystems ... done.
 [ 1335.684387] Freezing user space processes ... (elapsed 0.00 seconds) done.
 [ 1335.691741] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
 [ 1335.720886] Suspending console(s) (use no_console_suspend to debug)
 
 [ 1335.734405] PM: suspend of devices complete after 5.492 msecs
 [ 1335.735534] PM: late suspend of devices complete after 1.128 msecs
 [ 1335.737518] PM: noirq suspend of devices complete after 1.952 msecs
 [ 1335.737518] Disabling non-boot CPUs ...
 [ 1335.738525] CPU1: shutdown
 [ 1338.543762] Successfully put all powerdomains to target state
 [ 1338.543853] Enabling non-boot CPUs ...
 [ 1338.545654] CPU1: Booted secondary processor
 [ 1338.546020] CPU1 is up
 [ 1338.547027] PM: noirq resume of devices complete after 0.976 msecs
 [ 1338.548400] PM: early resume of devices complete after 0.762 msecs
 [ 1339.827087] PM: resume of devices complete after 1278.686 msecs
 [ 1339.890960] Restarting tasks ... done.
 # # grep -i uart /proc/interrupts
 106:       3385          0       GIC  OMAP UART2
 # echo mem > /sys/power/state
 [ 1358.015624] PM: Syncing filesystems ... done.
 [ 1358.020812] Freezing user space processes ... (elapsed 0.00 seconds) done.
 [ 1358.028167] Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
 [ 1358.055084] Suspending console(s) (use no_console_suspend to debug)
 
 [ 1358.068847] PM: suspend of devices complete after 5.633 msecs
 [ 1358.070007] PM: late suspend of devices complete after 1.126 msecs
 [ 1358.072051] PM: noirq suspend of devices complete after 2.040 msecs
 [ 1358.072051] Disabling non-boot CPUs ...
 [ 1358.073211] CPU1: shutdown
 [ 1359.104156] Successfully put all powerdomains to target state
 [ 1359.104278] Enabling non-boot CPUs ...
 [ 1359.106079] CPU1: Booted secondary processor
 [ 1359.106475] CPU1 is up
 [ 1359.107482] PM: noirq resume of devices complete after 1.004 msecs
 [ 1359.108886] PM: early resume of devices complete after 0.761 msecs
 [ 1360.414794] PM: resume of devices complete after 1305.836 msecs
 [ 1360.478668] Restarting tasks ... done.
 # # grep -i uart /proc/interrupts
 106:       3511          0       GIC  OMAP UART2

 arch/arm/plat-omap/include/plat/omap-serial.h |  1 +
 drivers/tty/serial/omap-serial.c              | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 743ac80..52328ca 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -130,6 +130,7 @@ struct uart_omap_port {
 	u32			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
+	unsigned int		irq_pending:1;
 
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a79658d..7e237f3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -353,9 +353,13 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_HANDLED;
 	int max_count = 256;
 
-	spin_lock(&up->port.lock);
-	pm_runtime_get_sync(up->dev);
+	if (pm_runtime_suspended(up->dev)) {
+		up->irq_pending = true;
+		pm_runtime_get(up->dev);
+		return IRQ_HANDLED;
+	}
 
+	spin_lock(&up->port.lock);
 	do {
 		iir = serial_in(up, UART_IIR);
 		if (iir & UART_IIR_NO_INT) {
@@ -400,6 +404,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	up->port_activity = jiffies;
+	up->irq_pending = false;
 
 	return ret;
 }
@@ -1305,7 +1310,6 @@ static int serial_omap_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
 
-	pm_runtime_irq_safe(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -1416,6 +1420,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (!up)
 		return -EINVAL;
 
+	if (up->irq_pending)
+		return -EBUSY;
+
 	if (!pdata)
 		return 0;
 
@@ -1452,6 +1459,9 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 		up->latency = up->calc_latency;
 		schedule_work(&up->qos_work);
+
+		if (up->irq_pending)
+			serial_omap_irq(up->port.irq, up);
 	}
 
 	return 0;
-- 
1.7.12.rc3


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/2d02391b/attachment-0001.sig>
