From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Jan 2011 13:27:45 +0000
Subject: [PATCH] ux500: add a few AB8500 regulator consumers
In-Reply-To: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
References: <1295269491-12107-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110117132745.GA21113@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 17, 2011 at 02:04:51PM +0100, Linus Walleij wrote:

> +static struct regulator_consumer_supply ab8500_vaux1_consumers[] = {
> +	{
> +		.dev = NULL,
> +		.supply = "v-display",
> +	},

Your use of NULL where there's no device in this patch is somewhat
erratic.

> +	{
> +		.dev_name = "bh1780",
> +		.supply = "v-als",
> +	},

This supply name (like many of the others) looks a bit odd, it's an
unusual idiom.  Indeed, looking at (first hit in Google):

	www.chipcatalog.com/ROHM/BH1780GLI.htm

it appears that the chip has one supply called VCC (subscripted CC) -
I'd therefore expect the driver to be asking for the supply using that
name.  It looks like most of the supplies here have been given the names
for the rail on the board rather than the name the chip expects for
them.

> +static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
> +	{
> +		.supply = "v-tvout",
> +	},
> +	{
> +		.supply = "ab8500-gpadc",
> +	},

I suspect there's a device for the ab8500?
