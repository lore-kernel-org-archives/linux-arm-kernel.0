From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 14:18:39 -0800
Subject: [PATCH 1/2] ARM64: dts: meson-gxm: Add R-Box Pro
In-Reply-To: <63fbfc68-917f-68b2-9e7d-e1834e2841d3@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Tue, 17 Jan 2017 04:35:10 +0100")
References: <20170117030611.23827-1-afaerber@suse.de>
 <20170117030611.23827-2-afaerber@suse.de>
 <63fbfc68-917f-68b2-9e7d-e1834e2841d3@suse.de>
Message-ID: <m27f5sypts.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 17.01.2017 um 04:06 schrieb Andreas F?rber:
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		blue {
>> +			label = "rbox-pro:blue:on";
>> +			gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
>> +			default-state = "on";
>> +		};
>> +
>> +		red {
>> +			label = "rbox-pro:red:standby";
>> +			gpios = <&gpio GPIODV_28 GPIO_ACTIVE_HIGH>;
>> +			default-state = "off";
>> +			retain-state-suspended;
>> +			panic-indicator;
>> +		};
>> +	};
>
> The original property names for these two were led and red. If anyone
> has better label names than the above, please speak up. Ditto for
> vega-s95. On the odroidc2 it's called alive but uses heartbeat there.
>
> The vendor device tree had a third "mcu" GPIO in the sysled node,
> GPIOAO_6, which leads to immediate power-off. I tried using
> "gpio-poweroff" to configure this pin, but that driver fails to
> initialize because some pm callback is already registered - I assume
> from psci, which apparently succeeds to power-off the system, too. For
> comparison, the S905 based Vega S95 Telos has no such mcu property. Any
> thoughts?
>
> Also, any ideas how best to switch from blue to red for suspend? Add
> pinctrl properties above? systemd service doing echo from userspace? I
> assume in Android the Amlogic sysled driver handles all that logic -
> didn't find any suspend equivalent to gpio-poweroff.

in leds-gpio, when retain-state-suspended is not set, the LED is
automatically set to value 0.  I wonder if leds-gpio should grow support
to make the suspend value configurable?  Or a property like
"toggle-state-suspended" ?

Kevin
