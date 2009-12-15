From: wim@iguana.be (Wim Van Sebroeck)
Date: Tue, 15 Dec 2009 13:02:29 +0100
Subject: [PATCH V2] Driver for the watchdog timer on all Freescale IMX
	processors.
In-Reply-To: <1260786235-32629-1-git-send-email-w.sang@pengutronix.de>
References: <20091209091244.GA15126@pengutronix.de>
	<1260786235-32629-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20091215120229.GJ4291@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> Changes since my V1:
> 
> * Use NULL instead of string in clk_get
> 
> Changes since the last version from Darius:
> 
> * removed all #ifdef CONFIG_ARCH_* and handle the differences at runtime
> * simplified house-keeping of the timeout value and fixed the conversion
>   into the corresponding register value
> * removed a superfluous static platform-device
> * removed debug output and comments with (IMHO) little information
> * cleaned up #includes
> * fixed some typos & removed unnecessary tabs & added kernel coding style
> * probably something else...

Some general feedback first:
* The MX2 and MX3 series have a watchdog device that cannot be stopped once
started. Since we use /dev/watchdog to start and stop the hardware, we
normally introduce a timer to keep the watchdog alive when /dev/watchdog
is closed. This is missing in this driver.
(See drivers/watchdog/at91sam9_wdt.c as an example).
* The MX1 platform is 32 bit instead of 16 bit and can be stopped and started.
Maybe it would make sense to split this in 2 drivers (one for MX1 and one for
the others).

Kind regards,
Wim.
