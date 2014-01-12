From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 12 Jan 2014 22:36:56 +0100
Subject: [BUG] FL1009: xHCI host not responding to stop endpoint command.
References: <87eh4dot61.fsf@natisbad.org>
Message-ID: <87sissopaf.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

arno at natisbad.org (Arnaud Ebalard) writes:

> Both with a LaCie 2.5" USB 3.0 Rugged Mini disk (powered by the port)
> and a 3.5" SATA disk connected via an ICY DOCK MB981U3S-1S dock station
> (external power), I can transfer huge files w/o issue but I get the
> following when transferring small files (e.g. copy of some debian
> directory to a folder on the disk):
>
> # cp -rf /lib/ /bin/ /sbin/ /opt /var/ /usr/ test/
> [  327.130045] xhci_hcd 0000:02:00.0: xHCI host not responding to stop endpoint command.
> [  327.137899] xhci_hcd 0000:02:00.0: Assuming host is dying, halting host.
> [  327.144644] xhci_hcd 0000:02:00.0: HC died; cleaning up
> [  327.150065] usb 3-2: USB disconnect, device number 2
> [  327.155190] sd 4:0:0:0: Device offlined - not ready after error recovery
> [  327.170110] sd 4:0:0:0: [sdc] Unhandled error code
> [  327.174921] sd 4:0:0:0: [sdc]  
> [  327.178075] sd 4:0:0:0: [sdc] CDB: 
> [  327.181601] end_request: I/O error, dev sdc, sector 4949712
> [  327.187188] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 318767104 size 8388608 starting block 618744)
> [  327.200604] Buffer I/O error on device sdc1, logical block 618458
> [  327.206711] Buffer I/O error on device sdc1, logical block 618459
> [  327.212818] Buffer I/O error on device sdc1, logical block 618460
> [  327.218922] Buffer I/O error on device sdc1, logical block 618461
> [  327.225030] Buffer I/O error on device sdc1, logical block 618462
> [  327.231137] Buffer I/O error on device sdc1, logical block 618463
> [  327.237240] Buffer I/O error on device sdc1, logical block 618464
> [  327.243347] Buffer I/O error on device sdc1, logical block 618465
> [  327.249451] Buffer I/O error on device sdc1, logical block 618466
> [  327.255557] Buffer I/O error on device sdc1, logical block 618467
> [  327.261717] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618782)
> [  327.275162] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618812)
> [  327.288603] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618842)
> [  327.302043] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618872)
> [  327.315483] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618902)
> [  327.328922] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618932)
> [  327.342362] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618962)
> [  327.355803] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 618992)
> [  327.369243] EXT4-fs warning (device sdc1): ext4_end_bio:317: I/O error writing to inode 7342793 (offset 327155712 size 8388608 starting block 619022)
> [  327.390294] sd 4:0:0:0: [sdc] Unhandled error code
> [  327.395102] sd 4:0:0:0: [sdc]  
> [  327.398254] sd 4:0:0:0: [sdc] CDB: 
> [  327.401775] end_request: I/O error, dev sdc, sector 4949952
> [  327.413642] Aborting journal on device sdc1-8.
> [  327.418381] EXT4-fs error (device sdc1): ext4_journal_check_start:56: Detected aborted journal
> [  327.427057] EXT4-fs (sdc1): Remounting filesystem read-only
> [  327.432645] EXT4-fs (sdc1): previous I/O error to superblock detected
> [  327.439119] EXT4-fs (sdc1): ext4_writepages: jbd2_start: 0 pages, ino 7342793; err -30
> [  327.447223] JBD2: Error -5 detected when updating journal superblock for sdc1-8.
> [  327.465498] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
> [  327.470799] sd 4:0:0:0: [sdc]  
> [  327.476202] EXT4-fs (sdc1): I/O error while writing superblock
>
>
> Previous trace is obtained on a NETGEAR ReadyNAS 102 (Marvell Armada 370
> based NAS) using current 3.13.0-rc7. The NAS has a Fresco Logic FL1009
> XHCI controller: 

I can add the following:

2) I just tested the copy of the small files using the ICY DOCK
MB981U3S-1S connected to my ReadyNAS 102 *on a 3.11.7 kernel*
and it completed successfully. 

2) on current 3.13.0-rc7 kernel (w/ Bj?rn patch applied just in case), I
just transferred 40GB through a Logitec LAN-GT JU3H3 (it is based on an
ASIX AX88179) connected to my ReadyNAS Duo v2 (NEC XHCI controller) at
an average rate of 82MB/s. Bottom line: no issue. When I try to do the
same on my ReadyNAS 102, I immediately get complaints:

[  383.280429] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  383.280892] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  411.620073] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
[  411.620750] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  411.621727] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.066651] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
[  412.067233] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.068196] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.242708] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
[  412.243333] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.244246] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.417956] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred
[  412.418516] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.419473] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20400 bytes untransferred
[  412.545330] xhci_hcd 0000:02:00.0: ep 0x82 - asked for 20480 bytes, 20352 bytes untransferred

If someone has a system w/ a Fresco Logic FL1009, I would be interested
by some feedback on how it behaves w/ current kernel.

Cheers,

a+
