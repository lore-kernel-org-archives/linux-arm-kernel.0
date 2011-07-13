From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 14 Jul 2011 08:15:16 +0900
Subject: [PATCH 3/4] dt: omap3: add generic board file for dt support
In-Reply-To: <1310592975-25773-4-git-send-email-manjugk@ti.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com>
	<1310592975-25773-4-git-send-email-manjugk@ti.com>
Message-ID: <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com> wrote:
>
> The generic board file is created and derived from beagle board file.
> The beagle board file is migrated to boot from flattened device tree and
> the cleanup of generic board file will happen in different stages.
>
> The changes here focus on i2c device registration through dt and upcoming
> patches in the series will adopt i2c driver to use dt registered i2c
> devices.

Since this is a new board file instead of a modification of an
existing one, I recommend *not* trying to completely duplicate the
behaviour of the beagle board.  Start small with only the registration
of the UART and i2c drivers from the device tree and build up
functionality until it can be used for all the OMAP3 boards.
Otherwise the patch just adds a lot of code that needs to be removed
again.

>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> ?arch/arm/mach-omap2/Kconfig ? ? ? ? ? ? | ? 12 +
> ?arch/arm/mach-omap2/Makefile ? ? ? ? ? ?| ? ?2 +
> ?arch/arm/mach-omap2/board-omap3-dt.c ? ?| ?623 +++++++++++++++++++++++++++++++
> ?arch/arm/mach-omap2/board-omap3beagle.c | ? 13 -
> ?4 files changed, 637 insertions(+), 13 deletions(-)
> ?create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..174f6d1 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP
> ? ? ? ?default y
> ? ? ? ?select OMAP_PACKAGE_CBP
>
> +config MACH_OMAP3_DT
> + ? ? ? bool "Generic OMAP3 board(FDT support)"
> + ? ? ? depends on ARCH_OMAP3
> + ? ? ? select OMAP_PACKAGE_CBB
> + ? ? ? select USE_OF
> + ? ? ? select PROC_DEVICETREE

Don't select PROC_DEVICETREE

> +
> + ? ? ? help
> + ? ? ? ? Support for generic TI OMAP3 boards using Flattened Device Tree.
> + ? ? ? ? Say Y here to enable OMAP3 device tree support
> + ? ? ? ? More information at Documentation/devicetree
> +
> ?config MACH_TI8168EVM
> ? ? ? ?bool "TI8168 Evaluation Module"
> ? ? ? ?depends on SOC_OMAPTI816X
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b148077..86e66f7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4) ? ? ? ? ?+= board-h4.o
> ?obj-$(CONFIG_MACH_OMAP_2430SDP) ? ? ? ? ? ? ? ?+= board-2430sdp.o \
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? hsmmc.o
> ?obj-$(CONFIG_MACH_OMAP_APOLLON) ? ? ? ? ? ? ? ?+= board-apollon.o
> +obj-$(CONFIG_MACH_OMAP3_DT) ? ? ? ? ? ?+= board-omap3-dt.o \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?hsmmc.o
> ?obj-$(CONFIG_MACH_OMAP3_BEAGLE) ? ? ? ? ? ? ? ?+= board-omap3beagle.o \
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? hsmmc.o

This is an odd construct.  Tony, why does each board add hsmmc to the
oby-y variable instead of it having its own kconfig symbol?

