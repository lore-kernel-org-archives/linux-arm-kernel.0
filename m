From: russ.dill@gmail.com (Russ Dill)
Date: Mon, 9 Apr 2012 09:56:38 -0700
Subject: [RESEND PATCH] ARM :OMAP2+: UART: Remove some of uart default pads
In-Reply-To: <CAMrsUdKs21qtrWX0i44fvm7U2JW0L=2NgmZBHAZGmwp03XFm6w@mail.gmail.com>
References: <1332324149-16058-1-git-send-email-govindraj.raja@ti.com>
 <20120403181925.GH8240@atomide.com>
 <CAMrsUdLrpyGrhggi820WcR+DoHJVB8GQ1THUOO-C4LqUQtAxWQ@mail.gmail.com>
 <20120405165811.GB3785@atomide.com>
 <CAMrsUdJEY2o2CWjzSg5dabVEkpk48O5njtDU55Z3Jq2vViNJgQ@mail.gmail.com>
 <20120406181556.GC15734@atomide.com>
 <CAMrsUdKs21qtrWX0i44fvm7U2JW0L=2NgmZBHAZGmwp03XFm6w@mail.gmail.com>
Message-ID: <CA+Bv8XZgKg-Om9S=CcJEDWRan0pMZ_t1aCVT31q3REmcgLntBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Thanks for the review and suggestions, here is the patch [1] to do the same.
>
> I tested this patch on beagle-xm where uart pin mux was causing clash
> with usb ehci hub gpio nrest pin, now with this patch smsc hub + ethernet
> get enumerated.

Morning. I tested this patch on both next and master on the xM and it
does work, however, I have some comments.

