From: mnalajal@codeaurora.org (Murali Nalajala)
Date: Tue, 21 Aug 2012 19:58:06 +0530
Subject: ioremap() fail on physical address 0x0 in 3.4 kernel
Message-ID: <50339AF6.1060601@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
I am doing a below call in my driver to get the virtual address 
equivalent to physical address 0x0.

pdata->v_addr = ioremap(pdata->p_addr, PAGE_SIZE); /* pdata->p_addr=0 */

Above call returns me a valid virtual address i.e: 0xfa200000. After 
that when i try to access the address i am getting a kernel panic like 
below.

[   59.498141] Unable to handle kernel paging request at virtual address 
fa200000
[   59.498141] pgd = d4f80000
[   59.498141] [fa200000] *pgd=00000000
[   59.498141] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   59.498141] Modules linked in:
[   59.498141] CPU: 0    Tainted: G        W 
(3.4.0-g3b5f728-00009-g638207a #13)
[   59.498141] PC is at msm_pm_config_rst_vector_before_pc+0x8/0x30
[   59.498141] LR is at msm_pm_boot_config_before_pc+0x18/0x20
[   59.498141] pc : [<c0078f84>]    lr : [<c007903c>]    psr: a0000093
[   59.498141] sp : c0837ef0  ip : cfe00000  fp : 0000000d
[   59.498141] r10: da7efc17  r9 : 225c4278  r8 : 00000006
[   59.498141] r7 : 0003c000  r6 : c085c824  r5 : 00000001  r4 : fa101000
[   59.498141] r3 : fa200000  r2 : c095080c  r1 : 002250fc  r0 : 00000000
[   59.498141] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment kernel
[   59.498141] Control: 10c5387d  Table: 25180059  DAC: 00000015
[   59.498141] [<c0078f84>] 
(msm_pm_config_rst_vector_before_pc+0x8/0x30) from [<c007903c>] 
(msm_pm_boot_config_before_pc+0x18/0x20)
[   59.498141] [<c007903c>] (msm_pm_boot_config_before_pc+0x18/0x20) 
from [<c007a55c>] (msm_pm_power_collapse+0x410/0xb04)
[   59.498141] [<c007a55c>] (msm_pm_power_collapse+0x410/0xb04) from 
[<c007b17c>] (arch_idle+0x294/0x3e0)
[   59.498141] [<c007b17c>] (arch_idle+0x294/0x3e0) from [<c000eed8>] 
(default_idle+0x18/0x2c)
[   59.498141] [<c000eed8>] (default_idle+0x18/0x2c) from [<c000f254>] 
(cpu_idle+0x90/0xe4)
[   59.498141] [<c000f254>] (cpu_idle+0x90/0xe4) from [<c057231c>] 
(rest_init+0x88/0xa0)
[   59.498141] [<c057231c>] (rest_init+0x88/0xa0) from [<c07ff890>] 
(start_kernel+0x3a8/0x40c)
[   59.498141] Code: c0704256 e12fff1e e59f2020 e5923000 (e5930000)


I am observing the crash on 3.4 but not on the 3.0 kernel.I check the 
"arch/arch/mm/ioremap.c" code changes between 3.0 and 3.4. I came across 
few changes that are uploaded by "Nicolas Pitre" and few fixes made by 
RMK and Pawel Moll.

I don't see a crash after i commented out the below code in 
__arm_ioremap_pfn_caller().


read_lock()
---
loop
---
read_unlock()


Here i am pasting a few extra logs that i have added into "ioremap.c" & 
"mmu.c" file.

[    0.000000] memory pool 3 (start 2a300000 size 3800000) initialized
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] vm_area_add_early: called with addr=fa100000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa101000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa000000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa102000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa103000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa010000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa900000 size=0xd00000
[    0.000000] vm_area_add_early: called with addr=fa400000 size=0x100000
[    0.000000] vm_area_add_early: called with addr=fa701000 size=0x1000
[    0.000000] vm_area_add_early: called with addr=fa300000 size=0x100000
[    0.000000] vm_area_add_early: called with addr=fa200000 size=0x100000
[    0.000000] vm_area_add_early: called with addr=fa500000 size=0x100000
[    0.000000] vm_area_add_early: called with addr=fa800000 size=0x100000
...
...
...
[ 0.161784] ioremap: pfn=0x0 phys=0x0 offset=0x0 size=0x1000
[ 0.161813] ioremap: area da0fbdc0: phys_addr=0xc0100000 pfn=0xc0100 
size=0x1000
[ 0.161838] ioremap: area da0fbe20: phys_addr=0xa8600000 pfn=0xa8600 
size=0x1000
[ 0.161861] ioremap: area da0fbd80: phys_addr=0xc0000000 pfn=0xc0000 
size=0x1000
[ 0.161886] ioremap: area da0fbda0: phys_addr=0xc0100000 pfn=0xc0100 
size=0x1000
[ 0.161909] ioremap: area da0fbde0: phys_addr=0xa9200000 pfn=0xa9200 
size=0x1000
[ 0.161933] ioremap: area da0fbe00: phys_addr=0xa9300000 pfn=0xa9300 
size=0x1000
[ 0.161956] ioremap: area da0fbd40: phys_addr=0x0 pfn=0x0 size=0x100000
[ 0.161979] ioremap: found: addr fa200000 => 0xfa200000 => 0xfa200000
[ 0.161999] *** reset_vector = 0xfa200000


Can someone know me what is wrong in ioremap call?
Why i am not seeing a crash after i commented out the loop above?


Thanks,
Murali N

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
