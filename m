From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 03 Aug 2015 10:00:17 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CAKv+Gu89UGzL9=0tYjQmv9dX7KOsfobpO4zG1E8X0g4W9u5Bkg@mail.gmail.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <1524396.PS7zpagrm1@wuerfel>
 <CAKv+Gu89UGzL9=0tYjQmv9dX7KOsfobpO4zG1E8X0g4W9u5Bkg@mail.gmail.com>
Message-ID: <1950491.fy9Zn5k0xY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 August 2015 08:19:07 Ard Biesheuvel wrote:
> >> >>
> >> >> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
> >> >> PHYS_OFFSET1 = memstart_addr + 2 GB
> >> >> PHYS_OFFSET2 = memstart_addr + 32 GB
> >> >>
> >> >> and only if the ARM recommended physical memory map is detected (with
> >> >> memstart_addr @ 0x8000_0000), switch to
> >> >>
> >> >> PHYS_OFFSET = PHYS_OFFSET0 = memstart_addr
> >> >> PHYS_OFFSET1 = memstart_addr + 30 GB
> >> >> PHYS_OFFSET2 = memstart_addr + 480 GB
> >> >
> >> > I don't really like such complexity when all you need on arm64 is to
> >> > enable 48-bit VA (though it would be interesting to benchmark it).
> >
> > More importantly, hardwiring this in virt_to_phys() would mean we can
> > no longer run a kernel with this hack turned on with systems that have
> > contiguous memory or any other layout besides the one from the document.
> >
> 
> Well the hack, if enabled, would be turned on dynamically iff the
> exact layout from the recommendation is detected, and the kernel is
> loaded right at the base of DRAM.
> Note that the first layout I presented is effectively the current
> linear mapping, but with three steps.

Ok, I see. So it would work everywhere, at the price of another conditional
for each virt_to_phys, either runtime or by binary patching at boottime.

	Arnd
