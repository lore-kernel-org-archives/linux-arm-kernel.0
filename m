From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Tue, 20 Feb 2018 16:18:35 -0500
Subject: [PATCH 06/11] ACPI / APEI: Make the fixmap_idx per-ghes to allow
 multiple in_nmi() users
In-Reply-To: <20180215185606.26736-7-james.morse@arm.com>
References: <20180215185606.26736-1-james.morse@arm.com>
 <20180215185606.26736-7-james.morse@arm.com>
Message-ID: <879ab426-c6a9-b881-e3d5-a605cfad5f97@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey James,


On 2/15/2018 1:56 PM, James Morse wrote:
> Arm64 has multiple NMI-like notifications, but GHES only has one
> in_nmi() path. The interactions between these multiple NMI-like
> notifications is, unclear.
>
> Split this single path up by moving the fixmap idx and lock into
> the struct ghes. Each notification's init function can consider
> which other notifications it masks and can share a fixmap_idx with.
> This lets us merge the two ghes_ioremap_pfn_* flavours.
>
> Two lock pointers are provided, but only one will be used by
> ghes_copy_tofrom_phys(), depending on in_nmi(). This means any
> notification that might arrive as an NMI must always be wrapped in
> nmi_enter()/nmi_exit().
>
> The double-underscore version of fix_to_virt() is used because
> the index to be mapped can't be tested against the end of the
> enum at compile time.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

> @@ -303,13 +278,11 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
>   
>   	while (len > 0) {
>   		offset = paddr - (paddr & PAGE_MASK);
> -		if (in_nmi) {
> -			raw_spin_lock(&ghes_ioremap_lock_nmi);
> -			vaddr = ghes_ioremap_pfn_nmi(paddr >> PAGE_SHIFT);
> -		} else {
> -			spin_lock_irqsave(&ghes_ioremap_lock_irq, flags);
> -			vaddr = ghes_ioremap_pfn_irq(paddr >> PAGE_SHIFT);
> -		}
> +		if (in_nmi)
> +			raw_spin_lock(ghes->nmi_fixmap_lock);
> +		else
> +			spin_lock_irqsave(ghes->fixmap_lock, flags);
This locking is resulting in a NULL pointer dereference for me during boot time. 
I removed the ghes_proc() call
from ghes_probe() and then when triggering errors and going through ghes_proc() 
the NULL pointer dereference
no longer happens. That makes me think that this is dependent on something that 
is not setup before
ghes_probe() is happening. Any ideas?

[?? 10.747323] Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
[?? 10.755121] Mem abort info:
[?? 10.757898]?? ESR = 0x96000005
[?? 10.760937]?? Exception class = DABT (current EL), IL = 32 bits
[?? 10.766839]?? SET = 0, FnV = 0
[?? 10.769877]?? EA = 0, S1PTW = 0
[?? 10.773002] Data abort info:
[?? 10.775867]?? ISV = 0, ISS = 0x00000005
[?? 10.779686]?? CM = 0, WnR = 0
[?? 10.782638] [0000000000000000] user address but active_mm is swapper
[?? 10.788976] Internal error: Oops: 96000005 [#1] SMP
[?? 10.793839] CPU: 8 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc2 #37
[?? 10.800173] Hardware name: Qualcomm Qualcomm Centriq(TM) 2400 Development 
Platform
[?? 10.813975] pstate: 60400085 (nZCv daIf +PAN -UAO)
[?? 10.818756] pc : _raw_spin_lock_irqsave+0x24/0x60
[?? 10.823441] lr : ghes_copy_tofrom_phys+0x170/0x178
[?? 10.828211] sp : ffff8017c6b03aa0
[?? 10.831509] x29: ffff8017c6b03aa0 x28: 0000000000010000
[?? 10.836804] x27: ffff000009a14cb8 x26: 0000000000000001
[?? 10.842099] x25: 0000000000000000 x24: 0000000000001000
[?? 10.847395] x23: ffff8017cab91000 x22: ffff80178be70c80
[?? 10.852690] x21: 0000000000811000 x20: 0000000000000014
[?? 10.857985] x19: 0000000000000000 x18: ffffffffffffffff
[?? 10.863280] x17: 0000000000000005 x16: 0000000000000000
[?? 10.868575] x15: ffff000009a85b08 x14: ffff8017cab8f91c
[?? 10.873870] x13: ffff8017cab8f18a x12: 0000000000000030
[?? 10.879165] x11: 0101010101010101 x10: ffff8017effb19d8
[?? 10.884461] x9 : 0000000000000000 x8 : ffff80178be33800
[?? 10.889756] x7 : 0000000000000040 x6 : 0000000000000040
[?? 10.895051] x5 : 0000000000810008 x4 : 0000000000000001
[?? 10.900346] x3 : 0000000000000014 x2 : 0000000000811000
[?? 10.905641] x1 : ffff8017cab91000 x0 : 0000000000000000
[?? 10.910937] Process swapper/0 (pid: 1, stack limit = 0x00000000ab1500d0)
[?? 10.917621] Call trace:
[?? 10.920052]? _raw_spin_lock_irqsave+0x24/0x60
[?? 10.924392]? ghes_copy_tofrom_phys+0x170/0x178
[?? 10.928819]? ghes_read_estatus+0xa4/0x188
[?? 10.932813]? ghes_proc+0x3c/0x190
[?? 10.936111]? ghes_probe+0x294/0x4c8
[?? 10.939585]? platform_drv_probe+0x60/0xc8
[?? 10.943576]? driver_probe_device+0x22c/0x310
[?? 10.947829]? __driver_attach+0xbc/0xc0
[?? 10.951564]? bus_for_each_dev+0x78/0xe0
[?? 10.955381]? driver_attach+0x30/0x40
[?? 10.958941]? bus_add_driver+0x110/0x228
[?? 10.962760]? driver_register+0x68/0x100
[?? 10.966579]? __platform_driver_register+0x54/0x60
[?? 10.971269]? ghes_init+0xbc/0x158
[?? 10.974566]? do_one_initcall+0xa8/0x14c
[?? 10.978385]? kernel_init_freeable+0x190/0x230
[?? 10.982725]? kernel_init+0x18/0x110
[?? 10.986199]? ret_from_fork+0x10/0x1c
[?? 10.989757] Code: d503201f d53b4220 d50342df f9800271 (885ffe61)
[?? 10.995856] ---[ end trace 6546810a8d401c9a ]---
[?? 11.000463] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
