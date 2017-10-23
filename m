From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Mon, 23 Oct 2017 05:37:02 +0000
Subject: kdump: need help with kexec -p
In-Reply-To: <HE1PR04MB12415392027297293D5FC07E97480@HE1PR04MB1241.eurprd04.prod.outlook.com>
References: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59DF54B3.1050404@arm.com>
 <HE1PR04MB124165F8510E983992B11EC797480@HE1PR04MB1241.eurprd04.prod.outlook.com>
 <59E095E1.5090706@arm.com>
 <HE1PR04MB12415392027297293D5FC07E97480@HE1PR04MB1241.eurprd04.prod.outlook.com>
Message-ID: <HE1PR04MB12413AEF2BF54623027FD22A97460@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,


> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Prabhakar Kushwaha
> Sent: Friday, October 13, 2017 4:54 PM
> To: James Morse <james.morse@arm.com>; takahiro.akashi at linaro.org
> Cc: Poonam Aggrwal <poonam.aggrwal@nxp.com>; Scott Wood
> <oss@buserror.net>; Abhimanyu Saini <abhimanyu.saini@nxp.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: kdump: need help with kexec -p
> 
> 
> > -----Original Message-----
> > From: James Morse [mailto:james.morse at arm.com]
> > Sent: Friday, October 13, 2017 4:01 PM
> > To: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>;
> > takahiro.akashi at linaro.org
> > Cc: linux-arm-kernel at lists.infradead.org; Poonam Aggrwal
> > <poonam.aggrwal@nxp.com>; Scott Wood <oss@buserror.net>; Abhimanyu
> > Saini <abhimanyu.saini@nxp.com>
> > Subject: Re: kdump: need help with kexec -p
> >
> > Hi Prabhakar,
> >
> > On 13/10/17 10:41, Prabhakar Kushwaha wrote:
> > >> On 11/10/17 10:11, Prabhakar Kushwaha wrote:
> > >>> We are facing some issues while using  kexec -p on ARM64 NXP platforms.
> > >>>
> > >>> 1) After calling kexec -p, if immediately "panic" is triggered the crash kernel
> > >>> does not boot. If we run few commands and wait for atleast (20-30 secs),
> > >> before
> > >>> triggering the panic, the crash kernel boots.
> > >>
> > >> What kernel version do you see this on?
> > > linux-linaro-lsk-v4.4  (f3b1dec5e8f2b4d17442a79bcb1f15953056519d)
> > >
> > >> Can you log the kernel output in each
> > >> case, (do you get a 'bye' message even when the new kernel doesn't boot).
> >
> > > Yes I get 'bye' message in all cases.
> >
> > Okay, so this means you get out of the old kernel. No further output means its
> > stuck either in purgatory or the new kernel before we manage to output
> > anything.
> >
> > Are you using earlycon?
> 
> Yes, we are using earlycon
> 
> Bootargs for kexec:  kexec_pk -p ./Image_lsk --append="console=ttyS0,115200
> root=/dev/ram0 earlycon=uart8250,mmio,0x21c0500 maxcpus=1" --initrd="./fsl-
> image-core-ls1043ardb.ext2.gz"
> 
> 
> >
> >
> > >>> 2) We do not see the issue ("1" ), when we do umount -a, before calling the
> > >> panic
> > >>> after kexec-p.
> > >>
> > >> What filesystems (ext4, nfs etc) do you have mounted, and which ones does
> > >> 'umount -a' get rid of?
> >
> > My theory here was that some writeback thread was causing kdump to block..
> >
> >
> > > root at ls1043ardb:~# mkdir temp; mount -t ext4 /dev/mmcblk0p3 temp/
> > > [   27.786681] EXT4-fs (mmcblk0p3): mounted filesystem with ordered data
> > mode. Opts: (null)
> > > root at ls1043ardb:~# cat /proc/mounts
> > > /dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
> > > devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
> > > proc /proc proc rw,relatime 0 0
> > > sysfs /sys sysfs rw,relatime 0 0
> > > debugfs /sys/kernel/debug debugfs rw,relatime 0 0
> > > devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
> > > /dev/mmcblk0p3 /home/root/temp ext4 rw,relatime,data=ordered 0 0
> > >
> > > root at ls1043ardb:~# umount -a
> > > umount: /dev: target is busy
> > >         (In some cases useful info about processes that
> > >          use the device is found by lsof(8) or fuser(1).)
> > > umount: /: target is busy
> > >         (In some cases useful info about processes that
> > >          use the device is found by lsof(8) or fuser(1).)
> > >
> > > root at ls1043ardb:~# cat /proc/mounts
> > > /dev/root / ext4 rw,relatime,block_validity,delalloc,barrier,user_xattr,acl 0 0
> > > devtmpfs /dev devtmpfs rw,relatime,mode=0755 0 0
> > > proc /proc proc rw,relatime 0 0
> > > sysfs /sys sysfs rw,relatime 0 0
> > > devpts /dev/pts devpts rw,relatime,gid=5,mode=620,ptmxmode=000 0 0
> > > root at ls1043ardb:~#
> > >
> > >
> > >> Where are these filesystems stored?
> > >>
> > >
> > > We are using ramdisk.
> > >
> > > Bootargs: ttyS0,115200 root=/dev/ram0
> earlycon=uart8250,mmio,0x21c0500
> > crashkernel=512M loglevel=8 ramdisk_size=0x20000000
> >
> > Okay, so in your (1) doesn't-boot case the mmc driver is still in use, and may
> > have dirty data to write back.
> >
> > This fits with your 'wait 20 seconds and it works'. (you can check this theroy
> > by increasing /proc/sys/vm/dirty_writeback_centisecs to something more than
> > 20seconds should break this).
> >
> 
> It was already 3000 centisecs. We increased to 6000 but still no success.
> 
> 
> > Your case (2), after 'umount -a' your mmc driver is no longer in use, any dirty
> > data will have been written back. This case works.
> >
> > (Is it the driver or the data causing the problem? You could try 'mount -o
> > remount,ro' on the mmc filesystems)
> >
> 
> No  success with this.
> 
> We tried below command also, but no luck. "Logs" are at bottom of mail.
> mount -t ext4 -o ro /dev/mmcblk0p3 temp/
> 
> 

After further analysis, it is figured out to be a data cache flush issue.   

After trying below patch(suggested by Takahiro). This problem looks to be resolved for now. 

===
commit 9b492cf58077
Author: Xunlei Pang <xlpang@redhat.com>
Date:   Mon May 23 16:24:10 2016 -0700

    kexec: introduce a protection mechanism for the crashkernel reserved memory
===

--prabhakar
