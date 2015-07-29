From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jul 2015 22:57:59 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <1732431.N2KqRfCTTW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 July 2015 20:49:57 Stuart Yoder wrote:
> > 
> > Perhaps you should mention, for the benefit of those not following the
> > other thread, that the platform in question has 2 chunks of memory,
> > i.e., 2 GB and 14 GB, with a 508 GB hole in between.
> 
> Yes, our physical memory layout for RAM looks like this:
> 2 GB at 0x8000_0000
> 510 GB at 0x80_8000_0000

Could we just ignore the first 2GB on this machine?

> > To be honest, I think this is poorly designed, and I am not sure we
> > should cater for such configurations in the defconfig.
> 
> Agree, if this is a one-off weird platform then we shouldn't.
> 
> But, the 'Principles of ARM Memory Maps' doc proposes this:
> 2 GB at 0x8000_0000
> 30 GB at 0x8_8000_0000
> 480 GB at 0x88_0000_0000
> 
> ...i.e. if you have > 32 GB then your RAM regions are split into 3 
> chunks.  The aarch64 kernel will support > than 32GB right?  A
> basic server will have that much or more.
> 
> How will we deal with systems with > 32GB of memory that follow that
> map?

Burn them? ;-)

Hopefully the hardware on most machines should allow the memory map to
be configured so it can appear somewhere in a single chunk by modifying
the boot loader.

> When do we expect the default page size for the aarch64 kernel to be
> changed to 64KB?

No.

> Any workload that puts pressure on the TLBs will benefit
> from this.

I would assume that the only benchmarks that benefit from 64kb
pages are the ones that benefit more from using transparent hugepages.
64kb pages is crazy as a default because it sucks for almost every
workload you'd see in practice.

	Arnd
