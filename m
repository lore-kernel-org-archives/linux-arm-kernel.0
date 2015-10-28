From: hans.heckel@alcatel-lucent.com (HECKEL, Hans (Hans))
Date: Wed, 28 Oct 2015 07:46:27 +0000
Subject: Problem: crashkernel boots at 512MB address in RAM with kexec -l/-e
 but not with kexec -p
Message-ID: <BAEDA261213CF64EAEFAC725AB01AEC386CDC1D3@FR712WXCHMBA09.zeu.alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear arm kernel mailing list,
I hope it is okay to ask you as my public problem description has not yielded 
any replies so far. My problem is posted here:
http://unix.stackexchange.com/questions/237580/boot-rescue-kernel-at-high-memory-address-using-kexec-on-arm
and also copied below (without the formatting). Any help is highly 
appreciated, and thanks for the work you are putting into GNU Linux!
Best regards,
Hans Heckel (Alcatel-Lucent, IP Routing and Transport)
P.S. Note that I tried to send this to the kexec mailing list first but it is 
being blocked by the moderator.


Summary: Crashkernel boots at 512MB address in RAM with kexec -l/-e but not
with kexec -p - why?

Embedded platform with Marvell Armada XP (MV78460) (ARMv7 with 4 cores) and
1GB of RAM.
- production kernel: customized Linux 3.4.91
- rescue kernel: clean kernel.org-Linux (4.2.3) (I am aware that it uses
device trees but that works fine by appending DTB to zImage)
- in user-space, I am using the latest kexec-tools (2.0.10)

History: Using kexec -l (with ramdisk and command line params from
3.4.91-kernel, and --atags) and kexec -e, the rescue kernel boots just fine
and seems to place itself in the beginning of RAM (according to /proc/iomem)
regardless of what is being set via --mem-min and --mem-max. When reserving
space in RAM using the boot-option crashkernel, I have to use a high memory
address because otherwise it tells me the requested area is already in use.
So we set crashkernel=128M at 512M. The kernel does not boot with kexec -p.

Current status: I understand that relocatable kernels
(CONFIG_AUTO_ZRELADDR=y) must reside within the top 128MB which is not
possible for us. So I have worked around the standard kernel configuration
and forced CONFIG_ARM_PATCH_PHYS_VIRT to no and CONFIG_PHYS_OFFSET to
0x20000000. I had to add a Makefile.boot for the machine where I set
zreladdr-y := 0x20008000, params_phys-y := 0x20000100, initrd_phys-y :=
0x20800000. Now the kernel still boots fine using kexec -l and kexec -e and
according to --mem-min. I can see it is placed at 512MB. However,
configuring it with -p and causing a panic, the console says Loading
crashdump kernel... Bye! and remains silent forever.

All files and everything is only located in RAM.

What could I be doing wrong? Should I worry about the decompression errors
(even in the good case)?

>From dmesg:
Reserving 128MB of memory at 512MB for crashkernel (System RAM: 760MB)

root at host:~# cat /proc/iomem
00000000-3bff9fff : System RAM
  00008000-00724f43 : Kernel code
  0076e000-0087553f : Kernel data
  20000000-27ffffff : Crash kernel
