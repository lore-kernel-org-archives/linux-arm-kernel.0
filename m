From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 9 Jun 2014 13:43:56 +0000
Subject: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
In-Reply-To: <5395B379.2010706@samsung.com>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
 <5388C0F1.90503@gmail.com> <5388CB1B.3090802@metafoo.de>
 <20140608231823.GB10112@trinity.fluff.org> <53959A93.7080308@metafoo.de>
 <5395B379.2010706@samsung.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17259A1F@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Of Andrzej Hajda
...
> > You can't error out on module unload, although that's not really relevant
> > here. gpiochip_remove() is typically called when the device that registered
> > the GPIO chip is unbound. And despite some remove() callbacks having a
> > return type of int you can not abort the removal of a device.
> 
> It is a design flaw in many subsystems having providers and consumers,
> not only GPIO. The same situation is with clock providers, regulators,
> phys, drm_panels, ..., at least it was such last time I have tested it.
> 
> The problem is that many frameworks assumes that lifetime of provider is
> always bigger than lifetime of its consumers, and this is wrong
> assumption - usually it is not possible to prevent unbinding driver from
> device, so if the device is a provider there is no way to inform
> consumers about his removal.
> 
> Some solution for such problems is to use some kind of availability
> callbacks for requesting resources (gpios, clocks, regulators,...)
> instead of simple 'getters' (clk_get, gpiod_get). Callbacks should
> guarantee that the resource is always valid between callback reporting
> its availability and callback reporting its removal. Such approach seems
> to be complicated at the first sight but it should allow to make the
> code safe and as a bonus it will allow to avoid deferred probing.
> Btw I have send already RFC for such framework [1].

Callbacks for delete are generally a locking nightmare.
A two-way handshake is also usually needed to avoid problems
with concurrent disconnect requests.

	David
