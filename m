From: richardmaw@codethink.co.uk (Richard Maw)
Date: Wed, 30 May 2012 19:02:42 +0100
Subject: ARM Versatile defconfig PCI io out of range?
Message-ID: <20120530180242.GA15772@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I build from f9369910a6225b8d4892c3f20ae740a711cd5ace
with versatile_defconfig, after making the changes described in
http://fedoraproject.org/wiki/Architectures/ARM/HowToQemu#Build_Kernel_Image_From_Source
Enabling PCI and the SYM53C8XX scsi disk driver, which aren't in the
defconfig.

QEMU is run with the command
  qemu-system-arm -M versatilepb \
  -drive file=$diskimage,if=scsi \
  -kernel linux/arch/arm/boot/zImage -append root=/dev/sda1
  
The system fails to find the scsi disk, due to the controller failing to
request the IO resource.

It gives the following on the console
Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0
Linux version 3.4.0+ (richardmaw at aegir) (gcc version 4.6.1
(Ubuntu/Linaro 4.6.1-9ubuntu3) ) #14 Wed May 30 16:54:55 BST 2012
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00093177
CPU: VIVT data cache, VIVT instruction cache
Machine: ARM-Versatile PB
Memory policy: ECC disabled, Data cache writeback
--SNIP--
PCI core found (slot 11)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x44000000-0x4fffffff]
pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff pref]
PCI: bus0: Fast back to back transfers disabled
pci 0000:00:0c.0: BAR 2: assigned [mem 0x50000000-0x50001fff]
pci 0000:00:0c.0: BAR 1: assigned [mem 0x50002000-0x500023ff]
pci 0000:00:0c.0: BAR 0: assigned [io  0x44000000-0x440000ff]
bio: create slab <bio-0> at 0
--SNIP--
brd: module loaded
PCI: enabling device 0000:00:0c.0 (0100 -> 0103)
sym53c8xx 0000:00:0c.0: pci_request_regions called
sym53c8xx 0000:00:0c.0: BAR 0: can't reserve [io  0x44000000-0x440000ff]
--SNIP--
VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)
[<c0019360>] (unwind_backtrace+0x0/0xf0) from [<c02876e8>]
(panic+0x74/0x1a8)
[<c02876e8>] (panic+0x74/0x1a8) from [<c035fc50>]
(mount_block_root+0x178/0x22c)
[<c035fc50>] (mount_block_root+0x178/0x22c) from [<c035fee4>]
(mount_root+0xe4/0x10c)
[<c035fee4>] (mount_root+0xe4/0x10c) from [<c036006c>]
(prepare_namespace+0x160/0x1b8)
[<c036006c>] (prepare_namespace+0x160/0x1b8) from [<c035f908>]
(kernel_init+0x198/0x1d8)
[<c035f908>] (kernel_init+0x198/0x1d8) from [<c0014510>]
(kernel_thread_exit+0x0/0x8)
QEMU: Terminated

We've tried to track down the problem, but we couldn't get much further
than finding out that the IO_SPACE_LIMIT in kernel/resource.c is 0xffff,
which is lower than the required 0x44000000.

We're not sure whether this is a problem with it not being allocated
enough space, or that it is not being translated properly.

Is this a known issue, I did a quick google for the "sym53c8xx
 can't reserve io" error, but nothing turned up.
If not, does anyone have any pointers to how this could be fixed?
