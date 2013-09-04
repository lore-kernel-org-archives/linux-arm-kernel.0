From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Sep 2013 14:24:39 +0100
Subject: [PATCH 11/11] iio: pressure-core: st: Provide correct regulator
 support
In-Reply-To: <20130904131111.GJ18206@e106331-lin.cambridge.arm.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-12-git-send-email-lee.jones@linaro.org>
 <20130904131111.GJ18206@e106331-lin.cambridge.arm.com>
Message-ID: <20130904132439.GA10155@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 02:11:11PM +0100, Mark Rutland wrote:
> On Wed, Sep 04, 2013 at 10:31:43AM +0100, Lee Jones wrote:

> > +	/* Regulator not mandatory, but if requested we should enable it. */
> > +	pdata->regulator = regulator_get(&indio_dev->dev, "vdd");
> > +	if (!IS_ERR_OR_NULL(pdata->regulator)) {

> Can regulator_get return NULL? As far as I can see, it either returns a
> valid reulator pointer or an ERR_PTR value.

Yes, NULL is a valid regulator.

> When you say "if requested", do you mean "if described in the dt"? If
> so, the above doesn't distunguish between a regulator not being listed
> and one failing to be got (e.g. if we got EPROBE_DEFER from
> regulator_get).

> I think this would be better handled with something like Mark Brown's
> suggested regulator_get_optional [1,2].

If the regulator may genuinely be absent from the system then it should
be being requested using regulator_get_optional().  Otherwise it should
be being requested using regulator_get().  In both cases it is important 
that the driver pays attention to errors.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130904/2740eea2/attachment.sig>
