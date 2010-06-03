From: rumjantsev@papillon.ru (237 Rumjantsev Egor (PROG))
Date: Thu, 03 Jun 2010 19:27:48 +0600
Subject: network device allocation oops
Message-ID: <4C07ADD4.3050706@papillon.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

We develop custom board on Voipac PXA270 DIMM module. We connected 2 
devices on MMC/SDIO bus of PXA270 (Wifi modem WLRG-DP601 based on 
Marvell 8686 chipset and SD cards slot). Bus switches by analog mux and 
one of GPIOs who selects which of devices is working now.
I add to pxamci some code which forces MMC bus to rescan devices 
connected to bus. I use mmc_suspend_host and mmc_resume_host for it and 
change device select GPIO to proper state.
In many cases this works but some times libertas_sdio fails to load 
modem's firmware and after such error next try to add wifi modem oops.
Is there other way to force to refresh device list on MMC bus?


alloc_etherdev_mq(): size: 8704 count: 1
alloc_netdev_mq(): size: 8704 name: eth%d count: 1
alloc_netdev_mq(): alloc_size: 9631
alloc_netdev_mq(): queue: 1 size: 20
libertas: 00:01:36:1f:23:04, fw 8.73.7p3, cap 0x00000393
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: eth1: Marvell WLAN 802.11 adapter
eth1: no IPv6 routers present
mmc0: card 0001 removed
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address b368
mmc0: card b368 removed
mmc0: new SDIO card at address 0001
libertas_sdio mmc0:0001:1: firmware: requesting sd8686_helper.bin
libertas_sdio mmc0:0001:1: firmware: requesting sd8686.bin
lbs_add_card(): size: 8704
alloc_etherdev_mq(): size: 8704 count: 1
alloc_netdev_mq(): size: 8704 name: eth%d count: 1
alloc_netdev_mq(): alloc_size: 9631
alloc_netdev_mq(): queue: 1 size: 20
libertas: 00:01:36:1f:23:04, fw 8.73.7p3, cap 0x00000393
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: PREP_CMD: command 0x00a3 failed: 2
libertas: eth1: Marvell WLAN 802.11 adapter
eth1: no IPv6 routers present
mmc0: card 0001 removed
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address b368
mmcblk0: mmc0:b368 SD01G 958 MiB
  mmcblk0: p1
