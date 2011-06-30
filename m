From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 30 Jun 2011 09:05:02 -0700
Subject: [PATCH v3 1/6] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <201106301122.50800.anarsoul@gmail.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
	<1309420175-10301-2-git-send-email-myungjoo.ham@samsung.com>
	<201106301122.50800.anarsoul@gmail.com>
Message-ID: <20110630160501.GG3249@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 11:22:50AM +0300, Vasily Khoruzhick wrote:
> On Thursday 30 June 2011 10:49:30 MyungJoo Ham wrote:

> > +	adc->vdd = regulator_get(dev, "vdd");
> > +	if (IS_ERR(adc->vdd)) {
> > +		dev_err(dev, "operating without regulator \"vdd\" .\n");
> > +		ret = PTR_ERR(adc->vdd);
> > +		goto err_alloc;
> > +	}
> > +

> NACK. Make it optional, otherwise it breaks s3c24xx.

No, the above code is how the regulator API should be used.  The API
will stub itself out if not in use so unless the s3c24xx platforms are
using regulators and there's a couple of options in the regulator API
for handling partially defined hookups of regulators on the board.

If there isn't a separate supply for the regulators on S3C24xx devices
then I guess the best option is to provide that supply as a dummy
regulator in the s3c24xx core code.
