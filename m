From: govindraj.ti@gmail.com (Govindraj)
Date: Fri, 9 Sep 2011 10:52:17 +0530
Subject: [PATCH v4 04/11] OMAP2+: UART: Remove uart clock handling code
	from serial.c
In-Reply-To: <87pqja61ue.fsf@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
	<1315400013-4849-5-git-send-email-govindraj.raja@ti.com>
	<87pqja61ue.fsf@ti.com>
Message-ID: <CAAL8m4xzaEhNbf9iRSq3crPvM_KwfLgjCgbsq_s5EEqr62ZasQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thanks for the review.

On Fri, Sep 9, 2011 at 5:09 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Cleanup serial.c file in preparation to addition of runtime API's in omap-serial
>> file. Remove all clock handling mechanism as this will be taken care with
>> pm runtime API's in omap-serial.c file itself.
>>
>> 1.) Remove omap-device enable and disable. We can can use get_sync/put_sync API's
>> 2.) Remove context save/restore can be done with runtime_resume callback for
>> ? ? get_sync call. No need to save context as all reg details available in
>> ? ? uart_port structure can be used for restore, so add missing regs in
>> ? ? uart port struct.
>> 3.) Add func to identify console uart.
>
> I don't see that as part of this patch.

Yes I have to remove that line.

>
>> 4.) Erratum handling informed as flag to driver and func to handle erratum
>> ? ? can be moved to omap-serial driver itself.
>
> OK, but I see two erratum flags removed, but only flag added back.
> Also, the erratum handling is completely removed here and not added to
> the driver.
>

errata 2.15, yes correct force idle mode if in dma mode
need to incorporated into runtime suspend call back.

> In general, this way of moving things makes it very difficult to review.
> You remove a bunch of things in this patch (and the previous one) and
> imply that some of it is added back to the driver. ?However, that's
> really difficult to verify with patch review.
>

the things I moved from here to driver :

1.) prepare and resume calls, Yes I can incorporate 9/11 into this patch.

2.) mdr errata movement - yes can be part of this change.

3.) context restore is part of runtime resume call back so I think
that should be part of runtime patches itself. Also force idle mode errata 2.15
missed out also should be part of runtime suspend hook.
so cant be part of this change here.


> If code is being moved, it is customary to remove it and add it to the
> new place in the same patch.
>

Ok.

>> Acked-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>> ---
>> ?arch/arm/mach-omap2/serial.c ? ? ? ? ? ? ? ? ?| ?742 ++-----------------------
>> ?arch/arm/plat-omap/include/plat/omap-serial.h | ? 11 +-
>> ?2 files changed, 53 insertions(+), 700 deletions(-)
>
> [...]
>
>> -static DEVICE_ATTR(sleep_timeout, 0644, sleep_timeout_show,
>> - ? ? ? ? ? ? sleep_timeout_store);
>> -#define DEV_CREATE_FILE(dev, attr) WARN_ON(device_create_file(dev, attr))
>> -#else
>> -static inline void omap_uart_idle_init(struct omap_uart_state *uart) {}
>> -static void omap_uart_block_sleep(struct omap_uart_state *uart)
>> +struct omap_hwmod *omap_uart_hwmod_lookup(int num)
>
> function should be static
>

OK.

> [...]
>
>> + ? ? for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>> + ? ? ? ? ? ? oh = omap_uart_hwmod_lookup(i);
>> ? ? ? ? ? ? ? if (!oh)
>> - ? ? ? ? ? ? ? ? ? ? break;
>> -
>> - ? ? ? ? ? ? uart = kzalloc(sizeof(struct omap_uart_state), GFP_KERNEL);
>> - ? ? ? ? ? ? if (WARN_ON(!uart))
>> - ? ? ? ? ? ? ? ? ? ? return -ENODEV;
>> -
>> - ? ? ? ? ? ? uart->oh = oh;
>> - ? ? ? ? ? ? uart->num = i++;
>> - ? ? ? ? ? ? list_add_tail(&uart->node, &uart_list);
>> - ? ? ? ? ? ? num_uarts++;
>> -
>> - ? ? ? ? ? ? /*
>> - ? ? ? ? ? ? ?* NOTE: omap_hwmod_setup*() has not yet been called,
>> - ? ? ? ? ? ? ?* ? ? ? so no hwmod functions will work yet.
>> - ? ? ? ? ? ? ?*/
>> -
>> - ? ? ? ? ? ? /*
>> - ? ? ? ? ? ? ?* During UART early init, device need to be probed
>> - ? ? ? ? ? ? ?* to determine SoC specific init before omap_device
>> - ? ? ? ? ? ? ?* is ready. ?Therefore, don't allow idle here
>> - ? ? ? ? ? ? ?*/
>> - ? ? ? ? ? ? uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>> - ? ? } while (1);
>> + ? ? ? ? ? ? ? ? ? ? continue;
>>
>> + ? ? ? ? ? ? oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>
> With proper runtime PM in the driver, I did not expect these to be
> needed any longer by the end of the series, but I see they are still
> there. ?Are they really needed?
>

Actually when we use early_printk option from CONFIG_DEBUG_LL
we use the debug-macro.s file to do put-char of early kernel prints until
a console driver is available, So while debug-macros does putchar from uart
if we try to reset console uart during hwmod_init this will cause uart
to go to bad state
and still no console driver available and can halt uart during bootup.

reset from hwmod -> putchar from earlyprintk driver doing tx on uart ??

Since softreset from hwmod can loose uart configuration from bootloader
and earlyprintk driver is unaware of this and does tx on uart.

Hence we still need this code to avoid uart reset & idle during bootup.

> [...]
>
>> @@ -864,15 +213,14 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
>> ? */
>> ?void __init omap_serial_init(void)
>> ?{
>> - ? ? struct omap_uart_state *uart;
>> ? ? ? struct omap_board_data bdata;
>> + ? ? u8 i;
>>
>> - ? ? list_for_each_entry(uart, &uart_list, node) {
>> - ? ? ? ? ? ? bdata.id = uart->num;
>> + ? ? for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
>
> This should probably use the hwmod class iterator.

yes, will check that option.

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
