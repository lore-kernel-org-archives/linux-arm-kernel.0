From: rogerq@ti.com (Roger Quadros)
Date: Wed, 17 Aug 2016 15:05:16 +0300
Subject: [PATCH 0/1] ARM: Keystone: Fix USB Mass storage on K2E
Message-ID: <1471435517-7840-1-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

USB mass storage devices lock up on K2E or any Keystone2 system with more than
2GB RAM. Test case:

1) Plug in USB pen drive
2) mount
	udisks --mount /dev/sda1
Mounted /org/freedesktop/UDisks/devices/sda at /media/PENDRIVE

3) write to medium
	cp blobs/1M.bin /media/PENDRIVE

4) flush to medium
	sync

Things lock up here with the following message within a minute.

[  103.440996] xhci-hcd xhci-hcd.0.auto: xHCI host not responding to stop endpoint command.
[  103.449083] xhci-hcd xhci-hcd.0.auto: Assuming host is dying, halting host.
[  103.456064] xhci-hcd xhci-hcd.0.auto: HC died; cleaning up
[  103.461619] usb 1-1: USB disconnect, device number 2
[  103.511036] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00
[  103.519210] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x2a 2a 00 00 07 cf 28 00 00 f0 00
[  103.526785] blk_update_request: I/O error, dev sda, sector 511784
[  103.533093] sd 0:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x01 driverbyte=0x00
[  103.541285] sd 0:0:0:0: [sda] tag#0 CDB: opcode=0x2a 2a 00 00 07 d0 18 00 00 f0 00
[  103.548854] blk_update_request: I/O error, dev sda, sector 512024
removing file
[  103.558340] VFS: busy inodes on changed media or resized disk sda
[  103.569007] FAT-fs (sda): Directory bread(block 30640) failed
[  103.574778] FAT-fs (sda): Directory bread(block 30641) failed
[  103.580554] FAT-fs (sda): Directory bread(block 30642) failed
[  103.586361] FAT-fs (sda): Directory bread(block 30643) failed
[  103.592134] FAT-fs (sda): Directory bread(block 30644) failed
[  103.597915] FAT-fs (sda): Directory bread(block 30645) failed
[  103.604012] FAT-fs (sda): Directory bread(block 30646) failed
[  103.610197] FAT-fs (sda): Directory bread(block 30647) failed

On Keystone2, DMA can happen only in the first 2 GB of RAM.
The culprit is an incorrect dma_max_pfn() which results in bounce buffers to
be set outside the DMA'ble area in the SCSI layer in scsi_calculate_bounce_limit().
XHCI controller tries to accesses these non DMA'ble regions which causes the lock-up.
This is explained further in the patch.

cheers,
-roger

Roger Quadros (1):
  ARM: dma: fix dma_max_pfn()

 arch/arm/include/asm/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4