(some RAM at the end is reserved for persistent storage, that's why it
doesn't add up to 1GB)

Successful case:

root at host:~# kexec -l -t zImage --command-line="console=ttyS0,38400
earlyprintk=ttyS0 root=/dev/ram rdinit=/sbin/init rw irqpoll maxcpus=1
reset_devices" --atags --initrd=./initramfs.cpio.gz -d --mem-min=0x20000000
--mem-max=0x28000000 ./zImage_fixed_addr
Try gzip decompression.
Try LZMA decompression.
lzma_decompress_file: read on ./zImage_fixed_addr of 65536 bytes failed
kernel: 0xb6c06008 kernel_size: 0x3db659
kexec_load: entry = 0x20008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0x40e98
segment[0].bufsz = 0x3f0
segment[0].mem   = 0x20001000
segment[0].memsz = 0x1000
segment[1].buf   = 0xb6c06008
segment[1].bufsz = 0x3db659
segment[1].mem   = 0x20008000
segment[1].memsz = 0x3dc000
segment[2].buf   = 0xb5ade008
segment[2].bufsz = 0x1127516
segment[2].mem   = 0x20f6e000
segment[2].memsz = 0x1128000
root at host:~# kexec -e
Starting new kernel
Booting Linux on physical CPU 0x0
...

After boot:

root at vanilla:~# cat /proc/iomem
20000000-3fffffff : System RAM
  20008000-206dd237 : Kernel code
  20720000-2078f54f : Kernel data

Unsuccessful case:

root at host:~# kexec -p -t zImage --command-line="console=ttyS0,38400
earlyprintk=ttyS0 root=/dev/ram rdinit=/sbin/init rw irqpoll maxcpus=1
reset_devices" --atags --initrd=./initramfs.cpio.gz -d ./zImage_fixed_addr
Try gzip decompression
Try LZMA decompression.
lzma_decompress_file: read on ./zImage_fixed_addr of 65536 bytes failed
kernel: 0xb6b69008 kernel_size: 0x3db659
phys_offset: 0
kernel symbol _stext vaddr =         c0008240
page_offset is set to c0000000
get_crash_notes_per_cpu: crash_notes addr = 10f525c, size = 1024
Elf header: p_type = 4, p_offset = 0x10f525c p_paddr = 0x10f525c p_vaddr =
0x0 p_filesz = 0x400 p_memsz = 0x400
get_crash_notes_per_cpu: crash_notes addr = 10ff25c, size = 1024
Elf header: p_type = 4, p_offset = 0x10ff25c p_paddr = 0x10ff25c p_vaddr =
0x0 p_filesz = 0x400 p_memsz = 0x400
get_crash_notes_per_cpu: crash_notes addr = 110925c, size = 1024
Elf header: p_type = 4, p_offset = 0x110925c p_paddr = 0x110925c p_vaddr =
0x0 p_filesz = 0x400 p_memsz = 0x400
get_crash_notes_per_cpu: crash_notes addr = 111325c, size = 1024
Elf header: p_type = 4, p_offset = 0x111325c p_paddr = 0x111325c p_vaddr =
0x0 p_filesz = 0x400 p_memsz = 0x400
vmcoreinfo header: p_type = 4, p_offset = 0x7f1330 p_paddr = 0x7f1330
p_vaddr = 0x0 p_filesz = 0x1000 p_memsz = 0x1000
Elf header: p_type = 1, p_offset = 0x0 p_paddr = 0x0 p_vaddr = 0xc0000000
p_filesz = 0x20000000 p_memsz = 0x20000000
Elf header: p_type = 1, p_offset = 0x28000000 p_paddr = 0x28000000 p_vaddr =
0xe8000000 p_filesz = 0x13ffa000 p_memsz = 0x13ffa000
elfcorehdr: 0x27f00000
crashkernel: [0x20000000 - 0x27ffffff] (128M)
memory range: [0 - 0x1fffffff] (512M)
memory range: [0x28000000 - 0x3bff9fff] (319M)
kernel command line: "console=ttyS0,38400 earlyprintk=ttyS0 root=/dev/ram
rdinit=/sbin/init rw irqpoll maxcpus=1 reset_devices elfcorehdr=0x27f00000
mem=130048K"
kexec_load: entry = 0x20008000 flags = 0x280001
nr_segments = 4
segment[0].buf   = 0x416e0
segment[0].bufsz = 0x410
segment[0].mem   = 0x20001000
segment[0].memsz = 0x1000
segment[1].buf   = 0xb6b69008
segment[1].bufsz = 0x3db659
segment[1].mem   = 0x20008000
segment[1].memsz = 0x3dc000
segment[2].buf   = 0xb5a41008
segment[2].bufsz = 0x1127516
segment[2].mem   = 0x20f6e000
segment[2].memsz = 0x1128000
segment[3].buf   = 0x412a0
segment[3].bufsz = 0x400
segment[3].mem   = 0x27f00000
segment[3].memsz = 0x1000

<cause crash via SysRq>

Loading crashdump kernel...
Bye!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5215 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/8be5a3c6/attachment.bin>
