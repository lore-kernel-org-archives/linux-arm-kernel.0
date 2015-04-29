From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Apr 2015 17:54:02 +0200
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
References: <D1665A4F.19E17%suravee.suthikulpanit@amd.com>
Message-ID: <2817500.sgztgK2NzB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 April 2015 14:57:10 Suthikulpanit, Suravee wrote:
> Otherwise, it would seem inconsistent with what states in the ACPI spec:
>  
>   CCA objects are only relevant for devices that can access CPU-visible
> memory,
>   such as devices that are DMA capable. On ARM based systems, the _CCA
> object 
>   must be supplied all such devices. On Intel platforms, if the _CCA
> object is 
>   not supplied, the OSPM will assume the devices are hardware cache
> coherent.
> 
> From the statement above, I interpreted as if it is not present, it would
> be non-coherent.
> 

My guess is that this section was included for Windows Phone, which runs
on embedded SoCs that usually have noncoherent DMA in a particular way.

Linux however only uses ACPI for servers, so that case does not happen.

I guess it would be reasonable to add a run-time warning here if you
try to do DMA on a device that does not have CCA set, and you should
probably set the DMA mask to 0 in that case as well.

Note that there are lots of ways in which you could have noncoherent DMA:
the default on ARM32 is that it requires uncached access or explicit
cache flushes, but it's also possible to have an SMP system where a device
is only coherent with some of the CPUs and requires explicit synchronization
(not flushes) otherwise. In a multi-level cache hierarchy, there could be
all sorts of combinations of flushes and syncs you would need to do.

With DT, we handle this using SoC-specific overrides for platforms that
are noncoherent in funny ways, see
http://lxr.free-electrons.com/source/arch/arm/mach-mvebu/coherency.c?v=3.18#L263
for instance. If we just disallow DMA to devices that are marked with _CCA=0
in ACPI, we can avoid this case, or discuss it by the time someone has hardware
that wants it, and then make a more informed decision about it.

	Arnd
