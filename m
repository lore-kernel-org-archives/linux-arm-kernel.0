From: angus@akkea.ca (Angus Ainslie)
Date: Sat, 20 May 2017 08:49:04 -0600
Subject: CHIPPro NAND issue with 4.12 rc1
Message-ID: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I'm trying to boot a CHIPPro with the stock 4.12 rc1 kernel. If I make 
no modifications to the sun5i-gr8-chip-pro.dtb the kernel boots but 
can't find the root partition.

So I added the partitions to the dts file

diff --git a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts 
b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
index c55b11a..0e61e6b 100644
--- a/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
+++ b/arch/arm/boot/dts/sun5i-gr8-chip-pro.dts
@@ -146,6 +146,32 @@
                 reg = <0>;
                 allwinner,rb = <0>;
                 nand-ecc-mode = "hw";
+    nand-on-flash-bbt;
+
+    spl at 0 {
+      label = "SPL";
+      reg = /bits/ 64 <0x0 0x400000>;
+    };
+
+    spl-backup at 400000 {
+      label = "SPL.backup";
+      reg = /bits/ 64 <0x400000 0x400000>;
+    };
+
+    u-boot at 800000 {
+      label = "U-Boot";
+      reg = /bits/ 64 <0x800000 0x400000>;
+    };
+
+    env at c00000 {
+      label = "env";
+      reg = /bits/ 64 <0xc00000 0x400000>;
+    };
+
+    rootfs at 1000000 {
+      label = "rootfs";
+      reg = /bits/ 64 <0x1000000 0x1f000000>;
+    };
         };
  };

and now the kernel finds the partition but it times out trying to mount 
it. It seems to be something in the dts files because if I use the 
ntc-gr8-crumb.dts from the ntc 4.4.30 kernel then the system boots all 
the way to userland.

[    7.130000] ubi0: scanning is finished
[    7.150000] ubi0: attached mtd4 (name "rootfs", size 496 MiB)
[    7.160000] ubi0: PEB size: 262144 bytes (256 KiB), LEB size: 258048 
bytes
[    7.170000] ubi0: min./max. I/O unit sizes: 4096/4096, sub-page size 
1024
[    7.180000] ubi0: VID header offset: 1024 (aligned 1024), data 
offset: 4096
[    7.190000] ubi0: good PEBs: 1977, bad PEBs: 7, corrupted PEBs: 0
[    7.200000] ubi0: user volume: 1, internal volumes: 1, max. volumes 
count: 128
[    7.210000] ubi0: max/mean erase counter: 3/1, WL threshold: 4096, 
image sequence number: 1444477407
[    7.220000] ubi0: available PEBs: 1, total reserved PEBs: 1976, PEBs 
reserved for bad PEB handling: 33
[    7.240000] hctosys: unable to open rtc device (rtc0)
[    7.250000] vcc3v0: disabling
[    7.250000] ALSA device list:
[    7.260000]   #0: sun4i-codec
[    7.260000] ubi0: background thread "ubi_bgt0d" started, PID 53
[    8.320000] sunxi_nand 1c03000.nand: wait interrupt timedout
[    9.320000] sunxi_nand 1c03000.nand: wait interrupt timedout
[   10.330000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   11.340000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   12.350000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   13.360000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   14.370000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   14.380000] ubi0 warning: ubi_io_read: error -110 while reading 4096 
bytes from PEB 1034:4096, read only 0 bytes, retry
[   15.390000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   16.400000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   17.410000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   18.420000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   19.430000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   20.440000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   21.440000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   22.450000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   23.460000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   23.470000] ubi0 warning: ubi_io_read: error -110 while reading 4096 
bytes from PEB 1034:4096, read only 0 bytes, retry
[   24.480000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   25.490000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   26.500000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   27.510000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   28.510000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   29.520000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   30.530000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   31.540000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   32.540000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   32.550000] ubi0 warning: ubi_io_read: error -110 while reading 4096 
bytes from PEB 1034:4096, read only 0 bytes, retry

