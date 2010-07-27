From: wjydlut@gmail.com (nonthing wu)
Date: Tue, 27 Jul 2010 14:20:17 +0800
Subject: Boot Filesystem form sd/mmc card, the sd/mmc driver can't probe
	proper
Message-ID: <AANLkTinpBh=dj2wGYXPxrogxNkp6=dpWOFLo5TQps0Ej@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel version is linux-2.6.33 , and apply with android patch, hardware is
arm realview pbxA9

I configured the sd/mmc driver into the kernel, when I boot filesystem from
nfs, after the kernel boot up, the sd/mmc driver is probe ok, and I can
mount the sd card. but when I copy the filesytem to sd/mmc card , and boot
with it, it can't works ok. error as follows:

<7>mmc0: starting CMD51 arg 00000000 flags 000000b5
<7>mmc0:     blksz 8 blocks 1 flags 00000200 tsac 100 ms nsac 0
Desc_No: 0 , desc0: 0x8000001c, desc1: 0x8,                     desc2:
0x7f3fe4e0, desc3: 0x0
[   55.324953] Desc_No: 0 , desc0: 0x8000001c, desc1:
0x8,                      desc2: 0x7f3fe4e0, desc3: 0x0
<3>ns2416-sdmmc ns2416-sdmmc.0: MMC IRQ 00000004 (CMD 51): [   55.365066]
ns2416-sdmmc ns2416-sdmmc.0: MMC IRQ 00000004 (CMD 51): CMD doneCMD done

<6>scsi0 : pata_platform
.......................................................................................
.......................................................................................
<4>atkbd.c: keyboard reset failed on fpga:kmi1
[   53.382712] atkbd.c: keyboard reset failed on fpga:kmi1
<6>Waiting for root device /dev/mmcblk0p4...
[   53.861013] Waiting for root device /dev/mmcblk0p4...
<3>INFO: task kmmcd:165 blocked for more than 120 seconds.
[  288.385908] INFO: task kmmcd:165 blocked for more than 120 seconds.
<3>"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  288.425467] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
<6>kmmcd           D[  288.454402] kmmcd           D<c> c02c69b4  c02c69b4
<c>    0   165      2 0x00000000
    0   165      2 0x00000000
[<c02c69b4>] (schedule+0x280/0x2c4) from [<c02c6b5c>]
(schedule_timeout+0x18/0x188)
[  288.508780] [<c02c69b4>] (schedule+0x280/0x2c4) from [<c02c6b5c>]
(schedule_timeout+0x18/0x188)
[<c02c6b5c>] (schedule_timeout+0x18/0x188) from [<c02c6628>]
(wait_for_common+0xc0/0x14c)
[  288.559151] [<c02c6b5c>] (schedule_timeout+0x18/0x188) from [<c02c6628>]
(wait_for_common+0xc0/0x14c)
[<c02c6628>] (wait_for_common+0xc0/0x14c) from [<c017b95c>]
(mmc_wait_for_req+0x114/0x120)
[  288.611389] [<c02c6628>] (wait_for_common+0xc0/0x14c) from [<c017b95c>]
(mmc_wait_for_req+0x114/0x120)
[<c017b95c>] (mmc_wait_for_req+0x114/0x120) from [<c017e1a4>]
(mmc_app_send_scr+0xec/0x134)
[  288.664140] [<c017b95c>] (mmc_wait_for_req+0x114/0x120) from [<c017e1a4>]
(mmc_app_send_scr+0xec/0x134)
[<c017e1a4>] (mmc_app_send_scr+0xec/0x134) from [<c017d8f0>]
(mmc_sd_init_card+0x38c/0x69c)
[  288.717131] [<c017e1a4>] (mmc_app_send_scr+0xec/0x134) from [<c017d8f0>]
(mmc_sd_init_card+0x38c/0x69c)
[<c017d8f0>] (mmc_sd_init_card+0x38c/0x69c) from [<c017dd04>]
(mmc_attach_sd+0x104/0x180)
[  288.769587] [<c017d8f0>] (mmc_sd_init_card+0x38c/0x69c) from [<c017dd04>]
(mmc_attach_sd+0x104/0x180)
[<c017dd04>] (mmc_attach_sd+0x104/0x180) from [<c017b7bc>]
(mmc_rescan+0x1b0/0x23c)
[  288.819924] [<c017dd04>] (mmc_attach_sd+0x104/0x180) from [<c017b7bc>]
(mmc_rescan+0x1b0/0x23c)
[<c017b7bc>] (mmc_rescan+0x1b0/0x23c) from [<c00500ac>]
(worker_thread+0x14c/0x1c4)
[  288.868745] [<c017b7bc>] (mmc_rescan+0x1b0/0x23c) from [<c00500ac>]
(worker_thread+0x14c/0x1c4)
[<c00500ac>] (worker_thread+0x14c/0x1c4) from [<c0052e94>]
(kthread+0x7c/0x84)
[  288.916254] [<c00500ac>] (worker_thread+0x14c/0x1c4) from [<c0052e94>]
(kthread+0x7c/0x84)
[<c0052e94>] (kthread+0x7c/0x84) from [<c002a970>]
(kernel_thread_exit+0x0/0x8)


CMD51 is the first command which need transfer data from SD to memory. At
normal working condition when I write DMA Descriptors address to register
it's begin transfer data, but now it's blocked and it can't get the data
tranfer over, timeout or any others interrupt. my programm flow as follows;

    setup DMA descriptors---> wmb() ----> write DMA descriptors address to
SD/MMC controller's regsiter and begin to transfer data

I don't how to relove this problem , anybody can help me ? thanks!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100727/49aae0be/attachment-0001.html>
