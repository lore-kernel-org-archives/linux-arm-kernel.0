From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Fri, 13 Oct 2017 09:41:37 +0000
Subject: kdump: need help with kexec -p
In-Reply-To: <59DF54B3.1050404@arm.com>
References: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59DF54B3.1050404@arm.com>
Message-ID: <HE1PR04MB124165F8510E983992B11EC797480@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: James Morse [mailto:james.morse at arm.com]
> Sent: Thursday, October 12, 2017 5:11 PM
> To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>;
> takahiro.akashi at linaro.org
> Cc: linux-arm-kernel at lists.infradead.org; Poonam Aggrwal
> <poonam.aggrwal@nxp.com>; Scott Wood <oss@buserror.net>; Abhimanyu
> Saini <abhimanyu.saini@nxp.com>
> Subject: Re: kdump: need help with kexec -p
> 
> Hi Prabhakar,
> 
> (+CC: Akashi Takahiro, who wrote the arm64 kdump support)
> 
> On 11/10/17 10:11, Prabhakar Kushwaha wrote:
> > We are facing some issues while using  kexec -p on ARM64 NXP platforms.
> >
> > 1) After calling kexec -p, if immediately "panic" is triggered the crash kernel
> > does not boot. If we run few commands and wait for atleast (20-30 secs),
> before
> > triggering the panic, the crash kernel boots.
> 
> What kernel version do you see this on? 
linux-linaro-lsk-v4.4  (f3b1dec5e8f2b4d17442a79bcb1f15953056519d)

> Can you log the kernel output in each
> case, (do you get a 'bye' message even when the new kernel doesn't boot).
> 
Yes I get 'bye' message in all cases. 

> Does 'kexec -p' report success in both cases? ($? == 0)
> 
> 

Unfortunately this command not support in my root file system.

I always gets prompt. So I assume kexec runs successfully. 

> kdump can take many seconds in purgatory, it checksums the kdump image to
> check
> it didn't get corrupted between 'kexec -p' and crash time, but it doesn't sound
> like this is what you're seeing.
> 
> 

Yes, this is correct understanding

> > 2) We do not see the issue ("1" ), when we do umount -a, before calling the
> panic
> > after kexec-p.
> 
> What filesystems (ext4, nfs etc) do you have mounted, and which ones does
> 'umount -a' get rid of?

root at ls1043ardb:~# mkdir temp; mount -t ext4 /dev/mmcblk0p3 temp/
[   27.786681] EXT4-fs (mmcblk0p3): mounted filesystem with ordered data mode. Opts: (null)
root at ls1043ardb:~# cat /proc/mounts
/dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
proc /proc proc rw,relatime 0 0
sysfs /sys sysfs rw,relatime 0 0
debugfs /sys/kernel/debug debugfs rw,relatime 0 0
devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
/dev/mmcblk0p3 /home/root/temp ext4 rw,relatime,data=ordered 0 0

root at ls1043ardb:~# umount -a
umount: /dev: target is busy
        (In some cases useful info about processes that
         use the device is found by lsof(8) or fuser(1).)
umount: /: target is busy
        (In some cases useful info about processes that
         use the device is found by lsof(8) or fuser(1).)

root at ls1043ardb:~# cat /proc/mounts
/dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
proc /proc proc rw,relatime 0 0
sysfs /sys sysfs rw,relatime 0 0
devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
root at ls1043ardb:~#


> Where are these filesystems stored?
> 

We are using ramdisk.

Bootargs: ttyS0,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 crashkernel=512M loglevel=8 ramdisk_size=0x20000000

> How many CPUs does your platform have?
> 

4

> (...does crashing on a different CPU change the behaviour?)
> > taskset -c 1 bash -c "echo c > /proc/sysrq-trigger"
> 

I tired taskset -c 1 bash -c "echo c > /proc/sysrq-trigger" and taskset -c 2 bash -c "echo c > /proc/sysrq-trigger".
Both worked i.e. crash kernel boot. 

One strange observation: Very first time crash kernel never boot. If you restart and try again.. it start working. 
I tried 3 iteration.   1/3 --> failed for both core 1 and core 2.    Subsequent restart and try always worked. 

Not able to correlate with anything. 

> 
> > The issue does not seem to pertain to the NXP software it seems.   (because
> this
> > observation has been observed on very simple kernel, where most of the
> > controllers have been removed from device tree).
> 
> > Also found some info related to this on  internet where it is mentioned that
> > without un-mounting the mounted filesystems, the boot of next kernel is not
> > recommended. (this is in context of kexec -e though)
> > https://www.linux.com/news/reboot-racecar-kexec.
> 
> This is because the filesystem is marked as mounted on-disk, and there may be
> vital data you've written but hasn't made it to the disk yet.
> 
> For 'kexec -e' I think it tries to shutdown and reboot, then jumps to the new
> kernel instead of calling the firmware. This means all filesystems should be
> sync()d, umounted or at least remounted read-only.

Ok. understood

> 
> For kdump, we've already crashed, so you've already lost data. Its a best effort
> can we get to a point where you can debug the original crash.
> 

Looks like umount  -a is not mandatory for kexec -p


Further observation 
---------------------------
** On upstream the dump capture boots (the issue is not observed) **
Default config + enabled RAM Block Device
The commit details as below:
commit 569dbb88e80deb68974ef6fdd6a13edb9d686261
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Sep 3 13:56:17 2017 -0700

    Linux 4.13

commit 5e3b19d8165c2af2afee313c9b40eee55cf27a55
Merge: d0fa6ea 2c0e838
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Sep 3 09:50:26 2017 -0700

    Merge branch 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus
    
    Pull MIPS fixes from Ralf Baechle:
     "The two indirect syscall fixes have sat in linux-next for a few days.
      I did check back with a hardware designer to ensure a SYNC is really
      what's required for the GIC fix and so the GIC fix didn't make it into
      to linux-next in time for this final pull request.
    
      It builds in local build tests and passes Imagination's test system"
    
    * 'upstream' of git://git.linux-mips.org/pub/scm/ralf/upstream-linus:
      irqchip: mips-gic: SYNC after enabling GIC region
      MIPS: Remove pt_regs adjustments in indirect syscall handler
      MIPS: seccomp: Fix indirect syscall args


** On 4.4 LSK: (default defconfig + enabled RAM Block Device); issue is observed **
 commit f3b1dec5e8f2b4d17442a79bcb1f15953056519d
 Merge: f5ca0eb 09e6960
 Author: Alex Shi <alex.shi@linaro.org>
 Date:   Mon Aug 7 12:02:09 2017 +0800
 
      Merge tag 'v4.4.80' into linux-linaro-lsk-v4.4
    
      This is the 4.4.80 stable release

--prabhakar
