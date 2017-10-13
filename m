From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Fri, 13 Oct 2017 11:23:38 +0000
Subject: kdump: need help with kexec -p
In-Reply-To: <59E095E1.5090706@arm.com>
References: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59DF54B3.1050404@arm.com>
 <HE1PR04MB124165F8510E983992B11EC797480@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59E095E1.5090706@arm.com>
Message-ID: <HE1PR04MB12415392027297293D5FC07E97480@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: James Morse [mailto:james.morse at arm.com]
> Sent: Friday, October 13, 2017 4:01 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>;
> takahiro.akashi at linaro.org
> Cc: linux-arm-kernel at lists.infradead.org; Poonam Aggrwal
> <poonam.aggrwal@nxp.com>; Scott Wood <oss@buserror.net>; Abhimanyu
> Saini <abhimanyu.saini@nxp.com>
> Subject: Re: kdump: need help with kexec -p
> 
> Hi Prabhakar,
> 
> On 13/10/17 10:41, Prabhakar Kushwaha wrote:
> >> On 11/10/17 10:11, Prabhakar Kushwaha wrote:
> >>> We are facing some issues while using  kexec -p on ARM64 NXP platforms.
> >>>
> >>> 1) After calling kexec -p, if immediately "panic" is triggered the crash kernel
> >>> does not boot. If we run few commands and wait for atleast (20-30 secs),
> >> before
> >>> triggering the panic, the crash kernel boots.
> >>
> >> What kernel version do you see this on?
> > linux-linaro-lsk-v4.4  (f3b1dec5e8f2b4d17442a79bcb1f15953056519d)
> >
> >> Can you log the kernel output in each
> >> case, (do you get a 'bye' message even when the new kernel doesn't boot).
> 
> > Yes I get 'bye' message in all cases.
> 
> Okay, so this means you get out of the old kernel. No further output means its
> stuck either in purgatory or the new kernel before we manage to output
> anything.
> 
> Are you using earlycon?

Yes, we are using earlycon

Bootargs for kexec:  kexec_pk -p ./Image_lsk --append="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 maxcpus=1" --initrd="./fsl-image-core-ls1043ardb.ext2.gz"


> 
> 
> >>> 2) We do not see the issue ("1" ), when we do umount -a, before calling the
> >> panic
> >>> after kexec-p.
> >>
> >> What filesystems (ext4, nfs etc) do you have mounted, and which ones does
> >> 'umount -a' get rid of?
> 
> My theory here was that some writeback thread was causing kdump to block..
> 
> 
> > root at ls1043ardb:~# mkdir temp; mount -t ext4 /dev/mmcblk0p3 temp/
> > [   27.786681] EXT4-fs (mmcblk0p3): mounted filesystem with ordered data
> mode. Opts: (null)
> > root at ls1043ardb:~# cat /proc/mounts
> > /dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
> > devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
> > proc /proc proc rw,relatime 0 0
> > sysfs /sys sysfs rw,relatime 0 0
> > debugfs /sys/kernel/debug debugfs rw,relatime 0 0
> > devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
> > /dev/mmcblk0p3 /home/root/temp ext4 rw,relatime,data=ordered 0 0
> >
> > root at ls1043ardb:~# umount -a
> > umount: /dev: target is busy
> >         (In some cases useful info about processes that
> >          use the device is found by lsof(8) or fuser(1).)
> > umount: /: target is busy
> >         (In some cases useful info about processes that
> >          use the device is found by lsof(8) or fuser(1).)
> >
> > root at ls1043ardb:~# cat /proc/mounts
> > /dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
> > devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
> > proc /proc proc rw,relatime 0 0
> > sysfs /sys sysfs rw,relatime 0 0
> > devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
> > root at ls1043ardb:~#
> >
> >
> >> Where are these filesystems stored?
> >>
> >
> > We are using ramdisk.
> >
> > Bootargs: ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500
> crashkernel=512M loglevel=8 ramdisk_size=0x20000000
> 
> Okay, so in your (1) doesn't-boot case the mmc driver is still in use, and may
> have dirty data to write back.
> 
> This fits with your 'wait 20 seconds and it works'. (you can check this theroy
> by increasing /proc/sys/vm/dirty_writeback_centisecs to something more than
> 20seconds should break this).
> 

