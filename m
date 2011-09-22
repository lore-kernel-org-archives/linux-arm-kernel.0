From: khilman@ti.com (Kevin Hilman)
Date: Thu, 22 Sep 2011 16:57:27 -0700
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 13 Sep 2011 18:32:33 +0530")
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <87mxdwm8pk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*

PER is still not hitting retention for me on 34xx/n900 when GPIOs have
debounce enabled.  Disabling debounce in the board file makes it work.

[...]

> - Add dbclk aliases for all GPIO modules. Without this, GPIO modules were not
>   getting the correct clock handle to enable/disable debounec clock.

This isn't right.  hwmod should already be adding aliases for the
optional clocks.

After debugging this myself a bit, here's what I think may be going on.
This may not be the only problem but here's at least one of them.

First, debounce clocks are disabled in the runtime_suspend callback.

When a GPIO is freed and it's the last one in the bank, bank->mod_usage
goes to zero.

After that, pm_runtime_put_sync() is called, which will trigger the
driver's ->runtime_suspend callback.  The ->runtime_suspend() callback
checks bank->mod_usage as well, and if zero, doesn't do anything
(notably, it doesn't disable debounce clocks.)

Kevin
