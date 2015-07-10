From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 10 Jul 2015 15:47:15 +0100
Subject: ACPI: regression: Failed to initialize GIC IRQ controller
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
References: <CACVXFVPkZYm2i+S3m8B0tixKmTx02psGndo79ehdJxLiz9T92A@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E37D30B295@ORSMSX112.amr.corp.intel.com>
Message-ID: <559FDAF3.10200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/15 15:28, Moore, Robert wrote:
> 
> 
>> -----Original Message-----
>> From: Ming Lei [mailto:ming.lei at canonical.com]
>> Sent: Friday, July 10, 2015 12:46 AM
>> To: Moore, Robert; Zheng, Lv; Wysocki, Rafael J
>> Cc: Linux Kernel Mailing List; linux-arm-kernel; Thomas Gleixner; Jason
>> Cooper; Hanjun Guo
>> Subject: ACPI: regression: Failed to initialize GIC IRQ controller
>>
>> Hi,
>>
>> Commit 0cff8dc0099f6d4f(ACPICA: ACPI 6.0: Add changes for MADT table.)
>> causes the following failure on APM mustang board(arm64) when booting via
>> UEFI and ACPI:
> 
> 
> I would be interested to know just what exactly about this change broke things.

The gory details are there: https://lkml.org/lkml/2015/7/6/876

Basically, some data structure (acpi_madt_generic_interrupt) grew by 4
bytes from ACPI 5.1 to 6.0, but BAD_MADT_ENTRY only knows about the new
size, and not the old one.

When booting on an old(er) version of ACPI, the interrupt controller
tables are ignore (not the right size), and the machine stops booting
very early.

Thanks,

	M.

> Bob
> 
> 
> 
>>
>> No valid GICC entries exist
>> ACPI: Failed to initialize GIC IRQ controller Kernel panic - not syncing:
>> No interrupt controller found.
>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-rc1+ #45 Hardware name:
>> APM X-Gene Mustang board (DT) Call trace:
>> [<ffffffc000089b94>] dump_backtrace+0x0/0x12c [<ffffffc000089cd0>]
>> show_stack+0x10/0x1c [<ffffffc0005fac18>] dump_stack+0x8c/0xdc
>> [<ffffffc0005f7218>] panic+0xe4/0x220 [<ffffffc00082631c>]
>> init_IRQ+0x24/0x30 [<ffffffc00082486c>] start_kernel+0x274/0x3d8 ---[ end
>> Kernel panic - not syncing: No interrupt controller found.
>>
>>
>> Thanks,
>> Ming
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Jazz is not dead. It just smells funny...
