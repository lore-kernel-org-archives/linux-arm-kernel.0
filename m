From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Apr 2014 20:44:32 +0200
Subject: [PATCH v2 2/5] Power: reset: add bindings for keystone reset
 driver
In-Reply-To: <1397497283-16391-3-git-send-email-ivan.khoronzhuk@ti.com>
References: <1397497283-16391-1-git-send-email-ivan.khoronzhuk@ti.com>
 <1397497283-16391-3-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <6937937.4J6iI7VpBO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 April 2014 20:41:20 Ivan Khoronzhuk wrote:
> +Optional properties:
> +
> +- ti,soft-reset:       Boolean option indicating soft reset.
> +                       By default hard reset is used.
> +
> +- ti,wdt_list:         WDT list that can cause SoC reset.
> +                       The list in format: <0>, <2>;
> +                       Begins from 0 to 3, as keystone can contain up
> +                       to 4 SoC reset watchdogs.
> 

This looks like your binding just describes a subset of the
watchdog timer registers. If so, don't do a standalone reset
driver, but instead do a watchdog driver that can also be
used for reset, and have a binding that properly describes
the watchdog hardware.

It is bad to have overlapping register ranges between logical
devices, and it's also generally wrong to describe devices that
are not actually there: The hardware contains a watchdog, not
a system-reset device, so you should not make one up because
it seems easier given the Linux driver model.

	Arnd
