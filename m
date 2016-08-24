From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Aug 2016 17:51:06 +0200
Subject: [PATCH 01/10] reset: ath79: add driver Kconfig option
In-Reply-To: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
References: <1472045342-7434-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20643424.8eBLZWavEG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 24, 2016 3:28:53 PM CEST Philipp Zabel wrote:
>  if RESET_CONTROLLER
>  
> +config RESET_ATH79
> +       bool "AR71xx Reset Driver" if COMPILE_TEST
> +       default ATH79
> +       help
> +         This enables the ATH79 reset controller driver that supports the
> +         AR71xx SoC reset controller.
> +
> 

Nice series!

Just note that there is one possible problem with COMPILE_TEST
when the platforms are enabled, as you can then disable a driver
that is normally there, and that can in turn cause problems in
rare cases, e.g. when the driver has a global function that is
called from platform code. I don't know if any of the drivers
do that, but if they do, you'd have to use

config RESET_ATH79
       bool "AR71xx Reset Driver" if COMPILE_TEST && !ATH79
       default ATH79

to ensure that it's impossible to disable the driver on platforms
that require it.

	Arnd
