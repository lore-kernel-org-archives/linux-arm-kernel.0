From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 23 Jul 2015 18:46:47 +0200
Subject: [PATCH 08/11] MTD: m25p80: Add option to limit SPI transfer size.
In-Reply-To: <201507221101.56441.marex@denx.de>
References: <cover.1433364398.git.hramrach@gmail.com>
 <201507221024.05496.marex@denx.de>
 <CAOMqctTyHF1ciN3-0yg1smYJ5kbuwfT_kmavTL8ARuZ69wSgAg@mail.gmail.com>
 <201507221101.56441.marex@denx.de>
Message-ID: <CAOMqctRnh2RsUYiRr2-+wucaq5NArTNrzPpqdPs+ETrFe9UrZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 July 2015 at 11:01, Marek Vasut <marex@denx.de> wrote:
> On Wednesday, July 22, 2015 at 10:38:14 AM, Michal Suchanek wrote:
>> On 22 July 2015 at 10:24, Marek Vasut <marex@denx.de> wrote:
>> > On Wednesday, July 22, 2015 at 10:18:04 AM, Michal Suchanek wrote:
>> >> On 22 July 2015 at 09:58, Marek Vasut <marex@denx.de> wrote:
>> >> > On Wednesday, July 22, 2015 at 09:45:27 AM, Michal Suchanek wrote:
>> >> >> On 22 July 2015 at 09:33, Marek Vasut <marex@denx.de> wrote:
>> >> >> > On Wednesday, July 22, 2015 at 09:30:54 AM, Michal Suchanek wrote:
>> >> >> >> On 22 July 2015 at 06:49, Vinod Koul <vinod.koul@intel.com> wrote:
>> >> >> >> > On Tue, Jul 21, 2015 at 10:14:11AM +0200, Michal Suchanek wrote:
>> >> >> >> >> > Or alternatively we could publish the limitations of the
>> >> >> >> >> > channel using capabilities so SPI knows I have a dmaengine
>> >> >> >> >> > channel and it can transfer max N length transfers so would
>> >> >> >> >> > be able to break rather than guessing it or coding in DT.
>> >> >> >> >> > Yes it may come from DT but that should be dmaengine driver
>> >> >> >> >> > rather than client driver :)
>> >> >> >> >> >
>> >> >> >> >> > This can be done by dma_get_slave_caps(chan, &caps)
>> >> >> >> >> >
>> >> >> >> >> > And we add max_length as one more parameter to existing set
>> >> >> >> >> >
>> >> >> >> >> > Also all this could be handled in generic SPI-dmaengine layer
>> >> >> >> >> > so that individual drivers don't have to code it in
>> >> >> >> >> >
>> >> >> >> >> > Let me know if this idea is okay, I can push the dmaengine
>> >> >> >> >> > bits...
>> >> >> >> >>
>> >> >> >> >> It would be ok if there was a fixed limit. However, the limit
>> >> >> >> >> depends on SPI slave settings. Presumably for other buses using
>> >> >> >> >> the dmaengine the limit would depend on the bus or slave
>> >> >> >> >> settings as well. I do not see a sane way of passing this all
>> >> >> >> >> the way to the dmaengine driver.
>> >> >> >> >
>> >> >> >> > I don't see why this should be client (SPI) dependent. The max
>> >> >> >> > length supported is a dmaengine constraint, typically flowing
>> >> >> >> > from max blocks/length it can transfer. Know this limit can
>> >> >> >> > allow clients to split transfers.
>> >> >> >>
>> >> >> >> In practice on the board I have the maximum transfer length before
>> >> >> >> it fails depends on SPI bus speed which is set up per slave. I
>> >> >> >> did not try searching the space of possible settings thorougly
>> >> >> >> and settled for a setting that gives reasonable speed and
>> >> >> >> transfer length.
>> >> >> >
>> >> >> > This looks more like a signal integrity issue though.
>> >> >>
>> >> >> It certainly does on the surface. However, when wrong data is
>> >> >> delivered over the SPI bus (such as when I use wrong phase setting)
>> >> >> the SPI controller happily delivers wrong data over PIO.
>> >> >>
>> >> >> The failure I am seeing is that the pl330 DMA program which
>> >> >> repeatedly waits for data from the SPI controller never finishes the
>> >> >> read loop and does not signal the interrupt. It seems it also leaves
>> >> >> some data in a FIFO somewhere so next command on the flash returns
>> >> >> garbage and fails.
>> >> >
>> >> > I observed something similar on MXS (mx28) SPI block. Do you use mixed
>> >> > PIO/DMA mode perhaps ?
>> >>
>> >> The SPI driver uses PIO for short transfers and DMA for transfers
>> >> longer than the controller FIFO. This seems to be the standard way to
>> >> do things.It works flawlessly so long as submitting overly long DMA
>> >> programs is avoided.
>> >
>> > Can you try doing JUST DMA, no PIO ? I remember seeing some bus
>> > synchronisation issues when I did mixed PIO/DMA on the MXS and it was
>> > nasty to track down. Just give pure DMA a go to see if the thing
>> > stabilizes somehow.
>>
>> It's probably slower to set up DMA for 2-byte commands but it might
>> work nonetheless.
>
> It is, the overhead will be considerable. It might help the stability
> though. I'm really looking forward to the results!
>

