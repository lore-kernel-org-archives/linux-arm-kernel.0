From: a.gal@motsai.com (Alex Gal)
Date: Mon, 9 Sep 2013 07:36:12 -0400
Subject: bug? kernel (3.10.7) panic while copying mmc partition in custom
 board with tx-28 module (imx28)
Message-ID: <CAN44aq06=NS8=wQbWF=zB0t8nH7+sofAsTaLmf6-SW5uJ88moQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I  have a custom board with the tx-28 module (imx28).

I use kernel 3.10.7 without any patches (see attachments for the
.config and the .dts file).

The rootfs is on the usb key.

I am decompressing and copying an image on an mmc partition using this command:

gzip -d -c image.bin.gz | dd of=/dev/mmcblk0p2 bs=1M

If I lower the block size value (1024 up to 63KB), I do not get the panic.

The image file is 1.1GB decompressed and 292MB compressed.

Panic:

INFO: task kworker/u2:2:1314 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u2:2    D c05211e4     0  1314      2 0x00000000
Workqueue: kmmcd mmc_rescan
[<c05211e4>] (__schedule+0x1b0/0x424) from [<c038857c>]
(__mmc_claim_host+0xac/0x1b0)
[<c038857c>] (__mmc_claim_host+0xac/0x1b0) from [<c038f0ac>]
(mmc_sd_detect+0x20/0x74)
[<c038f0ac>] (mmc_sd_detect+0x20/0x74) from [<c038ad2c>] (mmc_rescan+0xb0/0x390)
[<c038ad2c>] (mmc_rescan+0xb0/0x390) from [<c002c81c>]
(process_one_work+0x124/0x380)
[<c002c81c>] (process_one_work+0x124/0x380) from [<c002cf04>]

The mmc card was not removed; I also tried the broken-cd; option in
the ssp0 section of the dts file.
I also disabled ssp2 but I have the same error.

Any ideas what could be going on ?

Cheers,

Alex
-------------- next part --------------
INFO: task kworker/u2:2:1314 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u2:2    D c05211e4     0  1314      2 0x00000000
Workqueue: kmmcd mmc_rescan
[<c05211e4>] (__schedule+0x1b0/0x424) from [<c038857c>] (__mmc_claim_host+0xac/0x1b0)
[<c038857c>] (__mmc_claim_host+0xac/0x1b0) from [<c038f0ac>] (mmc_sd_detect+0x20/0x74)
[<c038f0ac>] (mmc_sd_detect+0x20/0x74) from [<c038ad2c>] (mmc_rescan+0xb0/0x390)
[<c038ad2c>] (mmc_rescan+0xb0/0x390) from [<c002c81c>] (process_one_work+0x124/0x380)
[<c002c81c>] (process_one_work+0x124/0x380) from [<c002cf04>] (worker_thread+0x13c/0x3d8)
[<c002cf04>] (worker_thread+0x13c/0x3d8) from [<c00326f8>] (kthread+0xa4/0xb0)
[<c00326f8>] (kthread+0xa4/0xb0) from [<c0009410>] (ret_from_fork+0x14/0x24)
Kernel panic - not syncing: hung_task: blocked tasks
CPU: 0 PID: 312 Comm: khungtaskd Not tainted 3.10.7-motsai+ #86
[<c000cd4c>] (unwind_backtrace+0x0/0xf0) from [<c000b664>] (show_stack+0x10/0x14)
[<c000b664>] (show_stack+0x10/0x14) from [<c051bf90>] (panic+0x98/0x1ec)
[<c051bf90>] (panic+0x98/0x1ec) from [<c005db14>] (watchdog+0x22c/0x258)
[<c005db14>] (watchdog+0x22c/0x258) from [<c00326f8>] (kthread+0xa4/0xb0)
[<c00326f8>] (kthread+0xa4/0xb0) from [<c0009410>] (ret_from_fork+0x14/0x24)
Rebooting in 1 seconds..

-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx28-tx28.dts.gz
Type: application/x-gzip
Size: 1615 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/3c72bb26/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: kernel_config.gz
Type: application/x-gzip
Size: 16720 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/3c72bb26/attachment-0003.bin>
