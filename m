From: jan.kiszka@web.de (Jan Kiszka)
Date: Sun, 22 Apr 2018 12:47:57 +0200
Subject: BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0
Message-ID: <97d99ad9-c5cf-a4d2-126a-2b39ffead0b3@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this can be triggered simply by running

# echo 0 > /sys/devices/system/cpu/cpu3/online
# echo 1 > /sys/devices/system/cpu/cpu3/online

[  455.904854] ==================================================================
[  455.906108] BUG: KASAN: global-out-of-bounds in unmap_kernel_at_el0+0x70/0x1a0
[  455.906668] Read of size 4 at addr ffff200008e3a9d8 by task swapper/3/0
[  455.907122] 
[  455.907647] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.17.0-rc1-00257-gbf20b92a3b12 #76
[  455.908158] Hardware name: linux,dummy-virt (DT)
[  455.908802] Call trace:
[  455.909126]  dump_backtrace+0x0/0x230
[  455.909522]  show_stack+0x14/0x20
[  455.909848]  dump_stack+0xa8/0xcc
[  455.910180]  print_address_description+0x13c/0x250
[  455.910576]  kasan_report+0x254/0x328
[  455.910985]  __asan_load4+0x88/0xb0
[  455.911326]  unmap_kernel_at_el0+0x70/0x1a0
[  455.911702]  __verify_local_cpu_caps+0x78/0x178
[  455.912098]  verify_local_cpu_caps+0x4c/0x60
[  455.912509]  check_local_cpu_capabilities+0x64/0x158
[  455.912955]  secondary_start_kernel+0x178/0x260
[  455.913366] 
[  455.913586] The buggy address belongs to the variable:
[  455.914026]  kpti_safe_list.26846+0x18/0x1460
[  455.914382] 
[  455.914606] Memory state around the buggy address:
[  455.915349]  ffff200008e3a880: 00 00 00 01 fa fa fa fa 00 00 04 fa fa fa fa fa
[  455.915942]  ffff200008e3a900: 03 fa fa fa fa fa fa fa 04 fa fa fa fa fa fa fa
[  455.916483] >ffff200008e3a980: 00 00 00 06 fa fa fa fa 00 00 00 fa fa fa fa fa
[  455.917077]                                                     ^
[  455.917539]  ffff200008e3aa00: 00 00 00 00 00 00 00 05 fa fa fa fa 00 00 00 00
[  455.918055]  ffff200008e3aa80: 00 00 00 00 03 fa fa fa fa fa fa fa 00 00 00 00
[  455.918579] ==================================================================

Issue is new with 4.17-rc. Can provide .config if needed. Device was
qemu-system-aarch64. 

Jan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/07601f35/attachment-0001.sig>
