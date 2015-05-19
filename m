From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 15:50:07 +0100
Subject: [PATCH v8 09/16] clockevents/drivers: Add STM32 Timer driver
In-Reply-To: <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <555B098A.8030202@linaro.org>
 <CALszF6AJ3Zf598wYeUx=iNWHHKT24xUyfagB=+4GocwZ-Fd-0g@mail.gmail.com>
 <6177628.0ZDPLeVyah@wuerfel>
 <CALszF6BZKD-CPTZ6Hc85wv2Z3Y7JmUv-cMkBtbk2Ga6WeeWU=A@mail.gmail.com>
 <555B3F80.8070605@linaro.org>
 <CALszF6A-De6dvcRNoa9ruL+y6Wt_rc7bi-O-VxHWkFF9NSt5_g@mail.gmail.com>
Message-ID: <20150519145006.GH2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 04:41:58PM +0200, Maxime Coquelin wrote:
> 2015-05-19 15:49 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> >
> >
> > It is not exactly as the initial patch.
> >
> > I think Arnd is proposing:
> >
> > config CLKSRC_STM32
> >         bool "Clocksource for STM32 SoCs" if COMPILE_TEST
> >         select CLKSRC_MMIO
> >
> 
> Isn't "depends on OF" missing for COMPILE_TEST case?

config CLKSRC_STM32
	bool "Clocksource for STM32 SoCs" if COMPILE_TEST
	depends on OF
	select CLKSRC_MMIO

This permits CLKSRC_STM32 to be selected by STM32 (provided OF is enabled,
it's always going to be for that case, right?) while allowing the option
to be visible when both OF!=n and COMPILE_TEST!=n.

Remember,

	bool "string" if <condition-affects-visibility-of-string>
	depends on <condition-affects-config-symbol-availability>

The former merely hides the option from the user _if_ the condition fails.
The latter _disables_ the option completely (except if you try and select
it, at which point you end up with a Kconfig warning about that.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
