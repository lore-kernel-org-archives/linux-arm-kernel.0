From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Apr 2014 09:12:50 +0200
Subject: [PATCH v7 1/6] pci: Introduce pci_register_io_range() helper
 function.
In-Reply-To: <CAErSpo6S49qNuJQB-XXEfJ1Nkz=4gZ5_hE93=gb_yGZesA1H9Q@mail.gmail.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-2-git-send-email-Liviu.Dudau@arm.com>
 <CAErSpo6S49qNuJQB-XXEfJ1Nkz=4gZ5_hE93=gb_yGZesA1H9Q@mail.gmail.com>
Message-ID: <4845032.VeNZmbvuW3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 April 2014 17:21:51 Bjorn Helgaas wrote:
> On Fri, Mar 14, 2014 at 9:34 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > Some architectures do not share x86 simple view of the PCI I/O space
> > and instead use a range of addresses that map to bus addresses. For
> > some architectures these ranges will be expressed by OF bindings
> > in a device tree file.
> >
> > Introduce a pci_register_io_range() helper function that can be used
> > by the architecture code to keep track of the I/O ranges described by the
> > PCI bindings. If the PCI_IOBASE macro is not defined that signals
> > lack of support for PCI and we return an error.
> >
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > Acked-by: Grant Likely <grant.likely@linaro.org>
> > Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> > ---
> >  drivers/of/address.c       | 9 +++++++++
> >  include/linux/of_address.h | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> > index 1a54f1f..be958ed 100644
> > --- a/drivers/of/address.c
> > +++ b/drivers/of/address.c
> > @@ -619,6 +619,15 @@ const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
> >  }
> >  EXPORT_SYMBOL(of_get_address);
> >
> > +int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> > +{
> > +#ifndef PCI_IOBASE
> > +       return -EINVAL;
> > +#else
> > +       return 0;
> > +#endif
> > +}
> 
> This isn't PCI code, so I'm fine with it in that sense, but I'm not
> sure the idea of a PCI_IOBASE #define is really what we need.  It's
> not really determined by the processor architecture, it's determined
> by the platform.  And a single address isn't enough in general,
> either, because if there are multiple host bridges, there's no reason
> the apertures that generate PCI I/O transactions need to be contiguous
> on the CPU side.
> 
> That's just a long way of saying that if we ever came up with a more
> generic way to handle I/O port spaces, PCI_IOBASE might go away.  And
> I guess part of that rework could be changing this use of it along
> with the others.

I'd rather not add a generic implementation of this at all, but
keep it all within the host resource scanning code.

If we do add a generic implementation, my preference would be
to use the version introduced for arm64, with a fallback of
returning -EINVAL if the architecture doesn't implement it.

There is no way ever that returning '0' makes sense here: Either
the architecture supports memory mapped I/O spaces and then we
should be able to find an appropriate io_offset for it, or it
doesn't support memory mapped I/O spaces and we should never
even call this function.

	Arnd
