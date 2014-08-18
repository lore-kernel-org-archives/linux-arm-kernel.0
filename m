From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 22:52:25 +0100
Subject: [PATCH v9 03/12] PCI: Introduce helper functions to deal with
 PCI I/O ranges.
In-Reply-To: <20140818213446.GC13147@bart.dudau.co.uk>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-4-git-send-email-Liviu.Dudau@arm.com>
 <20140818142604.GO20043@localhost>
 <20140818213446.GC13147@bart.dudau.co.uk>
Message-ID: <20140818215225.GI24600@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 10:34:46PM +0100, Liviu Dudau wrote:
> On Mon, Aug 18, 2014 at 03:26:04PM +0100, Catalin Marinas wrote:
> > On Tue, Aug 12, 2014 at 05:25:16PM +0100, Liviu Dudau wrote:
> > > Some architectures do not have a simple view of the PCI I/O space
> > > and instead use a range of CPU addresses that map to bus addresses.
> > > For some architectures these ranges will be expressed by OF bindings
> > > in a device tree file.
> > > 
> > > This patch introduces a pci_register_io_range() helper function with
> > > a generic implementation that can be used by such architectures to
> > > keep track of the I/O ranges described by the PCI bindings. If the
> > > PCI_IOBASE macro is not defined that signals lack of support for PCI
> > > and we return an error.
> > > 
> > > In order to retrieve the CPU address associated with an I/O port, a
> > > new helper function pci_pio_to_address() is introduced. This will
> > > search in the list of ranges registered with pci_register_io_range()
> > > and return the CPU address that corresponds to the given port.
> > > 
> > > Cc: Grant Likely <grant.likely@linaro.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> > > ---
> > >  drivers/of/address.c       | 95 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/of_address.h |  2 +
> > >  2 files changed, 97 insertions(+)
> > 
> > Actually, I think we moved too much code into drivers/of/. Is there
> > anything OF specific about this code to live here (apart from
> > OF_BAD_ADDR)? I think driver/pci/ more appropriate?
> 
> I have no strong preference for one place vs the other. While this does
> not use any OF specific code, it should be called only from OF enabled
> code. So the relationship is not one of depending on of_* but on being
> dependent on.

In this case it's probably ok to keep them here for the time being.

I wonder whether it would also be useful for ACPI. But I have no idea
how ACPI would fit with the ACPI patches.

-- 
Catalin
