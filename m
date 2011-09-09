From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 9 Sep 2011 12:02:49 +0530
Subject: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for
	omap-serial driver
In-Reply-To: <87obyu36lo.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-8-git-send-email-govindraj.raja@ti.com>
	<87obyu36lo.fsf@ti.com>
Message-ID: <CAAL8m4wpCVrhY7++ROwu0Whh4w_cF_dUr0t5622+WmJZah_FRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 9, 2011 at 5:54 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Adapts omap-serial driver to use pm_runtime API's.
>>
>> 1.) Moving context_restore func to driver from serial.c
>> 2.) Use runtime irq safe to use get_sync from irq context.
>> 3.) autosuspend for port specific activities and put for reg access.
>
> Re: autosuspend, it looks like the driver now has 2 mechanisms for
> tracking activity. ?The runtime PM 'mark last busy' and the existing
> 'up->port_activity = jiffies' stuff. ?Do you think those could be
> unified?
>

Is there a way where we can retrieve the last busy jiffie value
using runtime API? I don't find that available.


> At first glance, it looks like most places with a _mark_last_busy() also
> have a up->port_activity update. ?I'm not familiar enough with the
> driver to make the call, but they look awfully similar.
>

Ok, I will check whether I can get rid if it.

>> 4.) for earlyprintk usage the debug macro will write to console uart
>> ? ? so keep uart clocks active from boot, idle using hwmod API's re-enable back
>> ? ? using runtime API's.
>
> /me doesn't understand

I have added this reason in early mail reply to 04/11 patch review
[needed for earlyprintk option from low level debug ]


>
>> 5.) Moving context restore to runtime suspend and using reg values from port
>> ? ? structure to restore the uart port context based on context_loss_count.
>> ? ? Maintain internal state machine for avoiding repeated enable/disable of
>> ? ? uart port wakeup mechanism.
>> 6.) Add API to enable wakeup and check wakeup status.
>>
>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 49 ++++++
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? 10 ++
>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ?211 ++++++++++++++++++++++---
>> ?3 files changed, 250 insertions(+), 20 deletions(-)
>>

[..]

>> +
>> +static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
>> +{
>> + ? ? struct omap_device *od;
>> + ? ? struct omap_uart_port_info *up = pdev->dev.platform_data;
>> +
>> + ? ? /* Set or clear wake-enable bit */
>> + ? ? if (up->wk_en && up->wk_mask) {
>> + ? ? ? ? ? ? u32 v = __raw_readl(up->wk_en);
>> + ? ? ? ? ? ? if (enable)
>> + ? ? ? ? ? ? ? ? ? ? v |= up->wk_mask;
>> + ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? v &= ~up->wk_mask;
>> + ? ? ? ? ? ? __raw_writel(v, up->wk_en);
>> + ? ? }
>> +
>> + ? ? od = to_omap_device(pdev);
>> + ? ? if (enable)
>> + ? ? ? ? ? ? omap_hwmod_enable_wakeup(od->hwmods[0]);
>> + ? ? else
>> + ? ? ? ? ? ? omap_hwmod_disable_wakeup(od->hwmods[0]);
>> +}
>> +
>
> Here again, this is difficult to review because you removed the code in
> [4/11] and add it back here, but with rather different functionality
> with no description as to why.
>

will move this change as part of 4/11 itself.

> The previous version enabled wakeups at the PRCM and at the IO ring.
> This version enables wakeups at the PRCM as well but instead of enabling
> them at the IO ring, enables them at the module.
>

Since we are gating using prepare idle call I think
we can use this enable wake-up call as part of prepare idle call itself,
as done earlier.