Hello,

this does not quite work.

My test with spidev:

# ./spinor /dev/spidev1.0
Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60
Sending 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Received 00 ff ff ff ff c8 15 c8 15 c8 15 c8 15 c8 15 c8
Sending 9f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Received 00 ff c8 60 16 c8 60 16 c8 60 16 c8 60 16 c8 60

I receive correct ID but spi-nor complains it does not know ID 00 c8 60.
IIRC garbage should be sent only at the time command is transferred so
only one byte of garbage should be received. Also the garbage tends to
be the last state of the data output - all 0 or all 1.
So it seems using DMA for all transfers including 1-byte commands
results in (some?) received data getting an extra 00 prefix.

[   26.702690] spi spi1.0: setup mode 0, 8 bits/w, 40000000 Hz max --> 0
[   26.703474] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   26.703534] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed 40000000
[   26.703543] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[   26.703568] dma-pl330 121b0000.pdma: setting up request on thread 1
[   26.703576] bc041200:        DMAMOV CCR 0x800201
[   26.703585] bc041206:        DMAMOV SAR 0x6e151280
[   26.703593] bc04120c:        DMAMOV DAR 0x12d30018
[   26.703601] bc041212:        DMAWFPS 5
[   26.703609] bc041214:        DMALDA
[   26.703615] bc041215:        DMASTPS 5
[   26.703625] bc041217:        DMAFLUSHP 5
[   26.703636] bc041219:        DMASEV 1
[   26.703645] bc04121b:        DMAEND
[   26.703668] dma-pl330 121b0000.pdma: event signalled on thread id 1
[   26.703690] spi_master spi1: wait_for_dma: waiting for 100ms
transferring 1bytes at 40000000Hz
[   26.703699] spi_master spi1: wait_for_dma: waited 0 ms
[   26.703711] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed 40000000
[   26.703718] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[   26.703728] dma-pl330 121b0000.pdma: setting up request on thread 0
[   26.703733] bc041000:        DMAMOV CCR 0x804200
[   26.703742] bc041006:        DMAMOV SAR 0x12d3001c
[   26.703749] bc04100c:        DMAMOV DAR 0x6e151281
[   26.703755] bc041012:        DMALP_1 5
[   26.703763] bc041014:        DMAWFPS 4
[   26.703769] bc041016:        DMALDPS 4
[   26.703775] bc041018:        DMASTA
[   26.703781] bc041019:        DMAFLUSHP 4
[   26.703787] bc04101b:        DMALPENDA_1 bjmpto_7
[   26.703795] bc04101d:        DMASEV 0
[   26.703801] bc04101f:        DMAEND
[   26.703815] spi_master spi1: wait_for_dma: waiting for 100ms
transferring 6bytes at 40000000Hz
[   26.703820] dma-pl330 121b0000.pdma: event signalled on thread id 0
[   26.703837] spi_master spi1: wait_for_dma: waited 0 ms
[   26.703866] m25p80 spi1.0: unrecognized JEDEC id bytes: 00, c8, 60
[   26.703885] m25p80: probe of spi1.0 failed with error -2
[   26.703905] s3c64xx-spi 12d30000.spi: registered child spi1.0

