From: kilobyte@angband.pl (Adam Borowski)
Date: Mon, 10 Apr 2017 03:13:15 +0200
Subject: [PATCH] btrfs: scrub: use do_div() for 64-by-32 division
In-Reply-To: <20170409035854.7swkcndswifd622w@angband.pl>
References: <CAOMZO5B9J15qvrsjOb-e5gk47gA=+2p2yLNLhswG+H3S0L7LXg@mail.gmail.com>
 <20170408210737.5456-1-kilobyte@angband.pl>
 <20170409035854.7swkcndswifd622w@angband.pl>
Message-ID: <20170410011315.65rk2csei3ffh32g@angband.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 09, 2017 at 05:58:54AM +0200, Adam Borowski wrote:
> On Sat, Apr 08, 2017 at 11:07:37PM +0200, Adam Borowski wrote:
> > Unbreaks ARM and possibly other 32-bit architectures.
> 
> Turns out those "other 32-bit architectures" happen to include i386.
> 
> A modular build:
> ERROR: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> With the patch, i386 builds fine.
> 
> > Tested on amd64 where all is fine, and on arm (Odroid-U2) where scrub
> > sometimes works, but, like most operations, randomly dies with some badness
> > that doesn't look related: io_schedule, kunmap_high.  That badness wasn't
> > there in 4.11-rc5, needs investigating, but since it's not connected to our
> > issue at hand, I consider this patch sort-of tested.
> 
> Looks like current -next is pretty broken: while amd64 is ok, on an i386 box
> (non-NX Pentium 4) it hangs very early during boot, way before filesystem
> modules would be loaded.  Qemu boots but has random hangs.

A non-modular i386_defconfig + btrfs of -next is ok; whatever the problem
is, it's not relevant to our division build failure in scrub.

But, it looks like parity scrub is ${EXPLETIVE}ed on 32-bit.  Not just on
-next, also on 4.11-rc5 and 4.9.  Test script I used is attached, although
it's enough to just scrub a kosher filesystem without even damaging it.
On 64-bit it mostly works, but still warns about bogus unrecoverable errors
when in fact it succeeded.

Thus, I'd recommend:
* applying this patch to at least make it compile
* taking steps to warn outside people about RAID5/6

Let's discuss the rest in another thread, it's no longer interesting to ARM
people, they just want no build failures.

-- 
??????? Meow!
???????
??????? Collisions shmolisions, let's see them find a collision or second
??????? preimage for double rot13!
-------------- next part --------------
#!/bin/sh
set -x
DATA=/usr/bin  # use whole /usr on non-bloated VMs


mkdir -p /mnt/vol1
umount /mnt/vol1; losetup -D   # clean up after repeats

dd if=/dev/zero bs=1048576 count=1 seek=4095 of=ra
dd if=/dev/zero bs=1048576 count=1 seek=4095 of=rb
dd if=/dev/zero bs=1048576 count=1 seek=4095 of=rc
dd if=/dev/zero bs=1048576 count=1 seek=4095 of=rd

mkfs.btrfs -draid10 -mraid1 ra rb rc rd

losetup -D
losetup -f ra
losetup -f rb
losetup -f rc
losetup -f rd
sleep 2  # race with fsid detection
mount -onoatime /dev/loop0 /mnt/vol1 || exit $?
cp -pr "$DATA" /mnt/vol1
btrfs fi sync /mnt/vol1
btrfs fi us /mnt/vol1

btrfs balance start -dconvert=raid5 -mconvert=raid6 /mnt/vol1

btrfs scrub start -B /mnt/vol1
btrfs scrub start -B /mnt/vol1

umount /mnt/vol1
dd if=/dev/urandom of=rd bs=1048576 seek=96 count=4000
mount -onoatime /dev/loop0 /mnt/vol1 || exit $?
btrfs scrub start -B /mnt/vol1
btrfs scrub start -B /mnt/vol1

btrfs balance start -dconvert=raid10 -mconvert=raid1 /mnt/vol1

btrfs scrub start -B /mnt/vol1
btrfs scrub start -B /mnt/vol1

umount /mnt/vol1
dd if=/dev/urandom of=rd bs=1048576 seek=96 count=4000
mount -onoatime /dev/loop0 /mnt/vol1 || exit $?
btrfs scrub start -B /mnt/vol1
btrfs scrub start -B /mnt/vol1

diff -urd --no-dereference "$DATA" /mnt/vol1/*

umount /mnt/vol1
