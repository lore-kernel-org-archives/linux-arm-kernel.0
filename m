From: langabe@gmail.com (Alex Gonzalez)
Date: Tue, 15 Jun 2010 09:58:26 +0200
Subject: Hung kernel on SD writeback while suspending to RAM
Message-ID: <AANLkTikHHcnJygPWKAlDk4NWGBE_fxexeLt3WO0xea0M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am looking into suspend to RAM on a Freescale MX51 running a 2.6.31
kernel. The
system suspends and resumes OK except when an SD card is mounted.

What happens then is that it finds a page which is being written to disk
(writeback flag is set), so it waits forever in uninterruptible state for
the write to finish, which never happens.

I was expecting the filesystem sync previous to the tasks freezing to have
written all page caches to disk.

Any suggestion as to how to debug this forward?

Thanks in advance,
Alex

INFO: task sh:595 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
sh D c02be320 0 595 1 0x00000000
[<c02be320>] (schedule+0x300/0x344) from [<c02be388>]
(io_schedule+0x24/0x40)
[<c02be388>] (io_schedule+0x24/0x40) from [<c006fe18>]
(sync_page+0x38/0x40)
[<c006fe18>] (sync_page+0x38/0x40) from [<c02be68c>]
(__wait_on_bit+0x54/0x9c)
[<c02be68c>] (__wait_on_bit+0x54/0x9c) from [<c0070070>]
(wait_on_page_bit+0xb4/0xcc)
[<c0070070>] (wait_on_page_bit+0xb4/0xcc) from
[<c0075fc8>] (write_cache_pages+0x1fc/0x37c)
[<c0075fc8>] (write_cache_pages+0x1fc/0x37c) from
[<c00761ac>] (do_writepages+0x3c/0x54)
[<c00761ac>] (do_writepages+0x3c/0x54) from
[<c0070a80>] (__filemap_fdatawrite_range+0x64/0x6c)
[<c0070a80>] (__filemap_fdatawrite_range+0x64/0x6c) from
[<c00714c4>] (filemap_fdatawrite+0x28/0x30)
[<c00714c4>] (filemap_fdatawrite+0x28/0x30) from
[<c00714e4>] (filemap_write_and_wait+0x18/0x3c)
[<c00714e4>] (filemap_write_and_wait+0x18/0x3c) from
[<c00b2e68>] (fsync_bdev+0x18/0x38)
[<c00b2e68>] (fsync_bdev+0x18/0x38) from [<c013d3bc>]
(invalidate_partition+0x18/0x34)
[<c013d3bc>] (invalidate_partition+0x18/0x34) from [<c00ca6e0>]
(del_gendisk+0x28/0xc8)
[<c00ca6e0>] (del_gendisk+0x28/0xc8) from [<c01e4c88>]
(mmc_blk_remove+0x20/0x3c)
[<c01e4c88>] (mmc_blk_remove+0x20/0x3c) from [<c01e0688>]
(mmc_bus_remove+0x18/0x20)
[<c01e0688>] (mmc_bus_remove+0x18/0x20) from
[<c01872f8>] (__device_release_driver+0x64/0xa4)
[<c01872f8>] (__device_release_driver+0x64/0xa4) from
[<c01873dc>] (device_release_driver+0x1c/0x28)
[<c01873dc>] (device_release_driver+0x1c/0x28) from
[<c01869f8>] (bus_remove_device+0x9c/0xac)
[<c01869f8>] (bus_remove_device+0x9c/0xac) from [<c01852d0>]
(device_del+0x110/0x16c)
[<c01852d0>] (device_del+0x110/0x16c) from [<c01e073c>]
(mmc_remove_card+0x4c/0x60)
[<c01e073c>] (mmc_remove_card+0x4c/0x60) from [<c01e1b70>]
(mmc_sd_remove+0x24/0x30)
[<c01e1b70>] (mmc_sd_remove+0x24/0x30) from [<c01e001c>]
(mmc_suspend_host+0xc4/0x188)
[<c01e001c>] (mmc_suspend_host+0xc4/0x188) from [<c01e6860>]
(sdhci_suspend+0x58/0x120)
[<c01e6860>] (sdhci_suspend+0x58/0x120) from
[<c0188378>] (platform_pm_suspend+0x48/0x54)
[<c0188378>] (platform_pm_suspend+0x48/0x54) from [<c018a098>]
(pm_op+0x30/0x7c)
[<c018a098>] (pm_op+0x30/0x7c) from [<c018a86c>]
(dpm_suspend_start+0x3ac/0x50c)
[<c018a86c>] (dpm_suspend_start+0x3ac/0x50c) from
[<c006b560>] (suspend_devices_and_enter+0x3c/0x1c4)
[<c006b560>] (suspend_devices_and_enter+0x3c/0x1c4) from
[<c006b7a0>] (enter_state+0xb8/0x118)
[<c006b7a0>] (enter_state+0xb8/0x118) from [<c006afbc>]
(state_store+0xa0/0xbc)  [<c006afbc>] (state_store+0xa0/0xbc) from
[<c0146cd4>] (kobj_attr_store+0x18/0x1c)
[<c0146cd4>] (kobj_attr_store+0x18/0x1c) from
[<c00cbd24>] (sysfs_write_file+0x108/0x13c)
[<c00cbd24>] (sysfs_write_file+0x108/0x13c) from [<c008f7cc>]
(vfs_write+0xac/0x128)  [<c008f7cc>] (vfs_write+0xac/0x128) from
[<c008f8f4>] (sys_write+0x3c/0x68)
[<c008f8f4>] (sys_write+0x3c/0x68) from [<c0025e80>] (ret_fast_
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100615/db37e4de/attachment.html>
