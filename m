From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 May 2011 17:59:02 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTimhOCL7O1ERqUKkH_4sgq5xNYJZRg@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105081647.22091.arnd@arndb.de>
	<BANLkTimhOCL7O1ERqUKkH_4sgq5xNYJZRg@mail.gmail.com>
Message-ID: <201105081759.03032.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 08 May 2011 16:59:55 Rafa? Mi?ecki wrote:
> 2011/5/8 Arnd Bergmann <arnd@arndb.de>:
> >> >> diff --git a/drivers/bcma/TODO b/drivers/bcma/TODO
> >> >> new file mode 100644
> >> >> index 0000000..45eadc9
> >> >> --- /dev/null
> >> >> +++ b/drivers/bcma/TODO
> >> >> @@ -0,0 +1,3 @@
> >> >> +- Interrupts
> >> >> +- Defines for PCI core driver
> >> >> +- Convert bcma_bus->cores into linked list
> >> >
> >> > The last item doesn't make sense to me. Since you are using the regular
> >> > driver model, you can simply iterate over all child devices of any
> >> > dev.
> >>
> >> It's about optimization. Right now bcma_bus->cores is static array, we
> >> probably never will use all entries.
> >
> > Oh, I see. You should probably have neither of them. Instead allocate
> > the devices dynamically as you find them and do a device_register,
> > which will add the device into linked list.
> 
> As I said, and wrote: TODO.

Well, I think getting this part right is essential before the
patch can get merged.

> > Maybe you didn't understand what I said: This should be
> >
> > struct bcma_device {
> >     struct bcma_bus *bus;
> >     struct bcma_device_id id;
> >     struct device dev;
> >     u8 core_index;
> >
> >     u32 addr;
> >     u32 wrap;
> >
> >     void *drvdata;
> > };
> >
> > Here, bcma_device is the device, no need to follow pointers
> > around. It's how all bus_types work, you should just do the same.
> 
> We can not use static "struct device", see Greg's comments in:
> [RFC][PATCH V3] axi: add AXI bus driver
> (not to mention we would have unused "struct device" in ChipCommon's
> and PCI's "struct bcma_device").

Please reread what Greg explained, it's actually the same as what
I said here: Don't make the device static (you already don't),
don't put the device structure as a member in the bus structure
(as discussed above). Make the device a member of bcma_device,
so you get proper reference counting for it, in the way that
Greg explained.

	Arnd