mmc0: card b368 removed
mmc0: new SDIO card at address 0001
libertas_sdio mmc0:0001:1: firmware: requesting sd8686_helper.bin
libertas_sdio mmc0:0001:1: firmware: requesting sd8686.bin
lbs_add_card(): size: 8704
alloc_etherdev_mq(): size: 8704 count: 1
alloc_netdev_mq(): size: 8704 name: eth%d count: 1
alloc_netdev_mq(): alloc_size: 9631
alloc_netdev_mq(): queue: 1 size: 20
libertas: command 0x0003 timed out
libertas: requeueing command 0x0003 due to timeout (#1)
libertas: command 0x0003 timed out
libertas: requeueing command 0x0003 due to timeout (#2)
libertas: command 0x0003 timed out
libertas: requeueing command 0x0003 due to timeout (#3)
libertas: command 0x0003 timed out
libertas: Excessive timeouts submitting command 0x0003
libertas: PREP_CMD: command 0x0003 failed: -110
libertas_sdio: probe of mmc0:0001:1 failed with error -110
mmc0: card 0001 removed
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address b368
mmcblk0: mmc0:b368 SD01G 958 MiB
  mmcblk0: p1
mmc0: card b368 removed
mmc0: new SDIO card at address 0001
libertas_sdio mmc0:0001:1: firmware: requesting sd8686_helper.bin
libertas_sdio mmc0:0001:1: firmware: requesting sd8686.bin
lbs_add_card(): size: 8704
alloc_etherdev_mq(): size: 8704 count: 1
alloc_netdev_mq(): size: 8704 name: eth%d count: 1
alloc_netdev_mq(): alloc_size: 9631
kernel BUG at mm/slab.c:3000!
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = a0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
Modules linked in: vfat fat libertas_sdio libertas pxamci pxa_keypad 
pxa_qci ov5620 pxa_reg ac_adapter ucb1400_adc ipv6 power_button 
snd_pxa2xx_ac97 snd_ac97_codec ac97_bus snd_pxa2xx_pcm snd_pxa2xx_lib 
snd_pcm snd_timer snd snd_page_alloc ppp_async crc_ccitt i2c_pxa usbhid 
rtc_pxa [last unloaded: mmc_block]
CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #138)
PC is at __bug+0x20/0x2c
LR is at vprintk+0x320/0x3a0
pc : [<a00325a0>]    lr : [<a00484e0>]    psr: 40000093
sp : c7885cec  ip : c7885c60  fp : c7885cf8
r10: c78004e0  r9 : c7884000  r8 : 00000004
r7 : c7802368  r6 : c7802720  r5 : c7802360  r4 : c7aca300
r3 : 00000000  r2 : c7884000  r1 : c7884000  r0 : 00000021
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0000397f  Table: a7a6c000  DAC: 00000017
Process kmmcd (pid: 12, stack limit = 0xc7884268)
Stack: (0xc7885cec to 0xc7886000)
5ce0:                            c7885d34 c7885cfc a009156c a003258c 
00000010
5d00: 000000d0 00000000 c7802370 0000259f c78004e0 a0000013 000080d0 
00002200
5d20: a023b414 a03786b4 c7885d54 c7885d38 a0091a68 a0091424 0000259f 
00000001
5d40: c4860000 00000001 c7885d84 c7885d58 a022f6e0 a00919e4 00000001 
00002200
5d60: 00000001 c4860000 c7885de4 c4860000 c7885de4 c49a1e04 c7885d9c 
c7885d88
5d80: a023b400 a022f66c 000003fe a03a0664 c7885dcc c7885da0 9f11c27c 
a023b3d0
5da0: a03a0664 c4860000 000003fe a03a0664 c4860000 c7885de4 c49a1e00 
0000fedc
5dc0: c7885e1c c7885dd0 9f136dc8 9f11c254 00000000 20000013 c5b9c000 
c7bef200
5de0: c7acabc0 00000000 00000000 0000000b 00000000 00000000 9f137f58 
c49a1e00
5e00: 9f1394d8 00000000 00000000 c49a1e6c c7885e3c c7885e20 a02145f8 
9f136234
5e20: 00000000 a018ecec c49a1e04 9f1394d8 c7885e5c c7885e40 a018eb8c 
a0214530
5e40: 00000000 a018ecec c49a1e04 c7885e70 c7885e6c c7885e60 a018ecfc 
a018eac0
5e60: c7885e94 c7885e70 a018e0d0 a018ecf8 c7865be8 c6ba3214 c49a1e04 
c49a1eb0
5e80: 00000001 c49a1e90 c7885eac c7885e98 a018ed84 a018e084 a03b649c 
c49a1e04
5ea0: c7885ec4 c7885eb0 a018def8 a018ed38 c49a1e04 c49a1e04 c7885f08 
c7885ec8
5ec0: a018cb10 a018ded4 c7bef604 00000000 c5b9c000 00000000 00000001 
c7bef600
5ee0: c49a1e04 c49a1e00 00000001 c5b9c000 00000000 00000001 c7bef600 
c7885f20
5f00: c7885f0c a02143e4 a018c7d4 00000000 00000000 c7885f5c c7885f24 
a0213db0
5f20: a02143bc 00000000 c7885f33 90300000 07000000 c7885f60 c5b9c000 
c5b9c180
5f40: c7884000 a021093c 00000000 00000000 c7885f7c c7885f60 a0210a7c 
a02138d8
5f60: 90ff8000 c5b9c184 c786f580 c5b9c180 c7885fa4 c7885f80 a00589b8 
a0210948
5f80: c786f588 c7884000 c786f580 c7885fa8 00000000 00000000 c7885fd8 
c7885fa8
5fa0: a00590d0 a00588e4 00000000 c7871980 a005cff0 c7885fb4 c7885fb4 
c7884000
5fc0: c786f580 a0058fcc 00000000 c7885ff4 c7885fdc a005cd5c a0058fd8 
00000000
5fe0: 00000000 00000000 00000000 c7885ff8 a004ab50 a005cd10 00000000 
00000000
Backtrace:
[<a0032580>] (__bug+0x0/0x2c) from [<a009156c>] 
(cache_alloc_refill+0x154/0x5c0)
[<a0091418>] (cache_alloc_refill+0x0/0x5c0) from [<a0091a68>] 
(__kmalloc+0x90/0xcc)
[<a00919d8>] (__kmalloc+0x0/0xcc) from [<a022f6e0>] 
(alloc_netdev_mq+0x80/0x198)
  r7:00000001 r6:c4860000 r5:00000001 r4:0000259f
[<a022f660>] (alloc_netdev_mq+0x0/0x198) from [<a023b400>] 
(alloc_etherdev_mq+0x3c/0x50)
[<a023b3c4>] (alloc_etherdev_mq+0x0/0x50) from [<9f11c27c>] 
(lbs_add_card+0x34/0x448 [libertas])
  r5:a03a0664 r4:000003fe
[<9f11c248>] (lbs_add_card+0x0/0x448 [libertas]) from [<9f136dc8>] 
(if_sdio_probe+0xba0/0xd90 [libertas_sdio])
[<9f136228>] (if_sdio_probe+0x0/0xd90 [libertas_sdio]) from [<a02145f8>] 
(sdio_bus_probe+0xd4/0xf0)
[<a0214524>] (sdio_bus_probe+0x0/0xf0) from [<a018eb8c>] 
(driver_probe_device+0xd8/0x1ac)
  r7:9f1394d8 r6:c49a1e04 r5:a018ecec r4:00000000
[<a018eab4>] (driver_probe_device+0x0/0x1ac) from [<a018ecfc>] 
(__device_attach+0x10/0x14)
  r7:c7885e70 r6:c49a1e04 r5:a018ecec r4:00000000
[<a018ecec>] (__device_attach+0x0/0x14) from [<a018e0d0>] 
(bus_for_each_drv+0x58/0x98)
[<a018e078>] (bus_for_each_drv+0x0/0x98) from [<a018ed84>] 
(device_attach+0x58/0x70)
  r7:c49a1e90 r6:00000001 r5:c49a1eb0 r4:c49a1e04
[<a018ed2c>] (device_attach+0x0/0x70) from [<a018def8>] 
(bus_attach_device+0x30/0x60)
  r5:c49a1e04 r4:a03b649c
[<a018dec8>] (bus_attach_device+0x0/0x60) from [<a018cb10>] 
(device_add+0x348/0x4e8)
  r5:c49a1e04 r4:c49a1e04
[<a018c7c8>] (device_add+0x0/0x4e8) from [<a02143e4>] 
(sdio_add_func+0x34/0x4c)
[<a02143b0>] (sdio_add_func+0x0/0x4c) from [<a0213db0>] 
(mmc_attach_sdio+0x4e4/0x5b4)
  r5:00000000 r4:00000000
[<a02138cc>] (mmc_attach_sdio+0x0/0x5b4) from [<a0210a7c>] 
(mmc_rescan+0x140/0x274)
[<a021093c>] (mmc_rescan+0x0/0x274) from [<a00589b8>] 
(run_workqueue+0xe0/0x1a4)
  r6:c5b9c180 r5:c786f580 r4:c5b9c184
[<a00588d8>] (run_workqueue+0x0/0x1a4) from [<a00590d0>] 
(worker_thread+0x104/0x118)
[<a0058fcc>] (worker_thread+0x0/0x118) from [<a005cd5c>] (kthread+0x58/0x90)
  r7:00000000 r6:a0058fcc r5:c786f580 r4:c7884000
[<a005cd04>] (kthread+0x0/0x90) from [<a004ab50>] (do_exit+0x0/0x798)
  r6:00000000 r5:00000000 r4:00000000
Code: e1a01000 e59f000c eb0a89ae e3a03000 (e5833000)
---[ end trace 7cccef3b877a8342 ]---
note: kmmcd[12] exited with preempt_count 1

Best Regards
-- 
Rumjantsev Egor
