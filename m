From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 08 Dec 2010 15:26:16 +0100
Subject: [PATCHv3] support PMIC mc13892
In-Reply-To: <20101208100138.GB16418@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Wed, 8 Dec 2010 10:01:38 +0000")
References: <1291778460-22819-1-git-send-email-yong.shen@freescale.com>
	<1291778460-22819-2-git-send-email-yong.shen@freescale.com>
	<20101208091226.GD18244@pengutronix.de>
	<20101208100138.GB16418@rakim.wolfsonmicro.main>
Message-ID: <87r5dsl4s7.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Dec 08, 2010 at 10:12:26AM +0100, Uwe Kleine-K?nig wrote:
>
> Please cut unneded context - it makes it much easier to find the new
> text in your replies!
>
>> > +	if (ret)
>> > +		goto err_alloc;
>
>> err_alloc seems wrong.  The goto is taken when reading the revision
>> register fails, not on a failed allocation.
>
> His code is following the style of naming the exit points after what
> needs to be unwound rather than after the place jumped from which is
> common enough?
>
>> > +#define MC13892_PWGT1SPI	21
>> > +#define MC13892_PWGT2SPI	22
>> > +#define MC13892_VCOINCELL	23
>
>> I thought you wanted to put these somewhere below drivers/regulator/.
>
> Please.

If we move this header into drivers/regulator, how are we supposed to
declared regulators in the machine file ?
The regulator code does:
                priv->regulators[i] = regulator_register(
                                &mc13892_regulators[init_data->id].desc,
                                &pdev->dev, init_data->init_data, priv);

so, I'm declaring like this in the machine file:
static struct mc13xxx_regulator_init_data mx51_efikamx_regulators[] = {
        { .id = MC13892_SW1,            .init_data =  &sw1_init },
        { .id = MC13892_SW2,            .init_data =  &sw2_init },

I'm stupid enough to think that .id should match in the machine file and
in the regulator driver. Did I miss something ?

Arnaud
