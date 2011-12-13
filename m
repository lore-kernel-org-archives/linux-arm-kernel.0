From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 11:17:42 +0800
Subject: [PATCH v4] tty: serial: imx: Allow UART to be a source for wakeup
In-Reply-To: <CAOMZO5DM_eDZqbxsNKYvwgP+qjr=yoLHrWHuZb-PQn9xWZpsrg@mail.gmail.com>
References: <1323434541-27689-1-git-send-email-festevam@gmail.com>
 <1323456065-6240-1-git-send-email-festevam@gmail.com>
 <20111211060133.GA9470@S2100-06.ap.freescale.net>
 <CAOMZO5DM_eDZqbxsNKYvwgP+qjr=yoLHrWHuZb-PQn9xWZpsrg@mail.gmail.com>
Message-ID: <20111213031741.GC10866@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 04:17:04PM -0200, Fabio Estevam wrote:
> On Sun, Dec 11, 2011 at 4:01 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> >> + ? ? device_init_wakeup(&pdev->dev, 1);
> >> + ? ? device_set_wakeup_enable(&pdev->dev, 0);
> >> +
> > Rather than calling these two functions, simply calling
> >
> > ? ? ? ?device_set_wakeup_capable(&pdev->dev, true);
> >
> > can just do what we want to do here.
> 
> Yes, this is correct.
> 
> After checking the code it seems to me that  neither of this calls are needed.
> 
> serial_core.c already calls:
> 		device_init_wakeup(tty_dev, 1);
> 		device_set_wakeup_enable(tty_dev, 0);
> 
> and we can see a wakeup entry at:
> 
> /sys/devices/platform/imx21-uart.0/tty/ttymxc0/power/wakeup
> 
> However, if I send "enabled" to this file the
> "if (device_may_wakeup(&dev->dev)" statement is never true.
> 
That's because &pdev->dev and tty_dev above point to different
'struct dev'.

> I am not sure what would be the correct argument for device_may_wakeup
> to "see" the original wakeup entry.
> 
It seems difficult to figure out the tty_dev in imx driver.  And I do
not think we need to.  We can simply remove the device_may_wakeup
check and rxirq enable/disable from serial_imx_suspend/resume, because
both of these two things have been taken care of by serial_core.

The following change works for me.

8<----

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..1722230 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -566,6 +566,9 @@ static irqreturn_t imx_int(int irq, void *dev_id)
        if (sts & USR1_RTSD)
                imx_rtsint(irq, dev_id);

+       if (sts & USR1_AWAKE)
+               writel(USR1_AWAKE, sport->port.membase + USR1);
+
        return IRQ_HANDLED;
 }

@@ -1269,6 +1272,12 @@ static struct uart_driver imx_reg = {
 static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 {
        struct imx_port *sport = platform_get_drvdata(dev);
+       unsigned int val;
+
+       /* enable wakeup from i.MX UART */
+       val = readl(sport->port.membase + UCR3);
+       val |= UCR3_AWAKEN;
+       writel(val, sport->port.membase + UCR3);

        if (sport)
                uart_suspend_port(&imx_reg, &sport->port);
@@ -1279,6 +1288,11 @@ static int serial_imx_suspend(struct platform_device *dev, pm_message_t state)
 static int serial_imx_resume(struct platform_device *dev)
 {
        struct imx_port *sport = platform_get_drvdata(dev);
+       unsigned int val;
+
+       val = readl(sport->port.membase + UCR3);
+       val &= ~UCR3_AWAKEN;
+       writel(val, sport->port.membase + UCR3);

        if (sport)
                uart_resume_port(&imx_reg, &sport->port);

--->8

-- 
Regards,
Shawn
