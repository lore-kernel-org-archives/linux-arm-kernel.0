From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Jul 2014 09:19:58 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140714183624.GV6800@sirena.org.uk>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel> <20140714183624.GV6800@sirena.org.uk>
Message-ID: <4657735.1VKsbQGuH6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 July 2014 19:36:24 Mark Brown wrote:
> On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
> > On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
> 
> > > Yes. But now that you say it the gpiod_direction_output() call is missing 
> > > from this patch.
> 
> > I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/board.txt
> > and as Linus Walleij explained to me the other day, the lookup is supposed
> > to replace devm_gpio_request_one(), which in turn replaced both the
> > gpio_request and the gpio_direction_output(). Do I need to put the
> > gpiod_direction_output() back or is there another interface for that when
> > registering the board gpios?
> 
> Indeed.  If you *do* need an explicit _output() then that sounds to me
> like we either need a gpiod_get_one() or an extension to the table,
> looking at the code it seems like this is indeed the case.  We can set
> if the GPIO is active high/low, or open source/drain but there's no flag
> for the initial state.

(adding Alexandre and the gpio list)

GPIO people: any guidance on how a board file should set a gpio to
output/default-high in a GPIO_LOOKUP() table to replace a
devm_gpio_request_one() call in a device driver with devm_gpiod_get()?
Do we need to add an interface extension to do this, e.g. passing
GPIOF_OUT_INIT_HIGH as the flags rather than GPIO_ACTIVE_HIGH?

	Arnd
