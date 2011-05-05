From: govindraj.raja@ti.com (Raja, Govindraj)
Date: Thu, 5 May 2011 11:18:46 +0530
Subject: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for
	omap-serial driver
In-Reply-To: <87hb9aqk53.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-5-git-send-email-govindraj.raja@ti.com>
	<87hb9aqk53.fsf@ti.com>
Message-ID: <BANLkTinNVTq9OGUHj4ZDCTXvRE7Jgf0MKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 2:05 AM, Kevin Hilman <khilman@ti.com> wrote:

> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> > Adapts omap-serial driver to use pm_runtime api's.
> >
> > 1.) Populate reg values to uart port which can be used for context
> restore.
> > 2.) Moving context_restore func to driver from serial.c
> > 3.) Adding port_enable/disable func to enable/disable given uart port.
> >     enable port using get_sync and disable using autosuspend.
> > 4.) using runtime irq safe api to make get_sync be called from irq
> context.
> >
> > Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> > ---
> >  arch/arm/mach-omap2/serial.c                  |   16 ++
> >  arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
> >  drivers/tty/serial/omap-serial.c              |  211
> ++++++++++++++++++++++---
> >  3 files changed, 203 insertions(+), 26 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> > index 8c1a4c7..314d82f 100644
> > --- a/arch/arm/mach-omap2/serial.c
> > +++ b/arch/arm/mach-omap2/serial.c
> > @@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct
> omap_board_data *bdata)
> >       }
> >  }
> >
> > +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool
> enable)
> > +{
> > +     struct omap_uart_port_info *up = pdev->dev.platform_data;
> > +
> > +     /* Set or clear wake-enable bit */
> > +     if (up->wk_en && up->wk_mask) {
> > +             u32 v = __raw_readl(up->wk_en);
> > +             if (enable)
> > +                     v |= up->wk_mask;
> > +             else
> > +                     v &= ~up->wk_mask;
> > +             __raw_writel(v, up->wk_en);
> > +     }
> > +}
>
> Rather than having the driver do this via the PRCM, can you do an
> experiment?  Can you try to leave the module-level wakeup enabled all
> the time in the PRCM, and the driver can then enable/disable
> module-level wakeups simply by toggling ENAWAKEUP in the module's
> SYSCONFIG?  If that works, than you can just use
> omap_hwmod_enable_wakeup() for this and not need the above function.
>


If we leave PRCM uart module level bit enabled all time and we disable
wakeup using sysfs

echo disabled > /sys/devices/platform/omap/omap_uart.0/power/wakeup

it wakes up after clock disable, however unsetting the bit ensures
it doesn't
wakeup after uart clocks are cut.

As Paul suggested, How about adding omap_device/omap_hwmod function
to set and unset the bit?

Using

.module_bit = OMAP3430_EN_UART1_SHIFT,

from hwmod data?



