From: will.deacon@arm.com (Will Deacon)
Date: Sun, 22 Feb 2015 13:09:42 +0000
Subject: [PATCH] iommu/io-pgtable-arm: Add built time dependency
In-Reply-To: <20150220204642.04b1f0d8@endymion.delvare>
References: <20150220194445.4225d56b@endymion.delvare>
 <20150220191943.GB1767@arm.com>
 <20150220204642.04b1f0d8@endymion.delvare>
Message-ID: <20150222130942.GB9591@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 20, 2015 at 07:46:42PM +0000, Jean Delvare wrote:
> On Fri, 20 Feb 2015 19:19:43 +0000, Will Deacon wrote:
> > On Fri, Feb 20, 2015 at 06:44:45PM +0000, Jean Delvare wrote:
> > > If io-pgtable-arm is an ARM-specific driver then configuration option
> > > IOMMU_IO_PGTABLE_LPAE should not be presented to the user by default
> > > for non-ARM kernels.
> > > 
> > > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > ---
> > >  drivers/iommu/Kconfig |    1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > --- linux-3.20-rc0.orig/drivers/iommu/Kconfig	2015-02-20 17:24:46.838955014 +0100
> > > +++ linux-3.20-rc0/drivers/iommu/Kconfig	2015-02-20 19:38:45.804582668 +0100
> > > @@ -23,6 +23,7 @@ config IOMMU_IO_PGTABLE
> > >  config IOMMU_IO_PGTABLE_LPAE
> > >  	bool "ARMv7/v8 Long Descriptor Format"
> > >  	select IOMMU_IO_PGTABLE
> > > +	depends on ARM || COMPILE_TEST
> > >  	help
> > >  	  Enable support for the ARM long descriptor pagetable format.
> > >  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> > 
> > So this code doesn't actually *depend* on any arch code at all. In fact,
> > having it built and booted on x86 revealed a couple of bugs that I've
> > since fixed. I'd rather let this run everywhere, but if people insist on
> > the false dependency, so be it but we should add ARM64 to the mix too.
> 
> Oh, I'm not insisting on anything ;-) If the code is useful on other
> architectures then just ignore this patch. But if the only point of
> using it on other architectures is to reveal bugs which would not have
> triggered otherwise, then that's what COMPILE_TEST is there for.

Sure, COMPILE_TEST should definitely be there if we add a dependency, but
actually the issues raised so far were by *running* the code (there are
some boot-time self-tests).

> From the option description and help text, it really looks
> ARM-specific, so if it is not, the help text at least should be
> improved.

It's ARM-specific in that the users of the page table code are IOMMUs
typically present in ARM SoCs. However, there's no reason why you couldn't
stick one of these IOMMUs in another SoC in the same way that you can use
an Intel NIC on a PowerPC box.

Will