>> ?struct omap_hwmod *omap_uart_hwmod_lookup(int num)
>> ?{
>> ? ? ? struct omap_hwmod *oh;
>> @@ -317,6 +363,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>>
>> ? ? ? pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
>> ? ? ? pdata->flags = UPF_BOOT_AUTOCONF;
>> + ? ? pdata->enable_wakeup = omap_uart_wakeup_enable;
>> + ? ? pdata->chk_wakeup = omap_uart_chk_wakeup;
>> + ? ? pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
>>
>> ? ? ? pdev = omap_device_build(name, bdata->id, oh, pdata,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? sizeof(*pdata), omap_uart_latency,
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
>> index 06e3aa2..7fc63b8 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -67,6 +67,9 @@ struct omap_uart_port_info {
>> ? ? ? void __iomem *wk_st;
>> ? ? ? void __iomem *wk_en;
>> ? ? ? u32 wk_mask;
>> + ? ? void (*enable_wakeup)(struct platform_device *, bool);
>> + ? ? bool (*chk_wakeup)(struct platform_device *);
>> + ? ? u32 (*get_context_loss_count)(struct device *);
>> ?};
>>
>> ?struct uart_omap_dma {
>> @@ -118,7 +121,14 @@ struct uart_omap_port {
>> ? ? ? unsigned char ? ? ? ? ? msr_saved_flags;
>> ? ? ? char ? ? ? ? ? ? ? ? ? ?name[20];
>> ? ? ? unsigned long ? ? ? ? ? port_activity;
>> + ? ? u32 ? ? ? ? ? ? ? ? ? ? context_loss_cnt;
>> + ? ? u8 ? ? ? ? ? ? ? ? ? ? ?wake_status;
>> +
>> ? ? ? unsigned int ? ? ? ? ? ?errata;
>> + ? ? unsigned int ? ? ? ? ? ?clocked;
>
> This is a legacy from serial.c and should not be needed. ?Checking
> pm_runtime_suspended() will provide the same info.
>

Yes will try to use that.

>> + ? ? u8 ? ? ? ? ? ? ? ? ? ? ?console_locked;
>> +
>> + ? ? bool (*chk_wakeup)(struct platform_device *);
>
> s/chk/check/ please. ?It's not that much longer.
>

will change.

>> ?};
>>
>> ?#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 6ac0ade..30bdd05 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -37,10 +37,14 @@
>> ?#include <linux/clk.h>
>> ?#include <linux/serial_core.h>
>> ?#include <linux/irq.h>
>> +#include <linux/pm_runtime.h>
>>
>> ?#include <plat/dma.h>
>> ?#include <plat/dmtimer.h>
>> ?#include <plat/omap-serial.h>
>> +#include <plat/omap_device.h>
>> +
>> +#define OMAP_UART_AUTOSUSPEND_DELAY 3000 ? ? /* Value is msecs */
>
> Because of the character lost problem when UARTs are idled, Tony prefers
> that the default on this be no auto timeout, like the current mainline
> code does.
>

Yes fine, IIUC this value should be -1 by default and can be later set using
sysfs entry.


>> ?static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -102,6 +106,8 @@ static void serial_omap_stop_rxdma(struct uart_omap_port *up)
>> ? ? ? ? ? ? ? omap_free_dma(up->uart_dma.rx_dma_channel);
>> ? ? ? ? ? ? ? up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>> ? ? ? ? ? ? ? up->uart_dma.rx_dma_used = false;
>> + ? ? ? ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
>> + ? ? ? ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
>> ? ? ? }
>> ?}
>>
>> @@ -110,8 +116,11 @@ static void serial_omap_enable_ms(struct uart_port *port)

[..]

>>
>> ?#endif /* CONFIG_CONSOLE_POLL */
>>
>> ?#ifdef CONFIG_SERIAL_OMAP_CONSOLE
>> -
>> ?static struct uart_omap_port *serial_omap_console_ports[4];
>>
>> ?static struct uart_driver serial_omap_reg;
>> @@ -951,6 +1004,8 @@ serial_omap_console_write(struct console *co, const char *s,
>> ? ? ? unsigned int ier;
>> ? ? ? int locked = 1;
>>
>> + ? ? pm_runtime_get_sync(&up->pdev->dev);
>> +
>> ? ? ? local_irq_save(flags);
>> ? ? ? if (up->port.sysrq)
>> ? ? ? ? ? ? ? locked = 0;
>> @@ -983,9 +1038,12 @@ serial_omap_console_write(struct console *co, const char *s,
>> ? ? ? if (up->msr_saved_flags)
>> ? ? ? ? ? ? ? check_modem_status(up);
>>
>> + ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
>> + ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
>> ? ? ? if (locked)
>> ? ? ? ? ? ? ? spin_unlock(&up->port.lock);
>> ? ? ? local_irq_restore(flags);
>> + ? ? up->port_activity = jiffies;
>
> hmm, why? ?this change looks suspicious.
>

Yes will try to unify with mark last busy.
But as said earlier can we have option to retrieve
last busy jiffies value.


>> ?}
>>
>> ?static int __init
>> @@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg = {
>> ? ? ? .cons ? ? ? ? ? = OMAP_CONSOLE,
>> ?};
>>
>> -static int
>> -serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
>> +static int serial_omap_suspend(struct device *dev)
>> ?{
>> - ? ? struct uart_omap_port *up = platform_get_drvdata(pdev);
>> + ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>>
>> - ? ? if (up)
>> + ? ? if (up) {
>> ? ? ? ? ? ? ? uart_suspend_port(&serial_omap_reg, &up->port);
>> + ? ? ? ? ? ? if (up->port.line == up->port.cons->index &&
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? !is_console_locked())
>> + ? ? ? ? ? ? ? ? ? ? up->console_locked = console_trylock();
>> + ? ? }
>> +
>
> Motiviation for console locking in this version of the series is not
> clear, and not described in the changelog.
>
> It's also present here in static suspend/resume but not in runtime
> suspend/resume, which also is suspicious.
>

Yes will add to change log,

We needed this for no console suspend use case
no console lock is taken in no_console_suspend is specified,

Since our pwr_dmn hooks disable clocks left enabled during suspend,
so any prints after pwr_dmn hooks can cause problems since clocks
are already cut from pwr_dmn hooks.

So buffer prints while entering suspend by taking console lock
if not taken already and print back after uart state machine restores
console uart.


>> ? ? ? return 0;
>> ?}
>>
>> -static int serial_omap_resume(struct platform_device *dev)
>> +static int serial_omap_resume(struct device *dev)
>> ?{
>> - ? ? struct uart_omap_port *up = platform_get_drvdata(dev);
>> + ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>>
>> - ? ? if (up)
>> + ? ? if (up) {

[..]

>> + ? ? up->port.mapbase = mem->start;
>> + ? ? up->port.membase = ioremap(mem->start, mem->end - mem->start);
>
> The size is (end - start + 1), but please use the resource_size() helper
> for this to avoid this common problem.
>

will change that.

>> + ? ? if (!up->port.membase) {
>> + ? ? ? ? ? ? dev_err(&pdev->dev, "can't ioremap UART\n");
>> + ? ? ? ? ? ? ret = -ENOMEM;
>> + ? ? ? ? ? ? goto err1;
>> + ? ? }
>> +
>> ? ? ? up->port.flags = omap_up_info->flags;
>> - ? ? up->port.irqflags = omap_up_info->irqflags;
>> ? ? ? up->port.uartclk = omap_up_info->uartclk;
>> ? ? ? up->uart_dma.uart_base = mem->start;
>> + ? ? up->errata = omap_up_info->errata;
>> + ? ? up->chk_wakeup = omap_up_info->chk_wakeup;
>>
>> ? ? ? if (omap_up_info->dma_enabled) {
>> ? ? ? ? ? ? ? up->uart_dma.uart_dma_tx = dma_tx->start;
>> @@ -1299,18 +1378,34 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>> ? ? ? }
>>
>> + ? ? pm_runtime_use_autosuspend(&pdev->dev);
>> + ? ? pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + ? ? ? ? ? ? ? ? ? ? OMAP_UART_AUTOSUSPEND_DELAY);
>> +
>> + ? ? pm_runtime_irq_safe(&pdev->dev);
>> + ? ? if (device_may_wakeup(&pdev->dev)) {
>> + ? ? ? ? ? ? pm_runtime_enable(&pdev->dev);
>> + ? ? ? ? ? ? od = to_omap_device(up->pdev);
>> + ? ? ? ? ? ? omap_hwmod_idle(od->hwmods[0]);
>
> No hwmod calls in drivers please.
>
> In this case, this is a legacy of using HWMOD_INIT_NO_IDLE and
> _NO_RESET. ?That should be removed so this could be removed.
>

low level debug early printk use case as said earlier.


>> + ? ? ? ? ? ? pm_runtime_get_sync(&up->pdev->dev);
>> + ? ? ? ? ? ? up->clocked = 1;
>> + ? ? }
>> +
>> ? ? ? ui[pdev->id] = up;
>> ? ? ? serial_omap_add_console_port(up);
>>

[..]

>> + ? ? if (pdata->get_context_loss_count)
>> + ? ? ? ? ? ? up->context_loss_cnt = pdata->get_context_loss_count(dev);
>
> You need
>
> ? ? ? ?if (!pdata->enable_wakeup)
> ? ? ? ? ? ? ? ?return 0;
>
> here in case there is no ->enable_wakeup provided. ?Otherwise...
>
>> + ? ? if (device_may_wakeup(dev)) {
>> + ? ? ? ? ? ? if (!up->wake_status) {
>> + ? ? ? ? ? ? ? ? ? ? pdata->enable_wakeup(up->pdev, true);
>
> ...boom.
>

will correct it.

>> + ? ? ? ? ? ? ? ? ? ? up->wake_status = true;
>> + ? ? ? ? ? ? }
>> + ? ? } else {
>> + ? ? ? ? ? ? if (up->wake_status) {
>> + ? ? ? ? ? ? ? ? ? ? pdata->enable_wakeup(up->pdev, false);
>> + ? ? ? ? ? ? ? ? ? ? up->wake_status = false;
>> + ? ? ? ? ? ? }
>> + ? ? }
>
> up->wake_status would be better named ->wakeups_enabled;

sure.

>
>> + ? ? return 0;
>> +}
>> +
>> +static int omap_serial_runtime_resume(struct device *dev)
>> +{
>> + ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>> + ? ? struct omap_uart_port_info *pdata = dev->platform_data;
>> +
>> + ? ? if (up) {
>> + ? ? ? ? ? ? if (pdata->get_context_loss_count) {
>> + ? ? ? ? ? ? ? ? ? ? u32 loss_cnt = pdata->get_context_loss_count(dev);
>> +
>> + ? ? ? ? ? ? ? ? ? ? if (up->context_loss_cnt != loss_cnt)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? omap_uart_restore_context(up);
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_RUNTIME
>> +static const struct dev_pm_ops omap_serial_dev_pm_ops = {
>> + ? ? .suspend = serial_omap_suspend,
>> + ? ? .resume = serial_omap_resume,
>
> Static suspend operations should exists even when runtime PM is
> disabled.
>
>> + ? ? .runtime_suspend = omap_serial_runtime_suspend,
>> + ? ? .runtime_resume = omap_serial_runtime_resume,
>
> Note that some functions have serial_omap_ prefix and others have
> omap_serial_. ?It looks like serial_omap_ is used througout the driver.
> Please unify.
>

yes sure. will change.

>> +};
>> +#define SERIAL_PM_OPS (&omap_serial_dev_pm_ops)
>> +#else
>> +#define SERIAL_PM_OPS NULL
>> +#endif
>
> Instead of this ifdef construct, please use SET_SYSTEM_SLEEP_PM_OPS()
> and SET_RUNTIME_PM_OPS() which take care of the right ifdefs for you,
> and also ensure that callbacks are available for suspend-to-disk (hibernate):
>
> static const struct dev_pm_ops omap_serial_dev_pm_ops = {
> ? ? ? SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume),
> ? ? ? SET_RUNTIME_PM_OPS(runtime_suspend, runtime_resume, NULL),
> };
>

yes will incorporate this.

Will give a quick respin and try to repost asap.

--
Thanks,
Govindraj.R


>> ?static struct platform_driver serial_omap_driver = {
>> ? ? ? .probe ? ? ? ? ?= serial_omap_probe,
>> ? ? ? .remove ? ? ? ? = serial_omap_remove,
>> -
>> - ? ? .suspend ? ? ? ?= serial_omap_suspend,
>> - ? ? .resume ? ? ? ? = serial_omap_resume,
>> ? ? ? .driver ? ? ? ? = {
>> ? ? ? ? ? ? ? .name ? = DRIVER_NAME,
>> + ? ? ? ? ? ? .pm = SERIAL_PM_OPS,
>> ? ? ? },
>> ?};
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
