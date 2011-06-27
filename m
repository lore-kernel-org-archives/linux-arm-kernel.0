From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 27 Jun 2011 18:39:54 +0530
Subject: [PATCH v3 11/12] OMAP2: Serial: Add has_async_wake flag.
In-Reply-To: <87y60qpxcq.fsf@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
	<1307532194-13039-12-git-send-email-govindraj.raja@ti.com>
	<87y60qpxcq.fsf@ti.com>
Message-ID: <BANLkTik9ZLyA4+1VMFj08Zke151OqAhATQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2011 at 5:59 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Prior to this patch the uart_clock was cut using prepare/resume calls since
>> these funcs are no more available with runtime changes use has_async_wake
>> flag to keep clock active during bootup otherwise uart port will disabled
>> during boot-up and cannot be enabled back.
>
> Is this only a bootup issue, or a runtime PM issue? ?It appears to me
> that with this patch, runtime PM is effectively disabled for the whole
> time.
>

it boots up fine, its a runtime PM issue where there is
no mechanism to wakeup after clock cutting from
runtime autosuspend.


> Why not just use pm_runtime_disable() in _probe() for devices with no
> async wakeup.
>

Agree.
can drop of this patch and bind below changes in runtime conversion patch  04/12

do pm_runtime_enable only if device_may_wakeup
is true in probe.

<<SNIP>>
in serial_omap_probe

if (device_may_wakeup(&pdev->dev)) {
	pm_runtime_use_autosuspend(&pdev->dev);
	pm_runtime_set_autosuspend_delay(&pdev->dev,
				OMAP_UART_AUTOSUSPEND_DELAY);
	pm_runtime_enable(&pdev->dev);
	pm_runtime_irq_safe(&pdev->dev);
}


>> Also based on this flag we can disable uart port during suspend and
>> enable back during resume for omap_socs that have not set
>> has_async_wake.
>
> Then you can use pm_runtime_enable() in ->prepare() and
> pm_runtime_disable() in ->complete()
>

u mean runtime enable in suspend and runtime disable in resume
if device_may_wakeup is false.

<<SNIP>>
in serial_omap_suspend

if (!device_may_wakeup(&pdev->dev))
	pm_runtime_enable(&pdev->dev);


--
Thanks,
Govindraj.R

> Kevin
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?3 +++
>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 14 ++++++++++++++
>> ?3 files changed, 18 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 4bc5914..0a95c95 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -266,6 +266,7 @@ static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> ? ? ? ? ? ? ? ? ? ? ? break;
>> ? ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? uart->wk_mask = wk_mask;
>> + ? ? ? ? ? ? uart->has_async_wake = true;
>> ? ? ? } else if (cpu_is_omap24xx()) {
>> ? ? ? ? ? ? ? u32 wk_mask = 0;
>> ? ? ? ? ? ? ? u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
>> index b5117bd..69e6d4b 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -79,6 +79,7 @@ struct omap_uart_port_info {
>> ? ? ? void __iomem *wk_st;
>> ? ? ? void __iomem *wk_en;
>> ? ? ? u32 wk_mask;
>> + ? ? bool ? ? ? ? ? ? ? ? ? ?has_async_wake;
>> ?};
>>
>> ?struct uart_omap_dma {
>> @@ -134,6 +135,8 @@ struct uart_omap_port {
>> ? ? ? unsigned int ? ? ? ? ? ?errata;
>> ? ? ? void (*enable_wakeup)(struct platform_device *, bool);
>> ? ? ? bool (*chk_wakeup)(struct platform_device *);
>> +
>> + ? ? bool ? ? ? ? ? ? ? ? ? ?has_async_wake;
>> ?};
>>
>> ?#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index c3561dd..dbe76f3 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1181,6 +1181,13 @@ static int serial_omap_suspend(struct device *dev)
>> ? ? ? ? ? ? ? uart_suspend_port(&serial_omap_reg, &up->port);
>> ? ? ? ? ? ? ? console_trylock();
>> ? ? ? ? ? ? ? serial_omap_pm(&up->port, 3, 0);
>> +
>> + ? ? ? ? ? ? /* OMAP2 dont have async wakeup from prcm.
>> + ? ? ? ? ? ? ?* For such socs clocks will be kept active from probe and
>> + ? ? ? ? ? ? ?* cut only in suspend path.
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (!up->has_async_wake)
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_disable(up);
>> ? ? ? }
>> ? ? ? return 0;
>> ?}
>> @@ -1192,6 +1199,9 @@ static int serial_omap_resume(struct device *dev)
>> ? ? ? if (up) {
>> ? ? ? ? ? ? ? uart_resume_port(&serial_omap_reg, &up->port);
>> ? ? ? ? ? ? ? console_unlock();
>> +
>> + ? ? ? ? ? ? if (!up->has_async_wake)
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_enable(up);
>> ? ? ? }
>>
>> ? ? ? return 0;
>> @@ -1415,6 +1425,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? up->errata = omap_up_info->errata;
>> ? ? ? up->enable_wakeup = omap_up_info->enable_wakeup;
>> ? ? ? up->chk_wakeup = omap_up_info->chk_wakeup;
>> + ? ? up->has_async_wake = omap_up_info->has_async_wake;
>>
>> ? ? ? if (omap_up_info->dma_enabled) {
>> ? ? ? ? ? ? ? up->uart_dma.uart_dma_tx = dma_tx->start;
>> @@ -1443,6 +1454,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? serial_omap_port_disable(up);
>> ? ? ? }
>>
>> + ? ? if (!up->has_async_wake)
>> + ? ? ? ? ? ? serial_omap_port_enable(up);
>> +
>> ? ? ? ui[pdev->id] = up;
>> ? ? ? serial_omap_add_console_port(up);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
