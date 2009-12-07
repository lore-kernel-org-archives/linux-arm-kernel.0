From: jbe@pengutronix.de (Juergen Beisert)
Date: Mon, 7 Dec 2009 19:07:53 +0100
Subject: Strange jffs2 behaviour
In-Reply-To: <200912041729.55259.jbe@pengutronix.de>
References: <200912041729.55259.jbe@pengutronix.de>
Message-ID: <200912071907.53507.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Freitag, 4. Dezember 2009, Juergen Beisert wrote:
> Hi,
>
> I'm using a 2.6.31.6 kernel here to work on an S3C2410 based CPU card and
> three partitions in my 32 MiB NAND flash. Flash can be programmed by the
> boot loader (root filesystem in one partition) or erased (the other two
> partitions are currently empty).
>
> System comes up with the root filesystem in the first partition and mounts
> the other two partitions from some init scripts.
>
> $ mount
> rootfs on / type rootfs (rw)
> /dev/root on / type jffs2 (rw,relatime)
> [...]
> /dev/mtdblock3 on /mnt/applicat type jffs2 (rw,noatime)
> /dev/mtdblock4 on /mnt/data type jffs2 (rw,noatime)
>
> $ df
> /dev/root                12416     12072       344  97% /
> [...]
> /dev/mtdblock3            8192       436      7756   5% /mnt/applicat
> /dev/mtdblock4           10240       480      9760   5% /mnt/data
>
> (the 5% in /dev/mtdblock3+4 are my sample files, to check if writing files
> is working)
>
> I can copy data from the root filesystem partition to the other two
> partitions, run a "sync" and reboot and all the files are still present.
>
> But when I simply unmount one of the two other partitions, I get:
>
> JFFS2 notice: (417) jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in
> node header at 0x1be9e0. JFFS2 warning: (417) jffs2_do_read_inode_internal:
> no data nodes found for ino #170 iget() failed for ino #170
> JFFS2 warning: (417) jffs2_get_inode_nodes: Eep. No valid nodes for ino
> #170. JFFS2 warning: (417) jffs2_do_read_inode_internal: no data nodes
> found for ino #170
>
> And nothing else is working any more. E.g. any further access to any other
> partition ends with something like this:
>
> JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in
> node header at 0x1be8d8. JFFS2 warning: (428) jffs2_do_read_inode_internal:
> no data nodes found for ino #168 iget() failed for ino #168
> JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in
> node header at 0x1b4dd4. JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong
> magic bitmask 0x0000 in node header at 0x1b4774. JFFS2 notice: (428)
> jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in node header at
> 0x1b4000. JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong magic bitmask
> 0x0000 in node header at 0x1b3704. JFFS2 notice: (428)
> jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in node header at
> 0x1b300c. [...]
> JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in
> node header at 0x1a18c8. JFFS2 notice: (428) jffs2_get_inode_nodes: Wrong
> magic bitmask 0x0000 in node header at 0x1a108c. JFFS2 notice: (428)
> jffs2_get_inode_nodes: Wrong magic bitmask 0x0000 in node header at
> 0x1a08e0. JFFS2 warning: (428) jffs2_do_read_inode_internal: no data nodes
> found for ino #164 Erase at 0x001a4000 failed immediately: errno -5
>
> Any idea what can be wrong here?

For the records: The S3C2410 NFC driver disables the clock for the NFC unit 
when the NAND is IDLE and "MTD_NAND_S3C2410_CLKSTOP=y". And if one unmounts a 
NAND partition it seems to disable the clock for ever. So, all further 
accesses to the NAND device are failing...

With "MTD_NAND_S3C2410_CLKSTOP=n" the system works as expected (also on 
2.6.32).

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