[   65.079159] spi spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[   65.079343] spidev spi1.0: buggy DT: spidev listed directly in DT
[   65.079350] ------------[ cut here ]------------
[   65.079362] WARNING: CPU: 1 PID: 3951 at
/scratch/build/linux/drivers/spi/spidev.c:717
spidev_probe+0x1d4/0x1f0()
[   65.079367] Modules linked in: ipv6
[   65.079383] CPU: 1 PID: 3951 Comm: cat Not tainted
4.2.0-rc3-00167-ged73574 #43
[   65.079389] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   65.079406] [<c00168bc>] (unwind_backtrace) from [<c0012fc4>]
(show_stack+0x10/0x14)
[   65.079417] [<c0012fc4>] (show_stack) from [<c066fea8>]
(dump_stack+0x84/0xc4)
[   65.079428] [<c066fea8>] (dump_stack) from [<c00299a0>]
(warn_slowpath_common+0x84/0xb4)
[   65.079437] [<c00299a0>] (warn_slowpath_common) from [<c0029a6c>]
(warn_slowpath_null+0x1c/0x24)
[   65.079446] [<c0029a6c>] (warn_slowpath_null) from [<c03f38a4>]
(spidev_probe+0x1d4/0x1f0)
[   65.079457] [<c03f38a4>] (spidev_probe) from [<c03f1258>]
(spi_drv_probe+0x50/0x74)
[   65.079468] [<c03f1258>] (spi_drv_probe) from [<c03a885c>]
(driver_probe_device+0x1fc/0x43c)
[   65.079480] [<c03a885c>] (driver_probe_device) from [<c03a6a94>]
(bus_for_each_drv+0x64/0x98)
[   65.079489] [<c03a6a94>] (bus_for_each_drv) from [<c03a8588>]
(__device_attach+0x8c/0x108)
[   65.079498] [<c03a8588>] (__device_attach) from [<c03a7b08>]
(bus_probe_device+0x84/0x8c)
[   65.079506] [<c03a7b08>] (bus_probe_device) from [<c03a5cb0>]
(device_add+0x414/0x5a4)
[   65.079514] [<c03a5cb0>] (device_add) from [<c03f187c>]
(spi_add_device+0x94/0x16c)
[   65.079524] [<c03f187c>] (spi_add_device) from [<c03f1d08>]
(of_register_spi_device+0x234/0x2fc)
[   65.079532] [<c03f1d08>] (of_register_spi_device) from [<c03f3350>]
(of_spi_notify+0x88/0xd0)
[   65.079542] [<c03f3350>] (of_spi_notify) from [<c0043170>]
(notifier_call_chain+0x44/0x84)
[   65.079552] [<c0043170>] (notifier_call_chain) from [<c00434cc>]
(__blocking_notifier_call_chain+0x48/0x60)
[   65.079561] [<c00434cc>] (__blocking_notifier_call_chain) from
[<c00434fc>] (blocking_notifier_call_chain+0x18/0x20)
[   65.079572] [<c00434fc>] (blocking_notifier_call_chain) from
[<c0508350>] (__of_changeset_entry_notify+0x84/0xe0)
[   65.079581] [<c0508350>] (__of_changeset_entry_notify) from
[<c0508c08>] (of_changeset_apply+0x78/0x140)
[   65.079591] [<c0508c08>] (of_changeset_apply) from [<c050d5c8>]
(of_overlay_create+0x300/0x490)
[   65.079601] [<c050d5c8>] (of_overlay_create) from [<c050d790>]
(of_overlay_create_store+0x38/0x50)
[   65.079611] [<c050d790>] (of_overlay_create_store) from
[<c01375d4>] (kernfs_fop_write+0xb8/0x19c)
[   65.079622] [<c01375d4>] (kernfs_fop_write) from [<c00daae8>]
(__vfs_write+0x20/0xd8)
[   65.079631] [<c00daae8>] (__vfs_write) from [<c00db308>]
(vfs_write+0x90/0x164)
[   65.079639] [<c00db308>] (vfs_write) from [<c00dbb30>] (SyS_write+0x44/0x9c)
[   65.079647] [<c00dbb30>] (SyS_write) from [<c0010100>]
(ret_fast_syscall+0x0/0x3c)
[   65.079654] ---[ end trace 4cf0fad6e5c33d55 ]---
[   65.079957] s3c64xx-spi 12d30000.spi: registered child spi1.0
[   91.215230] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[   91.215242] spidev spi1.0: spi mode 0
[   91.215276] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[   91.215282] spidev spi1.0: msb first
[   91.215314] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[   91.215319] spidev spi1.0: 0 bits per word
[   91.215351] spidev spi1.0: setup mode 0, 8 bits/w, 1000000 Hz max --> 0
[   91.215424] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.215460] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed 1000000
[   91.215467] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.215500] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[   91.215515] dma-pl330 121b0000.pdma: setting up request on thread 1
[   91.215520] bc041200:        DMAMOV CCR 0x800201
[   91.215526] bc041206:        DMAMOV SAR 0x6d842000
[   91.215532] bc04120c:        DMAMOV DAR 0x12d30018
[   91.215538] bc041212:        DMAWFPS 5
[   91.215543] bc041214:        DMALDA
[   91.215548] bc041215:        DMASTPS 5
[   91.215553] bc041217:        DMAFLUSHP 5
[   91.215558] bc041219:        DMASEV 1
[   91.215563] bc04121b:        DMAEND
[   91.215577] dma-pl330 121b0000.pdma: setting up request on thread 0
[   91.215581] bc041000:        DMAMOV CCR 0x804200
[   91.215586] bc041006:        DMAMOV SAR 0x12d3001c
[   91.215592] bc04100c:        DMAMOV DAR 0x6d845000
[   91.215597] bc041012:        DMAWFPS 4
[   91.215602] bc041014:        DMALDPS 4
[   91.215607] bc041016:        DMASTA
[   91.215612] bc041017:        DMAFLUSHP 4
[   91.215617] bc041019:        DMASEV 0
[   91.215622] bc04101b:        DMAEND
[   91.215632] dma-pl330 121b0000.pdma: event signalled on thread id 1
[   91.215646] spi_master spi1: wait_for_dma: waiting for 100ms
transferring 1bytes at 1000000Hz
[   91.215650] dma-pl330 121b0000.pdma: event signalled on thread id 0
[   91.215680] spi_master spi1: wait_for_dma: waited 0 ms
[   91.215803] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.215836] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed 1000000
[   91.215844] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.215878] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[   91.215887] dma-pl330 121b0000.pdma: setting up request on thread
1[   91.215891] bc041200:        DMAMOV CCR 0x800201
[   91.215898] bc041206:        DMAMOV SAR 0x6d842000
[   91.215903] bc04120c:        DMAMOV DAR 0x12d30018
[   91.215909] bc041212:        DMALP_1 1
[   91.215914] bc041214:        DMAWFPS 5
[   91.215920] bc041216:        DMALDA
[   91.215925] bc041217:        DMASTPS 5
[   91.215931] bc041219:        DMAFLUSHP 5
[   91.215936] bc04121b:        DMALPENDA_1 bjmpto_7
[   91.215948] bc04121d:        DMASEV 1
[   91.215959] bc04121f:        DMAEND
[   91.215974] dma-pl330 121b0000.pdma: setting up request on thread 0
[   91.215978] bc041000:        DMAMOV CCR 0x804200
[   91.215984] bc041006:        DMAMOV SAR 0x12d3001c
[   91.215989] bc04100c:        DMAMOV DAR 0x6d845000
[   91.215994] bc041012:        DMALP_1 1
[   91.216000] bc041014:        DMAWFPS 4
[   91.216005] bc041016:        DMALDPS 4
[   91.216014] bc041018:        DMASTA
[   91.216023] bc041019:        DMAFLUSHP 4
[   91.216028] bc04101b:        DMALPENDA_1 bjmpto_7
[   91.216033] bc04101d:        DMASEV 0
[   91.216038] bc04101f:        DMAEND
[   91.216050] spi_master spi1: wait_for_dma: waiting for 100ms
transferring 2bytes at 1000000Hz
[   91.216055] dma-pl330 121b0000.pdma: event signalled on thread id 1
[   91.216064] dma-pl330 121b0000.pdma: event signalled on thread id 0
[   91.216579] spi_master spi1: wait_for_dma: waited 0 ms
[   91.216655] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.216678] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed 1000000
[   91.216684] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[   91.216716] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[   91.216726] dma-pl330 121b0000.pdma: setting up request on thread 1
[   91.216730] bc041200:        DMAMOV CCR 0x800201
[   91.216736] bc041206:        DMAMOV SAR 0x6d842000
[   91.216741] bc04120c:        DMAMOV DAR 0x12d30018
[   91.216747] bc041212:        DMALP_1 3
[   91.216752] bc041214:        DMAWFPS 5
[   91.216757] bc041216:        DMALDA
[   91.216762] bc041217:        DMASTPS 5
[   91.216767] bc041219:        DMAFLUSHP 5
[   91.216772] bc04121b:        DMALPENDA_1 bjmpto_7
[   91.216777] bc04121d:        DMASEV 1
[   91.216782] bc04121f:        DMAEND
[   91.216794] dma-pl330 121b0000.pdma: setting up request on thread 0
[   91.216797] bc041000:        DMAMOV CCR 0x804200
[   91.216803] bc041006:        DMAMOV SAR 0x12d3001c
[   91.216808] bc04100c:        DMAMOV DAR 0x6d845000
[   91.216813] bc041012:        DMALP_1 3
[   91.216818] bc041014:        DMAWFPS 4
[   91.216823] bc041016:        DMALDPS 4
[   91.216828] bc041018:        DMASTA
[   91.216833] bc041019:        DMAFLUSHP 4
[   91.216838] bc04101b:        DMALPENDA_1 bjmpto_7
[   91.216844] bc04101d:        DMASEV 0
[   91.216849] bc04101f:        DMAEND
[   91.216860] spi_master spi1: wait_for_dma: waiting for 100ms
transferring 4bytes at 1000000Hz
[   91.216865] dma-pl330 121b0000.pdma: event signalled on thread id 1
[   91.216891] dma-pl330 121b0000.pdma: event signalled on thread id 0
[   91.216910] spi_master spi1: wait_for_dma: waited 0 ms

The parallel transfer of command and reply seems particualrly dodgy in
this case.

I also managed to lock up the controller completely since there is
some error passing the SPI speed somewhere :(

[ 1352.977530] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[ 1352.977540] spidev spi1.0: spi mode 0
[ 1352.977576] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[ 1352.977582] spidev spi1.0: msb first
[ 1352.977614] spidev spi1.0: setup mode 0, 8 bits/w, 80000000 Hz max --> 0
[ 1352.977620] spidev spi1.0: 0 bits per word
[ 1352.977652] spidev spi1.0: setup mode 0, 8 bits/w, 2690588672 Hz max --> 0
[ 1352.977726] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[ 1352.977753] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: xfer
bpw 8 speed -1604378624
[ 1352.977760] spi_master spi1: s3c64xx_spi_config: clk_from_cmu 1
src_clk sclk_spi1 mode bpw 8
[ 1352.977781] spi_master spi1: spi1.0 s3c64xx_spi_transfer_one: using dma
[ 1352.977797] dma-pl330 121b0000.pdma: setting up request on thread 1
