From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Apr 2015 11:41:02 +0100
Subject: [Linaro-acpi] [PATCH 2/2] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <6513459.YvvHTY3yyJ@wuerfel>
References: <1430315049-4663-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <2968069.n1L1S3Mp2q@wuerfel> <554152C6.7020600@amd.com>
 <6513459.YvvHTY3yyJ@wuerfel>
Message-ID: <20150430104101.GD32373@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Apr 30, 2015 at 09:23:59AM +0100, Arnd Bergmann wrote:
> On Wednesday 29 April 2015 16:53:10 Suravee Suthikulpanit wrote:
> > As for the case where _CCA=0, I think the ACPI driver should essentially 
> > communicate the information as HW is non-coherent as described in the 
> > spec, and should be calling arch_setup_dma_ops(dev, false). It is true 
> > that this in probably less-likely for the ARM64 server platforms. 
> > However, I would think that the ACPI driver should not be making such 
> > assumption.
> 
> Can you add a description to the ACPI spec then to describe in detail what
> "non-coherent" is supposed to mean, and which action the OS is supposed to
> take when accessing data from device or CPU?

You may be interested in the IORT ACPI companion spec here:

  http://infocenter.arm.com/help/topic/com.arm.doc.den0049a/DEN0049A_IO_Remapping_Table.pdf

On CCA, it says:

  `This value must match the value returned by the _CCA object defined in
   the DSDT for the device represented by this node. The attribute can take
   the following values:

   - 0x1: The device is fully coherent. No cache maintenance[1] is required for
     memory shared with the device which is mapped on CPUs as
     Inner Write-Back (IWB), Outer Write-back (OWB), and Inner
     shareable (ISH). In addition, during system initialization at cold
     boot, or after wakeup from low-power state, if the cache
     coherency requires an SMMU override or some specific device
     configuration, the platform firmware has to ensure that this has
     been done. Therefore the semantics represented by a value of
     0x1 are always correct at the time of hand-off from firmware to
     OS.

   - 0x0: The device is not coherent. Therefore:
     * Cache maintenance is required for memory shared with the
       device that is mapped on CPUs as IWB-OWB-ISH.
     * No cache maintenance is required for memory shared with the
       device that is mapped on the CPU as device or Non-cacheable.

   All other values are reserved.

[1] Note: Caching operations described in this document apply to the CPU
    caches and any other caches in the system where device memory accesses
    can hit.'

This aside, the documented introduces some useful, related concepts such
as CPM (coherent path to memory) and DACS (device attributes are cacheable
and inner shareable) for describing different IO subsystems. It also has
mechanisms to descibe ID repainting from PCI->SMMU->ITS.

Will
