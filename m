From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 20 Apr 2011 19:59:30 +0200
Subject: [PATCH v2] driver core: let dev_set_drvdata return int instead of
	void as it can fail
In-Reply-To: <20110420161513.GA25396@suse.de>
References: <BANLkTi=MjDqawZx=+fKjaAs5SPfGQDEgVQ@mail.gmail.com>
	<1302547378-14639-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110419235812.GA4619@kroah.com>
	<BANLkTi=q8jfEaLByZVZPHHYp_5PTK-36cw@mail.gmail.com>
	<20110420161513.GA25396@suse.de>
Message-ID: <BANLkTi=CTQ4mYE1QXZjxQ0RdkkoVV-jzQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Greg KH <gregkh@suse.de>:
> On Wed, Apr 20, 2011 at 11:09:56AM +0200, Micha? Miros?aw wrote:
>> 2011/4/20 Greg KH <greg@kroah.com>:
>> > On Mon, Apr 11, 2011 at 08:42:58PM +0200, Uwe Kleine-K?nig wrote:
>> >> Before commit
>> >>
>> >> ? ? ? b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)
>> >>
>> >> calling dev_set_drvdata with dev=NULL was an unchecked error. After some
>> >> discussion about what to return in this case removing the check (and so
>> >> producing a null pointer exception) seems fine.
>> > I'm confused by this thread, care to resend all of these in a series
>> > against the latest linux-next tree?
>>
>> I'd argue that dev_set_drvdata() should never fail. All current
>> drivers depend on this, and if dev_set_drvdata() fails, user will get
>> an OOPS a short while after the device finishes initializing (or maybe
>> even before that if callbacks are involved).
>> Allowing dev_set_drvdata() to fail will need putting a lot of
>> boilerplate code into drivers for no real gain.
>>
>> Please consider reverting commit
>> b4028437876866aba4747a655ede00f892089e14 instead of "fixing" issues it
>> generates.
>
> That patch was from 2009, surely if there were real issues with that
> change, it would have shown up in the past 2 years, right?
>
> And no, I don't want to revert that, we need that for future work in
> this area.
>
> I have no problem migrating the error code for that function on down,
> very few drivers call this function directly, it should be wrapped by
> bus-specific functions instead, right? ?They can handle the error
> handling on their own and not force the individual drivers to handle it
> if needed.

> Have you ever seen this function fail?

When the allocation in device_private_init() fails, dev_set_drvdata()
leaves driver_data pointer not set.
But it looks like dev_set_drvdata() should not be called before
device_register(), so this check and allocation call there is
redundant.

So maybe the function should just look like this:

void dev_set_drvdata(struct device *dev, void *data)
{
  /* dev == NULL is a BUG; dev->p is allocated at device_register() time */
  BUG_ON(!dev->p);
  dev->p->driver_data = data;
}

Passing dev == NULL to dev_get_drvdata() is also a BUG, so:

void *dev_get_drvdata(const struct device *dev)
{
  return dev->p->driver_data;
}

Best Regards,
Micha? Miros?aw