> +static void __init omap3_init(void)
> +{
> + ? ? ? struct device_node *node;
> +
> + ? ? ? node = of_find_matching_node_by_address(NULL, omap3_dt_intc_match,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? OMAP34XX_IC_BASE);
> + ? ? ? if (node)
> + ? ? ? ? ? ? ? irq_domain_add_simple(node, 0);
> +
> + ? ? ? omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> + ? ? ? omap3_beagle_init_rev();
> + ? ? ? omap3_beagle_i2c_init();
> + ? ? ? platform_add_devices(omap3_beagle_devices,
> + ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(omap3_beagle_devices));
> + ? ? ? omap_display_init(&beagle_dss_data);
> + ? ? ? omap_serial_init();
> +
> + ? ? ? omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> + ? ? ? /* REVISIT leave DVI powered down until it's needed ... */
> + ? ? ? gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
> +
> + ? ? ? usb_musb_init(NULL);
> + ? ? ? usbhs_init(&usbhs_bdata);
> + ? ? ? omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand_partitions,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(omap3beagle_nand_partitions));
> +
> + ? ? ? /* Ensure msecure is mux'd to be able to set the RTC. */
> + ? ? ? omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
> +
> + ? ? ? /* Ensure SDRC pins are mux'd for self-refresh */
> + ? ? ? omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> + ? ? ? omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> +
> + ? ? ? beagle_display_init();
> + ? ? ? beagle_opp_init();
> + ? ? ? of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);

Hmmm, I don't think this will work for OMAP because it will not create
the i2c bus as an omap_device.  It will only be a plane
platform_deevice.  You'll need to have a hook in
of_platform_populate() to create devices the way omap3 infrastructure
expects.

> +}
> +
> +static const char *omap3_dt_match[] __initdata = {
> + ? ? ? "ti,omap3-beagle",
> + ? ? ? NULL

"ti,omap3" should be sufficient.

> +};
> +
> +DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
> + ? ? ? .boot_params ? ?= 0x80000100,

Drop boot_params.

> + ? ? ? .reserve ? ? ? ?= omap_reserve,
> + ? ? ? .map_io ? ? ? ? = omap3_map_io,
> + ? ? ? .init_early ? ? = omap3_init_early,
> + ? ? ? .init_irq ? ? ? = omap3_init_irq,
> + ? ? ? .init_machine ? = omap3_init,
> + ? ? ? .timer ? ? ? ? ?= &omap_timer,
> + ? ? ? .dt_compat ? ? ?= omap3_dt_match,
> +MACHINE_END
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 213c4cd..7efb178 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -19,7 +19,6 @@
> ?#include <linux/err.h>
> ?#include <linux/clk.h>
> ?#include <linux/io.h>
> -#include <linux/of_platform.h>
> ?#include <linux/leds.h>
> ?#include <linux/gpio.h>
> ?#include <linux/input.h>
> @@ -422,9 +421,7 @@ static int __init omap3_beagle_i2c_init(void)
> ? ? ? ?/* Bus 3 is attached to the DVI port where devices like the pico DLP
> ? ? ? ? * projector don't work reliably with 400kHz */
> ? ? ? ?omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY_SIZE(beagle_i2c_eeprom));
> -#ifdef CONFIG_OF
> ? ? ? ?omap_register_i2c_bus(2, 100, NULL, 0);
> -#endif /* CONFIG_OF */
> ? ? ? ?return 0;
> ?}
>
> @@ -567,10 +564,6 @@ static void __init beagle_opp_init(void)
>
> ?static void __init omap3_beagle_init(void)
> ?{
> -#ifdef CONFIG_OF
> - ? ? ? of_platform_prepare(NULL, NULL);
> -#endif /* CONFIG_OF */
> -
> ? ? ? ?omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> ? ? ? ?omap3_beagle_init_rev();
> ? ? ? ?omap3_beagle_i2c_init();
> @@ -599,11 +592,6 @@ static void __init omap3_beagle_init(void)
> ? ? ? ?beagle_opp_init();
> ?}
>
> -static const char *omap3_beagle_dt_match[] __initdata = {
> - ? ? ? "ti,omap3-beagle",
> - ? ? ? NULL
> -};
> -
> ?MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
> ? ? ? ?/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
> ? ? ? ?.boot_params ? ?= 0x80000100,
> @@ -613,5 +601,4 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
> ? ? ? ?.init_irq ? ? ? = omap3_beagle_init_irq,
> ? ? ? ?.init_machine ? = omap3_beagle_init,
> ? ? ? ?.timer ? ? ? ? ?= &omap_timer,
> - ? ? ? .dt_compat ? ? ?= omap3_beagle_dt_match,
> ?MACHINE_END
> --
> 1.7.4.1
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
