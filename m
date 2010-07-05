From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 15:01:04 -0400 (EDT)
Subject: [PATCH 2/3] leds: add LED driver for Network Space v2 LEDs
In-Reply-To: <1278325866-3890-2-git-send-email-simon@sequanux.org>
References: <1278325866-3890-1-git-send-email-simon@sequanux.org>
	<1278325866-3890-2-git-send-email-simon@sequanux.org>
Message-ID: <alpine.LFD.2.00.1007051444030.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jul 2010, Simon Guinot wrote:

> From: Simon Guinot <sguinot@lacie.com>
> 
> This patch add a LED class driver for the dual-GPIO LEDs found on the
> Network Space v2 board (and parents). This include Internet Space v2,
> Network Space (Max) v2 and d2 Network v2 boards.
> 
> This dual-GPIO LED is wired to a CPLD and can blink in relation with the
> SATA activity. The driver expose this capability through a "sata" sysfs
> attribute.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
[...]

> +config LEDS_NS2
> +	tristate "LED support for Network Space v2 GPIO LEDs"
> +	depends on MACH_NETSPACE_V2 || MACH_INETSPACE_V2 || MACH_NETSPACE_MAX_V2

You could add a "default y" here.

> +enum ns2_led_modes {
> +	NS_V2_LED_OFF,
> +	NS_V2_LED_ON,
> +	NS_V2_LED_SATA,
> +};
> +
> +struct ns2_led_mode_value {
> +	enum ns2_led_modes	mode;
> +	int			cmd_level;
> +	int			slow_level;
> +};
> +
> +struct ns2_led_mode_value ns2_led_modval[] = {
> +	{ NS_V2_LED_OFF	, 1, 0 },
> +	{ NS_V2_LED_ON	, 0, 1 },
> +	{ NS_V2_LED_ON	, 1, 1 },
> +	{ NS_V2_LED_SATA, 0, 0 },
> +};

You probably want to make this static.

> diff --git a/include/linux/leds-ns2.h b/include/linux/leds-ns2.h
> new file mode 100644
> index 0000000..c76ebbb
> --- /dev/null
> +++ b/include/linux/leds-ns2.h

This is probably not the best location for this file as it is really 
specific to a particular device and not generic for the kernel.  You 
could create it in arch/arm/mach-kirkwood/include/mach/leds-ns2.h 
instead, and include it with #include <mach/leds-ns2.h>.


Nicolas
