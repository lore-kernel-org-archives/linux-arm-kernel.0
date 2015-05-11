From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 May 2015 18:10:46 +0100
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <2927907.rePQ55aASC@wuerfel>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
 <2817500.sgztgK2NzB@wuerfel>
 <20150501110644.GF27755@e104818-lin.cambridge.arm.com>
 <2927907.rePQ55aASC@wuerfel>
Message-ID: <20150511171045.GJ18655@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 04:08:53PM +0200, Arnd Bergmann wrote:
> On Friday 01 May 2015 12:06:44 Catalin Marinas wrote:
> > > If we just disallow DMA to devices that are marked with _CCA=0
> > > in ACPI, we can avoid this case, or discuss it by the time someone has hardware
> > > that wants it, and then make a more informed decision about it.
> > 
> > I don't think we should disallow DMA to devices with _CCA == 0 (only to
> > those that don't have a _CCA property at all) as long as _CCA == 0 has
> > clear semantics like only architected cache maintenance required (and
> > that's what the ARMv8 ARM requires from compliant system caches).
> 
> Even if we exclude all cases in which the behavior may be unexpected,
> there is still the other point I raised initially:
> 
>              what would that be good for?
> 
> Can you think of a case where a server system has a reason to use
> a device in noncoherent mode? I think it's more likely to be a case
> where a device got misconfigured accidentally by the firmware, and
> we're better off warning about that in the kernel than trying to prepare
> for an unknown hardware that might use an obscure feature of the spec.

Maybe some of the people involved in arm64 servers can give a better
answer, I'm not familiar with their hardware (plans).

I would expect most DMA-capable devices to be cache coherent. However,
for (system) performance reasons, some of them could be configured as
non-coherent. An example, though unlikely on servers, is a display
device continuously accessing a framebuffer. You may not want to
overload the coherent interconnect.

-- 
Catalin
