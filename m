From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 4 May 2011 16:04:16 +0530
Subject: [PATCH v2 03/12] OMAP2+: Serial: Add default mux for all uarts.
In-Reply-To: <20110504100051.GZ2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
	<1304080796-625-4-git-send-email-govindraj.raja@ti.com>
	<20110504100051.GZ2092@atomide.com>
Message-ID: <BANLkTikcCHUP8j_z1A6mfmjj6_i9P-HN-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 4, 2011 at 3:30 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
>> Add default mux data for all uarts if mux info is not passed from
>> board file to avoid breaking any board support.
>
> This should only happen if omap_serial_init is called,
> then boards can still use platform data with omap_serial_init_port.

Yes correct thats how its designed with this patch series.
One can use omap_serial_init to initialize all uarts
or use omap_serial_init_port for individual uart.

Default pads are filled only if board uses omap_serial_init(NULL);
to initialize all uarts.

>
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -66,6 +66,129 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
>> ? ? ? },
>> ?};
>>
>> +#ifdef CONFIG_OMAP_MUX
>> +static struct omap_device_pad default_uart1_pads[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart1_cts.uart1_cts",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart1_rts.uart1_rts",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart1_tx.uart1_tx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart1_rx.uart1_rx",
>> + ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> + ? ? },
>> +};
>> +
>> +static struct omap_device_pad default_uart2_pads[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart2_cts.uart2_cts",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart2_rts.uart2_rts",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart2_tx.uart2_tx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart2_rx.uart2_rx",
>> + ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> + ? ? },
>> +};
>> +
>> +static struct omap_device_pad default_uart3_pads[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart3_cts_rctx.uart3_cts_rctx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart3_rts_sd.uart3_rts_sd",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart3_tx_irtx.uart3_tx_irtx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart3_rx_irrx.uart3_rx_irrx",
>> + ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> +};
>> +
>> +static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "gpmc_wait2.uart4_tx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "gpmc_wait3.uart4_rx",
>> + ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE2,
>> + ? ? },
>> +};
>> +
>> +static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart4_tx.uart4_tx",
>> + ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
>> + ? ? },
>> + ? ? {
>> + ? ? ? ? ? ? .name ? = "uart4_rx.uart4_rx",
>> + ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
>> + ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
>> + ? ? },
>
> Looks like you could easily allocate the struct and use sprintf
> to generate this as needed to avoid duplication.

Only uart1/2 have common name

* uart3 having different naming pins
* uart4 doesnt have cts/rts
* uart4 on 3630 uses gpmc.wait2
* rx requires wakeup enable flag

So would again give me a function with switch case for uart1/2/3/4
which is very similar to above structs.

Thats the reson I kept individual structs.
Also becomes easy if we need to disable or avoid a
individual uart pad.

--
Thanks,
Govindraj.R


>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
