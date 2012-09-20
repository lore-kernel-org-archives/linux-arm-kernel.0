From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 20 Sep 2012 20:03:42 +0100
Subject: [PATCH] pwm: Call pwm_enable() before pwm_config()
In-Reply-To: <50366464.4070801@metafoo.de>
References: <36966374.2768747.1345741025741.JavaMail.root@advansee.com>
 <50366464.4070801@metafoo.de>
Message-ID: <20120920190342.GA13264@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 07:12:04PM +0200, Lars-Peter Clausen wrote:
> On 08/23/2012 06:57 PM, Beno??t Th??baudeau wrote:

> > exists with several other PWM drivers.

> Since this seems to be a common pattern in a number of PWM drivers it might
> make sense to simply add support for enabling/disabling a clk to the pwm core.
> Or maybe just use the runtime pm API for this. This probably makes even more
> sense and grab a reference to the pm context when the enable() is called,
> release it when disable() is called and also grab it before calling the
> device's config callback and release it afterward.

It's a problem with IPs in general, a good proportion of modern SoCs
need a clock supplying in order to interact with the registers on most
of their IPs.  runtime PM is the normal way forwards, Tegra recently
started using regmap's cache code to handle this transparently in the
driver.