>
> >  static void omap_uart_idle_init(struct omap_uart_port_info *uart,
> >                               unsigned short num)
> >  {
> > @@ -332,6 +347,7 @@ void __init omap_serial_init_port(struct
> omap_board_data *bdata)
> >
> >       pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
> >       pdata->flags = UPF_BOOT_AUTOCONF;
> > +     pdata->enable_wakeup = omap_uart_wakeup_enable;
> >       if (bdata->id == omap_uart_con_id)
> >               pdata->console_uart = true;
> >
>
>
<<SNIP>>


> > +     pm_runtime_use_autosuspend(&pdev->dev);
> > +     pm_runtime_set_autosuspend_delay(&pdev->dev,
> > +                     OMAP_UART_AUTOSUSPEND_DELAY);
> > +
> > +     pm_runtime_enable(&pdev->dev);
> > +     pm_runtime_irq_safe(&pdev->dev);
> > +
> > +     if (omap_up_info->console_uart) {
> > +             od = to_omap_device(up->pdev);
> > +             omap_hwmod_idle(od->hwmods[0]);
>
> Driver should have know knowlege of the underlying hwmod.
>
> I assume this is here because of the usage of HWMOD_INIT_NO_IDLE and
> HWMOD_INIT_NO_RESET, right?


   Yes correct.



>  With proper runtime PM, we should be able to
> remove the need for using those flags.
>


For omap-uart used for earlyprintk's the early_console driver will
use printch from debug macro to print through uart.

During omap-hwmod is getting initialized

--> _setup
   --> _idle
    ---> _disable_clocks

at this point of time while printch is happening and
hwmod disables uart clocks I dont have uart-console
driver available which can enable clocks back.

So I have to use those flags when earlyprintk is enabled.

--
Thanks,
Govindraj.R




>
> Kevin
>
> > +             serial_omap_port_enable(up);
> > +             serial_omap_port_disable(up);
> > +     }
> > +
> >       ui[pdev->id] = up;
> >       serial_omap_add_console_port(up);
> >
> >       ret = uart_add_one_port(&serial_omap_reg, &up->port);
> >       if (ret != 0)
> > -             goto do_release_region;
> > +             goto err1;
> >
> > +     dev_set_drvdata(&pdev->dev, up);
> >       platform_set_drvdata(pdev, up);
> > +
> >       return 0;
> >  err:
> >       dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> >                               pdev->id, __func__, ret);
> > +err1:
> > +     kfree(up);
> >  do_release_region:
> >       release_mem_region(mem->start, (mem->end - mem->start) + 1);
> >       return ret;
> > @@ -1318,20 +1421,76 @@ static int serial_omap_remove(struct
> platform_device *dev)
> >
> >       platform_set_drvdata(dev, NULL);
> >       if (up) {
> > +             pm_runtime_disable(&up->pdev->dev);
> >               uart_remove_one_port(&serial_omap_reg, &up->port);
> >               kfree(up);
> >       }
> >       return 0;
> >  }
> >
> > +static void omap_uart_restore_context(struct uart_omap_port *up)
> > +{
> > +     u16 efr = 0;
> > +
> > +     serial_out(up, UART_OMAP_MDR1, up->mdr1);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     efr = serial_in(up, UART_EFR);
> > +     serial_out(up, UART_EFR, UART_EFR_ECB);
> > +     serial_out(up, UART_LCR, 0x0); /* Operational mode */
> > +     serial_out(up, UART_IER, 0x0);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     serial_out(up, UART_DLL, up->dll);
> > +     serial_out(up, UART_DLM, up->dlh);
> > +     serial_out(up, UART_LCR, 0x0); /* Operational mode */
> > +     serial_out(up, UART_IER, up->ier);
> > +     serial_out(up, UART_FCR, up->fcr);
> > +     serial_out(up, UART_LCR, 0x80);
> > +     serial_out(up, UART_MCR, up->mcr);
> > +     serial_out(up, UART_LCR, 0xBF); /* Config B mode */
> > +     serial_out(up, UART_EFR, efr);
> > +     serial_out(up, UART_LCR, UART_LCR_WLEN8);
> > +     /* UART 16x mode */
> > +     serial_out(up, UART_OMAP_MDR1, up->mdr1);
> > +}
> > +
> > +static int omap_serial_runtime_suspend(struct device *dev)
> > +{
> > +     struct uart_omap_port *up = dev_get_drvdata(dev);
> > +
> > +     if (!up)
> > +             goto done;
> > +
> > +     if (device_may_wakeup(dev))
> > +             up->enable_wakeup(up->pdev, true);
> > +     else
> > +             up->enable_wakeup(up->pdev, false);
> > +done:
> > +     return 0;
> > +}
> > +
> > +static int omap_serial_runtime_resume(struct device *dev)
> > +{
> > +     struct uart_omap_port *up = dev_get_drvdata(dev);
> > +
> > +     if (up)
> > +             omap_uart_restore_context(up);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops omap_serial_dev_pm_ops = {
> > +     .suspend = serial_omap_suspend,
> > +     .resume = serial_omap_resume,
> > +     .runtime_suspend = omap_serial_runtime_suspend,
> > +     .runtime_resume = omap_serial_runtime_resume,
> > +};
> > +
> >  static struct platform_driver serial_omap_driver = {
> >       .probe          = serial_omap_probe,
> >       .remove         = serial_omap_remove,
> > -
> > -     .suspend        = serial_omap_suspend,
> > -     .resume         = serial_omap_resume,
> >       .driver         = {
> >               .name   = DRIVER_NAME,
> > +             .pm = &omap_serial_dev_pm_ops,
> >       },
> >  };
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110505/874afec9/attachment-0001.html>
