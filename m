From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 28 Dec 2015 14:15:58 +0200
Subject: bbb kexec bug: Unhandled fault external abort on non-linefetch
 (0x1028) at 0xfa1ac140
In-Reply-To: <20151228071809.GA20621@dhcp-128-65.nay.redhat.com>
References: <20151227073840.GC23608@dhcp-128-65.nay.redhat.com>
 <20151228071809.GA20621@dhcp-128-65.nay.redhat.com>
Message-ID: <568127FE.3010001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/2015 09:18 AM, Dave Young wrote:
> On 12/27/15 at 03:38pm, Dave Young wrote:
>> Here is what I get when I test kdump on Beagle bone black:
>>
>> Added a printk line at the begin of function omap_gpio_rmw:
>> printk("########## %lx, %x, %x\n", base, reg, mask);
>>
>> Any hints how to fix it? I tried call the machine_kexec_mask_interrupts
>> at runtime kernel also panics so it may not limit to kdump case.
>>
>> [   66.340168] ########## fa1ac000, 140, 1
>> [   66.344456] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa1ac140
>> [   66.352142] pgd = dd9f0000

[...]

>> [   66.727278] [<c01f2276>] (omap_set_gpio_triggering) from [<c01f2551>] (omap_gpio_mask_irq+0x29/0x34)

Usually such back-trace means that you are trying to access HW
which is disabled (powered off) already. Or this HW IP has never been enabled.

>> [   66.736457] [<c01f2551>] (omap_gpio_mask_irq) from [<c0012f35>] (machine_crash_shutdown+0xb9/0x104)
>> [   66.745551] [<c0012f35>] (machine_crash_shutdown) from [<c00803fd>] (crash_kexec+0x35/0x68)
>> [   66.753942] [<c00803fd>] (crash_kexec) from [<c0010f51>] (die+0x1b9/0x390)
>> [   66.760859] [<c0010f51>] (die) from [<c001bc23>] (__do_kernel_fault.part.0+0x4f/0x1cc)
>> [   66.768824] [<c001bc23>] (__do_kernel_fault.part.0) from [<c0412e11>] (do_page_fault+0x155/0x29c)
>> [   66.777740] [<c0412e11>] (do_page_fault) from [<c00091ff>] (do_DataAbort+0x2f/0x88)
>> [   66.785432] [<c00091ff>] (do_DataAbort) from [<c041247b>] (__dabt_svc+0x3b/0x80)
>> [   66.792858] Exception stack(0xddc39e58 to 0xddc39ea0)
>> [   66.797929] 9e40:                                                       00000063 df93647c
>> [   66.806144] 9e60: 1f26a000 00000000 00000001 00000063 00000007 c0702e3c 00000000 ddc38000
>> [   66.814359] 9e80: 00000000 7f70d614 00000030 ddc39ea8 c021e54b c021e54c 600e0033 ffffffff
>> [   66.822575] [<c041247b>] (__dabt_svc) from [<c021e54c>] (sysrq_handle_crash+0x18/0x1c)
>> [   66.830530] [<c021e54c>] (sysrq_handle_crash) from [<c021e8b5>] (__handle_sysrq+0x79/0x10c)
>> [   66.838919] [<c021e8b5>] (__handle_sysrq) from [<c021ec79>] (write_sysrq_trigger+0x45/0x50)
>> [   66.847310] [<c021ec79>] (write_sysrq_trigger) from [<c010695f>] (proc_reg_write+0x43/0x68)
>> [   66.855700] [<c010695f>] (proc_reg_write) from [<c00ca6a3>] (__vfs_write+0xf/0x8c)
>> [   66.863304] [<c00ca6a3>] (__vfs_write) from [<c00cacd7>] (vfs_write+0x5f/0x128)
>> [   66.870646] [<c00cacd7>] (vfs_write) from [<c00cb313>] (SyS_write+0x2b/0x68)
>> [   66.877729] [<c00cb313>] (SyS_write) from [<c000ddc1>] (ret_fast_syscall+0x1/0x4c)
>> [   66.885332] Code: 443c 4643 f6a9 f9a1 (6823) 0732
>> [   66.890145] ---[ end trace 5a39094ece4dc200 ]---
>> [   66.894782] Kernel panic - not syncing: Fatal exception
>> [   66.900033] ---[ end Kernel panic - not syncing: Fatal exception
>>


-- 
regards,
-grygorii
