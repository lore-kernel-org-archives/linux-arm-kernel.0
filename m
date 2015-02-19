From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Feb 2015 16:01:29 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <20150219094155.GA3198@finisterre.sirena.org.uk>
References: <4553005.HBquOfbqXe@wuerfel>
 <20150219094155.GA3198@finisterre.sirena.org.uk>
Message-ID: <7767301.zaEX63gvjp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 February 2015 18:41:55 Mark Brown wrote:
> On Wed, Feb 18, 2015 at 04:29:10PM +0100, Arnd Bergmann wrote:
> 
> > The adds a dependency in Kconfig to prevent it from being selected
> > if the resets are not available.
> 
> Why is this a better fix than making the reset controller API stub
> itself out?  It's probably not such a big deal here but for devices that
> could be integrated into SoCs with and without reset controllers it
> seems like we might want that.

I would prefer that too, but it's not what the reset maintainer decided
to have, citing b424080a9e0 ("reset: Add optional resets and stubs"):
    
    This patch adds device_reset_optional and (devm_)reset_control_get_optional
    variants that drivers can use to indicate they can function without control
    over the reset line. For those functions, stubs are added so the drivers can
    be compiled with CONFIG_RESET_CONTROLLER disabled.
    Also, device_reset is annotated with __must_check. Drivers ignoring the return
    value should use device_reset_optional instead.
    
    Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
    Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
    Reviewed-by: Marek Vasut <marex@denx.de>
    Acked-by: Wolfram Sang <wsa@the-dreams.de>

So the stubs are provided for all functions except device_reset() and
reset_control_get(), and drivers using the API need to either call the
stubbed-out _optional() versions of these functions or have the explicit
dependency.

	Arnd
