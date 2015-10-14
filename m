From: s-anna@ti.com (Suman Anna)
Date: Wed, 14 Oct 2015 15:28:23 -0500
Subject: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
In-Reply-To: <5121845.p5XWunbq8r@wuerfel>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <106715675.XDtZ2nQqSM@wuerfel> <20151014161755.GB10113@atomide.com>
 <5121845.p5XWunbq8r@wuerfel>
Message-ID: <561EBAE7.60907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2015 03:12 PM, Arnd Bergmann wrote:
> On Wednesday 14 October 2015 09:17:56 Tony Lindgren wrote:
>> * Arnd Bergmann <arnd@arndb.de> [151014 02:20]:
>>> On Tuesday 13 October 2015 16:13:20 Tony Lindgren wrote:
>>>> On boards with more than 2GB of RAM booting goes wrong with things not working
>>>> and we're getting lots of l3 warnings:
>>>>
>>>> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x260/0x384()
>>>> 44000000.ocp:L3 Custom Error: MASTER MMC6 TARGET DMM1 (Idle): Data Access in User mode during Functional access
>>>> ...
>>>> [<c044e158>] (scsi_add_host_with_dma) from [<c04705c8>] (ata_scsi_add_hosts+0x5c/0x18c)
>>>> [<c04705c8>] (ata_scsi_add_hosts) from [<c046b13c>] (ata_host_register+0x150/0x2cc)
>>>> [<c046b13c>] (ata_host_register) from [<c046b38c>] (ata_host_activate+0xd4/0x124)
>>>> [<c046b38c>] (ata_host_activate) from [<c047f42c>] (ahci_host_activate+0x5c/0x194)
>>>> [<c047f42c>] (ahci_host_activate) from [<c0480854>] (ahci_platform_init_host+0x1f0/0x3f0)
>>>> [<c0480854>] (ahci_platform_init_host) from [<c047c9dc>] (ahci_probe+0x70/0x98)
>>>> [<c047c9dc>] (ahci_probe) from [<c04220cc>] (platform_drv_probe+0x54/0xb4)
>>>>
>>>> Let's fix the issue by enabling ZONE_DMA for LPAE.
>>>>
>>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>>>
>>>
>>> I suspect this is not the correct fix, even if it works around the problem.
>>>
>>> Am I right that the AHCI device can access the first 4GB of address space
>>> using 32-bit DMA, and that any RAM beyond 2GB is above that limit?
>>
>> Yes the memory above 2GB is at 0x300000000. The same problem is there at least
>> with MMC too.
>>
>>> Does the ZONE_DMA have the same size? If not, you get more bounce buffers
>>> than you want, which is bad for performance/
>>
>> Hmm good question. I guess we should set .dma_zone_size  = SZ_2G in this
>> case then as only 2GB of RAM can directly be accessed.
> 
> I think you need ".dma_zone_size  = SZ_4G", but I'm not completely sure
> whether this takes PHYS_OFFSET into account or not.
> 
>>> Another problem here is that it only works with the SCSI and net subsystems
>>> that have a hack in there to create manual bounce buffers, but other drivers
>>> that can do DMA to high addresses will not know about this.
>>
>> OK good to know.
>>
>>> The right solution would be to force the use of an IOMMU, and if that not
>>> works, add support for SWIOTLB on ARM.
>>
>> Suman might have some accelerators in mind we could use for DMA.

Only MMUs that we have on OMAP5 are the ones for the processors on the
SoC - MPU, DSP or the IPU (Dual-Cortex M4). There is one eDMA engine
within the DSP subsystem that goes through the DSP MMU, but this is
typically used by software running on DSP.

regards
Suman

>>
>> For SWIOTLB, It seems we have it for arm64 but not for arm?
> 
> Correct. A number of people have run into problems with this before, but
> it has never been added to the kernel. At some point, I tried to help
> Peter Senna Tschudin get it implemented, but I think he gave up when it
> turned out that the platform he was using to test this did not need it
> after all.
> 
> The reason we have it on ARM64 is that you are completely screwed there
> if you have no IOMMU but use a 32-bit DMA master, while on 32-bit platforms
> most of the time you don't have memory above 4GB, and if you do then most
> of the time you don't have any DMA masters other than network and scsi
> (including sata) on them, or you have an IOMMU for each one.
> 
> 	Arnd
> 
