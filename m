From: denys.zagorui@globallogic.com (Denys Zagorui)
Date: Fri, 7 Apr 2017 14:52:35 +0300
Subject: Testing kexec/kdump on ls2085ardb (arm64)
Message-ID: <799fca3b-8d1c-c1d0-f3d7-e3b060f962fd@globallogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I was testing kexec/kdump on ls2085ardb using kexec-tools from:

https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/log/?h=arm64/kdump

and kernel from:

https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git/log/?h=arm64/kdump

------------------------------------------------------------------------------------

Kernel required configs:

CONFIG_KEXEC=y
CONFIG_SYSFS=y
CONFIG_DEBUG_INFO=y
CONFIG_CRASH_DUMP=y
CONFIG_PROC_VMCORE=y

------------------------------------------------------------------------------------
Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc3 (denyszagorui at kbp1-ldl-f65370) 
(gcc version 6.2.0 (GCC) ) #4 SMP PREEMPT Tue Apr 4 17:08:07 EEST 2017
[    0.000000] Boot CPU: AArch64 Processor [411fd071]
[    0.000000] earlycon: uart8250 at MMIO 0x00000000021c0600 (options '')
[    0.000000] bootconsole [uart8250] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] crashkernel reserved: 0x00000000bfe00000 - 
0x00000000ffe00000 (1024 MB)

.....

[    0.000000] Kernel command line: console=ttyS1,115200 
root=/dev/mmcblk0p1 rootwait earlycon=uart8250,mmio,0x21c0600, 
ramdisk_size=0x2000000 default_hugepagesz=2m hugepagesz=2m hugepages=256 
crashkernel=1024M
------------------------------------------------------------------------------------

I was trying two modes: direct boot (kexec -l than kexec -e) and kdump 
(kexec -p than echo c > /proc/sysrq-trigger).

Direct boot:
------------------------------------------------------------------------------------
root at ls2085ardb:~# kexec -l /boot/Image --initrd=/boot/initrd.cpio 
--command-line="console=ttyS1,115200 root=/dev/ram0 
earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices" -d
arch_process_options:147: command_line: console=ttyS1,115200 
root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices
arch_process_options:149: initrd: /boot/initrd.cpio
arch_process_options:150: dtb: (null)
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/Image of 65536 bytes failed
kernel: 0xffffac0f8010 kernel_size: 0xe80a00
get_memory_ranges_iomem_cb: 0000000080000000 - 00000000ffffffff : System RAM
get_memory_ranges_iomem_cb: 0000008080000000 - 00000083bfffffff : System RAM
elf_arm64_probe: Not an ELF executable.
image_arm64_load: kernel_segment: 0000000080000000
image_arm64_load: text_offset:    0000000000080000
image_arm64_load: image_size:     0000000000eea000
image_arm64_load: phys_offset:    0000000080000000
image_arm64_load: vp_offset:      ffffffffffffffff
image_arm64_load: PE format:      yes
.....
kexec_load: entry = 0x817ed660 flags = 0xb70000
nr_segments = 4
segment[0].buf   = 0xffffac0f8010
segment[0].bufsz = 0xe80a00
segment[0].mem   = 0x80080000
segment[0].memsz = 0xeea000
segment[1].buf   = 0xffffab879010
segment[1].bufsz = 0x87e800
segment[1].mem   = 0x80f6a000
segment[1].memsz = 0x87f000
segment[2].buf   = 0x377b3e80
segment[2].bufsz = 0x3d64
segment[2].mem   = 0x817e9000
segment[2].memsz = 0x4000
segment[3].buf   = 0x377b7f20
segment[3].bufsz = 0x31c8
segment[3].mem   = 0x817ed000
segment[3].memsz = 0x4000
kexec_load failed: Device or resource busy
entry       = 0x817ed660 flags = 0xb70000
nr_segments = 4
segment[0].buf   = 0xffffac0f8010
segment[0].bufsz = 0xe80a00
segment[0].mem   = 0x80080000
segment[0].memsz = 0xeea000
segment[1].buf   = 0xffffab879010
segment[1].bufsz = 0x87e800
segment[1].mem   = 0x80f6a000
segment[1].memsz = 0x87f000
segment[2].buf   = 0x377b3e80
segment[2].bufsz = 0x3d64
segment[2].mem   = 0x817e9000
segment[2].memsz = 0x4000
segment[3].buf   = 0x377b7f20
segment[3].bufsz = 0x31c8
segment[3].mem   = 0x817ed000
segment[3].memsz = 0x4000
root at ls2085ardb:~# kexec -e
Nothing has been loaded!

