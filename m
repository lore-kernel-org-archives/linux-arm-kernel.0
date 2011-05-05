From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 5 May 2011 17:16:37 +0530
Subject: [PATCH v2 11/12] OMAP: Serial: Use resume call from prcm to
	enable uart
In-Reply-To: <87pqnym2f2.fsf@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-12-git-send-email-govindraj.raja@ti.com>
	<87pqnym2f2.fsf@ti.com>
Message-ID: <BANLkTi=32NfMr7exWpOoPHX7_-Jc0i5LqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 5, 2011 at 5:41 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Use resume idle call from prcm_irq to enable uart_port from low power states.
>> Add api to check pad wakeup status which will we used from uart_resume func.
>> to enable back uart port if a wakeup event occurred.
>>
>> UART_Resume func. can be removed once we have irq_chaining functionality
>> available.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> The part adding a new hwmod API needs to be separated out into a
> separate patch which is not dependent on the rest of this series.
>

ok. fine

>> ---
>> ?arch/arm/mach-omap2/mux.c ? ? ? ? ? ? ? ? ? ? | ? 23 +++++++++++++++++++++++
>> ?arch/arm/mach-omap2/mux.h ? ? ? ? ? ? ? ? ? ? | ? 13 +++++++++++++
>> ?arch/arm/mach-omap2/omap_hwmod.c ? ? ? ? ? ? ?| ? 13 +++++++++++++
>> ?arch/arm/mach-omap2/pm24xx.c ? ? ? ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-omap2/pm34xx.c ? ? ? ? ? ? ? ? ?| ? ?2 ++
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ? 23 +++++++++++++++++++++++
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? ?2 ++
>> ?arch/arm/plat-omap/include/plat/omap_hwmod.h ?| ? ?1 +
>> ?arch/arm/plat-omap/include/plat/serial.h ? ? ?| ? ?1 +
>> ?drivers/tty/serial/omap-serial.c ? ? ? ? ? ? ?| ? 23 +++++++++++++++++++++++
>> ?10 files changed, 103 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
>> index a4ab1e3..7149671 100644
>> --- a/arch/arm/mach-omap2/mux.c
>> +++ b/arch/arm/mach-omap2/mux.c
>> @@ -348,6 +348,29 @@ err1:
>> ? ? ? return NULL;
>> ?}
>>
>> +/* Gets the wakeup status of given pad from omap-hwmod.
>> + * Returns the wake_up status bit of available pad mux pin
>> + */
>
> fix multi-line comment style
>

ok.

