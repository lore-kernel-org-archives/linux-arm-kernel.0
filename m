From: ynvich@gmail.com (Sergei Ianovich)
Date: Tue, 10 Dec 2013 14:25:12 +0400
Subject: [PATCH 08/20] mmc: host: pxamci: switch over to dmaengine use
In-Reply-To: <1386667657-26355-1-git-send-email-ynvich@gmail.com>
References: <1375889649-14638-9-git-send-email-zonque>
 <1386667657-26355-1-git-send-email-ynvich@gmail.com>
Message-ID: <1386671112.7152.219.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 13:27 +0400, Sergei Ianovich wrote:
> The device works in general, but it is slower than with the old DMA
> and it reports sporadic failures like that

This took 40 minutes on my ARM device:
--->8---
# fsck.ext3 -cvf /dev/mmcblk0p1 
e2fsck 1.42.5 (29-Jul-2012)
Checking for bad blocks (read-only test): done                                                 
/dev/mmcblk0p1: Updating bad block inode.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/mmcblk0p1: ***** FILE SYSTEM WAS MODIFIED *****
/dev/mmcblk0p1: ***** REBOOT LINUX *****

        8649 inodes used (3.56%, out of 242880)
           7 non-contiguous files (0.1%)
           7 non-contiguous directories (0.1%)
             # of inodes with ind/dind/tind blocks: 540/3/0
       91255 blocks used (9.40%, out of 970752)
           0 bad blocks
           1 large file

        6502 regular files
         860 directories
           0 character device files
           0 block device files
           1 fifo
           0 links
        1277 symbolic links (1277 fast symbolic links)
           0 sockets
------------
        8640 files
--->8---

The same card immediately after on my x86_64 PC, in 2 minutes:
--->8---
$ sudo fsck -cfv /dev/mmcblk0p1
fsck from util-linux 2.20.1
e2fsck 1.42.8 (20-Jun-2013)
Checking for bad blocks (read-only test):
done                                                 
/dev/mmcblk0p1: Updating bad block inode.
Pass 1: Checking inodes, blocks, and sizes
Inodes that were part of a corrupted orphan linked list found.  Fix<y>?
yes
Inode 24388 was part of the orphaned inode list.  FIXED.
Inode 24511 was part of the orphaned inode list.  FIXED.
Inode 24727 was part of the orphaned inode list.  FIXED.
Inode 32410 was part of the orphaned inode list.  FIXED.
Inode 32413 was part of the orphaned inode list.  FIXED.
Inode 57554 was part of the orphaned inode list.  FIXED.
Inode 57680 was part of the orphaned inode list.  FIXED.
Inode 57681 was part of the orphaned inode list.  FIXED.
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/mmcblk0p1: ***** FILE SYSTEM WAS MODIFIED *****

        8649 inodes used (3.56%, out of 242880)
           7 non-contiguous files (0.1%)
           7 non-contiguous directories (0.1%)
             # of inodes with ind/dind/tind blocks: 540/3/0
       91255 blocks used (9.40%, out of 970752)
           0 bad blocks
           1 large file

        6502 regular files
         860 directories
           0 character device files
           0 block device files
           1 fifo
           0 links
        1277 symbolic links (1277 fast symbolic links)
           0 sockets
------------
        8640 files
--->8---

The same command with old DMA driver took 23 minutes. There was no DMA
errors.

When retested the card on PC, there was:
Inodes that were part of a corrupted orphan linked list found.  Fix<y>? yes
Inode 57554 was part of the orphaned inode list.  FIXED.

The card was mounted as readonly rootfs while fsck run on ARM, so there
may be some background noise.

Conclusions:
1. The card itself is fine.

2. There are issues with new DMA driver. I am ready to test patches,
without questions.

3. There are issues with the MMC stack in my ARM device. Please drop a
pointer where to start digging.
