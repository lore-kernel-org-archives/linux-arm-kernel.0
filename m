From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Sep 2012 14:01:06 +0000
Subject: mfd: Implement devicetree support for AB8500 Btemp
In-Reply-To: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
References: <CAB4BAktQz5MY_AHHWUAhRp7HtEzC3v8uFbP0enx1b7ibJLoZ4Q@mail.gmail.com>
Message-ID: <201209101401.06859.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 10 September 2012, Rajanikanth HV wrote:
> +
> +supplied-to:
> +       This is a logical binding w.r.t power supply event change
> +       across energy-management-module drivers where in the
> +       runtime battery properties are shared along with uevent
> +       notification.
> +       ref: di->btemp_psy.external_power_changed =
> +               ab8500_btemp_external_power_changed;
> +               ab8500_btemp.c
> +
> +       Need for this property:
> +               btemp, fg and charger updates power-supply properties
> +               based on the events listed above.
> +               Event handler invokes power supply change notifier
> +               which in-turn invokes registered power supply class call-back
> +               based on the 'supplied_to' string.
> +               ref:
> +               power_supply_changed_work(..) ./drivers/power/power_supply_core.c
> +
> +       example:
> +       ab8500-btemp {
> +               /* Other enery management module */
> +               supplied-to = "ab8500_chargalg", "ab8500_fg";
> +               num_supplicants = <2>;
> +       };
> +

This looks like you're doing things the opposite way from everyone else.
Normally, each device uses phandles to refer to other objects it depends
on (gpio lines, regulators, clocks, interrupts, ...), rather than listing
things that depend on it.

Can you turn this around to be more like the others?

Note also that device tree identifiers should use '-' as a word separator,
not '_', and that a binding document should specify the exact set of
possible values. If the properties contain strings, please list every
valid string.

> +               thermister-internal-to-battery = <1>;
> +               li_ion_9100_battery = <0>;

Boolean properties should be empty when enabled and not present when
disabled. In this example, one would just write

		thermister-internal-to-battery;


	Arnd
