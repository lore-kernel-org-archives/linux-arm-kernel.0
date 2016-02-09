From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Feb 2016 17:27:05 +0100
Subject: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD249@lhreml503-mbs>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3113837.YSNyDAf4HQ@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD249@lhreml503-mbs>
Message-ID: <5968234.D2a3VCM72k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 February 2016 16:51:19 Gabriele Paoloni wrote:
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > On Monday 08 February 2016 16:06:54 Gabriele Paoloni wrote:
> > > > On Monday 08 February 2016 12:41:02 Gabriele Paoloni wrote:
> > int
> > > > size,
> > > > > +                         u32 *val)
> > > > > +{
> > > > > +   u32 reg;
> > > > > +   u32 reg_val;
> > > > > +   void *walker = &reg_val;
> > > > > +
> > > > > +   walker += (where & 0x3);
> > > > > +   reg = where & ~0x3;
> > > > > +   reg_val = readl(reg_base + reg);
> > > > > +
> > > > > +   if (size == 1)
> > > > > +           *val = *(u8 __force *) walker;
> > > > > +   else if (size == 2)
> > > > > +           *val = *(u16 __force *) walker;
> > > > > +   else if (size == 4)
> > > > > +           *val = reg_val;
> > > > > +   else
> > > > > +           return PCIBIOS_BAD_REGISTER_NUMBER;
> > > > > +
> > > > > +   return PCIBIOS_SUCCESSFUL;
> > > > > +}
> > > >
> > > > Isn't this the same hack that Qualcomm are using?
> > >
> > > As far as I can see Qualcomm defines its own config access
> > > mechanism only for RC config read and also it seems they're
> > > having problems with reporting the device class...
> > >
> > > https://github.com/torvalds/linux/blob/master/drivers/pci/host/pcie-
> > qcom.c#L474
> > >
> > > Our problem is that our HW can only perform 32b rd/wr accesses
> > > So we can't use readw/readb/writew/writeb...
> > >
> > >
> > 
> > Sorry, my mistake, I meant Cavium not Qualcomm.
> > See https://lkml.org/lkml/2016/2/5/689 for the patches.
> 
> Well, looking at it Cavium seems quite different, 
> 
> On read they need to trigger the retrieval of the
> config space info writing to the lower 32b of a 64b register,
> then they need to read data back on the upper 64b of the
> same register and adjust the content to remove the garbage...
> 
> We just use 32b accesses and adjust grab the appropriate
> bytes depending on the read/write sizes...

Hmm, I must have misremembered that too then, let me try once more ;-)

The above appears to reimplement pci_generic_config_read32(). Can you
just use that instead?

	Arnd
