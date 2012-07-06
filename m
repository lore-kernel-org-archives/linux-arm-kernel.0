From: monstr@monstr.eu (Michal Simek)
Date: Fri, 06 Jul 2012 11:08:29 +0200
Subject: arm cortex a9, smp bootup requirement
Message-ID: <4FF6AB0D.8010105@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

can someone correct me about smp boot requirement for Linux?

We are fixing ARM zynq smp bootup code and would like to be sure
that out bootup code is correct.

I have found some requirements from standalone boot up code
which is invalidate dcache, icache, branch predictor array
and flush TLB.

I have found in secondary_start_kernel that TLB are flushed
by local_flush_tlb_all function.
But haven't found any cache invalidation calling.

I think it is required and we could be added to platform_secondary_init.

Or is it requirement which has to be fulfil by bootloader before
secondary_startup is called?

We have the option to reset specific cpu in the system and cpu
starts from 0x0 with cache off and in non-virtual mode
where we place simple jump trampoline to the secondary_startup
function. If cache invalidation is required by Linux we can extend this code
to do it.

Jumping trampoline is:
0x0: ldr r0, [8]
0x4: mov pc, r0
0x8: jump address

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
