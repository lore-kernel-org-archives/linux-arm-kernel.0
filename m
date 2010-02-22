From: b.hutchman@gmail.com (Brian Hutchinson)
Date: Mon, 22 Feb 2010 17:07:21 -0500
Subject: Separate/external initramfs, ATAG's, kernel panics ... Oh My!
Message-ID: <3d1967ab1002221407r1e10dff2l395b3d365ffe3a29@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I have a board with a ARM926EJS core that we have booted with a rootfs
on JFFS2 up to this point.? For performance (need some things to run
out of RAM), I've been trying to figure out how to get separate
initramfs working and have gone down several rabbit trails after
reading all I could on the u-boot and ARM list archives.

First, while reading the fine ARM boot document about ATAG's, I
realized that the u-boot (version 1.1.6) that shipped with our board
had #define CONFIG_SETUP_MEMORY_TAGS and CONFIG_INITRD_TAG commented
out.

Thinking that this was my problem ... I recompiled u-boot only to
start getting the Kernel telling me it couldn't recognize my ATAG_MEM
definitions and that INITRD: was outside physical memory.

So, I restored the original u-boot and then started passing initrd=
only to have the system hang.

Firing up OpenOCD/gdb and checking out init/initramfs.c left me even
more puzzled.? I set a breakpoint to make sure I was getting to
populate_rootfs ... and I am ... but it isn't doing anything!

Reading all the fine documentation on initramfs ...
CONFIG_BLK_DEV_INITRD=y is needed but CONFIG_BLK_DEV_RAM is not so I
don't have that set although it looks like maybe I should have it
after looking at the code.

My init/initramfs.c populate_rootfs in my 2.6.28 kernel looks like this:

static int __init populate_rootfs(void)
{
??? char *err = unpack_to_rootfs(__initramfs_start,
??? ??? ??? ?__initramfs_end - __initramfs_start, 0);
??? if (err)
??? ??? panic(err);
??? if (initrd_start) {
#ifdef CONFIG_BLK_DEV_RAM
??? ??? int fd;
??? ??? printk(KERN_INFO "checking if image is initramfs...");
??? ??? err = unpack_to_rootfs((char *)initrd_start,
??? ??? ??? initrd_end - initrd_start, 1);
??? ??? if (!err) {
??? ??? ??? printk(" it is\n");
??? ??? ??? unpack_to_rootfs((char *)initrd_start,
??? ??? ??? ??? initrd_end - initrd_start, 0);
??? ??? ??? free_initrd();
??? ??? ??? return 0;
??? ??? }
??? ??? printk("it isn't (%s); looks like an initrd\n", err);
??? ??? fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 0700);
??? ??? if (fd >= 0) {
??? ??? ??? sys_write(fd, (char *)initrd_start,
??? ??? ??? ??? ??? initrd_end - initrd_start);
??? ??? ??? sys_close(fd);
??? ??? ??? free_initrd();
??? ??? }
#else
??? ??? printk(KERN_INFO "Unpacking initramfs...");
??? ??? err = unpack_to_rootfs((char *)initrd_start,
??? ??? ??? initrd_end - initrd_start, 0);
??? ??? if (err)
??? ??? ??? panic(err);
??? ??? printk(" done\n");
??? ??? free_initrd();
#endif
??? }
??? return 0;
}

With OpenOCD, I discovered that __initramfs_end and __initramfs_start
don't appear to have anything to do with my initrd= line passed in
with bootargs.
The test of initrd_start fails because my initrd_start is zero.  I'm
not sure yet how initrd_start gets set but I did see something in a
#ifdef CONFIG_KEXEC that did something with it.  I don't have
CONFIG_KEXEC.

So at this point I guess my questions are:
1.  How do I get __initramfs_start and __initramfs_start to reflect my
initrd= bootargs argument?  Do I have to fix my ATAG's problem for
this?
2.  How does initrd_start get set?
3.  Do I need CONFIG_KEXEC?

What I've done so far is take the rootfs that was used with JFFS and
created a init->busybox soft link.  If I build the kernel with the
initramfs linked in (with CONFIG_INITRAMFS_SOURCE), the initramfs
works just fine so I know my cpio.gz is OK.  If I place the cpio.gz in
flash or tftp it to try separate initramfs ... it hangs the system.

I've tried to wrap the cpio.gz in a u-boot image with:
mkimage -A arm -O linux -T ramdisk -C gzip -a 0x200000 -e 0x200000 -n
uInitramfs_busybox -d /home/hutch/squashfs/test.cpio.gz
uInitramfs_busybox

This was used with a bootargs line in uboot of:
bootargs initrd=0x200000
ip=$ipaddr:$serverip:$gatewayip:$netmask:$hostname:$netdev:any
console=$consoledev,$baudrate $othbootargs;

Kernel is located at 0x20080000 and the cpio.gz mkimage file was
stored at 0x20280000

bootcmd in uboot was bootm 0x20080000 0x20280000

I also tried to tftp just the cpio.gz file (without the u-boot header)
to 0x200000 and then bootm 0x20080000 with a initrd=0x200000 with the
same result ... system hang because it doesn't try to do anything with
my initramfs and I didn't supply a root= so it falls back and then
panics because it can't find a filesystem.

Hopefully I've provided enough info to show I've been digging through
this but something just isn't clicking yet.  Hopefully someone with
more experience can show me the way!

Regards,

Brian
