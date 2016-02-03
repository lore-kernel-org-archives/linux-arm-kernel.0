From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Wed, 3 Feb 2016 09:03:48 +0200
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160203000045.GE19432@atomide.com>
References: <568D5F54.7040900@gmail.com> <20160107180700.GN12777@atomide.com>
 <568EDC8D.7070205@gmail.com> <20160108022619.GS12777@atomide.com>
 <568F4596.8020206@gmail.com> <20160108075913.GN11364@pali>
 <569052FE.1040008@gmail.com> <20160121091437.GT7192@pali>
 <56B077D4.3030902@gmail.com> <20160202233911.GB19432@atomide.com>
 <20160203000045.GE19432@atomide.com>
Message-ID: <56B1A654.1060905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On  3.02.2016 02:00, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [160202 15:40]:
>> * Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [160202 01:34]:
>>> On 21.01.2016 11:14, Pali Roh?r wrote:
>>>> On Saturday 09 January 2016 02:23:26 Ivaylo Dimitrov wrote:
>>>>> The key word here is "sometimes". i.e sometimes it hapens on normal reboot,
>>>>> sometimes it happens on oops.
>>>>
>>>> So where is problem? In omap-gpmc? mtd? onenand? or ubifs? Or in
>>>> different component? Do we know at least this?
>>>>
>>>
>>> I think I made some progress on the issue, it seems I have to have *both*
>>> e7b11dc7b77bfce0a351230a5feeadc1d0bba997
>>> (e7b11dc7b77bfce0a351230a5feeadc1d0bba997) reverted *and*
>>> HWMOD_INIT_NO_RESET restored in omap3xxx_gpmc_hwmod flags to have working
>>> onenand.
>>
>> That is strange. This is what I get with omap2plus_defconfig and
>> omap-for-v4.5/fixes-rc1 after flashing the rootfs and booting kernel
>> like you suggested on irc:

What I forgot to tell on IRC is that you should try to boot stock kernel 
after booting mainline. Here it spits a lot of ECC errors (I have 
framebuffer console enabled to see those) and refuses to mount rootfs.

>>
>> # dmesg | grep -i -e ubi -e onenand
>> [    2.502899] omap2-onenand omap2-onenand: initializing on CS0, phys base 0x01000000, virtual base d0940000, freq 83 MHz
>> [    2.514373] OneNAND Manufacturer: Numonyx (0x20)
>> [    2.519287] Muxed OneNAND 256MB 1.8V 16-bit (0x40)
>> [    2.524444] OneNAND version = 0x0031

Exactly the same chip here.

>> [    2.671966] 6 ofpart partitions found on MTD device omap2-onenand
>> [    2.678436] Creating 6 MTD partitions on "omap2-onenand":
>> [    3.414764] ubi0: attaching mtd5
>> [    3.668212] ubi0: scanning is finished
>> [    3.716552] ubi0: attached mtd5 (name "rootfs", size 251 MiB)
>> [    3.722839] ubi0: PEB size: 131072 bytes (128 KiB), LEB size: 129024 bytes
>> [    3.730194] ubi0: min./max. I/O unit sizes: 2048/2048, sub-page size 512
>> [    3.737304] ubi0: VID header offset: 512 (aligned 512), data offset: 2048
>> [    3.744537] ubi0: good PEBs: 2010, bad PEBs: 0, corrupted PEBs: 0
>> [    3.751037] ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
>> [    3.758697] ubi0: max/mean erase counter: 1/0, WL threshold: 4096, image sequence number: 0
>> [    3.767578] ubi0: available PEBs: 0, total reserved PEBs: 2010, PEBs reserved for bad PEB handling: 40
>> [    3.923980] ubi0: background thread "ubi_bgt0d" started, PID 85
>> [    3.980529] UBIFS (ubi0:0): background thread "ubifs_bgt0_0" started, PID 87
>> [    3.996337] UBIFS (ubi0:0): recovery needed
>> [    4.079925] UBIFS (ubi0:0): recovery completed
>> [    4.085876] UBIFS (ubi0:0): UBIFS: mounted UBI device 0, volume 0, name "rootfs"
>> [    4.093780] UBIFS (ubi0:0): LEB size: 129024 bytes (126 KiB), min./max. I/O unit sizes: 2048 bytes/2048 bytes
>> [    4.104339] UBIFS (ubi0:0): FS size: 252241920 bytes (240 MiB, 1955 LEBs), journal size 9033728 bytes (8 MiB, 71 LEBs)
>> [    4.115722] UBIFS (ubi0:0): reserved for root: 4190434 bytes (4092 KiB)
>> [    4.122772] UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID 8F30A88A-F605-4291-9927-00CF3A2AE119, small LPT model
>> [    4.136077] VFS: Mounted root (ubifs filesystem) on device 0:15.
>>
>> I copied over the modules to this rootfs too :) But in general onenand
>> seems to behave for me.
>

Yes, initially it works, but is corrupted after a reboot or two here.

