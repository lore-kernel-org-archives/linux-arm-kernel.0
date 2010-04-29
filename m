From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Apr 2010 10:17:29 +0100
Subject: [PATCH 10/10] mmp: append device support in jasper
In-Reply-To: <n2h771cded01004282005j709b34dfq50c591bf8dc0defa@mail.gmail.com>
References: <i2x771cded01004280523g5e3b567aled05b1fea293587a@mail.gmail.com>
	<20100428135255.GB8960@sirena.org.uk>
	<n2h771cded01004282005j709b34dfq50c591bf8dc0defa@mail.gmail.com>
Message-ID: <20100429091729.GB2738@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 28, 2010 at 11:05:13PM -0400, Haojian Zhuang wrote:

> OK. Update this patch by removing regulators in max8925. They'll be

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> contained in later patches. Whatever I think a big array is suitable
> for unused regulators. Is it right?

No, not at all.  If the regulator has no consumers then there should not
be any supplies set up from it.  The sole purpose of supplies is to
connect the consumers and regulators to each other so if the regulator
is unused there should be no supplies defined at all.  This is what I
was saying about supplies with NULL devices being very suspicious.

> +static struct regulator_consumer_supply max8649_supply[] = {
> +	REGULATOR_SUPPLY("vcc_core", NULL),
> +};
> +
> +static struct regulator_init_data max8649_init_data = {
> +	.constraints	= {
> +		.name		= "vcc_core range",

You probably just want to call this vcc_core (the name is used when
logging about the supply and provided to userspace so you want something
that would make sense in a log message).  It doesn't really matter,
though.
