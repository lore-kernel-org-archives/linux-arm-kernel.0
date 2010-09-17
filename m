From: ecc@cmu.edu (Eric Cooper)
Date: Thu, 16 Sep 2010 20:03:21 -0400
Subject: [PATCH v2] support for Seagate DockStar
In-Reply-To: <4C926B65.2010606@googlemail.com>
References: <4C926B65.2010606@googlemail.com>
Message-ID: <20100917000321.GB26621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 09:09:25PM +0200, Marcus Osdoba wrote:
> Regarding the mtd-partitions,
> your patch does not reflect the original layout of the 256MiB flash.
> 
> The original layout is:
> 0x00100000 "U-Boot"     1MiB
> 0x00400000 "uImage"     4MiB
> 0x02000000 "root"       32MiB
> 0x0db00000 "data"       219MiB
> 
> The patchv2 subsumes the last two "partitions".
> Was this done with intention?

It was intentional, but I wouldn't mind getting some feedback on the
decision.  And this may all be moot since the partition scheme can be
set on the kernel command line with mtdparts=... anyway.

The original system from Cloud Engines uses the layout you describe
above.  I found that also to be useful for running OpenWrt on the
device -- the "root" partition can be used for a read-only rootfs, and
the "data" partition as a writable overlay on top of the rootfs.

I now actually prefer to use just 2 partitions -- 1MB for u-boot, and
255MB for a ubifs root, with the uImage as just a regular file in
/boot.  But this only works when the factory u-boot is replaced with a
newer one that can read files from ubifs.

So I felt the three-partition scheme struck a balance -- it would
allow one to set up a standard kernel in the uImage partition and a ubifs
root filesystem in the remaining space, without having to re-flash the
u-boot partition.

-- 
Eric Cooper             e c c @ c m u . e d u
