From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Nov 2018 17:37:37 +0000
Subject: WARN_ON after gic_reserve_range
In-Reply-To: <2665ddbd-5912-12b9-f5bd-6ccaec0e6e2d@huawei.com>
References: <20181120162305.GA2088@hc>
 <2665ddbd-5912-12b9-f5bd-6ccaec0e6e2d@huawei.com>
Message-ID: <61079d3d-6bb6-cd00-fbfa-d13c19706e0f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2018 17:30, John Garry wrote:
> On 20/11/2018 16:23, Jan Glauber wrote:
>> Hi Marc,
>>
>> with 4.20-rc3 I see two WARN_ON's firing on a ThunderX2 system that come from
>> commit 3fb68faee867 (irqchip/gic-v3-its: Register LPI tables with EFI config table).
>>
>> Global efi_memreserve_root is NULL as it will only be set when early initcalls are
>> running, but from the backtrace the WARN_ON's are running even earlier (init_IRQ).
>>
>> Am I the only one seeing this?
>>
> 
> I see it also:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
> [    0.000000] Linux version 4.20.0-rc3 
> (johnpgarry at johnpgarry-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
> [linaro-7.3-2018.05-rc1 revision 
> 38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
> #971 SMP PREEMPT Tue Nov 20 17:15:03 GMT 2018
> [    0.000000] efi: Getting EFI parameters from FDT:
> [    0.000000] efi: EFI v2.60 by EDK II
> [    0.000000] efi:  SMBIOS=0x3f050000  SMBIOS 3.0=0x39b00000 
> ACPI=0x39bd0000  ACPI 2.0=
> 
> ...
> 
> 
> [    0.000000] ITS at 0x00000408c6000000: allocated 65536 Virtual CPUs 
> @1fb9d80000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] ITS at 0x00000408c6000000: allocated 512 Interrupt 
> Collections @1fbb977000 (flat, esz 8, psz 4K, shr 1)
> [    0.000000] WARNING: CPU: 0 PID: 0 at 
> drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x360/0x5f4
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3 #971
> [    0.000000] pstate: 00000085 (nzcv daIf -PAN -UAO)
> [    0.000000] pc : its_init+0x360/0x5f4
> [    0.000000] lr : its_init+0x35c/0x5f4
> [    0.000000] sp : ffff000009183ca0
> [    0.000000] x29: ffff000009183ca0 x28: ffff7dfffe67b3e4
> [    0.000000] x27: 0000000000000001 x26: ffff801fbb928000
> [    0.000000] x25: ffff000009325360 x24: ffff00000918c8c8
> [    0.000000] x23: ffff801fbb802100 x22: ffff00000918c8c8
> [    0.000000] x21: ffff000009189000 x20: ffff0000091b8000
> [    0.000000] x19: ffff000009325000 x18: ffffffffffffffff
> [    0.000000] x17: 0000000001f4d3b5 x16: 0000000000000000
> [    0.000000] x15: ffff0000091896c8 x14: ffff801fbb97389b
> [    0.000000] x13: ffff801fbb97389a x12: 2074707572726574
> [    0.000000] x11: ffff000009183a00 x10: ffff000009183a00
> [    0.000000] x9 : ffff7e007eeed400 x8 : ffff801fbbb60000
> [    0.000000] x7 : a2a2a2a2a2a2a2a2 x6 : 0000801ff2d1c000
> [    0.000000] x5 : ffff7e0000000000 x4 : ffff00000918c8c8
> [    0.000000] x3 : ffff801fbbb50000 x2 : 0000000000000000
> [    0.000000] x1 : 0000000000010000 x0 : 00000000ffffffed
> [    0.000000] Call trace:
> [    0.000000]  its_init+0x360/0x5f4
> [    0.000000]  gic_init_bases+0x2d4/0x2f4
> [    0.000000]  gic_acpi_init+0x154/0x278
> [    0.000000]  acpi_match_madt+0x44/0x78
> [    0.000000]  acpi_table_parse_entries_array+0x13c/0x214
> [    0.000000]  acpi_table_parse_entries+0x40/0x60
> [    0.000000]  acpi_table_parse_madt+0x24/0x2c
> [    0.000000]  __acpi_probe_device_table+0x80/0xdc
> [    0.000000]  irqchip_init+0x30/0x38
> [    0.000000]  init_IRQ+0xfc/0x130
> [    0.000000]  start_kernel+0x288/0x418
> [    0.000000] ---[ end trace c841ef100bdd09a6 ]---

Yes, anyone with GICv3 and EFI will see this.

	M.
-- 
Jazz is not dead. It just smells funny...
