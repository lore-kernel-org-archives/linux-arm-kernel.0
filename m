From: pratyush.linux@gmail.com (Pratyush Anand)
Date: Wed, 1 Sep 2010 13:22:09 +0530
Subject: PCI master abort with USB3.0 card
In-Reply-To: <AANLkTi=CdAYrU6M8y2JYZRUv07SermQe7bWaZm7EcohA@mail.gmail.com>
References: <AANLkTi=CdAYrU6M8y2JYZRUv07SermQe7bWaZm7EcohA@mail.gmail.com>
Message-ID: <AANLkTimw=HEvsGjUSA2A57Cc=xDMwf2ZheZ6WQbAThwp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 1, 2010 at 1:08 PM, Pratyush Anand <pratyush.linux@gmail.com> wrote:
>
> Hello Amit,
>
>
>
> We are using USB3.0 controller chip from NEC (D720200F1).
>
> Arm processor is cortex-A9.
>
>
>
> You can see the pcie implementation for my platform in this patch
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-August/024364.html
>
>
>
> Regards
>
> Pratysuh
>
>
> > Hi,
> > Can you please share the USB3.0 controller chip or the PCIe card manufacturer's name? Also, which ARM processor are you using?
> > Thanks,
> > - Amit
> >
> > On Tue, 31 Aug 2010 12:47:26 +0530 (IST) Pratyush Anand <anand_pratyush@xxxxxxxxxxx> wrote:
> >
> >> Hello All,
> >> I am using a PCIE base usb3.0 card on ARM based platform. Linux
> >> version is 2.6.32.
> >> Support of PCIE for this platform has been added by me.
> >> This usb3.0 card works well , if I connect it to host intel
> >> PC(fedora) having same linux kernel version.
> >> But , with my board I have some issue.
> >> I am able to detect the card.
> >> If I connect a mass storage device to the card , it is also detected.
> >> If I copy a small file from mass storage to root file system , it is
> >> copied well.
> >> But If I copy a big file(say 1MB) and do sync or umount operation , it
> >> fails. If I try to see pci configuration register of this card then I
> >> found that "Master abort received " bit is set.
> >> Can anyone suggest a pointer to look into it.
> >> Regards>
> >> Pratyush
> >> At the console i see following error:
> >>
> >> ------------------------------------------
> >> root at xxxxxxxxxxxx:~# mount /dev/sda1 /mnt/ root at xxxxxxxxxxxx:~# cp 1MB
> >> /mnt/ root at xxxxxxxxxxxx:~# umount /mnt/
> >> INFO: task scsi_eh_0:482 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. scsi_eh_0???? D c02c0708???? 0?? 482????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc3ac r5:cf892080 r4:cf9dc3b0 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c020bcfc>]
> >> (command_abort+0x94/0x9c)
> >> [<c020bc68>] (command_abort+0x0/0x9c) from [<c019f8fc>]
> >> (__scsi_try_to_abort_cmd+0x2c/0x30)
> >>? r7:cf9d2000 r6:cf9d3f84 r5:cf9dc000 r4:cfacf320 [<c019f8d0>]
> >> (__scsi_try_to_abort_cmd+0x0/0x30) from [<c01a12f0>]
> >> (scsi_error_handler+0x12c/0x358)
> >> [<c01a11c4>] (scsi_error_handler+0x0/0x358) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r7:c01a11c4 r6:cf9dc000 r5:cf867bb8 r4:cf9d3fbc [<c00510c8>]
> >> (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)? r7:00000000
> >> r6:00000000 r5:00000000 r4:00000000
> >> INFO: task usb-storage:483 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. usb-storage?? D c02c0708???? 0?? 483????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc364 r5:cf892700 r4:cf9dc368 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c01f1c40>]
> >> (usb_sg_wait+0x148/0x154)
> >> [<c01f1af8>] (usb_sg_wait+0x0/0x154) from [<c020c748>]
> >> (usb_stor_bulk_transfer_sglist+0xbc/0x110)
> >> [<c020c68c>] (usb_stor_bulk_transfer_sglist+0x0/0x110) from
> >> [<c020c7cc>] (usb_stor_bulk_srb+0x30/0x48) [<c020c79c>]
> >> (usb_stor_bulk_srb+0x0/0x48) from [<c020ccfc>]
> >> (usb_stor_Bulk_transport+0x110/0x2ac)
> >>? r4:ffc1300f
> >> [<c020cbec>] (usb_stor_Bulk_transport+0x0/0x2ac) from [<c020cec0>]
> >> (usb_stor_invoke_transport+0x28/0x314)
> >> [<c020ce98>] (usb_stor_invoke_transport+0x0/0x314) from [<c020becc>]
> >> (usb_stor_transparent_scsi_command+0x10/0x14)
> >>? r8:00000000 r7:c020de84 r6:cf9dc000 r5:cf9dc2bc r4:cf9f1fbc
> >> [<c020bebc>] (usb_stor_transparent_scsi_command+0x0/0x14) from
> >> [<c020dfd8>] (usb_stor_control_thread+0x154/0x21c)
> >> [<c020de84>] (usb_stor_control_thread+0x0/0x21c) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r6:cf9dc2bc r5:cf867c10 r4:cf9f1fbc
> >> [<c00510c8>] (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)
> >> r7:00000000 r6:00000000 r5:00000000 r4:00000000
> >> INFO: task umount:1413 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. umount??????? D c02c0708???? 0? 1413?? 1407 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c00afb5c>]
> >> (bdi_sched_wait+0x10/0x18) [<c00afb4c>] (bdi_sched_wait+0x0/0x18) from
> >> [<c02c0d0c>] (__wait_on_bit+0x64/0xac) [<c02c0ca8>]
> >> (__wait_on_bit+0x0/0xac) from [<c02c0dd4>]
> >> (out_of_line_wait_on_bit+0x80/0x8c)
> >> [<c02c0d54>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00afbf4>]
> >> (sync_inodes_sb+0x90/0x15c)
> >> [<c00afb64>] (sync_inodes_sb+0x0/0x15c) from [<c00b3c78>]
> >> (__sync_filesystem+0x38/0x64)
> >>? r8:00000000 r7:cfb9d580 r6:c02c8724 r5:00000001 r4:cfac7c00
> >> [<c00b3c40>] (__sync_filesystem+0x0/0x64) from [<c00b3e88>]
> >> (sync_filesystem+0x54/0x5c)
> >>? r5:cfad2000 r4:cfac7c00
> >> [<c00b3e34>] (sync_filesystem+0x0/0x5c) from [<c0095ea8>]
> >> (generic_shutdown_super+0x38/0x118)
> >>? r5:cfad2000 r4:cfac7c00
> >> [<c0095e70>] (generic_shutdown_super+0x0/0x118) from [<c0095fa8>]
> >> (kill_block_super+0x20/0x38)
> >>? r7:cfb9d580 r6:cfb9d580 r5:00000003 r4:cf50a000 [<c0095f88>]
> >> (kill_block_super+0x0/0x38) from [<c00962d8>]
> >> (deactivate_super+0x50/0x68)
> >>? r5:c03a9b48 r4:cfac7c00
> >> [<c0096288>] (deactivate_super+0x0/0x68) from [<c00aa51c>]
> >> (mntput_no_expire+0x70/0xb0)
> >>? r5:cfb9d580 r4:cfac7c00
> >> [<c00aa4ac>] (mntput_no_expire+0x0/0xb0) from [<c00aaaf4>]
> >> (sys_umount+0x2c0/0x2f8)
> >>? r5:cfb9d598 r4:cfb9d578
> >> [<c00aa834>] (sys_umount+0x0/0x2f8) from [<c0028e40>]
> >> (ret_fast_syscall+0x0/0x2c)
> >> INFO: task flush-8:0:1414 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. flush-8:0???? D c02c0708???? 0? 1414????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0888>]
> >> (io_schedule+0x44/0x70) [<c02c0844>] (io_schedule+0x0/0x70) from
> >> [<c00b6458>] (sync_buffer+0x4c/0x54) r5:c0604248 r4:cfb07d9c
> >> [<c00b640c>] (sync_buffer+0x0/0x54) from [<c02c0bd4>]
> >> (__wait_on_bit_lock+0x64/0xac)
> >> [<c02c0b70>] (__wait_on_bit_lock+0x0/0xac) from [<c02c0c9c>]
> >> (out_of_line_wait_on_bit_lock+0x80/0x8c)
> >> [<c02c0c1c>] (out_of_line_wait_on_bit_lock+0x0/0x8c) from [<c00b6710>]
> >> (__lock_buffer+0x3c/0x44) [<c00b66d4>] (__lock_buffer+0x0/0x44) from
> >> [<c00b96d0>]
> >> (sync_dirty_buffer+0x60/0x144)
> >> [<c00b9670>] (sync_dirty_buffer+0x0/0x144) from [<c0105f48>]
> >> (fat_write_inode+0x1e4/0x218)
> >>? r5:00000000 r4:ce882160
> >> [<c0105d64>] (fat_write_inode+0x0/0x218) from [<c00af820>]
> >> (writeback_single_inode+0x10c/0x21c)
> >> [<c00af714>] (writeback_single_inode+0x0/0x21c) from [<c00b0168>]
> >> (writeback_inodes_wb+0x390/0x43c)
> >> [<c00afdd8>] (writeback_inodes_wb+0x0/0x43c) from [<c00b034c>]
> >> (wb_writeback+0x138/0x1b8)
> >> [<c00b0214>] (wb_writeback+0x0/0x1b8) from [<c00b0530>]
> >> (wb_do_writeback+0x68/0x1a0)
> >> [<c00b04c8>] (wb_do_writeback+0x0/0x1a0) from [<c00b0698>]
> >> (bdi_writeback_task+0x30/0xc0)
> >> [<c00b0668>] (bdi_writeback_task+0x0/0xc0) from [<c007b414>]
> >> (bdi_start_fn+0x78/0xd8)
> >>? r7:c007b39c r6:cf99daa8 r5:cf99dad8 r4:cf99da38 [<c007b39c>]
> >> (bdi_start_fn+0x0/0xd8) from [<c0051150>]
> >> (kthread+0x88/0x90) r7:c007b39c r6:cf99daa8 r5:cf897ef8 r4:cfb07fbc
> >> [<c00510c8>] (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)
> >> r7:00000000 r6:00000000 r5:00000000 r4:00000000
> >> INFO: task scsi_eh_0:482 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. scsi_eh_0???? D c02c0708???? 0?? 482????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc3ac r5:cf892080 r4:cf9dc3b0 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c020bcfc>]
> >> (command_abort+0x94/0x9c)
> >> [<c020bc68>] (command_abort+0x0/0x9c) from [<c019f8fc>]
> >> (__scsi_try_to_abort_cmd+0x2c/0x30)
> >>? r7:cf9d2000 r6:cf9d3f84 r5:cf9dc000 r4:cfacf320 [<c019f8d0>]
> >> (__scsi_try_to_abort_cmd+0x0/0x30) from [<c01a12f0>]
> >> (scsi_error_handler+0x12c/0x358)
> >> [<c01a11c4>] (scsi_error_handler+0x0/0x358) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r7:c01a11c4 r6:cf9dc000 r5:cf867bb8 r4:cf9d3fbc [<c00510c8>]
> >> (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)? r7:00000000
> >> r6:00000000 r5:00000000 r4:00000000
> >> INFO: task usb-storage:483 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. usb-storage?? D c02c0708???? 0?? 483????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc364 r5:cf892700 r4:cf9dc368 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c01f1c40>]
> >> (usb_sg_wait+0x148/0x154)
> >> [<c01f1af8>] (usb_sg_wait+0x0/0x154) from [<c020c748>]
> >> (usb_stor_bulk_transfer_sglist+0xbc/0x110)
> >> [<c020c68c>] (usb_stor_bulk_transfer_sglist+0x0/0x110) from
> >> [<c020c7cc>] (usb_stor_bulk_srb+0x30/0x48) [<c020c79c>]
> >> (usb_stor_bulk_srb+0x0/0x48) from [<c020ccfc>]
> >> (usb_stor_Bulk_transport+0x110/0x2ac)
> >>? r4:ffc1300f
> >> [<c020cbec>] (usb_stor_Bulk_transport+0x0/0x2ac) from [<c020cec0>]
> >> (usb_stor_invoke_transport+0x28/0x314)
> >> [<c020ce98>] (usb_stor_invoke_transport+0x0/0x314) from [<c020becc>]
> >> (usb_stor_transparent_scsi_command+0x10/0x14)
> >>? r8:00000000 r7:c020de84 r6:cf9dc000 r5:cf9dc2bc r4:cf9f1fbc
> >> [<c020bebc>] (usb_stor_transparent_scsi_command+0x0/0x14) from
> >> [<c020dfd8>] (usb_stor_control_thread+0x154/0x21c)
> >> [<c020de84>] (usb_stor_control_thread+0x0/0x21c) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r6:cf9dc2bc r5:cf867c10 r4:cf9f1fbc
> >> [<c00510c8>] (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)
> >> r7:00000000 r6:00000000 r5:00000000 r4:00000000
> >> INFO: task umount:1413 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. umount??????? D c02c0708???? 0? 1413?? 1407 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c00afb5c>]
> >> (bdi_sched_wait+0x10/0x18) [<c00afb4c>] (bdi_sched_wait+0x0/0x18) from
> >> [<c02c0d0c>] (__wait_on_bit+0x64/0xac) [<c02c0ca8>]
> >> (__wait_on_bit+0x0/0xac) from [<c02c0dd4>]
> >> (out_of_line_wait_on_bit+0x80/0x8c)
> >> [<c02c0d54>] (out_of_line_wait_on_bit+0x0/0x8c) from [<c00afbf4>]
> >> (sync_inodes_sb+0x90/0x15c)
> >> [<c00afb64>] (sync_inodes_sb+0x0/0x15c) from [<c00b3c78>]
> >> (__sync_filesystem+0x38/0x64)
> >>? r8:00000000 r7:cfb9d580 r6:c02c8724 r5:00000001 r4:cfac7c00
> >> [<c00b3c40>] (__sync_filesystem+0x0/0x64) from [<c00b3e88>]
> >> (sync_filesystem+0x54/0x5c)
> >>? r5:cfad2000 r4:cfac7c00
> >> [<c00b3e34>] (sync_filesystem+0x0/0x5c) from [<c0095ea8>]
> >> (generic_shutdown_super+0x38/0x118)
> >>? r5:cfad2000 r4:cfac7c00
> >> [<c0095e70>] (generic_shutdown_super+0x0/0x118) from [<c0095fa8>]
> >> (kill_block_super+0x20/0x38)
> >>? r7:cfb9d580 r6:cfb9d580 r5:00000003 r4:cf50a000 [<c0095f88>]
> >> (kill_block_super+0x0/0x38) from [<c00962d8>]
> >> (deactivate_super+0x50/0x68)
> >>? r5:c03a9b48 r4:cfac7c00
> >> [<c0096288>] (deactivate_super+0x0/0x68) from [<c00aa51c>]
> >> (mntput_no_expire+0x70/0xb0)
> >>? r5:cfb9d580 r4:cfac7c00
> >> [<c00aa4ac>] (mntput_no_expire+0x0/0xb0) from [<c00aaaf4>]
> >> (sys_umount+0x2c0/0x2f8)
> >>? r5:cfb9d598 r4:cfb9d578
> >> [<c00aa834>] (sys_umount+0x0/0x2f8) from [<c0028e40>]
> >> (ret_fast_syscall+0x0/0x2c)
> >> INFO: task flush-8:0:1414 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. flush-8:0???? D c02c0708???? 0? 1414????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0888>]
> >> (io_schedule+0x44/0x70) [<c02c0844>] (io_schedule+0x0/0x70) from
> >> [<c00b6458>] (sync_buffer+0x4c/0x54) r5:c0604248 r4:cfb07d9c
> >> [<c00b640c>] (sync_buffer+0x0/0x54) from [<c02c0bd4>]
> >> (__wait_on_bit_lock+0x64/0xac)
> >> [<c02c0b70>] (__wait_on_bit_lock+0x0/0xac) from [<c02c0c9c>]
> >> (out_of_line_wait_on_bit_lock+0x80/0x8c)
> >> [<c02c0c1c>] (out_of_line_wait_on_bit_lock+0x0/0x8c) from [<c00b6710>]
> >> (__lock_buffer+0x3c/0x44) [<c00b66d4>] (__lock_buffer+0x0/0x44) from
> >> [<c00b96d0>]
> >> (sync_dirty_buffer+0x60/0x144)
> >> [<c00b9670>] (sync_dirty_buffer+0x0/0x144) from [<c0105f48>]
> >> (fat_write_inode+0x1e4/0x218)
> >>? r5:00000000 r4:ce882160
> >> [<c0105d64>] (fat_write_inode+0x0/0x218) from [<c00af820>]
> >> (writeback_single_inode+0x10c/0x21c)
> >> [<c00af714>] (writeback_single_inode+0x0/0x21c) from [<c00b0168>]
> >> (writeback_inodes_wb+0x390/0x43c)
> >> [<c00afdd8>] (writeback_inodes_wb+0x0/0x43c) from [<c00b034c>]
> >> (wb_writeback+0x138/0x1b8)
> >> [<c00b0214>] (wb_writeback+0x0/0x1b8) from [<c00b0530>]
> >> (wb_do_writeback+0x68/0x1a0)
> >> [<c00b04c8>] (wb_do_writeback+0x0/0x1a0) from [<c00b0698>]
> >> (bdi_writeback_task+0x30/0xc0)
> >> [<c00b0668>] (bdi_writeback_task+0x0/0xc0) from [<c007b414>]
> >> (bdi_start_fn+0x78/0xd8)
> >>? r7:c007b39c r6:cf99daa8 r5:cf99dad8 r4:cf99da38 [<c007b39c>]
> >> (bdi_start_fn+0x0/0xd8) from [<c0051150>]
> >> (kthread+0x88/0x90) r7:c007b39c r6:cf99daa8 r5:cf897ef8 r4:cfb07fbc
> >> [<c00510c8>] (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)
> >> r7:00000000 r6:00000000 r5:00000000 r4:00000000
> >> INFO: task scsi_eh_0:482 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. scsi_eh_0???? D c02c0708???? 0?? 482????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc3ac r5:cf892080 r4:cf9dc3b0 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c020bcfc>]
> >> (command_abort+0x94/0x9c)
> >> [<c020bc68>] (command_abort+0x0/0x9c) from [<c019f8fc>]
> >> (__scsi_try_to_abort_cmd+0x2c/0x30)
> >>? r7:cf9d2000 r6:cf9d3f84 r5:cf9dc000 r4:cfacf320 [<c019f8d0>]
> >> (__scsi_try_to_abort_cmd+0x0/0x30) from [<c01a12f0>]
> >> (scsi_error_handler+0x12c/0x358)
> >> [<c01a11c4>] (scsi_error_handler+0x0/0x358) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r7:c01a11c4 r6:cf9dc000 r5:cf867bb8 r4:cf9d3fbc [<c00510c8>]
> >> (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)? r7:00000000
> >> r6:00000000 r5:00000000 r4:00000000
> >> INFO: task usb-storage:483 blocked for more than 120 seconds.
> >> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> >> message. usb-storage?? D c02c0708???? 0?? 483????? 2 0x00000000
> >> Backtrace:
> >> [<c02c0468>] (schedule+0x0/0x2dc) from [<c02c0954>]
> >> (schedule_timeout+0x20/0x1b8)
> >> [<c02c0934>] (schedule_timeout+0x0/0x1b8) from [<c02c033c>]
> >> (wait_for_common+0xe0/0x178)
> >>? r7:7fffffff r6:cf9dc364 r5:cf892700 r4:cf9dc368 [<c02c025c>]
> >> (wait_for_common+0x0/0x178) from [<c02c0464>]
> >> (wait_for_completion+0x18/0x1c)
> >> [<c02c044c>] (wait_for_completion+0x0/0x1c) from [<c01f1c40>]
> >> (usb_sg_wait+0x148/0x154)
> >> [<c01f1af8>] (usb_sg_wait+0x0/0x154) from [<c020c748>]
> >> (usb_stor_bulk_transfer_sglist+0xbc/0x110)
> >> [<c020c68c>] (usb_stor_bulk_transfer_sglist+0x0/0x110) from
> >> [<c020c7cc>] (usb_stor_bulk_srb+0x30/0x48) [<c020c79c>]
> >> (usb_stor_bulk_srb+0x0/0x48) from [<c020ccfc>]
> >> (usb_stor_Bulk_transport+0x110/0x2ac)
> >>? r4:ffc1300f
> >> [<c020cbec>] (usb_stor_Bulk_transport+0x0/0x2ac) from [<c020cec0>]
> >> (usb_stor_invoke_transport+0x28/0x314)
> >> [<c020ce98>] (usb_stor_invoke_transport+0x0/0x314) from [<c020becc>]
> >> (usb_stor_transparent_scsi_command+0x10/0x14)
> >>? r8:00000000 r7:c020de84 r6:cf9dc000 r5:cf9dc2bc r4:cf9f1fbc
> >> [<c020bebc>] (usb_stor_transparent_scsi_command+0x0/0x14) from
> >> [<c020dfd8>] (usb_stor_control_thread+0x154/0x21c)
> >> [<c020de84>] (usb_stor_control_thread+0x0/0x21c) from [<c0051150>]
> >> (kthread+0x88/0x90)
> >>? r6:cf9dc2bc r5:cf867c10 r4:cf9f1fbc
> >> [<c00510c8>] (kthread+0x0/0x90) from [<c003fb30>] (do_exit+0x0/0x5c4)
> >> r7:00000000 r6:00000000 r5:00000000 r4:00000000
> >> --------------------------------
> >>
> >>
> >>
> >>
> >> _______________________________________________
> >> linux-arm mailing list
> >> linux-arm at xxxxxxxxxxxxxxxxxxx
> >> http://lists.infradead.org/mailman/listinfo/linux-arm
> >>
>
