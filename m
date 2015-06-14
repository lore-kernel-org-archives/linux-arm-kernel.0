From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 20:13:46 +0100
Subject: [PATCH] ARM: debug: Remove unsupported operand from Kconfig.debug
In-Reply-To: <1434306201-21840-1-git-send-email-linux@roeck-us.net>
References: <1434306201-21840-1-git-send-email-linux@roeck-us.net>
Message-ID: <20150614191346.GI7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 14, 2015 at 11:23:21AM -0700, Guenter Roeck wrote:
> arm builds show the following warning.
> 
> arch/arm/Kconfig.debug:1576:warning: ignoring unsupported character '>'
> 
> This is due to
> 
> config DEBUG_UART_8250_WORD
> 	bool "Use 32-bit accesses for 8250 UART"
> 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
> 	depends on DEBUG_UART_8250_SHIFT >= 2
> 
> This may create the false expectation that DEBUG_UART_8250_WORD
> is enabled if DEBUG_UART_8250_SHIFT is larger than 2, so drop the '>'.

"is" ?  No, "depends" will control the visibility of this option.

You're quite right that it's expected that the option is visible if
DEBUG_UART_8250_SHIFT is greater than or equal to 2, and that's
actually exactly what we want to express here - and it's entirely
possible for someone to type in a shift greater than two, and that
would also be legal.

I guess if >= 2 doesn't work, what we need instead is:

	depends on DEBUG_UART_8250_SHIFT != 0 &&
		   DEBUG_UART_8250_SHIFT != 1

which would have the same effect.  I also guess that adding a
"range 0 31" or similar to the DEBUG_UART_8250_SHIFT option would
also be a good idea.

Patches to that effect welcome.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
