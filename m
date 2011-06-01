From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Jun 2011 10:20:14 -0300
Subject: [PATCH] arm: at91: convert old leds drivers to gpio_led and
	led_trigger drivers
In-Reply-To: <1306922407-22632-1-git-send-email-bryan.wu@canonical.com>
References: <1306922407-22632-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <BANLkTin3K-=+9SFKYPg1kjnABjHXr3V1dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Wed, Jun 1, 2011 at 7:00 AM, Bryan Wu <bryan.wu@canonical.com> wrote:
> Build with at91 defconfigs successfully
>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
> ?arch/arm/mach-at91/board-cap9adk.c ? ? ?| ? 21 ++++++-
> ?arch/arm/mach-at91/board-csb337.c ? ? ? | ? ?3 -
> ?arch/arm/mach-at91/board-ecbat91.c ? ? ?| ? 18 +++++-
> ?arch/arm/mach-at91/board-eco920.c ? ? ? | ? 23 ++++++-
> ?arch/arm/mach-at91/board-kafa.c ? ? ? ? | ? 17 ++++-
> ?arch/arm/mach-at91/board-kb9202.c ? ? ? | ? 23 ++++++-
> ?arch/arm/mach-at91/board-rm9200dk.c ? ? | ? ?3 -
> ?arch/arm/mach-at91/board-rm9200ek.c ? ? | ? ?3 -
> ?arch/arm/mach-at91/board-sam9-l9260.c ? | ? 23 ++++++-
> ?arch/arm/mach-at91/board-sam9261ek.c ? ?| ? ?3 -
> ?arch/arm/mach-at91/board-yl-9200.c ? ? ?| ? ?3 -
> ?arch/arm/mach-at91/include/mach/board.h | ? ?1 -
> ?arch/arm/mach-at91/leds.c ? ? ? ? ? ? ? | ?105 -------------------------------
> ?13 files changed, 108 insertions(+), 138 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-cap9adk.c b/arch/arm/mach-at91/board-cap9adk.c
> index 1904fdf..c324b85 100644
> --- a/arch/arm/mach-at91/board-cap9adk.c
> +++ b/arch/arm/mach-at91/board-cap9adk.c
> @@ -55,8 +55,6 @@ static void __init cap9adk_init_early(void)
> ? ? ? ?/* Initialize processor: 12 MHz crystal */
> ? ? ? ?at91cap9_initialize(12000000);
>
> - ? ? ? /* Setup the LEDs: USER1 and USER2 LED for cpu/timer... */
> - ? ? ? at91_init_leds(AT91_PIN_PA10, AT91_PIN_PA11);
> ? ? ? ?/* ... POWER LED always on */
> ? ? ? ?at91_set_gpio_output(AT91_PIN_PC29, 1);
>
> @@ -365,6 +363,23 @@ static struct ac97c_platform_data cap9adk_ac97_data = {
> ?// ? ? .reset_pin ? ? ?= ... not connected
> ?};
>
> +/*
> + * LEDs
> + */
> +static struct gpio_led cap9adk_leds[] = {
> + ? ? ? { ? ? ? /* D1 */
> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "led1",
> + ? ? ? ? ? ? ? .gpio ? ? ? ? ? ? ? ? ? = AT91_PIN_PA10,
> + ? ? ? ? ? ? ? .active_low ? ? ? ? ? ? = 1,
> + ? ? ? ? ? ? ? .default_trigger ? ? ? ?= "heartbeat",
> + ? ? ? },
> + ? ? ? { ? ? ? /* D2 */
> + ? ? ? ? ? ? ? .name ? ? ? ? ? ? ? ? ? = "led2",
> + ? ? ? ? ? ? ? .gpio ? ? ? ? ? ? ? ? ? = AT91_PIN_PA11,
> + ? ? ? ? ? ? ? .active_low ? ? ? ? ? ? = 1,
> + ? ? ? ? ? ? ? .default_trigger ? ? ? ?= "timer",
> + ? ? ? }
> +};
>
> ?static void __init cap9adk_board_init(void)
> ?{
> @@ -392,6 +407,8 @@ static void __init cap9adk_board_init(void)
> ? ? ? ?at91_add_device_lcdc(&cap9adk_lcdc_data);
> ? ? ? ?/* AC97 */
> ? ? ? ?at91_add_device_ac97(&cap9adk_ac97_data);
> + ? ? ? /* LEDs */
> + ? ? ? at91_gpio_leds(cap9adk_leds, ARRAY_SIZE(cap9adk_leds));

I haven't checked the way you register the LEDs, but maybe you can try
to use gpio_led_register_device to register them.

Uwe has recently introduced a new new leds-gpio registration helper.

Please check the patch below for an example of its usage:
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=cf1738dad02f22781ae1f08414634086fc613d81

Regards,

Fabio Estevam