[   32.550000] ubi0 warning: ubi_io_read: error -110 while reading 4096 
bytes from PEB 1034:4096, read only 0 bytes, retry
[   33.560000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   34.570000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   35.580000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   36.590000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   37.600000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   38.600000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   39.610000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   40.620000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   41.630000] sunxi_nand 1c03000.nand: wait for empty cmd FIFO timedout
[   41.630000] ubi0 error: ubi_io_read: error -110 while reading 4096 
bytes from PEB 1034:4096, read 0 bytes
[   41.650000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.12.0-rc1TNCPro-dirty #7
[   41.650000] Hardware name: Allwinner sun4i/sun5i Families
[   41.650000] [<c010e440>] (unwind_backtrace) from [<c010b01c>] 
(show_stack+0x10/0x14)
[   41.650000] [<c010b01c>] (show_stack) from [<c036d46c>] 
(dump_stack+0x84/0x98)
[   41.650000] [<c036d46c>] (dump_stack) from [<c04b1e54>] 
(ubi_io_read+0x144/0x328)
[   41.650000] [<c04b1e54>] (ubi_io_read) from [<c04afc54>] 
(ubi_eba_read_leb+0xcc/0x430)
[   41.650000] [<c04afc54>] (ubi_eba_read_leb) from [<c04ae91c>] 
(ubi_leb_read+0x70/0xc0)
[   41.650000] [<c04ae91c>] (ubi_leb_read) from [<c02ffdfc>] 
(ubifs_leb_read+0x2c/0x78)
[   41.650000] [<c02ffdfc>] (ubifs_leb_read) from [<c0301834>] 
(ubifs_read_node+0x94/0x28c)
[   41.650000] [<c0301834>] (ubifs_read_node) from [<c02feaf4>] 
(ubifs_read_sb_node+0x58/0x7c)
[   41.650000] [<c02feaf4>] (ubifs_read_sb_node) from [<c02ff174>] 
(ubifs_read_superblock+0x61c/0xc9c)
[   41.650000] [<c02ff174>] (ubifs_read_superblock) from [<c02fdebc>] 
(ubifs_mount+0xb7c/0x1588)
[   41.650000] [<c02fdebc>] (ubifs_mount) from [<c01f820c>] 
(mount_fs+0x14/0xa4)
[   41.650000] [<c01f820c>] (mount_fs) from [<c02134f0>] 
(vfs_kern_mount+0x4c/0x104)
[   41.650000] [<c02134f0>] (vfs_kern_mount) from [<c0216340>] 
(do_mount+0x154/0xbd8)
[   41.650000] [<c0216340>] (do_mount) from [<c0217164>] 
(SyS_mount+0x90/0xc0)
[   41.650000] [<c0217164>] (SyS_mount) from [<c0a0117c>] 
(mount_block_root+0x10c/0x270)
[   41.650000] [<c0a0117c>] (mount_block_root) from [<c0a014a8>] 
(prepare_namespace+0x9c/0x198)
[   41.650000] [<c0a014a8>] (prepare_namespace) from [<c0a00e40>] 
(kernel_init_freeable+0x1d8/0x1e8)
[   41.650000] [<c0a00e40>] (kernel_init_freeable) from [<c070c4dc>] 
(kernel_init+0x8/0x110)
[   41.650000] [<c070c4dc>] (kernel_init) from [<c0107578>] 
(ret_from_fork+0x14/0x3c)
[   41.920000] UBIFS error (ubi0:0 pid 1): ubifs_leb_read: reading 4096 
bytes from LEB 0:0 failed, error -110
[   41.940000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.12.0-rc1TNCPro-dirty #7
[   41.940000] Hardware name: Allwinner sun4i/sun5i Families
[   41.940000] [<c010e440>] (unwind_backtrace) from [<c010b01c>] 
(show_stack+0x10/0x14)
[   41.940000] [<c010b01c>] (show_stack) from [<c036d46c>] 
(dump_stack+0x84/0x98)
[   41.940000] [<c036d46c>] (dump_stack) from [<c02ffe44>] 
(ubifs_leb_read+0x74/0x78)
[   41.940000] [<c02ffe44>] (ubifs_leb_read) from [<c0301834>] 
(ubifs_read_node+0x94/0x28c)
[   41.940000] [<c0301834>] (ubifs_read_node) from [<c02feaf4>] 
(ubifs_read_sb_node+0x58/0x7c)
[   41.940000] [<c02feaf4>] (ubifs_read_sb_node) from [<c02ff174>] 
(ubifs_read_superblock+0x61c/0xc9c)
[   41.940000] [<c02ff174>] (ubifs_read_superblock) from [<c02fdebc>] 
(ubifs_mount+0xb7c/0x1588)
[   41.940000] [<c02fdebc>] (ubifs_mount) from [<c01f820c>] 
(mount_fs+0x14/0xa4)
[   41.940000] [<c01f820c>] (mount_fs) from [<c02134f0>] 
(vfs_kern_mount+0x4c/0x104)
[   41.940000] [<c02134f0>] (vfs_kern_mount) from [<c0216340>] 
(do_mount+0x154/0xbd8)
[   41.940000] [<c0216340>] (do_mount) from [<c0217164>] 
(SyS_mount+0x90/0xc0)
[   41.940000] [<c0217164>] (SyS_mount) from [<c0a0117c>] 
(mount_block_root+0x10c/0x270)
[   41.940000] [<c0a0117c>] (mount_block_root) from [<c0a014a8>] 
(prepare_namespace+0x9c/0x198)
[   41.940000] [<c0a014a8>] (prepare_namespace) from [<c0a00e40>] 
(kernel_init_freeable+0x1d8/0x1e8)
[   41.940000] [<c0a00e40>] (kernel_init_freeable) from [<c070c4dc>] 
(kernel_init+0x8/0x110)
[   41.940000] [<c070c4dc>] (kernel_init) from [<c0107578>] 
(ret_from_fork+0x14/0x3c)
[   42.200000] VFS: Cannot open root device "ubi0:rootfs" or 
unknown-block(0,0): error -110
[   42.220000] Please append a correct "root=" boot option; here are the 
available partitions:
[   42.230000] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(0,0)
[   42.230000] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
4.12.0-rc1TNCPro-dirty #7
[   42.230000] Hardware name: Allwinner sun4i/sun5i Families
[   42.230000] [<c010e440>] (unwind_backtrace) from [<c010b01c>] 
(show_stack+0x10/0x14)
[   42.230000] [<c010b01c>] (show_stack) from [<c036d46c>] 
(dump_stack+0x84/0x98)
[   42.230000] [<c036d46c>] (dump_stack) from [<c01a7968>] 
(panic+0xdc/0x248)
[   42.230000] [<c01a7968>] (panic) from [<c0a01208>] 
(mount_block_root+0x198/0x270)
[   42.230000] [<c0a01208>] (mount_block_root) from [<c0a014a8>] 
(prepare_namespace+0x9c/0x198)
[   42.230000] [<c0a014a8>] (prepare_namespace) from [<c0a00e40>] 
(kernel_init_freeable+0x1d8/0x1e8)
[   42.230000] [<c0a00e40>] (kernel_init_freeable) from [<c070c4dc>] 
(kernel_init+0x8/0x110)
[   42.230000] [<c070c4dc>] (kernel_init) from [<c0107578>] 
(ret_from_fork+0x14/0x3c)
[   42.230000] ---[ end Kernel panic - not syncing: VFS: Unable to mount 
root fs on unknown-block(0,0)
