From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 6 May 2011 15:04:28 +0530
Subject: [PATCH v2 12/12] OMAP2: Serial: Add no async wake flag.
In-Reply-To: <87k4e5hx32.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-13-git-send-email-govindraj.raja@ti.com>
	<87k4e5hx32.fsf@ti.com>
Message-ID: <BANLkTimg2-eJtDnAykDmciEf7s9siuG_QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 11:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> For omap2 cpu_idle thread will not be available
>
> Why not?
>
>> and uart_clock cutting happens only in suspend path.
>
> Aren't clocks also cut after runtime PM autosuspend?
>
>> Prior to this patch the uart_clock was cut using prepare/resume
>> calls since these funcs are no more available with runtime
>> changes use no_async_wake flag to keep clock active during bootup
>> otherwise uart port will disabled during boot-up and cannot be
>> enabled back.
>
> This doesn't just keep clock active during bootup, but it keeps clock
> active always, except during suspend.
>
>> Also based on this flag we can disable uart port during suspend
>> and enable back during resume.
>
> I think disabling UART port during suspend should already be part of an
> earlier patch. ?This patch should then only make it conditional.
>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? ?7 +++++++
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?3 +++
>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 14 ++++++++++++++
>> ?3 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index d4ef370..1af9fd5 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -245,6 +245,12 @@ static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
>> ?static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned short num)
>> ?{
>> + ? ? /* On omap2 no cpu_idle and async wakeup from prcm_module.
>
> Please remove comments about CPU idle, as the need for this has nothing
> to do with CPU idle.
>
>> + ? ? ?* This flag can be used to cut clocks only in suspend path.
>> + ? ? ?* to avoid boot break due to aggressive clock cutting from
>> + ? ? ?* omap-serial driver.
>> + ? ? ?*/
>
> fix multi-line comment style throughout
>
>> + ? ? uart->no_async_wake = true;
>
> If needed (which I still don't think I understand),

Looking into the pm24xx.c code what I understood is..

(1) omap2_enter_full_retention was cutting and enabling the uart
clocks back whether in idle patch or in suspend path.

(2) since we cut clocks outside this retention path I don't know
how to wake back uart as don't see any irq_handlers servicing
wake-up events in pm24xx.c
[Correct me if I am missing something here.]

(3) Since there was no async wakeup mechanism I could see
on pm24xx.c so one approach was to use of these flags.
[If I cut clocks during boot using put_sync in uart code since no
wakeup mechanism will break boot]

(4) For socs with no aync wakeup we are keeping clocks active from
probe and disabling/enabling clocks in suspend/resume hooks.

> for readability sake
> this flag should be called 'has_async_wake', and default to false. ?It
> should then be set to true on available SoCs.

Yes sure I can rename the flag and use above approach.

--
Thanks,
Govindraj.R


>
> Kevin
>
>> ? ? ? if (cpu_is_omap34xx()) {
>> ? ? ? ? ? ? ? u32 mod = num > 1 ? OMAP3430_PER_MOD : CORE_MOD;
>> ? ? ? ? ? ? ? u32 wk_mask = 0;
>> @@ -266,6 +272,7 @@ static void omap_uart_idle_init(struct omap_uart_port_info *uart,
>> ? ? ? ? ? ? ? ? ? ? ? break;
>> ? ? ? ? ? ? ? }
>> ? ? ? ? ? ? ? uart->wk_mask = wk_mask;
>> + ? ? ? ? ? ? uart->no_async_wake = false;
>> ? ? ? } else if (cpu_is_omap24xx()) {
>> ? ? ? ? ? ? ? u32 wk_mask = 0;
>> ? ? ? ? ? ? ? u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
>> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
>> index b5117bd..1de5bc4 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> @@ -79,6 +79,7 @@ struct omap_uart_port_info {
>> ? ? ? void __iomem *wk_st;
>> ? ? ? void __iomem *wk_en;
>> ? ? ? u32 wk_mask;
>> + ? ? bool ? ? ? ? ? ? ? ? ? ?no_async_wake;
>> ?};
>>
>> ?struct uart_omap_dma {
>> @@ -134,6 +135,8 @@ struct uart_omap_port {
>> ? ? ? unsigned int ? ? ? ? ? ?errata;
>> ? ? ? void (*enable_wakeup)(struct platform_device *, bool);
>> ? ? ? bool (*chk_wakeup)(struct platform_device *);
>> +
>> + ? ? bool ? ? ? ? ? ? ? ? ? ?no_async_wake;
>> ?};
>>
>> ?#endif /* __OMAP_SERIAL_H__ */
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index eea478c..59f548f 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -1168,6 +1168,13 @@ static int serial_omap_suspend(struct device *dev)
>> ? ? ? ? ? ? ? uart_suspend_port(&serial_omap_reg, &up->port);
>> ? ? ? ? ? ? ? console_trylock();
>> ? ? ? ? ? ? ? serial_omap_pm(&up->port, 3, 0);
>> +
>> + ? ? ? ? ? ? /* OMAP2 dont have cpu_idle thread and async wakeup from prcm.
>> + ? ? ? ? ? ? ?* For such socs clocks will be kept active from probe and
>> + ? ? ? ? ? ? ?* cut only in suspend path.
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (up->no_async_wake)
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_disable(up);
>> ? ? ? }
>> ? ? ? return 0;
>> ?}
>> @@ -1179,6 +1186,9 @@ static int serial_omap_resume(struct device *dev)
>> ? ? ? if (up) {
>> ? ? ? ? ? ? ? uart_resume_port(&serial_omap_reg, &up->port);
>> ? ? ? ? ? ? ? console_unlock();
>> +
>> + ? ? ? ? ? ? if (up->no_async_wake)
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_enable(up);
>> ? ? ? }
>>
>> ? ? ? return 0;
>> @@ -1402,6 +1412,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? up->errata = omap_up_info->errata;
>> ? ? ? up->enable_wakeup = omap_up_info->enable_wakeup;
>> ? ? ? up->chk_wakeup = omap_up_info->chk_wakeup;
>> + ? ? up->no_async_wake = omap_up_info->no_async_wake;
>>
>> ? ? ? if (omap_up_info->dma_enabled) {
>> ? ? ? ? ? ? ? up->uart_dma.uart_dma_tx = dma_tx->start;
>> @@ -1430,6 +1441,9 @@ static int serial_omap_probe(struct platform_device *pdev)
>> ? ? ? ? ? ? ? serial_omap_port_disable(up);
>> ? ? ? }
>>
>> + ? ? if (up->no_async_wake)
>> + ? ? ? ? ? ? serial_omap_port_enable(up);
>> +
>> ? ? ? ui[pdev->id] = up;
>> ? ? ? serial_omap_add_console_port(up);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
