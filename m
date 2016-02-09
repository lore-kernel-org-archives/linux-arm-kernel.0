From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Tue, 9 Feb 2016 16:52:38 +0000
Subject: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
 controllers driver to preapare for ACPI
In-Reply-To: <5968234.D2a3VCM72k@wuerfel>
References: <1454935264-6076-1-git-send-email-gabriele.paoloni@huawei.com>
 <3113837.YSNyDAf4HQ@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECAD249@lhreml503-mbs>
 <5968234.D2a3VCM72k@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ECAF48D@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 09 February 2016 16:27
> To: Gabriele Paoloni
> Cc: linux-arm-kernel at lists.infradead.org; Guohanjun (Hanjun Guo);
> Wangzhou (B); liudongdong (C); Linuxarm; qiujiang; bhelgaas at google.com;
> Lorenzo.Pieralisi at arm.com; tn at semihalf.com; linux-pci at vger.kernel.org;
> linux-kernel at vger.kernel.org; xuwei (O); linux-acpi at vger.kernel.org;
> jcm at redhat.com; zhangjukuo; Liguozhu (Kenneth)
> Subject: Re: [RFC PATCH v2 1/3] PCI: hisi: re-architect Hip05/Hip06
> controllers driver to preapare for ACPI
> 
> On Monday 08 February 2016 16:51:19 Gabriele Paoloni wrote:
> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > On Monday 08 February 2016 16:06:54 Gabriele Paoloni wrote:
> > > > > On Monday 08 February 2016 12:41:02 Gabriele Paoloni wrote:
> > > int
> > > > > size,
> > > > > > +                         u32 *val)
> > > > > > +{
> > > > > > +   u32 reg;
> > > > > > +   u32 reg_val;
> > > > > > +   void *walker = &reg_val;
> > > > > > +
> > > > > > +   walker += (where & 0x3);
> > > > > > +   reg = where & ~0x3;
> > > > > > +   reg_val = readl(reg_base + reg);
> > > > > > +
> > > > > > +   if (size == 1)
> > > > > > +           *val = *(u8 __force *) walker;
> > > > > > +   else if (size == 2)
> > > > > > +           *val = *(u16 __force *) walker;
> > > > > > +   else if (size == 4)
> > > > > > +           *val = reg_val;
> > > > > > +   else
> > > > > > +           return PCIBIOS_BAD_REGISTER_NUMBER;
> > > > > > +
> > > > > > +   return PCIBIOS_SUCCESSFUL;
> > > > > > +}
> > > > >
> > > > > Isn't this the same hack that Qualcomm are using?
> > > >
> > > > As far as I can see Qualcomm defines its own config access
> > > > mechanism only for RC config read and also it seems they're
> > > > having problems with reporting the device class...
> > > >
> > > >
> https://github.com/torvalds/linux/blob/master/drivers/pci/host/pcie-
> > > qcom.c#L474
> > > >
> > > > Our problem is that our HW can only perform 32b rd/wr accesses
> > > > So we can't use readw/readb/writew/writeb...
> > > >
> > > >
> > >
> > > Sorry, my mistake, I meant Cavium not Qualcomm.
> > > See https://lkml.org/lkml/2016/2/5/689 for the patches.
> >
> > Well, looking at it Cavium seems quite different,
> >
> > On read they need to trigger the retrieval of the
> > config space info writing to the lower 32b of a 64b register,
> > then they need to read data back on the upper 64b of the
> > same register and adjust the content to remove the garbage...
> >
> > We just use 32b accesses and adjust grab the appropriate
> > bytes depending on the read/write sizes...
> 
> Hmm, I must have misremembered that too then, let me try once more ;-)
> 
> The above appears to reimplement pci_generic_config_read32(). Can you
> just use that instead?

Nope I don't think so,

When we read the root complex config space we need to use a configuration
address space that is different from the one used to map the rest of the
hierarchy; I think this is something to do with Designware itself. It
is clear if you look at

http://lxr.free-electrons.com/source/drivers/pci/host/pcie-designware.c#L657

Here you can see that in calling "dw_pcie_wr_own_conf" Designware does not
pass "bus" and "devfn" that are actually required by pci_generic_config_read32()
to map the addr...

Many Thanks

Gab

> 
> 	Arnd
