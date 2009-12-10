From: mkl0301@hotmail.com (mkl lin)
Date: Thu, 10 Dec 2009 14:59:26 +0000
Subject: dma_cache_maint_contiguous should be patched as dma_cache_maint do
Message-ID: <SNT109-W4788A2C238168B3B9086CBA78D0@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


hi,



I've got a deadlock while testing SATA AHCI driver ahci.c with the new IPI patch.



My platform is ARM11 MPCore 2CPU, Linux 2.6.31.1, SMP, with L1. I did a
simple write-read test with a PCIe SATA adapter and it stuck at first
or second round.



Here is the call stack of each CPU:

CPU1:

__smp_dma_cache_op

dma_cache_maint_page

dma_map_sg

ata_qc_issue

ata_scsi_translate

ata_scsi_queuecmd

scsi_request_fn

__generic_unplug_device

generic_unplug_device

blk_unplug

sync_buffer

__wait_on_bit_lock

out_of_line_wait_on_bit_lock

lock_buffer

__block_write_full_page





CPU0:

__raw_spin_lock

_spin_lock

ata_scsi_queuecmd





Following is my guess:

CPU1 called ata_scsi_queuecmd and get the lock, and go all the way down
into __smp_dma_cache_op, which send the IPI message and waiting for
other CPU finish cache operation (I guess so).


??? while(!cpus_empty(data.unfinished))





CPU0 also called ata_scsi_queuecmd and stuck in a spinlock, which is
obtained by CPU1, with IRQ disabled. So CPU0 could not handle the IPI,
keep spining, and CPU1 is waiting for CPU0 to finish handling IPI.




One strange thing is that whenever ata_scsi_queuecmd is called, the IRQ have already been disabled.



The patch would fix the bug, but I'm not sure whether will it break other things or not. 


Best Regard,
Mac Lin




 		 	   		  
_________________________________________________________________
Keep your friends updated?even when you?re not signed in.
http://www.microsoft.com/middleeast/windows/windowslive/see-it-in-action/social-network-basics.aspx?ocid=PID23461::T:WLMTAGL:ON:WL:en-xm:SI_SB_5:092010
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch
Type: application/octet-stream
Size: 631 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091210/520c074d/attachment-0001.obj>
