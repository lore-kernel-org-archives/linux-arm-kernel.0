From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Mar 2014 22:06:36 +0100
Subject: [PATCH v17 3/4] ata: Add APM X-Gene SoC AHCI SATA host controller
 driver
In-Reply-To: <CAPw-ZT=1KWEowD_i=qoWwg372XdzC4p227rpNo7ov+NwOYFUDA@mail.gmail.com>
References: <1394655573-32645-1-git-send-email-lho@apm.com>
 <201403142005.52991.arnd@arndb.de>
 <CAPw-ZT=1KWEowD_i=qoWwg372XdzC4p227rpNo7ov+NwOYFUDA@mail.gmail.com>
Message-ID: <201403142206.36611.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 March 2014, Loc Ho wrote:
> Hi,
> 
> >> > gets called. Can you clarify what this register access does?
> >> > If it's just setting a index into a mux output, would it make
> >> > sense to have an optional DT property containing an integer with
> >> > the mux setting you want to set? That way you wouldn't even
> >> > have to have two compatible strings but just do
> >> >
> >> >         ret = of_property_read_u32(node, "apm,ahci-mux", &mux);
> >> >         if (!ret)
> >> >                 xgene_ahci_mux_select(ctx, mux);
> >> >
> >>
> >> Given that fact that I will break up the resource. Let's just use the
> >> resource for the MUX to handle this. For the IP that doesn't existed,
> >> I will just not list it.
> >
> > Ah, that sounds good. It also means that if the firmware has set up
> > the mux already, you don't have to touch it again. That would probably
> > be the preferred case.
> >
> > I'm undecided about the value that you write in there. That could either
> > be passed through DT as I suggested above for extra flexibility, or you
> > can keep it hardcoded if you are absolutely sure that there will never
> > need to be a case where you have to set it to something other than '1',
> 
> It is only a mux between two IP's. Writing 1 is fine. For ACPI, it can
> be missing and handled by the firmware or can be handled just like the
> DTS way.

Why can't you have it handled by the firmware in the DTS case?

I still think it's rather unlikely that we will actually see ACPI support
on your platform, btw.

I'm willing to look at the patches you need for it, but I'm not very
optimistic, in particular because of the kind of hacks you need
for random bits of hardware.

> > Is there also an IOMMU, or just the PIM? If there is no IOMMU,
> > we will actually have to use the swiotlb code here, otherwise we
> > can rely on the IOMMU to do the translation so we can pretend that
> > there is always 64-bit DMA capability.
> >
> > In theory, the PIM could be dynamically reprogrammed for each
> > DMA, as an extremely primitive IOMMU implementation, but I don't
> > know what the impact on performance would be from doing that.
> > It would also prevent you from starting multiple concurrent DMAs,
> > although I suspect that is not an important case for SPI and SDIO.
> 
> This first generation don't support IOMMU and rely on swiotlb. In any
> case, for SDIO, the solution is to reprogram the PIM and limit to SDMA
> - single buffer - for each operation.

Ok, interesting. In that case, I suppose the DMA mask is actually 64-bit.

	Arnd
