From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Dec 2016 15:04:31 +0000
Subject: [RFC v2 PATCH 0/3] Fix dma_alloc_coherent() and friends for NOMMU
In-Reply-To: <1BE9400D-BACB-4C07-B6F0-1963D90A7029@esh.hu>
References: <1481636704-18948-1-git-send-email-vladimir.murzin@arm.com>
 <1BE9400D-BACB-4C07-B6F0-1963D90A7029@esh.hu>
Message-ID: <58500DFF.6010801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13/12/16 14:33, Szemz? Andr?s wrote:
> Hi,
> 
>> On 2016. Dec 13., at 14:45, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>>
>> Hi,
>>
>> It seem that addition of cache support for M-class cpus uncovered
>> latent bug in DMA usage. NOMMU memory model has been treated as being
>> always consistent; however, for R/M classes of cpu memory can be
>> covered by MPU which in turn might configure RAM as Normal
>> i.e. bufferable and cacheable. It breaks dma_alloc_coherent() and
>> friends, since data can stuck in caches now or be buffered.
>>
>> This patch set is trying to address the issue by providing region of
>> memory suitable for consistent DMA operations. It is supposed that such
>> region is marked by MPU as non-cacheable. Since we have MPU support in
>> Linux for R-class only and M-class setting MPU in bootloader, proposed
>> interface to advertise such memory is via "memdma=size at start" command
>> line option, to avoid clashing with normal memory (which usually comes
>> from dts) it'd be safer to use it together with "mem=" command line
>> option. Meanwhile, I'm open to suggestions for the better way telling
>> Linux of such memory.
>>
> 
> I have tested these patches on my ATMEL SAME70 armv7m board.
> 
> After setting the memory regions and attributes in the bootloader and providing the required 
> command line parameters, the DMA issues fixed.
> 
> I have tested an usart, sdcard, and ethernet driver with DMA enabled.
> 
> Booting Linux on physical CPU 0x0
> Linux version 4.9.0 (root at debian) (gcc version 4.8.3 20140320 (prerelease) (Sourcery CodeBench Lite 2014.05-29) ) #4 Mon Dec 12 20:27:21 CET 201
> 6
> CPU: ARMv7-M [410fc271] revision 1 (ARMv7M), cr=00000000
> CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
> OF: fdt:Machine model: SAME70-sampione board
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 15748
> Kernel command line: console=ttyS1,115200 root=/dev/mmcblk0p2 rw init=/linuxrc rootwait mem=62M memdma=2M at 0x73e00000
> 
> So you can add my Tested-by.
> 
> Thanks for the patches!

Glad to hear it works for you! Thanks for reporting and testing!

Cheers
Vladimir

> 
> Regards,
> Andras
> 
> 
> 
