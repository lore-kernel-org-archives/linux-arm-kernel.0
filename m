From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 09:14:22 +0200
Subject: [PATCH v5] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <000e01cfd94a$c5c60510$51520f30$@samsung.com>
References: <1411360807-7750-1-git-send-email-pankaj.dubey@samsung.com>
 <5439567.VeRyeUcp1j@wuerfel> <000e01cfd94a$c5c60510$51520f30$@samsung.com>
Message-ID: <1842088.hi6OA3SDTq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014 10:58:33 Pankaj Dubey wrote:
> On Thursday, September 25, 2014 6:12 PM, Arnd Bergmann wrote,
> > I don't remember noticing the of_find_device_by_node or
> > platform_device_alloc in
> > earlier versions of this patch, but that could just be me failing to read
> > it right.
> > 
> Yes, till v2 of this patch set we do not used this and while calling
> regmap_init_mmio, I used
> NULL pointer while creating regmap handle.  But as you may be remember Dong
> Aisheng reported crash
> on latest Linus tree after applying this patch, and it caused because of
> some recent changes in
> regmap which has already landed in main tree, which makes passing of dev
> pointer compulsory
> while calling regmap_init_mmio. Please check following commits in current
> tree
> 
> 1) d647c19 regmap: add DT endianness binding support.
> 2) ba1b53f regmap: Fix DT endianess parsing logic.
> 3) 45e1a27 regmap: of_regmap_get_endian() cleanup
> 
> and following patch [1] for changing syscon binding from Xiubo Li
> 
> [1] [PATCH] mfd: syscon: binding: Add syscon endianness support
> https://lkml.org/lkml/2014/9/18/67
> 
> So we discussed [2] and decided to use either actual device if it's
> populated and available for use or
> create either actual device or dummy device for using it during
> regmap_init_mmio calls.
> 
> [2]: https://lkml.org/lkml/2014/9/18/35
> 
> So what I understood from these changes from Xiubo Li, they wanted to pass
> endianness of regmap
> handle to be passed from DT. 
> 
> So I am not sure if we can really make regmap code work without a device
> pointer. 

Why can't we just have both a dev pointer and an explicit of_node pointer
that can be used in the absence of the device?

I think it's dangerous to have a platform device that is allocated but
not registered as you do in your driver at the moment. We can't register
it for early callers either, and if we found a way to do so, we'd end
up with multiple platform devices that contain the same of_node, which
would then cause other problems, such as binding both devices to the
same driver.

> > I think this should get removed: it would be much better to ensure that
> the regmap
> > code can work without a device pointer, which I thought it did. We should
> probably
> > also skip the creation of the debugfs directory in that case.
> > 
> > > Also if it was just a matter of creating platform_device at early
> > > stage then early initialization of syscon could have been solved till
> > > now.
> 
> As far as debugfs of regmap is concerned it can be solved as I replied to
> Heiko in this thread [3]
> if we are using device pointer while creating regmap handle. 
> If we are not using device pointer while creating regmap handle it won't
> cause any problem and 
> there won't be any debugfs entry.
> 
> [3]: https://lkml.org/lkml/2014/9/26/20

Right, this works, although my earlier thoughts were that we would
just never have a device for a syscon any more. We could have a
different representation for syscon regmaps in debugfs though, one
that is separate from the devices and that is based on the just the
of_node pointer. syscon is special enough that I think the regmap
infrastructure should be aware of what is a syscon regmap as opposed
to one from a device.

	Arnd
