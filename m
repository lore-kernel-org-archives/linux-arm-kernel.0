From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 23:44:32 +0000
Subject: bcm4708-smartrg-sr400ac boot failures in next/arm-soc
In-Reply-To: <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
References: <CANMBJr6LW=y7g4_CCutHf4vu5NkzoeXt_RvPSJAsTE2nFpGwqw@mail.gmail.com>
 <20160108225032.GO19062@n2100.arm.linux.org.uk>
 <CANMBJr6DR=y2oOqnEyUAxhzhXn1twXozGacOpcVRx8NcWf-mfw@mail.gmail.com>
Message-ID: <20160108234432.GQ19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 03:17:19PM -0800, Tyler Baker wrote:
> On 8 January 2016 at 14:50, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 08, 2016 at 02:33:39PM -0800, Tyler Baker wrote:
> >> After a bit of investigation, I determined that CONFIG_BLK_DEV_RAM was
> >> causing the issue and disabling it fixed the boot issue. Essentially,
> >> the kernel cannot find the initrd that has been loaded into memory by
> >> CFE bootloader with this option enabled as I inject the following
> >> command line into the DT before it's loaded over tftp.
> >>
> >> Loaded in CFE by: 'load -raw -tftp -addr=0x4000000 -max=0x900000
> >> 192.168.2.2:tmpqC9zOv/ramdisk.cpio.gz'
> >>
> >> Kernel arguments injected into DT: 'console=ttyS0,115200
> >> initrd=0x4000000,8M root=/dev/ram0 ip=dhcp'
> >
> > What is the problem that the kernel is reporting?
> 
> The kernel complaining that there is no file system to mount, and
> panics. Here is a plain text version of the issue if you want to have
> a look[1].

Thanks.

The error is:

[   16.557922] RAMDISK: EOF while reading compressed data

which is not surprising given:

initrd=0x4000000,8M

is given on the kernel command line, but:

Loader:raw Filesys:tftp Dev:eth0 File:192.168.2.2:tmpd9L7xr/ramdisk.cpio.gz Options:(null)
... 8450989 bytes read

the actual ramdisk is larger than 8M.  8M would've been 8388608 bytes,
but you're about 64k over that.

Hence, the decompression into /dev/ram0 fails when BLK_DEV_RAM is
enabled (that decompressor strictly follows the initrd limit), which
then goes on to cause the failure to mount the rootfs.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
