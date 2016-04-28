From: balbi@kernel.org (Felipe Balbi)
Date: Thu, 28 Apr 2016 17:27:14 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <2806018.GHhm6tEuKR@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87y47ykzmz.fsf@intel.com> <20160428141611.GK19428@n2100.arm.linux.org.uk>
 <2806018.GHhm6tEuKR@wuerfel>
Message-ID: <87vb31kdvh.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Thursday 28 April 2016 15:16:12 Russell King - ARM Linux wrote:
>> On Thu, Apr 28, 2016 at 09:37:08AM +0300, Felipe Balbi wrote:
>> > 
>> > Hi,
>> > 
>> > Arnd Bergmann <arnd@arndb.de> writes:
>> > >    pointer and pass that in platform_data. This is really easy, it's
>> > 
>> > Sorry but passing a struct device pointer in platform_data is
>> > ridiculous. Not to mention that, as I said before, we can't assume which
>> > device to pass to xhci_plat in the first place. It might be dwc->dev and
>> > it might be dwc->dev->parent.
>> 
>> +1.  Passing an unref-counted struct device through platform data is
>> totally mad, Arnd you're off your rocker if you think that's a good
>> idea.  What's more is that there's no way to properly refcount the
>> thing.
>
> It's the parent device (or NULL), there is no way it can ever go away as
> it's already refcounted through the device subsystem by the creation
> of the child device.

you're assuming that based on what we have today. We could get into a
situation where we need to use a completely unrelated device and the
problem exists again.

> I do realize that it's a hack, but the idea is to get rid of that
> as soon as possibly by fixing the way the xhci device is probe so
> we no longer need to fake a platform_device as the child here and
> can just use the device itself.

okay, let me try to be extra clear here:

We will *not* remove the extra platform_device because it actually
*does* exist and helps me hide/abstract a bunch of details and make
assumptions about order of certain events. We have already gone through
that in the past when I explained why I wrote dwc3 the way it is; if you
need a refresher, there are mailing list archives for that.

Moreover, this same problem exists for anything under drivers/mfd. It
just so happens that they're usually some i2c or spi device which don't
do DMA by themselves.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160428/a6f1334a/attachment.sig>
