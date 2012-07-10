From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2012 14:12:01 +0000
Subject: [PATCH] mfd: Implement devicetree support for AB8500 Btemp
In-Reply-To: <1341926639-9956-1-git-send-email-rajanikanth.hv@stericsson.com>
References: <1341926639-9956-1-git-send-email-rajanikanth.hv@stericsson.com>
Message-ID: <201207101412.01561.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012, Rajanikanth H.V wrote:

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
> @@ -0,0 +1,54 @@
> +AB8500 Battery Termperature Monitor Driver
> +
> +AB8500 is a mixed signal multimedia and power management
> +device comprising: power and energy management module,
> +WalliCharger and USB charger interface, audio, general
> +purpose ADC TVOut, clock management and SIM card Interface.
> +
> +Battery temperature monitoring support is part of 'energy
> +management module', the other components of this module
> +are: 'main and USB Combo charger' and fuel guage.
> +
> +The properties below describes the node for battery
> +temperature monitor driver.
> +
> +Required Properties:
> +- compatible = "stericsson,ab8500-btemp"
> +
> +interrupts:
> +	Four battery temperature ranges are be defined
> +	which results in interrupt events as:
> +	- Btemp
> +	- BtempLow
> +	- BtempMedium
> +	- BtempHigh
> +

These names do not match the five interrupts in the example or in the
code. When you provide an "interrupt-names" property you have to define
the exact strings that are permissible for them in the binding.

> +Supplied-to:
> +	This shall be power supply class dependency where in the runtime battery
> +	properties will be shared across fuel guage and charging algorithm driver.

I probably don't understand enough of this, but shouldn't the other devices
that are supplied by this have a reference to this node rather than doing
it this way around? Why use strings here instead of phandles?

You are also not listing some of the properties that are in the device
tree here, like the "interrupts" property itself.

> diff --git a/arch/arm/mach-ux500/board-mop500-bm.c b/arch/arm/mach-ux500/board-mop500-bm.c
> new file mode 100644
> index 0000000..3349ceb
> --- /dev/null
> +++ b/arch/arm/mach-ux500/board-mop500-bm.c

Didn't we conclude that this file has no board-specific information in it?
Either explain why it's still here, or move it into the driver itself.

> +/*
> + * Note that the batres_vs_temp table must be strictly sorted by falling
> + * temperature values to work.
> + */
> +#ifdef CONFIG_AB8500_9100_LI_ION_BATTERY
> +#define BATRES	180
> +#else
> +#define BATRES	300
> +#endif

I think I mentioned before that you need to get rid of the
CONFIG_AB8500_9100_LI_ION_BATTERY symbol. If you have exclusive
compile-time options, it is impossible to build a kernel that
runs on all system, so this has to be a run-time option.

	Arnd
