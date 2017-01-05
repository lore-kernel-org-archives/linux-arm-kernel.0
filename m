From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 5 Jan 2017 17:46:51 +0100
Subject: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
In-Reply-To: <cf4590d1-5381-f1da-7271-e6e7fee0c479@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
 <CAGb2v67S==AG=jZA=mO-bB4u1F2TOwhmBXg385W1xhUa3RAFbA@mail.gmail.com>
 <9acfe5e0-dc56-bd63-02b4-7bf34d49d62c@free-electrons.com>
 <CAGb2v66n46KQAzQBUrDwx7sYADkRm3_XyCHf9imN+FiDkHfP1w@mail.gmail.com>
 <cf4590d1-5381-f1da-7271-e6e7fee0c479@free-electrons.com>
Message-ID: <20170105164651.tk5e3rhdthtpn4lc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 10:50:33AM +0100, Quentin Schulz wrote:
> >>>> +static int axp20x_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +       struct axp20x_adc_iio *info;
> >>>> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >>>> +
> >>>> +       info = iio_priv(indio_dev);
> >>>
> >>> Nit: you could just reverse the 2 declarations above and join this
> >>> line after struct axp20x_adc_iio *info;
> >>>
> >>>> +       regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> >>>> +       regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> >>>
> >>> The existing VBUS power supply driver enables the VBUS ADC bits itself,
> >>> and does not check them later on. This means if one were to remove this
> >>> axp20x-adc module, the voltage/current readings in the VBUS power supply
> >>> would be invalid. Some sort of workaround would be needed here in this
> >>> driver of the VBUS driver.
> >>>
> >>
> >> That would be one reason to migrate the VBUS driver to use the IIO
> >> channels, wouldn't it?
> > 
> > It is, preferably without changing the device tree.
> > 
> 
> Yes, of course.

Note that you can have something like a test for the iio channel
property in the VBUS driver, and keep the old behaviour in the case
where we wouldn't have it.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170105/1230184d/attachment.sig>
