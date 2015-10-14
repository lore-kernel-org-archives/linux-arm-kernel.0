From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 11:42:27 +0200
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1624367C@lhreml503-mbs>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <7409042.iUdOP6FlU8@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1624367C@lhreml503-mbs>
Message-ID: <5959363.QRL4hSioHL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 09:31:48 Gabriele Paoloni wrote:
> > 
> > > To me it sounds more appropriate to adopt subsys_initcall() for all
> > the
> > > PCI Host Bridge controllers rather than having them as loadable
> > modules...
> > >
> > > What is your view?
> > 
> > subsys_initcall() sounds odd because it's a driver rather than a
> > subsystem,
> > but I realize that most of the other levels don't fit any better.
> 
> Yes well I was seeing for example the vgaarb 
> http://lxr.free-electrons.com/source/drivers/gpu/vga/vgaarb.c#L1357
> 
> That in the init is calling pci_get_subsys()
> 
> So I was wondering that the PCI devices may not be registered unless
> we also init the PCI host bridge through subsys_initcall()...

I think this should work as is: the code first looks for devices
that are already there and then registers a notifier for devices
that show up later. This is meant to work for both devices that
are hotplugged at a later point as well as PCI buses that are
already there but not yet probed.

> But then maybe is the vgaarb to be buggy...

Possible. It may well be that the code is only tested on x86,
which always probes its PCI very early.

> > As I said, it's not really a choice we have to make in the source code,
> > we can use subsys_initcall together with module_exit(), or we can
> > create a helper macro that is similar to module_platform_driver()
> > specifically for PCI that uses a particular initcall level.
> 
> Ok got it. But I guess this needs to be thought and applied to all
> the PCI host bridge controllers...
> 
> So maybe for this driver I can use module_platform_driver_probe()
> and then we can see...

Sounds good. Let's focus on getting the driver merged first and
then follow up with a patch to get this right for all PCI hosts.

	Arnd
