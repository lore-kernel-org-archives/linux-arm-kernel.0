From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Aug 2010 11:26:36 +0800
Subject: [PATCH 04/13] [ARM] pxa/palm: Modularize rest of code in Palms
In-Reply-To: <1280373389-32475-4-git-send-email-marek.vasut@gmail.com>
References: <1280373389-32475-1-git-send-email-marek.vasut@gmail.com>
	<1280373389-32475-4-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTins4gL93uTgCT0fErbLVUzWtiJheNzpi7mrRuZW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 11:16 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> ?arch/arm/mach-pxa/palmld.c ? | ? 63 +++++++++++++++----
> ?arch/arm/mach-pxa/palmt5.c ? | ? 22 ++++++-
> ?arch/arm/mach-pxa/palmtreo.c | ?141 ++++++++++++++++++++----------------------
> ?arch/arm/mach-pxa/palmtx.c ? | ? 49 ++++++++++++---
> ?arch/arm/mach-pxa/palmz72.c ?| ? 22 ++++++-
> ?5 files changed, 196 insertions(+), 101 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
> index cac66ca..d59db0b 100644
> --- a/arch/arm/mach-pxa/palmld.c
> +++ b/arch/arm/mach-pxa/palmld.c
> @@ -128,6 +128,7 @@ static unsigned long palmld_pin_config[] __initdata = {
> ?/******************************************************************************
> ?* NOR Flash
> ?******************************************************************************/
> +#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
> ?static struct mtd_partition palmld_partitions[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "Flash",
> @@ -161,9 +162,18 @@ static struct platform_device palmld_flash = {
> ? ? ? ?},
> ?};
>
> +static void __init palmld_nor_init(void)
> +{
> + ? ? ? platform_device_register(&palmld_flash);
> +}
> +#else
> +static inline void palmld_nor_init(void) {}
> +#endif
> +
> ?/******************************************************************************
> ?* GPIO keyboard
> ?******************************************************************************/
> +#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
> ?static unsigned int palmld_matrix_keys[] = {
> ? ? ? ?KEY(0, 1, KEY_F2),
> ? ? ? ?KEY(0, 2, KEY_UP),
> @@ -190,9 +200,18 @@ static struct pxa27x_keypad_platform_data palmld_keypad_platform_data = {
> ? ? ? ?.debounce_interval ? ? ?= 30,
> ?};
>
> +static void __init palmld_kpc_init(void)
> +{
> + ? ? ? pxa_set_keypad_info(&palmld_keypad_platform_data);
> +}
> +#else
> +static inline void palmld_kpc_init(void) {}
> +#endif
> +
> ?/******************************************************************************
> ?* GPIO keys
> ?******************************************************************************/
> +#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> ?static struct gpio_keys_button palmld_pxa_buttons[] = {
> ? ? ? ?{KEY_F8, GPIO_NR_PALMLD_HOTSYNC_BUTTON_N, 1, "HotSync Button" },
> ? ? ? ?{KEY_F9, GPIO_NR_PALMLD_LOCK_SWITCH, 0, "Lock Switch" },
> @@ -212,9 +231,18 @@ static struct platform_device palmld_pxa_keys = {
> ? ? ? ?},
> ?};
>
> +static void __init palmld_keys_init(void)
> +{
> + ? ? ? platform_device_register(&palmld_pxa_keys);
> +}
> +#else
> +static inline void palmld_keys_init(void) {}
> +#endif
> +
> ?/******************************************************************************
> ?* LEDs
> ?******************************************************************************/
> +#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
> ?struct gpio_led gpio_leds[] = {
> ?{
> ? ? ? ?.name ? ? ? ? ? ? ? ? ? = "palmld:green:led",
> @@ -240,26 +268,34 @@ static struct platform_device palmld_leds = {
> ? ? ? ?}
> ?};
>
> +static void __init palmld_leds_init(void)
> +{
> + ? ? ? platform_device_register(&palmld_leds);
> +}
> +#else
> +static inline void palmld_leds_init(void) {}
> +#endif
> +
> ?/******************************************************************************
> ?* HDD
> ?******************************************************************************/
> -static struct platform_device palmld_hdd = {
> +#if defined(CONFIG_PATA_PALMLD) || defined(CONFIG_PATA_PALMLD_MODULE)
> +static struct platform_device palmld_ide_device = {
> ? ? ? ?.name ? = "pata_palmld",
> ? ? ? ?.id ? ? = -1,
> ?};
>
> +static void __init palmld_ide_init(void)
> +{
> + ? ? ? platform_device_register(&palmld_ide_device);
> +}
> +#else
> +static inline void palmld_ide_init(void) {}
> +#endif
> +
> ?/******************************************************************************
> ?* Machine init
> ?******************************************************************************/
> -static struct platform_device *devices[] __initdata = {
> -#if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
> - ? ? ? &palmld_pxa_keys,
> -#endif
> - ? ? ? &palmld_leds,
> - ? ? ? &palmld_hdd,
> - ? ? ? &palmld_flash,
> -};
> -
> ?static struct map_desc palmld_io_desc[] __initdata = {
> ?{
> ? ? ? ?.virtual ? ? ? ?= PALMLD_IDE_VIRT,
> @@ -301,8 +337,11 @@ static void __init palmld_init(void)
> ?{
> ? ? ? ?pxa2xx_mfp_config(ARRAY_AND_SIZE(palmld_pin_config));
> ? ? ? ?palm27x_common_init(&palmld);
> - ? ? ? pxa_set_keypad_info(&palmld_keypad_platform_data);
> - ? ? ? platform_add_devices(devices, ARRAY_SIZE(devices));
> + ? ? ? palmld_kpc_init();
> + ? ? ? palmld_keys_init();

The original code is already well modularized, I doubt we need to go this
far. And I guess the following function names will be a bit readable?

	palmld_keypad_init();
	palmld_gpio_keys_init();

'kpc' - Grrr.... will take a bit time to figure out it's KeyPad Controller...
