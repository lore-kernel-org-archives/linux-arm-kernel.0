From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 25 Feb 2016 22:24:34 +0100
Subject: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for HiSilicon
 SoCs Host Controllers
In-Reply-To: <20160225195912.GA4818@localhost>
References: <20160209182429.GD4348@leverpostej>
 <20160225120750.GA32016@red-moon> <20160225195912.GA4818@localhost>
Message-ID: <8105311.kD8XXIcipM@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, February 25, 2016 01:59:12 PM Bjorn Helgaas wrote:
> On Thu, Feb 25, 2016 at 12:07:50PM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Feb 25, 2016 at 03:01:19AM +0000, Gabriele Paoloni wrote:
> > 
> > [...]
> > 
> > > > I think the relevant spec is the PCI Firmware Spec, r3.0, sec 4.1.2.
> > > > Note 2 in that section says the address range of an MMCFG region
> > > > must be reserved by declaring a motherboard resource, i.e., included
> > > > in the _CRS of a PNP0C02 or similar device.
> > > 
> > > I had a look a this. So yes the specs says that we should use the 
> > > PNP0C02 device if MCFG is not supported. 
> > 
> > AFAIK, PNP0C02 is a resource reservation mechanism, the spec says that
> > MCFG regions must be reserved using PNP0C02, even though its
> > current usage on x86 is a bit unfathomable to me, in particular
> > in relation to MCFG resources retrieved for hotpluggable bridges (ie
> > through _CBA, which I think consider the MCFG region as reserved
> > by default, regardless of PNP0c02):
> > 
> > see pci_mmcfg_check_reserved() arch/x86/pci/mmconfig-shared.c
> 
> I don't know how _CBA-related resources would be reserved.  I haven't
> personally worked with any host bridges that supply _CBA, so I don't
> know whether or how they handled it.
> 
> I think the spec intent was that the Consumer/Producer bit (Extended
> Address Space Descriptor, General Flags Bit[0], see ACPI spec sec
> 6.4.3.5.4) would be used.  Resources such as ECAM areas would be
> marked "Consumer", meaning the bridge consumed that space itself, and
> windows passed down to the PCI bus would be marked "Producer".
> 
> But BIOSes didn't use that bit consistently, so we couldn't rely on
> it.  I verified experimentally that Windows didn't pay attention to
> that bit either, at least for DWord descriptors:
> https://bugzilla.kernel.org/show_bug.cgi?id=15701
> 
> It's conceivable that we could still use that bit in Extended Address
> Space descriptors, or maybe some hack like pay attention if the bridge
> has _CBA, or some such.

Last time I asked the firmware vendor people in the ASWG about that,
the answer was that the Consumer/Producer bit was useless as they had
never paid any attention to it in general.

It may be good to update the spec to say something along these lines, actually.

Thanks,
Rafael