It was already 3000 centisecs. We increased to 6000 but still no success. 


> Your case (2), after 'umount -a' your mmc driver is no longer in use, any dirty
> data will have been written back. This case works.
> 
> (Is it the driver or the data causing the problem? You could try 'mount -o
> remount,ro' on the mmc filesystems)
> 

No  success with this.

We tried below command also, but no luck. "Logs" are at bottom of mail.
mount -t ext4 -o ro /dev/mmcblk0p3 temp/



> [...]
> 
> >> (...does crashing on a different CPU change the behaviour?)
> >>> taskset -c 1 bash -c "echo c > /proc/sysrq-trigger"
> >>
> >
> > I tired taskset -c 1 bash -c "echo c > /proc/sysrq-trigger" and taskset -c 2 bash -
> c "echo c > /proc/sysrq-trigger".
> > Both worked i.e. crash kernel boot.
> >
> > One strange observation: Very first time crash kernel never boot. If you restart
> and try again.. it start working.
> > I tried 3 iteration.   1/3 --> failed for both core 1 and core 2.    Subsequent
> restart and try always worked.
> >
> > Not able to correlate with anything.
> 
> restart via platform firwmare? That is odd. Do the CPUs always come up in the
> same order? (you're using PSCI to bring up secondaries?)
> 

CPU always up in same order. We are using PSCI to wake secondary cores.

> 
> >> For kdump, we've already crashed, so you've already lost data. Its a best
> effort
> >> can we get to a point where you can debug the original crash.
> >>
> >
> > Looks like umount  -a is not mandatory for kexec -p
> 
> Not mandatory because it would be actively harmful:
> Umounting or even just syncing filesystems would write any dirty data back to
> disk, which may be corrupt. (hence the 'not syncing' message from the kernel).
> 
> 
> > Further observation
> > ---------------------------
> > ** On upstream the dump capture boots (the issue is not observed) **
> > Default config + enabled RAM Block Device
> 
> > ** On 4.4 LSK: (default defconfig + enabled RAM Block Device); issue is
> observed **
> 
> It looks like this is something to do with the mmc driver. I would look for
> differences between the mainline driver and LSK, there may be some fixed-bug
> causing the issue you are seeing.
> 
> 

Thanks
Prabhakar

root at ls1043ardb:~# mkdir temp
root at ls1043ardb:~# cd temp/
root at ls1043ardb:~/temp# ls
root at ls1043ardb:~/temp# [.10/.13/.2017 4:34 PM]  Prabhakar Kushwaha:
-sh: [.10/.13/.2017: No such file or directory
root at ls1043ardb:~/temp# mount -t ext4 -o ro /dev/mmcblk0p3 temp/
mount: mount point temp/ does not exist
root at ls1043ardb:~/temp#
root at ls1043ardb:~/temp# mount -t ext4 -o ro /dev/mmcblk0p3 ^Cmp/
root at ls1043ardb:~/temp# cd ..
root at ls1043ardb:~# mount -t ext4 -o ro /dev/mmcblk0p3 temp/
[   44.982030] EXT4-fs (mmcblk0p3): mounted filesystem with ordered data mode. Opts: (null)
root at ls1043ardb:~# cat /proc/iomem
01560000-0156ffff : mmc0
02100000-0210ffff : /soc/dspi at 2100000
02180000-0218ffff : /soc/i2c at 2180000
021c0500-021c05ff : serial
021c0600-021c06ff : serial
021d0500-021d05ff : serial
021d0600-021d06ff : serial
02ad0000-02adffff : /soc/wdog at 2ad0000
02f00000-02f07fff : /soc/usb3 at 2f00000
02f0c100-02f0ffff : /soc/usb3 at 2f00000
03000000-03007fff : /soc/usb3 at 3000000
0300c100-0300ffff : /soc/usb3 at 3000000
03100000-03107fff : /soc/usb3 at 3100000
0310c100-0310ffff : /soc/usb3 at 3100000
03200000-0320ffff : ahci
03500000-035fffff : regs
03600000-036fffff : regs
60000000-67ffffff : 60000000.nor
80000000-fbffffff : System RAM
  80080000-80d8ffff : Kernel code
  80e40000-80f5afff : Kernel data
  dc000000-fbffffff : Crash kernel
ff000000-ff7fffff : System RAM
ffc00000-ffdfffff : System RAM
5040000000-504007ffff : e1000e
50400c0000-50400dffff : e1000e
50400e0000-50400e3fff : e1000e
root at ls1043ardb:~# cd ./temp/
root at ls1043ardb:~/temp# ./kexec_pk -p -d ./Image_lsk --append="console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 maxcpus=1" --initrd="./fsl-image-core-ls1043ardb.ext2.gz" ; echo c > /proc/sysrq-trigger
arch_process_options:148: command_line: console=ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 maxcpus=1
arch_process_options:150: initrd: ./fsl-image-core-ls1043ardb.ext2.gz
arch_process_options:151: dtb: (null)
kernel: 0xffffb0159010 kernel_size: 0xe66400
get_memory_ranges_iomem_cb: 0000000080000000 - 00000000fbffffff : System RAM
get_memory_ranges_iomem_cb: 00000000ff000000 - 00000000ff7fffff : System RAM
get_memory_ranges_iomem_cb: 00000000ffc00000 - 00000000ffdfffff : System RAM
elf_arm64_probe: Not an ELF executable.
image_arm64_load: kernel_segment: 00000000dc000000
image_arm64_load: text_offset:    0000000000080000
image_arm64_load: image_size:     0000000000edb000
image_arm64_load: phys_offset:    0000000080000000
image_arm64_load: vp_offset:      ffffffffffffffff
image_arm64_load: PE format:      yes
Reserved memory range
00000000dc000000-00000000fbffffff (0)
Coredump memory ranges
0000000080000000-00000000dbffffff (0)
00000000ff000000-00000000ff7fffff (0)
00000000ffc00000-00000000ffdfffff (0)
kernel symbol _text vaddr = ffff000008080000
load_crashdump_segments: page_offset:   ffff800000000000
get_crash_notes_per_cpu: crash_notes addr = d5230800, size = 424
Elf header: p_type = 4, p_offset = 0xd5230800 p_paddr = 0xd5230800 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = d522f800, size = 424
Elf header: p_type = 4, p_offset = 0xd522f800 p_paddr = 0xd522f800 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = d522e800, size = 424
Elf header: p_type = 4, p_offset = 0xd522e800 p_paddr = 0xd522e800 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
get_crash_notes_per_cpu: crash_notes addr = d522d800, size = 424
Elf header: p_type = 4, p_offset = 0xd522d800 p_paddr = 0xd522d800 p_vaddr = 0x0 p_filesz = 0x1a8 p_memsz = 0x1a8
vmcoreinfo header: p_type = 4, p_offset = 0x80f17d18 p_paddr = 0x80f17d18 p_vaddr = 0x0 p_filesz = 0x1024 p_memsz = 0x1024
Kernel text Elf header: p_type = 1, p_offset = 0x80080000 p_paddr = 0x80080000 p_vaddr = 0xffff000008080000 p_filesz = 0xedb000 p_memsz = 0xedb000
Elf header: p_type = 1, p_offset = 0x80000000 p_paddr = 0x80000000 p_vaddr = 0xffff800000000000 p_filesz = 0x5c000000 p_memsz = 0x5c000000
Elf header: p_type = 1, p_offset = 0xff000000 p_paddr = 0xff000000 p_vaddr = 0xffff80007f000000 p_filesz = 0x800000 p_memsz = 0x800000
Elf header: p_type = 1, p_offset = 0xffc00000 p_paddr = 0xffc00000 p_vaddr = 0xffff80007fc00000 p_filesz = 0x200000 p_memsz = 0x200000
load_crashdump_segments: elfcorehdr 0xfbfff000-0xfbfff3ff
read_1st_dtb: found /sys/firmware/fdt
get_cells_size: #address-cells:2 #size-cells:2
cells_size_fitted: fbfff000-fbfff3ff
cells_size_fitted: dc000000-fbffffff
dump_reservemap: dtb_sys {90000000, 10000}
dump_reservemap: dtb_sys {a06ac0c0, 225e77b}
initrd: base dcf5b000, size 225e4deh (36037854)
dtb_set_initrd: start 3707088896, end 3743126750, size 36037854 (35193 KiB)
dtb:    base df1ba000, size ffd1h (65489)
sym: sha256_starts info: 12 other: 00 shndx: 1 value: e70 size: 58
sym: sha256_starts value: df1cae70 addr: df1ca014
machine_apply_elf_rel: CALL26 5800065394000000->5800065394000397
sym: sha256_update info: 12 other: 00 shndx: 1 value: 2dd8 size: c
sym: sha256_update value: df1ccdd8 addr: df1ca030
machine_apply_elf_rel: CALL26 eb15027f94000000->eb15027f94000b6a
sym: sha256_finish info: 12 other: 00 shndx: 1 value: 2de8 size: 1c4
sym: sha256_finish value: df1ccde8 addr: df1ca048
machine_apply_elf_rel: CALL26 aa1303e194000000->aa1303e194000b68
sym:     memcmp info: 12 other: 00 shndx: 1 value: 5f8 size: 34
sym: memcmp value: df1ca5f8 addr: df1ca058
machine_apply_elf_rel: CALL26 340003a094000000->340003a094000168
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca068
machine_apply_elf_rel: CALL26 5800042094000000->580004209400012b
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca070
machine_apply_elf_rel: CALL26 5800043694000000->5800043694000129
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca084
machine_apply_elf_rel: CALL26 f100827f94000000->f100827f94000124
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca0a0
machine_apply_elf_rel: CALL26 5800032094000000->580003209400011d
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca0a8
machine_apply_elf_rel: CALL26 38736a8194000000->38736a819400011b
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca0b8
machine_apply_elf_rel: CALL26 f100827f94000000->f100827f94000117
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca0c8
machine_apply_elf_rel: CALL26 5280002094000000->5280002094000113
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: df1cd028 addr: df1ca0e0
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1cd028
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1ccfb8 addr: df1ca0e8
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1ccfb8
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1ccfd8 addr: df1ca0f0
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1ccfd8
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1ccfe8 addr: df1ca0f8
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1ccfe8
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1ccfee addr: df1ca100
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1ccfee
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1ccff0 addr: df1ca108
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1ccff0
sym:     printf info: 12 other: 00 shndx: 1 value: 514 size: 80
sym: printf value: df1ca514 addr: df1ca11c
machine_apply_elf_rel: CALL26 9400000094000000->94000000940000fe
sym: setup_arch info: 12 other: 00 shndx: 1 value: e68 size: 4
sym: setup_arch value: df1cae68 addr: df1ca120
machine_apply_elf_rel: CALL26 9400000094000000->9400000094000352
sym: verify_sha256_digest info: 12 other: 00 shndx: 1 value: 0 size: e0
sym: verify_sha256_digest value: df1ca000 addr: df1ca124
machine_apply_elf_rel: CALL26 3400004094000000->3400004097ffffb7
sym: post_verification_setup_arch info: 12 other: 00 shndx: 1 value: e64 size: 4
sym: post_verification_setup_arch value: df1cae64 addr: df1ca134
machine_apply_elf_rel: JUMP26 0000000014000000->000000001400034c
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1cd000 addr: df1ca138
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1cd000
sym:    putchar info: 12 other: 00 shndx: 1 value: e60 size: 4
sym: putchar value: df1cae60 addr: df1ca198
machine_apply_elf_rel: CALL26 140000b394000000->140000b394000332
sym:    putchar info: 12 other: 00 shndx: 1 value: e60 size: 4
sym: putchar value: df1cae60 addr: df1ca208
machine_apply_elf_rel: CALL26 9100069494000000->9100069494000316
sym:    putchar info: 12 other: 00 shndx: 1 value: e60 size: 4
sym: putchar value: df1cae60 addr: df1ca458
machine_apply_elf_rel: CALL26 9100071894000000->9100071894000282
sym: .rodata.str1.1 info: 03 other: 00 shndx: 3 value: 0 size: 0
sym: .rodata.str1.1 value: df1cd012 addr: df1ca498
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1cd012
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 140 size: 354
sym: vsprintf value: df1ca140 addr: df1ca508
machine_apply_elf_rel: CALL26 a8d07bfd94000000->a8d07bfd97ffff0e
sym:   vsprintf info: 12 other: 00 shndx: 1 value: 140 size: 354
sym: vsprintf value: df1ca140 addr: df1ca588
machine_apply_elf_rel: CALL26 a8d17bfd94000000->a8d17bfd97fffeee
sym:  purgatory info: 12 other: 00 shndx: 1 value: 110 size: 28
sym: purgatory value: df1ca110 addr: df1ca638
machine_apply_elf_rel: CALL26 5800001194000000->5800001197fffeb6
sym: arm64_kernel_entry info: 10 other: 00 shndx: 4 value: 120 size: 8
sym: arm64_kernel_entry value: df1cd148 addr: df1ca63c
machine_apply_elf_rel: LD_PREL_LO19 5800000058000011->5800000058015871
sym: arm64_dtb_addr info: 10 other: 00 shndx: 4 value: 128 size: 8
sym: arm64_dtb_addr value: df1cd150 addr: df1ca640
machine_apply_elf_rel: LD_PREL_LO19 aa1f03e158000000->aa1f03e158015880
sym: sha256_process info: 12 other: 00 shndx: 1 value: ec8 size: 1e08
sym: sha256_process value: df1caec8 addr: df1ccd4c
machine_apply_elf_rel: CALL26 eb14027f94000000->eb14027f97fff85f
sym:     memcpy info: 12 other: 00 shndx: 1 value: 5d8 size: 20
sym: memcpy value: df1ca5d8 addr: df1ccd98
machine_apply_elf_rel: JUMP26 d503201f14000000->d503201f17fff610
sym:     memcpy info: 12 other: 00 shndx: 1 value: 5d8 size: 20
sym: memcpy value: df1ca5d8 addr: df1ccdb8
machine_apply_elf_rel: CALL26 aa1403e194000000->aa1403e197fff608
sym: sha256_process info: 12 other: 00 shndx: 1 value: ec8 size: 1e08
sym: sha256_process value: df1caec8 addr: df1ccdc4
machine_apply_elf_rel: CALL26 17ffffd894000000->17ffffd897fff841
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
sym: .data value: df1cd158 addr: df1ccfb0
machine_apply_elf_rel: ABS64 0000000000000000->00000000df1cd158
kexec_load: entry = 0xdf1ca630 flags = 0xb70001
nr_segments = 5
segment[0].buf   = 0xffffb0159010
segment[0].bufsz = 0xe66400
segment[0].mem   = 0xdc080000
segment[0].memsz = 0xedb000
segment[1].buf   = 0xffffadeea010
segment[1].bufsz = 0x225e4de
segment[1].mem   = 0xdcf5b000
segment[1].memsz = 0x225f000
segment[2].buf   = 0x2bade9d0
segment[2].bufsz = 0x[  142.203769] sysrq: SysRq : ffd1
segment[2]Trigger a crash
.mem   = 0xdf1ba[  142.209608] Unable to handle kernel NULL pointer dereference at virtual address 00000000
000
segment[2].[  142.219079] pgd = ffff80002217f000
[  142.223848] [00000000] *pgd=00000000d27a7003
                                               segment[3].buf , *pud=00000000a217a003  = 0x2baeed00
, *pmd=0000000000000000segment[3].bufsz
 = 0x3198
segme[  142.237665] Internal error: Oops: 96000046 [#1] PREEMPT SMP
nt[3].mem   = 0x[  142.244612] Modules linked in:
df1ca000
segmen[  142.249049] CPU: 1 PID: 1512 Comm: sh Not tainted 4.4.80-01714-gf05f1fc-dirty #1
t[3].memsz = 0x4[  142.257817] Hardware name: LS1043A RDB Board (DT)
000
segment[4].[  142.263897] task: ffff800055280c00 ti: ffff800022164000 task.ti: ffff800022164000
buf   = 0x2ba9e2[  142.272762] PC is at sysrq_handle_crash+0x14/0x20
b0
segment[4].b[  142.278836] LR is at __handle_sysrq+0x124/0x198
ufsz = 0x400
se[  142.284741] pc : [<ffff00000857bfbc>] lr : [<ffff00000857c9d4>] pstate: 00000145
[  142.293511] sp : ffff800022167d40
gment[4].mem   =[  142.296814] x29: ffff800022167d40 x28: ffff800022164000
[  142.303506] x27: ffff0000089e2000  0xfbfff000
segx26: 0000000000000040
[  142.310197] x25: 000000000000011d ment[4].memsz = x24: 0000000000000015
[  142.316889] x23: 0000000000000000 0x1000
x22: 0000000000000008
[  142.322885] x21: ffff000008e88ef8 x20: 0000000000000063
[  142.328189] x19: ffff000008e5d000 x18: 0000000000000000
[  142.333493] x17: 0000ffff8f6b86c0 x16: ffff0000081b4d98
[  142.338797] x15: ffff000008ef18e8 x14: ffff000008e5d778
[  142.344101] x13: ffff000008e5d000 x12: 0000000000000146
[  142.349404] x11: 0000000000000002 x10: 0000000000000001
[  142.354708] x9 : 0000000000000146 x8 : 0000000000000030
[  142.360010] x7 : 0000000000000000 x6 : ffff000008ef1e27
[  142.365314] x5 : 0000000000000000 x4 : 0000000000000000
[  142.370616] x3 : 0000000000000000 x2 : ffff800022164000
[  142.375920] x1 : 0000000000000000 x0 : 0000000000000001
[  142.381224]
[  142.382705] Process sh (pid: 1512, stack limit = 0xffff800022164020)
[  142.389047] Stack: (0xffff800022167d40 to 0xffff800022168000)
[  142.394783] 7d40: ffff800022167d80 ffff00000857ce58 0000000000000002 fffffffffffffffb
[  142.402601] 7d60: 0000ffff8f5f5000 ffff800022167eb8 0000000020000000 0000000000000015
[  142.410420] 7d80: ffff800022167da0 ffff0000082154ec ffff8000525f6c00 0000000092000046
[  142.418238] 7da0: ffff800022167dc0 ffff0000081b3944 ffff800052472200 0000000000000002
[  142.426056] 7dc0: ffff800022167e40 ffff0000081b427c ffff800052472200 0000000000000002
[  142.433875] 7de0: ffff800022167e10 ffff000008081288 ffff800022167e10 ffff0000080f0748
[  142.441694] 7e00: ffff800055035278 ffff800052472200 ffff800022167e30 ffff0000081b749c
[  142.449512] 7e20: ffff800052472200 0000000000000002 ffff800022167e40 ffff0000081b4380
[  142.457331] 7e40: ffff800022167e80 ffff0000081b4ddc ffff800052472200 ffff800052472200
[  142.465149] 7e60: 0000ffff8f5f5000 0000000000000002 0000000020000000 0000ffff8f715758
[  142.472966] 7e80: 0000000000000000 ffff000008082e30 0000000000000000 0000ffff8f5f5000
[  142.480785] 7ea0: ffffffffffffffff 0000ffff8f70d1e8 0000000000000000 0000000000000000
[  142.488603] 7ec0: 0000000000000001 0000ffff8f5f5000 0000000000000002 0000000000000000
[  142.496420] 7ee0: 0000000000000000 0000ffff8f6975c8 00000000056d82e0 fefefeff046bff62
[  142.504239] 7f00: 0000000000000040 fefffefe8dff6a6f 7f7fffffff7f7f7f 0101010101010101
[  142.512057] 7f20: 0000000000000008 0000000000000018 0000ffff8f654368 0000000000000005
[  142.519875] 7f40: 0000000000000000 0000ffff8f6b86c0 0000000000000015 0000000000000002
[  142.527693] 7f60: 0000ffff8f5f5000 0000ffff8f794500 0000000000000002 0000000000000001
[  142.535511] 7f80: 00000000004e3000 00000000004c1b38 00000000056bdcc0 0000000000000000
[  142.543328] 7fa0: 0000000000000000 0000ffffedf9e130 0000ffff8f6bf700 0000ffffedf9e130
[  142.551146] 7fc0: 0000ffff8f70d1e8 0000000020000000 0000000000000001 0000000000000040
[  142.558963] 7fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[  142.566780] Call trace:
[  142.569216] Exception stack(0xffff800022167b70 to 0xffff800022167ca0)
[  142.575644] 7b60:                                   ffff000008e5d000 0001000000000000
[  142.583462] 7b80: ffff800022167d40 ffff00000857bfbc 0000000000000007 0000000000000000
[  142.591281] 7ba0: 0000000000000000 0000000000000001 0000000000000002 ffff000008f14250
[  142.599099] 7bc0: 000000000000000f ffff000008f12250 ffff800022167c70 ffff0000080fe098
[  142.606917] 7be0: ffff0000080fe060 ffff000008d13d08 ffff000008e88ef8 0000000000000008
[  142.614734] 7c00: 0000000000000000 0000000000000015 0000000000000001 0000000000000000
[  142.622552] 7c20: ffff800022164000 0000000000000000 0000000000000000 0000000000000000
[  142.630371] 7c40: ffff000008ef1e27 0000000000000000 0000000000000030 0000000000000146
[  142.638189] 7c60: 0000000000000001 0000000000000002 0000000000000146 ffff000008e5d000
[  142.646008] 7c80: ffff000008e5d778 ffff000008ef18e8 ffff0000081b4d98 0000ffff8f6b86c0
[  142.653827] [<ffff00000857bfbc>] sysrq_handle_crash+0x14/0x20
[  142.659562] [<ffff00000857ce58>] write_sysrq_trigger+0x58/0x68
[  142.665386] [<ffff0000082154ec>] proc_reg_write+0x64/0x90
[  142.670775] [<ffff0000081b3944>] __vfs_write+0x1c/0xd0
[  142.675903] [<ffff0000081b427c>] vfs_write+0x8c/0x1a8
[  142.680944] [<ffff0000081b4ddc>] SyS_write+0x44/0xa0
[  142.685900] [<ffff000008082e30>] el0_svc_naked+0x24/0x28
[  142.691202] Code: 52800020 b90ddc20 d5033e9f d2800001 (39000020)
[  142.697287] SMP: stopping secondary CPUs
[  142.701247] Starting crashdump kernel...
[  142.705160] Bye!
