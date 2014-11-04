From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 4 Nov 2014 18:01:44 +0100
Subject: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
In-Reply-To: <3036013.4SXEGIT6Kk@vostro.rjw.lan>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <20141104090521.GA13219@dtor-glaptop>
 <CAPDyKFrMMnOwOHuVcpxBWNARKUsVyq66yuH+=LcS3K7bBiUTVA@mail.gmail.com>
 <3036013.4SXEGIT6Kk@vostro.rjw.lan>
Message-ID: <CAPDyKFr7fqwb77Xhnwf7ACFX7skrY2O+_-aB1T_yfShDA1jASA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>
>> Devices that are created while "discoverable buses" are being probed
>> can't be attached to a PM domain before the probing is done, because
>> those simply doesn't exist.
>
> Honestly, I'm not sure what you're talking about.
>
> Devices on a "discoverable* bus (say PCI) are added when the *controller* is
> probed, not when *they* are probed.

Okay, so maybe "discoverable buses" isn't the proper term.

>
> You very much need to have a struct device registered to be able to call
> really_probe() for it.

Yes. But my point is that the struct device may be created dynamically
at some point in time.

This is how mmc/sd/sdio cards are handled. We don't have the
information about the card and thus not the struct device of it, until
we have detected it. Maybe we could at that point try to add the
device to its PM domain?

>
>> Now, I haven't yet seen a demand for such a cases, but it seems wrong
>> to not consider them. The current solution cover these.
>
> Oh dear.  Please rethink this.

Currently, dev_pm_domain_attach() is being invoked at the point when a
SDIO card has been found. From sdio_add_func(). How would that be
solved?

Kind regards
Uffe