>> +bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>
> The name here should be more descriptive: like _get_wake_status or
> something.
>
>> +{
>> + ? ? int i;
>> + ? ? unsigned int val;
>> + ? ? u8 ret = 0;
>> +
>> + ? ? for (i = 0; i < hmux->nr_pads; i++) {
>> + ? ? ? ? ? ? struct omap_device_pad *pad = &hmux->pads[i];
>> +
>> + ? ? ? ? ? ? val = omap_mux_read(pad->partition,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? pad->mux->reg_offset);
>> + ? ? ? ? ? ? if (val & OMAP_WAKEUP_EVENT) {
>> + ? ? ? ? ? ? ? ? ? ? ret = 1;
>> + ? ? ? ? ? ? ? ? ? ? break;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> +
>> + ? ? return ret;
>> +}
>> +
>> ?/* Assumes the calling function takes care of locking */
>> ?void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>> ?{
>> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
>> index 137f321..379fb6e 100644
>> --- a/arch/arm/mach-omap2/mux.h
>> +++ b/arch/arm/mach-omap2/mux.h
>> @@ -225,8 +225,21 @@ omap_hwmod_mux_init(struct omap_device_pad *bpads, int nr_pads);
>> ? */
>> ?void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>>
>> +
>> +/**
>> + * omap_hwmod_mux_wakeup - omap hwmod check given pad had wakeup event
>> + * @hmux: ? ? ? ? ? ?Pads for a hwmod
>> + *
>> + * Called only from omap_hwmod.c, do not use.
>> + */
>
> Please put the kerneldoc comments in the C file instead of the header.
>

ok.

>> +bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux);
>> ?#else
>>
>> +static inline bool omap_hwmod_mux_wakeup(struct omap_hwmod_mux_info *hmux)
>> +{
>> + ? ? return 0;
>> +}
>> +
>> ?static inline int omap_mux_init_gpio(int gpio, int val)
>> ?{
>> ? ? ? return 0;
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
>> index 4a12336..86cb8c4 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -2403,3 +2403,16 @@ int omap_hwmod_enable_ioring_wakeup(struct omap_hwmod *oh, bool enable)
>>
>> ? ? ? return ret;
>> ?}
>> +
>> +/**
>> + * omap_hwmod_pad_wakeup_status - get pad wakeup status if mux is available.
>
> How about _get_pad_wakeup_status()
>

Yes fine will update.

>> + * @oh: struct omap_hwmod *
>> + *
>> + * Returns the wake_up status bit of available pad mux pin.
>
> or on error... ?

-EINVAL. Will update the comments.

>
>> + */
>> +int omap_hmwod_pad_wakeup_status(struct omap_hwmod *oh)
>> +{
>> + ? ? if (oh->mux)
>> + ? ? ? ? ? ? return omap_hwmod_mux_wakeup(oh->mux);
>> + ? ? return -EINVAL;
>> +}
>> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
>> index c405bda..ba58a1d 100644
>> --- a/arch/arm/mach-omap2/pm24xx.c
>> +++ b/arch/arm/mach-omap2/pm24xx.c
>> @@ -137,6 +137,8 @@ static void omap2_enter_full_retention(void)
>> ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP_SDRC_REGADDR(SDRC_DLLA_CTRL),
>> ? ? ? ? ? ? ? ? ? ? ? ? ?OMAP_SDRC_REGADDR(SDRC_POWER));
>>
>> + ? ? omap_uart_resume_idle();
>> +
>> ?no_sleep:
>> ? ? ? if (omap2_pm_debug) {
>> ? ? ? ? ? ? ? unsigned long long tmp;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index ce0ecdc..3960330 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -216,6 +216,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
>>
>> ? ? ? wkst = omap2_prm_read_mod_reg(module, wkst_off);
>> ? ? ? wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
>> +
>> + ? ? c += omap_uart_resume_idle();
>
> No...
>
> [...]
>
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 9ed993c..eea478c 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -43,6 +43,7 @@
>> ?#include <plat/dmtimer.h>
>> ?#include <plat/omap-serial.h>
>> ?#include <plat/omap_device.h>
>> +#include <plat/serial.h>
>>
>> ?static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>>
>> @@ -108,6 +109,27 @@ static inline void serial_omap_port_enable(struct uart_omap_port *up)
>> ? ? ? pm_runtime_get_sync(&up->pdev->dev);
>> ?}
>>
>> +/* TBD: Should be removed once we irq-chaining mechanism in place */
>
> ...indeed...
>
>> +u32 omap_uart_resume_idle()
>> +{
>> + ? ? int i;
>> + ? ? u32 ret = 0;
>> +
>> + ? ? for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>> + ? ? ? ? ? ? struct uart_omap_port *up = ui[i];
>> +
>> + ? ? ? ? ? ? if (!up)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>> +
>> + ? ? ? ? ? ? if (up->chk_wakeup(up->pdev)) {
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_enable(up);
>> + ? ? ? ? ? ? ? ? ? ? serial_omap_port_disable(up);
>> + ? ? ? ? ? ? ? ? ? ? ret++;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> + ? ? return ret;
>> +}
>
> ... this is just putting back basically the same thing that was removed in
> patch 1. ?IOW, this is now being checked for *every* PRCM wakeup, which
> is no different than having it in the idle path.
>
> I thought I understood that you had the SW IRQ triggering working, so
> this part should not be necessary.

Actually I tried few experiments but couldn't get it working.

Tried below but didn't help.

------------------------------------
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3960330..2c1dfc2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -288,6 +288,16 @@ static irqreturn_t prcm_interrupt_handler (int
irq, void *dev_id)
        do {
                if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
                                     OMAP3430_IO_ST_MASK)) {
+#if 1
+                       /*
+                        * EXP-1: SET UART1 SOFT IRQ BIT
+                        * 3430 -SDP UART1 console.
+                        * M_IRQ_72, INTCPS_ISR_SET
+                        * 0x4820 0090 + (0x20 * n)
+                        * bit-8 n = 2
+                        */
+                       __raw_writel(0x100 , 0x482000D0);
+#endif
                        c = _prcm_int_handle_wakeup();

                        /*

-----------------------------------

Currently we are planning to integrate irq_chaining patches
on top uart_runtime patches which is work-in-progress.
Will remove resume_idle once we have irq_chaining patches available.

--
Thanks,
Govindraj.R

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