> From 37850b9e80fc4dac050bff5b6dbb67c245be43cc Mon Sep 17 00:00:00 2001
> From: "Govindraj.R" <govindraj.raja@ti.com>
> Date: Mon, 9 Apr 2012 15:16:52 +0530
> Subject: [PATCH] ARM: OMAP2+: UART: Fix usage of default uart pads.
>
> The following commit:
> (7496ba3 ?ARM: OMAP2+: UART: Add default mux for all uarts)
> added default pads for all uarts. But not all boards tend to
> use all uarts and most of unused uart pins are muxed for
> other purpose. This commit breaks the modules which where trying
> to use unused uart pins on their boards.
>
> So check for the availability of uart pins before filling the pads
> if both tx and rx are available as uart pins then use them for
> filling as default pads where rx pin is muxed dynamically for
> rx wakeup capability.
>
> However the board file owners can use omap_serial_init_port
> and pass mux data part of board data for board specific use cases.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
> ?arch/arm/mach-omap2/mux.c ? ?| ? ?2 +-
> ?arch/arm/mach-omap2/mux.h ? ?| ? 10 +++
> ?arch/arm/mach-omap2/serial.c | ?158 ++++++++++++------------------------------
> ?3 files changed, 56 insertions(+), 114 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> index 65c3391..5334914 100644
> --- a/arch/arm/mach-omap2/mux.c
> +++ b/arch/arm/mach-omap2/mux.c
> @@ -217,7 +217,7 @@ static int __init _omap_mux_get_by_name(struct
> omap_mux_partition *partition,

It seems your mailer might be eating your patches....What mailer are you using?

> ? ? ? ?return -ENODEV;
> ?}
>
> -static int __init
> +int __init
> ?omap_mux_get_by_name(const char *muxname,
> ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux_partition **found_partition,
> ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux **found_mux)
> diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
> index 69fe060..461b90d 100644
> --- a/arch/arm/mach-omap2/mux.h
> +++ b/arch/arm/mach-omap2/mux.h
> @@ -225,8 +225,18 @@ omap_hwmod_mux_init(struct omap_device_pad
> *bpads, int nr_pads);
> ?*/
> ?void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
>
> +int omap_mux_get_by_name(const char *muxname,
> + ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux_partition **found_partition,
> + ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux **found_mux);
> ?#else
>
> +static inline int omap_mux_get_by_name(const char *muxname,
> + ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux_partition **found_partition,
> + ? ? ? ? ? ? ? ? ? ? ? ?struct omap_mux **found_mux)
> +{
> + ? ? ? return 0;
> +}
> +
> ?static inline int omap_mux_init_gpio(int gpio, int val)
> ?{
> ? ? ? ?return 0;
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0cdd359..30a0f4e 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -120,127 +120,59 @@ static void omap_uart_set_smartidle(struct
> platform_device *pdev) {}
> ?#endif /* CONFIG_PM */
>
> ?#ifdef CONFIG_OMAP_MUX
> -static struct omap_device_pad default_uart1_pads[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart1_cts.uart1_cts",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart1_rts.uart1_rts",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart1_tx.uart1_tx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart1_rx.uart1_rx",
> - ? ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? ? ? ? ? .idle ? = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? },
> -};
>
> -static struct omap_device_pad default_uart2_pads[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart2_cts.uart2_cts",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart2_rts.uart2_rts",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart2_tx.uart2_tx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart2_rx.uart2_rx",
> - ? ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? ? ? ? ? .idle ? = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? },
> -};
> -
> -static struct omap_device_pad default_uart3_pads[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart3_cts_rctx.uart3_cts_rctx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart3_rts_sd.uart3_rts_sd",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart3_tx_irtx.uart3_tx_irtx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart3_rx_irrx.uart3_rx_irrx",
> - ? ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> - ? ? ? ? ? ? ? .idle ? = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> -};
> +#define OMAP_UART_DEFAULT_PAD_NAME_LEN 28
> +static char __initdata rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN];
>
> -static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "gpmc_wait2.uart4_tx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "gpmc_wait3.uart4_rx",
> - ? ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE2,
> - ? ? ? ? ? ? ? .idle ? = OMAP_PIN_INPUT | OMAP_MUX_MODE2,
> - ? ? ? },
> -};
> +static void ?__init omap_serial_fill_default_pads(struct
> omap_board_data *bdata)
> +{
> + ? ? ? struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
> + ? ? ? struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
> + ? ? ? struct omap_device_pad default_omap_uart_pads[2];
> +
> + ? ? ? if (bdata->id != 2) {
> + ? ? ? ? ? ? ? snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? ?"uart%d_rx.uart%d_rx", bdata->id + 1, bdata->id + 1);
> + ? ? ? ? ? ? ? snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? ?"uart%d_tx.uart%d_tx", bdata->id + 1, bdata->id + 1);
> + ? ? ? } else {
> + ? ? ? ? ? ? ? snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? "uart%d_rx_irrx.uart%d_rx_irrx", bdata->id + 1,
> + ? ? ? ? ? ? ? ? ? ? ? bdata->id + 1);
> + ? ? ? ? ? ? ? snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> + ? ? ? ? ? ? ? ? ? ? ? "uart%d_tx_irtx.uart%d_tx_irtx", bdata->id + 1,
> + ? ? ? ? ? ? ? ? ? ? ? bdata->id + 1);
> + ? ? ? }
>
> -static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {
> - ? ? ? {
> - ? ? ? ? ? ? ? .name ? = "uart4_tx.uart4_tx",
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> + ? ? ? if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_mux) >= 0 &&
> + ? ? ? ? ? ? ? omap_mux_get_by_name(tx_pad_name, &tx_partition, &tx_mux) >= 0)
> ? ? ? ?{
> - ? ? ? ? ? ? ? .name ? = "uart4_rx.uart4_rx",
> - ? ? ? ? ? ? ? .flags ?= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> - ? ? ? ? ? ? ? .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> - ? ? ? ? ? ? ? .idle ? = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> - ? ? ? },
> -};
> -
> -static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
> -{
> - ? ? ? switch (bdata->id) {
> - ? ? ? case 0:
> - ? ? ? ? ? ? ? bdata->pads = default_uart1_pads;
> - ? ? ? ? ? ? ? bdata->pads_cnt = ARRAY_SIZE(default_uart1_pads);
> - ? ? ? ? ? ? ? break;
> - ? ? ? case 1:
> - ? ? ? ? ? ? ? bdata->pads = default_uart2_pads;
> - ? ? ? ? ? ? ? bdata->pads_cnt = ARRAY_SIZE(default_uart2_pads);
> - ? ? ? ? ? ? ? break;
> - ? ? ? case 2:
> - ? ? ? ? ? ? ? bdata->pads = default_uart3_pads;
> - ? ? ? ? ? ? ? bdata->pads_cnt = ARRAY_SIZE(default_uart3_pads);
> - ? ? ? ? ? ? ? break;
> - ? ? ? case 3:
> - ? ? ? ? ? ? ? if (cpu_is_omap44xx()) {
> - ? ? ? ? ? ? ? ? ? ? ? bdata->pads = default_omap4_uart4_pads;
> - ? ? ? ? ? ? ? ? ? ? ? bdata->pads_cnt =
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(default_omap4_uart4_pads);
> - ? ? ? ? ? ? ? } else if (cpu_is_omap3630()) {
> - ? ? ? ? ? ? ? ? ? ? ? bdata->pads = default_omap36xx_uart4_pads;
> - ? ? ? ? ? ? ? ? ? ? ? bdata->pads_cnt =
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(default_omap36xx_uart4_pads);
> + ? ? ? ? ? ? ? u16 tx_mode, rx_mode;
> +
> + ? ? ? ? ? ? ? tx_mode = omap_mux_read(tx_partition, tx_mux->reg_offset);
> + ? ? ? ? ? ? ? rx_mode = omap_mux_read(rx_partition, rx_mux->reg_offset);
> +
> + ? ? ? ? ? ? ? if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].name = rx_pad_name;
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].flags ?=
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].enable = OMAP_PIN_INPUT |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[0].idle = OMAP_PIN_INPUT |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> +
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[1].name = tx_pad_name;
> + ? ? ? ? ? ? ? ? ? ? ? default_omap_uart_pads[1].enable = OMAP_PIN_OUTPUT |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP_MUX_MODE0;
> + ? ? ? ? ? ? ? ? ? ? ? bdata->pads = default_omap_uart_pads;

You are assigning this variable to a structure on the stack.

> + ? ? ? ? ? ? ? ? ? ? ? bdata->pads_cnt = ARRAY_SIZE(default_omap_uart_pads);
> ? ? ? ? ? ? ? ?}
> - ? ? ? ? ? ? ? break;
> - ? ? ? default:
> - ? ? ? ? ? ? ? break;
> ? ? ? ?}
> ?}
> ?#else
> -static void omap_serial_fill_default_pads(struct omap_board_data *bdata) {}
> +static void __init omap_serial_fill_default_pads(struct omap_board_data *bdata)
> +{}
> ?#endif
>
> ?char *cmdline_find_option(char *str)
> --
> 1.7.9
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