Not working for me:
kexec_load failed: Device or resource busy


kdump mode:
------------------------------------------------------------------------------------
root at ls2085ardb:~# kexec -p /boot/Image --initrd=/boot/initrd.cpio 
--command-line="console=ttyS1,115200 root=/dev/ram0 
earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices" -d
arch_process_options:147: command_line: console=ttyS1,115200 
root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600, 1 maxcpus=1 reset_devices
arch_process_options:149: initrd: /boot/initrd.cpio
arch_process_options:150: dtb: (null)
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on /boot/Image of 65536 bytes failed
kernel: 0xffff86fa8010 kernel_size: 0xe80a00
get_memory_ranges_iomem_cb: 0000000080000000 - 00000000ffffffff : System RAM
get_memory_ranges_iomem_cb: 0000008080000000 - 00000083bfffffff : System RAM
elf_arm64_probe: Not an ELF executable.
image_arm64_load: kernel_segment: 00000000bfe00000
image_arm64_load: text_offset:    0000000000080000
image_arm64_load: image_size:     0000000000eea000
image_arm64_load: phys_offset:    0000000080000000
image_arm64_load: vp_offset:      ffffffffffffffff
image_arm64_load: PE format:      yes
Reserved memory range
00000000bfe00000-00000000ffdfffff (0)
Coredump memory ranges
0000000080000000-00000000bfdfffff (0)
00000000ffe00000-00000000ffffffff (0)
0000008080000000-00000083bfffffff (0)
kernel symbol _text vaddr = ffff000008080000
load_crashdump_segments: page_offset:   ffff800000000000
...
kexec_load: entry = 0xc15ed660 flags = 0xb70001
nr_segments = 5
segment[0].buf   = 0xffff86fa8010
segment[0].bufsz = 0xe80a00
segment[0].mem   = 0xbfe80000
segment[0].memsz = 0xeea000
segment[1].buf   = 0xffff86729010
segment[1].bufsz = 0x87e800
segment[1].mem   = 0xc0d6a000
segment[1].memsz = 0x87f000
segment[2].buf   = 0x36959590
segment[2].bufsz = 0x3dc7
segment[2].mem   = 0xc15e9000
segment[2].memsz = 0x4000
segment[3].buf   = 0x3695d690
segment[3].bufsz = 0x31c8
segment[3].mem   = 0xc15ed000
segment[3].memsz = 0x4000
segment[4].buf   = 0x36949490
segment[4].bufsz = 0x400
segment[4].mem   = 0xffdff000
segment[4].memsz = 0x1000

root at ls2085ardb:~# echo c > /proc/sysrroot at ls2085ardb:~# echo c > 
/proc/sysrq-trigger

[  265.274402] sysrq: SysRq : Trigger a crash
[  265.278588] Unable to handle kernel NULL pointer dereference at 
virtual address 00000000
...
[  265.750726] Starting crashdump kernel...
[  265.754644] Some CPUs may be stale, kdump will be unreliable.
[  265.760388] ------------[ cut here ]------------
[  265.765006] WARNING: CPU: 0 PID: 1360 at 
arch/arm64/kernel/machine_kexec.c:158 machine_kexec+0x44/0x280
...

root at ls2085ardb:~# ls -al /proc/
...
-r--------    1 root     root     15048032256 Mar 28 15:36 vmcore
-r--r--r--    1 root     root             0 Mar 28 15:36 vmstat
-r--r--r--    1 root     root             0 Mar 28 15:36 zoneinfo

After that watched through /proc/vmcore using gdb. Seems to be working

Best Regards,
Denys

-- 
Denys Zagorui
GlobalLogic
Kyiv, 03038, Protasov Business Park, N.Grinchenka, 2/1
M +380673173093
www.globallogic.com

http://www.globallogic.com/email_disclaimer.txt
