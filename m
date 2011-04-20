From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Wed, 20 Apr 2011 11:09:56 +0200
Subject: [PATCH v2] driver core: let dev_set_drvdata return int instead of
	void as it can fail
In-Reply-To: <20110419235812.GA4619@kroah.com>
References: <BANLkTi=MjDqawZx=+fKjaAs5SPfGQDEgVQ@mail.gmail.com>
	<1302547378-14639-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110419235812.GA4619@kroah.com>
Message-ID: <BANLkTi=q8jfEaLByZVZPHHYp_5PTK-36cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/20 Greg KH <greg@kroah.com>:
> On Mon, Apr 11, 2011 at 08:42:58PM +0200, Uwe Kleine-K?nig wrote:
>> Before commit
>>
>> ? ? ? b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)
>>
>> calling dev_set_drvdata with dev=NULL was an unchecked error. After some
>> discussion about what to return in this case removing the check (and so
>> producing a null pointer exception) seems fine.
> I'm confused by this thread, care to resend all of these in a series
> against the latest linux-next tree?

I'd argue that dev_set_drvdata() should never fail. All current
drivers depend on this, and if dev_set_drvdata() fails, user will get
an OOPS a short while after the device finishes initializing (or maybe
even before that if callbacks are involved).
Allowing dev_set_drvdata() to fail will need putting a lot of
boilerplate code into drivers for no real gain.

Please consider reverting commit
b4028437876866aba4747a655ede00f892089e14 instead of "fixing" issues it
generates.

Best Regards,
Micha? Miros?aw
