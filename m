From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 21 May 2010 11:29:40 +0530
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> Sent: Thursday, May 20, 2010 8:00 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 0/4] Patches for -next
> 
> Hi,
> 
> I would like to get these patches in the linux-next tree for this
> release cycle and aim to submit them for upstream 2.6.36-rc1 (next
> merging window).
> 
> Please let me know if you have any objections.
> 
> Thanks.
> 
> 
> Catalin Marinas (4):
>       ARM: Remove the domain switching on ARMv6k/v7 CPUs
>       ARM: Use lazy cache flushing on ARMv7 SMP systems
>       ARM: Assume new page cache pages have dirty D-cache
>       ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP
> 
> 
I just gave quick try with these patches on OMAP4 yesterday.
"ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP" 
patch is creating regression when loading the module.

Didn't get time to debug it but though if reporting it.

******************************************************************************
# insmod test_module.ko
Unable to handle kernel paging request at virtual address bf005da8
pgd = dfe20000
[bf005da8] *pgd=9fede011, *pte=9fedf4df, *ppte=9fedf45f
Internal error: Oops: 8000000f [#1] PREEMPT SMP
last sysfs file:
Modules linked in: g_zero(+)
CPU: 1    Not tainted  (2.6.34-00074-g8e3b656 #1)
PC is at init+0x0/0x1c [g_zero]
LR is at do_one_initcall+0x64/0x1bc
pc : [<bf005da8>]    lr : [<c002a51c>]    psr: 60000013
sp : dfe9ff50  ip : c0356060  fp : dfe9ff7c
r10: 00000000  r9 : dfe9e000  r8 : c002b2e8
r7 : 00000000  r6 : bf005da8  r5 : bf002304  r4 : 00000000
r3 : 00000000  r2 : dfe9e000  r1 : 00000000  r0 : bf005da8
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 10c53c7d  Table: 9fe2004a  DAC: 00000015
Process insmod (pid: 585, stack limit = 0xdfe9e2f8)
Stack: (0xdfe9ff50 to 0xdfea0000)
ff40:                                     40212008 c002b2e8 dfe9ff7c
dfe9ff68
ff60: 00000000 bf002304 00092008 40212008 dfe9ffa4 dfe9ff80 c007a72c
c002a4c4
ff80: 00000003 40212000 0008f6b0 00000002 00024c72 00000080 00000000
dfe9ffa8
ffa0: c002b140 c007a67c 0008f6b0 00000002 40212008 00024c72 00092008
00000140
ffc0: 0008f6b0 00000002 00024c72 00000080 0008f6b0 bef73f2b 0008f8a8
00000038
ffe0: bef73c60 bef73c50 00013ee4 401a7740 60000010 40212008 ffffffff
00000000
Backtrace:
[<c002a4b8>] (do_one_initcall+0x0/0x1bc) from [<c007a72c>]
(sys_init_module+0xbc/0x1ec)
 r7:40212008 r6:00092008 r5:bf002304 r4:00000000
[<c007a670>] (sys_init_module+0x0/0x1ec) from [<c002b140>]
(ret_fast_syscall+0x0/0x30)
 r7:00000080 r6:00024c72 r5:00000002 r4:0008f6b0
Code: e89da800 bf002428 bf00205c bf001f47 (e1a0c00d)
---[ end trace 11affbcdd9483af2 ]---
Segmentation fault
******************************************************************************
