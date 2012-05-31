From: thiago.bauermann@gmail.com (Thiago Jung Bauermann)
Date: Wed, 30 May 2012 23:24:07 -0300
Subject: Kernel 3.4 error on Dreamplug: [vectors]: mlock failed: Cannot
 allocate memory
In-Reply-To: <20120531005109.GW24238@titan.lakedaemon.net>
References: <1338401183.22894.11.camel@hactar>
 <20120531005109.GW24238@titan.lakedaemon.net>
Message-ID: <1338431047.1822.11.camel@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-30 at 20:51 -0400, Jason Cooper wrote:
> On Wed, May 30, 2012 at 03:06:23PM -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > I have just upgraded my Dreamplug to the 3.4 kernel, and when creating
> > an LVM snapshot volume, I see errors for which I didn't find any report
> > yet:
> > 
> > # lvcreate -s -L 80M -n root-fsck-snapshot marv2-vg/root
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
> >   Logical volume "root-fsck-snapshot" created
> > 
> > # lvremove -f marv2-vg/root-fsck-snapshot
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: mlock failed: Cannot allocate memory
> >   ffff0000-ffff1000 r-xp 00000000 00:00 0          [vectors]: munlock failed: Cannot allocate memory
> >   Logical volume "root-fsck-snapshot" successfully removed
> > 
> > This is on the following kernel:
> > 
> > Linux marv 3.4.0-1bauer2-kirkwood #1 Wed May 30 01:31:47 BRT 2012 armv5tel GNU/Linux
> 
> Is this a vanilla v3.4 kernel?  Is this a repeatable error, even after
> hard reboot?

Yes, the error happens every time even after rebooting or powering off
the machine and then on again after a minute.

The kernel is almost vanilla... I'm using the patches here on top of the
vanilla kernel:

https://github.com/bauermann/dreamplug/tree/master/with-linux-3.4

There's not much really. One patch (dreamplug-3.4.0.patch) adapts the
kernel to use the Guruplug machine id and adapts the kernel to boot
without a flattened device tree (I'm using Marvell's original u-boot,
with the old id and no device tree support), three of them (mvsdio-*)
add magic delays to the SD card driver and three others add the
libertas_uap wireless driver (which I'm not using and the modules aren't
even loaded).

The phys-virt.diff one may be of interest. It sets PHYS_OFFSET to 0x0.
Also, I have CONFIG_EMBEDDED=y but I disabled
CONFIG_ARM_PATCH_PHYS_VIRT. This is because of some forum posts saying
that ARM_PATCH_PHYS_VIRT yelds an unbootable kernel. I didn't test if
that was indeed the case though.


-- 
[]'s
Thiago Jung Bauermann