> And ere are my GPCM timings when booted with GPMC_DEBUG
> in case they are different somehow for your device.
>
> Regards,
>
> Tony
>
> omap-gpmc 6e000000.gpmc: GPMC revision 5.0
> GPMC CS0: cs_on            :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: cs_rd_off        :  14 ticks,  84 ns (was  16 ticks)  84 ns
> GPMC CS0: cs_wr_off        :  19 ticks, 114 ns (was  16 ticks) 114 ns
> GPMC CS0: adv_on           :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: adv_rd_off       :   3 ticks,  18 ns (was   2 ticks)  18 ns
> GPMC CS0: adv_wr_off       :   3 ticks,  18 ns (was   2 ticks)  18 ns
> GPMC CS0: oe_on            :   5 ticks,  30 ns (was   2 ticks)  30 ns
> GPMC CS0: oe_off           :  14 ticks,  84 ns (was  16 ticks)  84 ns
> GPMC CS0: we_on            :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: we_off           :  14 ticks,  84 ns (was  16 ticks)  84 ns
> GPMC CS0: rd_cycle         :  18 ticks, 108 ns (was  19 ticks) 108 ns
> GPMC CS0: wr_cycle         :  17 ticks, 102 ns (was  19 ticks) 102 ns
> GPMC CS0: access           :  13 ticks,  78 ns (was  15 ticks)  78 ns
> GPMC CS0: page_burst_access:   0 ticks,   0 ns (was   2 ticks)   0 ns
> GPMC CS0: bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
> GPMC CS0: wr_access        :  13 ticks,  78 ns (was  15 ticks)  78 ns
> GPMC CS0: wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: clk_activation   :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0 CLK period is 6 ns (div 1)
> gpmc cs0 after gpmc_cs_set_timings:
> cs0 GPMC_CS_CONFIG1: 0xd9001200
> cs0 GPMC_CS_CONFIG2: 0x00130e00
> cs0 GPMC_CS_CONFIG3: 0x00030300
> cs0 GPMC_CS_CONFIG4: 0x0e000e05
> cs0 GPMC_CS_CONFIG5: 0x000d1112
> cs0 GPMC_CS_CONFIG6: 0x8d050000
> gpmc cs0 access configuration:
> gpmc,mux-add-data = <2>
> gpmc,device-width = <1>
> gpmc,wait-pin = <0>
> gpmc,burst-length = <16>
> gpmc,sync-write = <1>
> gpmc,burst-write = <1>
> gpmc,burst-read = <1>
> gpmc,burst-wrap = <1>
> gpmc cs0 timings configuration:
> gpmc,cs-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,cs-rd-off-ns = <84> /* 79 ns - 84 ns; 14 ticks */
> gpmc,cs-wr-off-ns = <114> /* 109 ns - 114 ns; 19 ticks */
> gpmc,adv-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,adv-rd-off-ns = <18> /* 13 ns - 18 ns; 3 ticks */
> gpmc,adv-wr-off-ns = <18> /* 13 ns - 18 ns; 3 ticks */
> gpmc,oe-on-ns = <30> /* 25 ns - 30 ns; 5 ticks */
> gpmc,oe-off-ns = <84> /* 79 ns - 84 ns; 14 ticks */
> gpmc,we-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,we-off-ns = <84> /* 79 ns - 84 ns; 14 ticks */
> gpmc,rd-cycle-ns = <108> /* 103 ns - 108 ns; 18 ticks */
> gpmc,wr-cycle-ns = <102> /* 97 ns - 102 ns; 17 ticks */
> gpmc,access-ns = <78> /* 73 ns - 78 ns; 13 ticks */
> gpmc,page-burst-access-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,bus-turnaround-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,clk-activation-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
> gpmc,wr-access-ns = <78> /* 73 ns - 78 ns; 13 ticks */
> GPMC CS0: cs_on            :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: cs_rd_off        :  16 ticks,  96 ns (was  14 ticks)  96 ns
> GPMC CS0: cs_wr_off        :  16 ticks,  96 ns (was  19 ticks)  96 ns
> GPMC CS0: adv_on           :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: adv_rd_off       :   2 ticks,  12 ns (was   3 ticks)  12 ns
> GPMC CS0: adv_wr_off       :   2 ticks,  12 ns (was   3 ticks)  12 ns
> GPMC CS0: oe_on            :   3 ticks,  18 ns (was   5 ticks)  18 ns
> GPMC CS0: oe_off           :  16 ticks,  96 ns (was  14 ticks)  96 ns
> GPMC CS0: we_on            :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: we_off           :  16 ticks,  96 ns (was  14 ticks)  96 ns
> GPMC CS0: rd_cycle         :  19 ticks, 114 ns (was  18 ticks) 114 ns
> GPMC CS0: wr_cycle         :  19 ticks, 114 ns (was  17 ticks) 114 ns
> GPMC CS0: access           :  15 ticks,  90 ns (was  13 ticks)  90 ns
> GPMC CS0: page_burst_access:   2 ticks,  12 ns (was   0 ticks)  12 ns
> GPMC CS0: bus_turnaround   :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: cycle2cycle_delay:   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: wr_data_mux_bus  :   5 ticks,  30 ns (was   5 ticks)  30 ns
> GPMC CS0: wr_access        :  15 ticks,  90 ns (was  13 ticks)  90 ns
> GPMC CS0: wait_monitoring  :   0 ticks,   0 ns (was   0 ticks)   0 ns
> GPMC CS0: clk_activation   :   1 ticks,   6 ns (was   0 ticks)   6 ns
> GPMC CS0 CLK period is 12 ns (div 2)
> gpmc cs0 after gpmc_cs_set_timings:
> cs0 GPMC_CS_CONFIG1: 0xfb001201
> cs0 GPMC_CS_CONFIG2: 0x00101000
> cs0 GPMC_CS_CONFIG3: 0x00020200
> cs0 GPMC_CS_CONFIG4: 0x10001003
> cs0 GPMC_CS_CONFIG5: 0x020f1313
> cs0 GPMC_CS_CONFIG6: 0x8f050000
> gpmc cs0 access configuration:
> gpmc,mux-add-data = <2>
> gpmc,device-width = <1>
> gpmc,wait-pin = <0>
> gpmc,burst-length = <16>
> gpmc,sync-write = <1>
> gpmc,burst-write = <1>
> gpmc,gpmc,sync-read = <1>
> gpmc,burst-read = <1>
> gpmc,burst-wrap = <1>
> gpmc cs0 timings configuration:
> gpmc,cs-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,cs-rd-off-ns = <96> /* 91 ns - 96 ns; 16 ticks */
> gpmc,cs-wr-off-ns = <96> /* 91 ns - 96 ns; 16 ticks */
> gpmc,adv-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,adv-rd-off-ns = <12> /* 7 ns - 12 ns; 2 ticks */
> gpmc,adv-wr-off-ns = <12> /* 7 ns - 12 ns; 2 ticks */
> gpmc,oe-on-ns = <18> /* 13 ns - 18 ns; 3 ticks */
> gpmc,oe-off-ns = <96> /* 91 ns - 96 ns; 16 ticks */
> gpmc,we-on-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,we-off-ns = <96> /* 91 ns - 96 ns; 16 ticks */
> gpmc,rd-cycle-ns = <114> /* 109 ns - 114 ns; 19 ticks */
> gpmc,wr-cycle-ns = <114> /* 109 ns - 114 ns; 19 ticks */
> gpmc,access-ns = <90> /* 85 ns - 90 ns; 15 ticks */
> gpmc,page-burst-access-ns = <12> /* 7 ns - 12 ns; 2 ticks */
> gpmc,bus-turnaround-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,cycle2cycle-delay-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,wait-monitoring-ns = <0> /* 0 ns - 0 ns; 0 ticks */
> gpmc,clk-activation-ns = <6> /* 1 ns - 6 ns; 1 ticks */
> gpmc,wr-data-mux-bus-ns = <30> /* 25 ns - 30 ns; 5 ticks */
> gpmc,wr-access-ns = <90> /* 85 ns - 90 ns; 15 ticks */
> omap2-onenand omap2-onenand: initializing on CS0, phys base 0x04000000, virtual base d0940000, freq 83 MHz
> OneNAND Manufacturer: Numonyx (0x20)
> Muxed OneNAND 256MB 1.8V 16-bit (0x40)
> OneNAND version = 0x0031
> Chip support all block unlock
> Chip has 2 plane
> Scanning device for bad blocks
> 6 ofpart partitions found on MTD device omap2-onenand
> Creating 6 MTD partitions on "omap2-onenand":
> 0x000000000000-0x000000020000 : "bootloader"
> 0x000000020000-0x000000080000 : "config"
> 0x000000080000-0x0000000c0000 : "log"
> mtdoops: ready 43, 6188 (no erase)
> mtdoops: Attached to MTD device 2
> 0x0000000c0000-0x0000002c0000 : "kernel"
> 0x0000002c0000-0x0000004c0000 : "initfs"
> 0x0000004c0000-0x000010000000 : "rootfs"
>

Exactly the same log here, besides "mtdoops: ready 36, 959521164 (no 
erase)", no idea what that "959521164" is supposed to mean.

May I ask you to send me the full boot log with omap2plus_defconfig 
kernel booting mtd5 maemo rootfs, until it restarts and the next boot 
log with the stock kernel. It could be there is some other driver acting 
here (g_nokia for example) you don't have enabled in your config.

I will play a bit more with omap2plus_defconfig here in attempt to make 
it boot, to see if I can recreate the issue.

Also, I looked at the TRM and GPMC has more stuff than timings, like 
PRFETCH and ECC. Will dump those with and without HWMOD_INIT_NO_RESET to 
see if there is any difference.

Thanks,
Ivo
