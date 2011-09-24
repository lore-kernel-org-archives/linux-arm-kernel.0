From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Sat, 24 Sep 2011 09:26:41 +0530
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <87mxdwm8pk.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
Message-ID: <CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> After debugging this myself a bit, here's what I think may be going on.
> This may not be the only problem but here's at least one of them.
>
> First, debounce clocks are disabled in the runtime_suspend callback.
>
> When a GPIO is freed and it's the last one in the bank, bank->mod_usage
> goes to zero.
>
> After that, pm_runtime_put_sync() is called, which will trigger the
> driver's ->runtime_suspend callback. ?The ->runtime_suspend() callback
> checks bank->mod_usage as well, and if zero, doesn't do anything
> (notably, it doesn't disable debounce clocks.)
I need some clarification in reproducing/testing the fix on OMAP3430SDP.
The first thing I am trying to verify is the code flow of suspend.

1) With no debounce clock enabled, when I enable UART timeouts, I
automatically see
system going to retention. That is I don't have to type echo mem >
/sys/power/state
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout

2) I am do not see the print in omap_gpio_suspend/resume(), but I see
the print in
*_prepare_for_idle()/*_resume_after_idle().

Folks testing on Tablet2 platform said there is dedicated button to
suspend/resume.
Is there something equivalent?
--
Tarun
