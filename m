From: Jan.Glauber@cavium.com (Jan Glauber)
Date: Tue, 20 Nov 2018 16:23:11 +0000
Subject: WARN_ON after gic_reserve_range
Message-ID: <20181120162305.GA2088@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

with 4.20-rc3 I see two WARN_ON's firing on a ThunderX2 system that come from
commit 3fb68faee867 (irqchip/gic-v3-its: Register LPI tables with EFI config table).

Global efi_memreserve_root is NULL as it will only be set when early initcalls are
running, but from the backtrace the WARN_ON's are running even earlier (init_IRQ).

Am I the only one seeing this?

[    0.000000] WARNING: CPU: 0 PID: 0 at drivers/irqchip/irq-gic-v3-its.c:1696 its_init+0x36c/0x608
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.20.0-rc3-jang+ #69
[    0.000000] pstate: 60000089 (nZCv daIf -PAN -UAO)
[    0.000000] pc : its_init+0x36c/0x608
[    0.000000] lr : its_init+0x368/0x608
[    0.000000] sp : ffff000008e53c60
[    0.000000] x29: ffff000008e53c60 x28: ffff7dfffe6807a4 
[    0.000000] x27: 0000000000000001 x26: ffff80267b4c2100 
[    0.000000] x25: ffff000008ffe930 x24: ffff000008e5d9c8 
[    0.000000] x23: ffff80267bc10300 x22: ffff000008e5d9c8 
[    0.000000] x21: ffff000008e59000 x20: ffff000008f12000 
[    0.000000] x19: ffff000008ffe000 x18: ffffffffffffffff 
[    0.000000] x17: 0000000000000009 x16: 0000000000000000 
[    0.000000] x15: ffff000008e59648 x14: ffff000088fa616f 
[    0.000000] x13: ffff000008fa617d x12: ffff000008e7e000 
[    0.000000] x11: ffff000008e53900 x10: ffff000008e59eb0 
[    0.000000] x9 : ffff000008e3e018 x8 : ffff00000875ac58 
[    0.000000] x7 : 206f6e203a746e65 x6 : 000000000000018c 
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000 
[    0.000000] x3 : 0000000000000001 x2 : 4f419eae5e0eb800 
[    0.000000] x1 : 0000000000000000 x0 : 00000000ffffffed 
[    0.000000] Call trace:
[    0.000000]  its_init+0x36c/0x608
[    0.000000]  gic_init_bases+0x288/0x300
[    0.000000]  gic_acpi_init+0x124/0x248
[    0.000000]  acpi_match_madt+0x4c/0x88
[    0.000000]  acpi_table_parse_entries_array+0x134/0x220
[    0.000000]  acpi_table_parse_entries+0x70/0x98
[    0.000000]  acpi_table_parse_madt+0x40/0x50
[    0.000000]  __acpi_probe_device_table+0x88/0xe4
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0xcc/0x100
[    0.000000]  start_kernel+0x2fc/0x490
[    0.000000] ---[ end trace 41868d15bb5cf8f6 ]---

--Jan
