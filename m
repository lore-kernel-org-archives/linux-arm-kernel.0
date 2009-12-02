From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Dec 2009 20:40:26 +0000
Subject: [PATCH] leds: Add LED class driver for regulator driven LEDs.
In-Reply-To: <20091202212521.500f7a46.ospite@studenti.unina.it>
References: <1259775625-25973-1-git-send-email-ospite@studenti.unina.it>
	<20091202180658.GA12292@rakim.wolfsonmicro.main>
	<20091202212521.500f7a46.ospite@studenti.unina.it>
Message-ID: <20091202204026.GA18311@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2009 at 09:25:21PM +0100, Antonio Ospite wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > There's no need to do this since the regulator API matches consumers
> > based on struct device as well as name so you can have as many LEDs as
> > you like all using the same supply name mapping to different regulators.

> I need some more explanation here, I am currently using the driver with
> this code:

> +/* VVIB: Vibrator on A780, A1200, A910, E6, E2 */
> +static struct regulator_consumer_supply pcap_regulator_VVIB_consumers
> [] = {
> +	{ .dev_name = "leds-regulator", .supply = "vibrator", },

So you're instantiating the device with .id set to -1 (as your code
below shows), meaning there's only one leds-regulator in the system and
there's no need to number them.  If you had more than one of them then
you'd number them and then have something like:

	{ .dev_name = "leds-regulator.0", supply = "vled" },
	{ .dev_name = "leds-regulator.1", supply = "vled" },

when setting up the supplies.

> If I set the .supply value fixed, how can I assign different
> regulators to different leds? Should I use the address to the platform
> device (a780_vibrator in this case) for .dev when defining the
> regulator in the first place?

There is no need to use the .dev field, that is kept to avoid build
breakage transitioning to dev_name.
