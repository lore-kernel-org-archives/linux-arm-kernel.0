From: james.morse@arm.com (James Morse)
Date: Mon, 9 Jul 2018 11:56:36 +0100
Subject: [PATCH v3 0/3] arm64: kexec, kdump: fix boot failures on acpi-only
 system
In-Reply-To: <20180709000750.22172-1-takahiro.akashi@linaro.org>
References: <20180709000750.22172-1-takahiro.akashi@linaro.org>
Message-ID: <f52f8607-ed7e-40fd-002c-13cb34bb0396@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Akashi,

On 09/07/18 01:07, AKASHI Takahiro wrote:
> Patch#2 and #3 addresses kdump case. Ard's patch [4] needs to be applied
> preliminarily.

I missed this, and was then surprised by [0], when I tested kdump.

Could you re-post this with all the dependencies in the series? These changes
need to be tested together and merged at the same time, otherwise kdump can't be
tested and we risk the maintainer picking up broken code.


Thanks,

James


[0] failed kdump boot on Seattle
------------------%<------------------
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
Unable to handle kernel paging request@virtual address ffff2007
Mem abort info:
  ESR = 0x96000021
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000021
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
pgd=00000080ffdfd803, pud=00000080ffdfc803, pm3
Internal error: Oops: 96000021 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G S                4.18.0-1
Hardware name: AMD Overdrive/Supercharger/Default string, BIOS RO6
pstate: 10400005 (nzcV daif +PAN -UAO)
pc : acpi_ns_lookup+0x550/0x740
lr : acpi_ns_lookup+0x2f8/0x740
[...]
Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
Call trace:
 acpi_ns_lookup+0x550/0x740
 acpi_ds_load2_begin_op+0x568/0x87c
  acpi_ds_exec_begin_op+0x50/0x388
 acpi_ps_build_named_op+0x1cc/0x3dc
 acpi_ps_create_op+0x4f4/0x864
 acpi_ps_parse_loop+0x40c/0x133c
 acpi_ps_parse_aml+0x1f4/0x5a8
 acpi_ps_execute_table+0x24c/0x2e0
 acpi_ns_execute_table+0x354/0x408
 acpi_ns_parse_table+0x5c/0x94
 acpi_ns_load_table+0x40/0xf8
 acpi_tb_load_namespace+0x31c/0x510
 acpi_load_tables+0x48/0x13c
 acpi_init+0x170/0x5c8
 do_one_initcall+0xc0/0x2b0
 kernel_init_freeable+0x3d4/0x484
 kernel_init+0x10/0x118
 ret_from_fork+0x10/0x18
Code: f90037a2 aa1303e0 97dfd654 f94037a2 (b9400260)
---[ end trace d678006368422baa ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00b
------------------%<------------------
