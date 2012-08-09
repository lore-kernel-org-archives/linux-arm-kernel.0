From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 09 Aug 2012 08:47:57 +0100
Subject: dreamplug spi partitions
Message-ID: <1344498477.11783.38.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've been using "fw_printenv" and "fw_setenv" from the u-boot-tools
package on my DreamPlug which work fine with this /etc/fw_env.config:
        # Configuration file for fw_(printenv/saveenv) utility.
        # Up to two entries are valid, in this case the redundant
        # environment sector is assumed present.
        # MTD device name       Device offset   Env. size       Flash sector size
        /dev/mtd1               0x00000000      0x00001000      0x00001000
        
This corresponds roughly, but not exactly, with:
        # cat /proc/mtd 
        dev:    size   erasesize  name
        mtd0: 00080000 00001000 "u-boot"
        mtd1: 00010000 00001000 "u-boot env"
        mtd2: 00010000 00001000 "dtb"

But notice how "Env. size" and mtd1's size don't match -- if I use
0x10000 in fw_env.cfg then the tools don't work (checksums don't match).

This map appears to be hardcoded in u-boot & the kernel, u-boot has:
        #define CONFIG_ENV_SECT_SIZE            0x10000 /* 64k */
        #define CONFIG_ENV_SIZE                 0x1000  /* 4k */
        #define CONFIG_ENV_ADDR                 0x100000
        #define CONFIG_ENV_OFFSET               0x100000 /* env starts here */
        
(this is upstream u-boot, I've not checked the one shipped by the
factory)

The kernel has:
        struct mtd_partition dreamplug_partitions[] = {
                {
                        .name   = "u-boot",
                        .size   = SZ_512K,
                        .offset = 0,
                },
                {
                        .name   = "u-boot env",
                        .size   = SZ_64K,
                        .offset = SZ_512K + SZ_512K,
                },
                {
                        .name   = "dtb",
                        .size   = SZ_64K,
                        .offset = SZ_512K + SZ_512K + SZ_512K,
                },
        };

However u-boot has a comment next to CONFIG_ENV_SIZE about rounding the
size to a sector which "sf probe" under u-boot reports as being 64K
(consistent with CONFIG_ENV_SECT_SIZE). However /proc/mtd reports it as
4K. So I'm totally confused about who is wrong, other than the fact that
using the u-boot numbers in /etc/fw_env.config works...

Even then I'm not sure what the rest of the layout should look like. The
kernel's partitioning scheme seems to leave an awful lot of holes and
the dtb partition seems to be entirely a kernel thing.

I'd be happy to make a patch, I just have no idea what I would write in
it ;-)

Cheers,
Ian.
-- 
Ian Campbell


When some people discover the truth, they just can't understand why
everybody isn't eager to hear it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120809/d6f1314d/attachment-0001.sig>
