From: jmkrzyszt@gmail.com (Janusz Krzysztofik)
Date: Mon, 21 May 2018 22:21:46 +0200
Subject: [alsa-devel] [PATCH 5/6] mtd: rawnand: ams-delta: use GPIO lookup
 table
In-Reply-To: <20180520200822.GA119427@dtor-ws>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180520192705.GA12883@lenoch> <20180520200822.GA119427@dtor-ws>
Message-ID: <19579964.NkVAqtTb47@z50>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, May 20, 2018 10:08:22 PM CEST Dmitry Torokhov wrote:
> On Sun, May 20, 2018 at 09:27:05PM +0200, Ladislav Michl wrote:
> > On Sat, May 19, 2018 at 11:55:51PM +0200, Janusz Krzysztofik wrote:
> > > On Saturday, May 19, 2018 8:00:38 PM CEST Andy Shevchenko wrote:
> > > > On Sat, May 19, 2018 at 2:15 AM, Janusz Krzysztofik
> > > > <jmkrzyszt@gmail.com>
> > > 
> > > wrote:
> > > > > On Friday, May 18, 2018 11:21:14 PM CEST Andy Shevchenko wrote:
> > > > >> On Sat, May 19, 2018 at 12:09 AM, Janusz Krzysztofik
> > > > >> 
> > > > >> <jmkrzyszt@gmail.com> wrote:
> > > > >> > +       gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> > > > >> > GPIOD_IN);
> > > > >> > +       if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> > > > >> 
> > > > >> So, is it optional or not at the end?
> > > > >> If it is, why do we check for NULL?
> > > > > 
> > > > > As far as I can understand, nand_chip->dev_ready() callback is
> > > > > optional.
> > > > > That's why I decided to use the _optional variant of
> > > > > devm_gpiod_get(). In
> > > > > case of ams-delta, the dev_ready() callback depends on availability
> > > > > of
> > > > > the 'rdy' GPIO pin. As a consequence, I'm checking for both NULL and
> > > > > ERR
> > > > > in order to decide if dev_ready() will be supported.
> > > > > 
> > > > > I can pretty well replace it with the standard form and check for
> > > > > ERR only
> > > > > if the purpose of the _optional form is different.
> > > > 
> > > > NULL check in practice discards the _optional part of gpiod_get(). So,
> > > > either you use non-optional variant and decide how to handle an
> > > > errors, or user _optional w/o NULL check.
> > > 
> > > OK, I'm going to use something like the below while submitting v2:
> > > 
> > > -	gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
> > > -	if (!IS_ERR_OR_NULL(gpiod_rdy)) {
> > > -		this->dev_ready = ams_delta_nand_ready;
> > > -	} else {
> > > -		this->dev_ready = NULL;
> > > -		pr_notice("Couldn't request gpio for Delta NAND ready.\n");
> > > +	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy",
> > > +						  GPIOD_IN);
> > > +	if (IS_ERR(priv->gpiod_rdy)) {
> > > +		err = PTR_ERR(priv->gpiod_nwp);
> > 
> > ??? --------------------------------^^^^^^^^^
> > 
> > > +		dev_warn(&pdev->dev, "RDY GPIO request failed (%d)\n", err);
> > > +		goto err_gpiod;
> > 
> > Driver will just use worst case delay instead of RDY signal, so this
> > is perhaps too strict. I will work with degraded performance.
> 
> If RDY signal is not available then the board should not define it.
> Degrading performance and having users wondering because RDY is
> sometimes not available is not great. Especially if we get -EPROBE_DEFER
> here.

Hi,

I'm a bit lost after your comments.

As far as I can read the code of gpiod_get_optional and underlying functions, 
if a board doesn't define the "rdy" pin in a respective lookup table, the 
function returns NULL and the device gets a chance to work in degraded mode.

NULL may also happen if the driver probes the device before the lookup table 
is added. In that case other non-optional pin requests fail with -ENOENT, the 
probe is deferred and the device gets a chance to probe successfully in 
late_init if the table is added but fails if not.

If the pin is defined but GPIO device providing that pin is not available 
(-ENODEV), the probe is initially deferred and may succeed in late_init if the 
GPIO device appears but fails otherwise. 

Isn't that behavior acceptable, close enough to the expected even if not 
strictly because of that -EPROBE_DEFER?

Thanks,
Janusz
