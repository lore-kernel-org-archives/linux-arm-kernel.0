From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Sep 2009 02:13:05 +0800
Subject: [PATCH 2/3] regulator: add 88PM8607 PMIC driver
In-Reply-To: <f17812d70909221112laf6c182nf0c26253066310e9@mail.gmail.com>
References: <771cded00909040313k311fba93o98071eb0ecd3fdca@mail.gmail.com>
	<771cded00909070210o7d19b0a2mda910bd2d6150e7@mail.gmail.com>
	<20090907094432.GA23318@sirena.org.uk> <1252320709.5876.25.camel@odin>
	<20090909091857.GB4292@sortiz.org>
	<771cded00909100411m3c27711ej54d7b9823463b9d5@mail.gmail.com>
	<20090910173203.GD25960@rakim.wolfsonmicro.main>
	<20090911125937.GA6034@sortiz.org>
	<771cded00909170550o3fe757f5q51e8076fc0af7b45@mail.gmail.com>
	<f17812d70909221112laf6c182nf0c26253066310e9@mail.gmail.com>
Message-ID: <f17812d70909221113iae6fa0ew8fa19a658cf90a1e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forwarded to correct mailing list manually, pity.

On Wed, Sep 23, 2009 at 2:12 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Sep 17, 2009 at 8:50 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Fri, Sep 11, 2009 at 8:59 AM, Samuel Ortiz <sameo@linux.intel.com> wrote:
>>>
>>> On Thu, Sep 10, 2009 at 06:32:03PM +0100, Mark Brown wrote:
>>> > On Thu, Sep 10, 2009 at 07:11:58PM +0800, Haojian Zhuang wrote:
>>> >
>>> > > +static int __remove_subdev(struct device *dev, void *unused)
>>> > > +{
>>> > > + ? platform_device_unregister(to_platform_device(dev));
>>> > > + ? return 0;
>>> > > +}
>>> > > +
>>> > > +static int pm8607_remove_subdevs(struct pm8607_chip *chip)
>>> > > +{
>>> > > + ? return device_for_each_child(chip->dev, NULL, __remove_subdev);
>>> > > +}
>>> >
>>> > You could just use the MFD core functions for this - they implement the
>>> > same actions.
>>> >
>>> > > +static int __devinit pm8607_add_subdevs(struct pm8607_chip *chip,
>>> > > + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pm8607_platform_data
>>> > > *pdata)
>>> > > +{
>>> > > + ? struct pm8607_subdev_info *subdev;
>>> > > + ? struct platform_device *pdev;
>>> > > + ? int i, ret = 0;
>>> > > +
>>> > > + ? for (i = 0; i < pdata->num_subdevs; i++) {
>>> > > + ? ? ? ? ? subdev = &pdata->subdevs[i];
>>> >
>>> > I think I queried last time you posted the driver why it's doing this -
>>> > I'd have expected that the driver would know most if not all of the
>>> > subdevices which are present without needing the information to be
>>> > supplied by platform data.
>>> I agree. Please give us an explanation here. All other MFD drivers are
>>> declaring their subdevices from the driver code, not by fetching data from
>>> the
>>> platform specific declarations.
>>>
>>> Cheers,
>>> Samuel.
>>>
>>
>> Hi Mark & Samuel,
>>
>> Yes, MFD core driver can take this job also. But it addes more
>> initialization code in custom MFD driver.
>>
>> I formated the patch again for MFD core driver. Let's review that we have to
>> assign all kinds of resources and subdevs in the MFD driver. Even I'm not
>> planning use it in the platform driver.
>>
>> If I'm using my original patch, I needn't do such the initialization. I just
>> assign the ones in platform driver and initlize the subdevs in custom MFD
>> driver.
>>
>> From this view, I think that custom MFD driver is complex and not very
>> clear.
>>
>
> I'd agree with this.
>
> I don't see any point that the use of the MFD API is mandatory here. This
> is really a simple and straightforward task to add all the sub-devices
> (as platform_device - though I don't like this platform_device at all), and
> maybe in a specific manner the composite device needs, we don't really
> need to involve all those mfd_cell, and resource copying stuffs.
>
> - eric
>
