From: lftan@altera.com (Ley Foon Tan)
Date: Thu, 8 Oct 2015 18:03:24 +0800
Subject: [PATCH v8 3/6] pci:host: Add Altera PCIe host controller driver
In-Reply-To: <20151008094744.GD32532@n2100.arm.linux.org.uk>
References: <1444297394-3122-1-git-send-email-lftan@altera.com>
 <1444297394-3122-4-git-send-email-lftan@altera.com>
 <20151008094744.GD32532@n2100.arm.linux.org.uk>
Message-ID: <CAFiDJ58oMa6rgQe_STCiWRpdL+P22BN1=Nin_+QnLXC9RGiSzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 8, 2015 at 5:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Thu, Oct 08, 2015 at 05:43:11PM +0800, Ley Foon Tan wrote:
> > +static int altera_pcie_cfg_write(struct pci_bus *bus, unsigned int devfn,
> > +                              int where, int size, u32 value)
> > +{
> > +     struct altera_pcie *pcie = bus->sysdata;
> > +     u32 data32;
> > +     u32 shift = 8 * (where & 3);
> > +     int ret;
> > +
> > +     if (!altera_pcie_valid_config(pcie, bus, PCI_SLOT(devfn)))
> > +             return PCIBIOS_DEVICE_NOT_FOUND;
> > +
> > +     /* write partial */
> > +     if (size != sizeof(u32)) {
> > +             ret = tlp_cfg_dword_read(pcie, bus->number, devfn,
> > +                                      where & ~DWORD_MASK, &data32);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     switch (size) {
> > +     case 1:
> > +             data32 = (data32 & ~(0xff << shift)) |
> > +                             ((value & 0xff) << shift);
> > +             break;
> > +     case 2:
> > +             data32 = (data32 & ~(0xffff << shift)) |
> > +                             ((value & 0xffff) << shift);
> > +             break;
> > +     default:
> > +             data32 = value;
>
> Can you generate proper 1, 2 and 4 byte configuration accesses?  That
> is much preferred over the above read-modify-write, as there are
> registers in PCI and PCIe that are read/write-1-to-clear.  The above
> has the effect of inadvertently clearing those RW1C bits.
No, hardware can only access 4-byte aligned address.

Regards
Ley Foon
