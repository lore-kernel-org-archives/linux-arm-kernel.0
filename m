From: tpiepho@kymetacorp.com (Trent Piepho)
Date: Tue, 3 May 2016 19:17:34 +0000
Subject: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
In-Reply-To: <20160430104832.GJ19428@n2100.arm.linux.org.uk>
References: <20160429195741.GY19428@n2100.arm.linux.org.uk>
 <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
 <20160429211328.GZ19428@n2100.arm.linux.org.uk>
 <CAD=FV=V8BOsO36eUOGAcXp04xCiN13UGG0Vaf2yhh1MQn85FjA@mail.gmail.com>
 <20160429212920.GA19428@n2100.arm.linux.org.uk>
 <CAD=FV=V9V8P=d59RX1eaAdVxJgMxub1F6hzQNw1QW+7t=3POBw@mail.gmail.com>
 <20160429215017.GC19428@n2100.arm.linux.org.uk>
 <CAD=FV=VgQX_EVhUUCugzv+CZqjzTS8LwyeU5419aX9FbDnWJDg@mail.gmail.com>
 <20160429221606.GE19428@n2100.arm.linux.org.uk>
 <CABxcv==4C+RrEV1Fd+DkbMdGrLyObw36vsmo3wTGdxO=UnAa8w@mail.gmail.com>
 <20160430104832.GJ19428@n2100.arm.linux.org.uk>
Message-ID: <1462303111.9103.225.camel@rtred1test09.kymeta.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2016-04-30 at 11:48 +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2016 at 06:42:35PM -0400, Javier Martinez Canillas wrote:
> > Maybe a third opinion could make this conversation constructive again.

And maybe a forth.

> > I think Doug's point is that using a UUID or labels for consistency is
> > orthogonal to having a deterministic numbering for MMC devices. And I
> > agree with his point of view for what is worth.
> 
> Yes, it may be orthogonal, but there are two issues here:
> 
> 1. How does the system know which MMC device to mount for its rootfs.
> 
> This is the point that I've picked up on, which has been solved for
> years, and actually pre-dates MMC support in the kernel, and that is
> mount by UUID.

What about eMMC boot blocks and replay protected memory block?  These
are special sub-device like features of eMMC that provide storage from
different areas than the normal flash.  The kernel names them something
like "/dev/mmcblk0boot0" and "/dev/mmcblk1rpmb".

They typically don't have partition tables and in fact the kernel
xplicitly does not scan them for a partition table.  So how can they
have a UUID?

Suppose your device has two SD slots, neither with an SD card inserted
in it, one external and one internal behind a locked access panel.  They
serve different purposes.  How do you determine which is which via UUID
when they have no media?

> The kernel itself has no support for mount-by-label, which is normally
> solved by using an initramfs, which contains programs such as mount
> etc which will scan the block devices looking for an appropriately
> labelled filesystem.  Label has slightly more issues since its possible

But what is faster, using an initramfs that loads a working userspace
into RAM, scans the flash device for partition labels, determines the
device ID, and then switches to the real rootfs.  Or having the
bootloader, which already knows the partition the rootfs is in, tell the
kernel what device to mount from the beginning?

Which brings me to another reason for providing device enumeration
information via the device tree that isn't just about mounting the root
filesystem.

The bootloader will create an enumeration of devices so that it can
access them.  The kernel will also create an enumeration of the same
devices.  Should these enumerations be the same, or should they be
different?

Clearly there are advantages to the enumeration being the same.  It's
easier on users if device IDs can be the same between the two
environments, bootloader and kernel, the device can be accessed from.

It also makes it easier if information about a device needs to be passed
from the bootloader to the kernel.  This could be the root filesystem,
but that's not the only thing.  Console serial port is another.  But we
could also want to kernel to know which of the SoC's ports is connected
to the blank eMMC chip it should create a partition table on and format,
and which is connected to the SD card it should store logging data to.

I can't think of any advantage of the enumerations being different.

So if identical enumerations are desirable, how to achieve it?

One way would be to have the bootloader create its enumeration and then
throw it away when the kernel boots.  The the kernel creates a new
enumeration from scratch, using a different system with different code
and a different design, that happens to create the same enumeration that
the bootloader did.  This seems like a bad design to me.  Two different
code bases will need to kept in sync, to always to the same thing in a
different way.  It will be hard to avoid bugs from corner cases that
fail to produce the same enumerations.

Another way would be to have the bootloader tell the kernel what it
enumerated and then have the kernel use this enumeration.  This avoids
the need to keep two code bases in sync.  It avoids bugs where they fail
to produce the same enumeration.

And how to do this pass the enumeration from the bootloader to the
kernel?  The same way all other information from the bootloader is
passed to the kernel, via the device tree.

The alias system that already exists allows the bootloader to tell the
kernel about enumerations it has already created, which it must do since
it runs before the kernel, and would like the kernel to continue to use.

So this isn't just about finding the root filesystem.  It's about
passing enumeration information from the bootloader to the kernel.
