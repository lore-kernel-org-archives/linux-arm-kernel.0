From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 17 Dec 2009 11:54:10 +0530
Subject: CPU consumption is going as high as 95% on ARM Cortex A8
In-Reply-To: <19F8576C6E063C45BE387C64729E73940449F43857@dbde02.ent.ti.com>
References: <19F8576C6E063C45BE387C64729E73940449F43857@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BFB58568@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Hiremath, Vaibhav
> Sent: Thursday, December 17, 2009 11:09 AM
> To: linux at arm.linux.org.uk
> Cc: linux-mm at kvack.org; linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: CPU consumption is going as high as 95% on ARM Cortex A8
> 
> Hi,
> 
> I am seeing some strange behavior while accessing buffers through User Space (mapped using mmap call)
> 
> Background :-
> ------------
> Platform - TI AM3517
> CPU - ARM Cortex A8
> 
> root at am3517-evm:~#
> root at am3517-evm:~# cat /proc/cpuinfo
> Processor       : ARMv7 Processor rev 7 (v7l)
> BogoMIPS        : 499.92
> Features        : swp half thumb fastmult vfp edsp neon vfpv3
> CPU implementer : 0x41
> CPU architecture: 7
> CPU variant     : 0x1
> CPU part        : 0xc08
> CPU revision    : 7
> Hardware        : OMAP3517/AM3517 EVM
> Revision        : 0020
> Serial          : 0000000000000000
> root at omap3517-evm:~#
> 
> 
> Issue/Usage :-
> -------------
> The V4l2-Capture driver captures the data from video decoder into buffer and the application does
> some processing on this buffer. The mmap implementation can be found at drivers/media/video/videobuf-
> dma-contig.c, function__videobuf_mmap_mapper().
> 
> Observation -
> The CPU consumption goes as high as 95% on read buffer operation, please note that write operation on
> these buffers also gives 60-70% CPU consumption. (Using memcpy/memset API's for read and write
> operation).
> 
> Some more inputs :-
> ------------------
> - If I specify PAGE_READONLY or PAGE_SHARED (actual flag is L_PTE_USER) while mapping the buffer to
> UserSpace in mmap system call, the CPU consumption goes down to expected value (20-27%).
> Then I reached till the function cpu_v7_set_pte_ext, where we are configuring level 2 translation
> table entries, which makes use of these flags.
> 
> - Below is the value of r0, r1 and r2 register (ptep, pteval, ext) in both the cases -
> 
> 
> Without PAGE_READONLY/PAGE_SHARED
> 
> ptep - cfb5de10, pte - 8d200383, ext - 800
> ptep - cfb5de14, pte - 8d201383, ext - 800

Which kernel version is this? Can you please also give values of PRRR, NMRR and SCTLR 
