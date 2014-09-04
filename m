From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 04 Sep 2014 10:45:19 +0200
Subject: [PATCH] mfd: twl4030-power: Fix PM idle pin configuration to
 not conflict with regulators
In-Reply-To: <20140903183901.GF11766@atomide.com>
References: <20140819152405.GA12002@atomide.com>
 <20140902082931.GA32460@breakpoint.cc> <20140903002445.GD11766@atomide.com>
 <5406D388.5050104@linutronix.de> <20140903183901.GF11766@atomide.com>
Message-ID: <5408269F.7030400@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 08:39 PM, Tony Lindgren wrote:
>> good.txt and bad.txt are from the late_initcall.
>>
>>  $ diff -u good.txt bad.txt
>> --- good.txt    2014-09-03 10:29:58.920317368 +0200
>> +++ bad.txt     2014-09-03 10:28:57.064313222 +0200
> 
> Hmm can you check that you have good.txt and bad.txt the
> right way? I'd assume you need VAUX2 or VAUX3 enabled
> not disabled for the MMC to work?

No, it was correct. If you look at the complete file you will notice
the - which removes the mmc detect/mount in the bad case and + which
adds the -110 error

>> @@ -1,13 +1,13 @@
>>   1: addr: 0x0017 grp: 0x0000 type: 0x0000 remap: 0x0008
>> - 2: addr: 0x001b grp: 0x0000 type: 0x0000 remap: 0x0008
>> - 3: addr: 0x001f grp: 0x0000 type: 0x0000 remap: 0x0008
>> + 2: addr: 0x001b grp: 0x002e type: 0x0000 remap: 0x0008
>> + 3: addr: 0x001f grp: 0x002e type: 0x0000 remap: 0x0008
> 
> OK so looking at res_config_addrs[], we have RES_VAUX2 at
> 0x1b and RES_VAUX3 at 0x1f. The value for the group register
> 0x2e means that bit5 is set and it's used by the p1 device
> group. So when the group register is 0x2e, the resource is
> enabled. Those got most likely enabled by twl-regulator.c
> as twl4030-power.c has TWL4030_RESCONFIG_UNDEF for VAUX2 and
> VAUX3.
> 
>>   4: addr: 0x0023 grp: 0x0000 type: 0x0000 remap: 0x0008
>>   5: addr: 0x0027 grp: 0x002e type: 0x0000 remap: 0x0008
>>   6: addr: 0x002b grp: 0x0000 type: 0x0000 remap: 0x0008
>>   7: addr: 0x002f grp: 0x002e type: 0x000b remap: 0x0000
>>   8: addr: 0x0033 grp: 0x002e type: 0x0000 remap: 0x0008
>>   9: addr: 0x0037 grp: 0x002e type: 0x0000 remap: 0x0008
>> -10: addr: 0x003b grp: 0x0000 type: 0x0000 remap: 0x0008
>> +10: addr: 0x003b grp: 0x002e type: 0x0000 remap: 0x0008
> 
> And that's RES_VDAC at 0x3b with the same story, it's also
> marked TWL4030_RESCONFIG_UNDEF and only modified by the
> twl4030-power.c.
> 
> I think the use on beaglboard for these are:
> 
> VAUX2	USB_1V8
> VAUX3	CAM_CORE
> VDAC	VDAC_1V8
> 
> Not quite seeing the connection.. But I'm assuming you have
> good.txt and bad.txt the wrong way around, and you need
> VAUX2, VAUX3 or VDAC _enabled_ to get MMC working :)
> 
> So this seems to hint we have issue in one of these:
> 
> 1. We are not claiming VAUX2, VAUX3 or VDAC for beagleboard,
>    and there's now a timing issue where the regulator
>    framework disables the unused regulators before MMC.
> 
> 2. We may have a bug that causes register access to
>    DEV_GRP_OFFSET in twl4030-power.c even with those
>    resources marked as TWL4030_RESCONFIG_UNDEF.
> 
> 3. There's a I2C race somewhere accessing twl registers.
> 
> Guessing #1 above, maybe give the following patch a try
> and see if that helps? If that works, try commenting out
> vaux3 or vdac and see which one is needed. I'm guessing
> it's the vdac.

With that patch it seems it is a little harder to trigger. It is
usually every other boot that fails. Here a diff between two that
worked (say good-v1 vs good-v2):

@@ -151,19 +151,15 @@
 Btrfs loaded
 hsusb2_vbus: 3300 mV
 1: addr: 0x0017 grp: 0x0000 type: 0x0000 remap: 0x0008
-2: addr: 0x001b grp: 0x002e type: 0x0000 remap: 0x0008
-3: addr: 0x001f grp: 0x002e type: 0x0000 remap: 0x0008
+2: addr: 0x001b grp: 0x0000 type: 0x0000 remap: 0x0008
+3: addr: 0x001f grp: 0x0000 type: 0x0000 remap: 0x0008
 4: addr: 0x0023 grp: 0x0000 type: 0x0000 remap: 0x0008
 5: addr: 0x0027 grp: 0x002e type: 0x0000 remap: 0x0008
 6: addr: 0x002b grp: 0x0000 type: 0x0000 remap: 0x0008
 7: addr: 0x002f grp: 0x002e type: 0x000b remap: 0x0000
 8: addr: 0x0033 grp: 0x002e type: 0x0000 remap: 0x0008
-mmc0: host does not support reading read-only switch. assuming
write-enable.
 9: addr: 0x0037 grp: 0x002e type: 0x0000 remap: 0x0008
-mmc0: new high speed SDHC card at address 1234
-mmcblk0: mmc0:1234 SA04G 3.63 GiB
-10: addr: 0x003b grp: 0x002e type: 0x0000 remap: 0x0008
- mmcblk0: p1 p2 p3
+10: addr: 0x003b grp: 0x0000 type: 0x0000 remap: 0x0008
 11: addr: 0x003f grp: 0x00ef type: 0x0011 remap: 0x0008
 12: addr: 0x0043 grp: 0x00ef type: 0x0010 remap: 0x0008
 13: addr: 0x0047 grp: 0x00ef type: 0x0011 remap: 0x0008
@@ -173,8 +169,12 @@
 17: addr: 0x0071 grp: 0x0000 type: 0x0000 remap: 0x0008
 18: addr: 0x0074 grp: 0x0000 type: 0x0000 remap: 0x0008
 19: addr: 0x0077 grp: 0x00ef type: 0x0000 remap: 0x0008
+mmc0: host does not support reading read-only switch. assuming
write-enable.
 20: addr: 0x007a grp: 0x0000 type: 0x0000 remap: 0x0000
+mmc0: new high speed SDHC card at address 1234
+mmcblk0: mmc0:1234 SA04G 3.63 GiB
 21: addr: 0x007f grp: 0x00ef type: 0x000a remap: 0x0008
+ mmcblk0: p1 p2 p3
 22: addr: 0x0082 grp: 0x00ee type: 0x0008 remap: 0x0008
 23: addr: 0x0085 grp: 0x00af type: 0x0013 remap: 0x0000
 24: addr: 0x0088 grp: 0x00ef type: 0x000e remap: 0x0008

It took mmc a little longer to detect but it worked. And the content of
the three registers seem not to matter _or_ it was dumped before MMC
got active.

Now a diff of good v1 vs bad:

@@ -158,12 +158,8 @@
 6: addr: 0x002b grp: 0x0000 type: 0x0000 remap: 0x0008
 7: addr: 0x002f grp: 0x002e type: 0x000b remap: 0x0000
 8: addr: 0x0033 grp: 0x002e type: 0x0000 remap: 0x0008
-mmc0: host does not support reading read-only switch. assuming
write-enable.
 9: addr: 0x0037 grp: 0x002e type: 0x0000 remap: 0x0008
-mmc0: new high speed SDHC card at address 1234
-mmcblk0: mmc0:1234 SA04G 3.63 GiB
 10: addr: 0x003b grp: 0x002e type: 0x0000 remap: 0x0008
- mmcblk0: p1 p2 p3
 11: addr: 0x003f grp: 0x00ef type: 0x0011 remap: 0x0008
 12: addr: 0x0043 grp: 0x00ef type: 0x0010 remap: 0x0008
 13: addr: 0x0047 grp: 0x00ef type: 0x0011 remap: 0x0008
@@ -183,19 +179,13 @@
 27: addr: 0x0091 grp: 0x00ee type: 0x0006 remap: 0x0008
 28: addr: 0x0094 grp: 0x00ef type: 0x0000 remap: 0x0008
 input: gpio_keys as /devices/gpio_keys/input/input2
-twl_rtc 48070000.i2c:twl at 48:rtc: setting system clock to 2000-01-01
00:02:39 UTC (946684959)
+twl_rtc 48070000.i2c:twl at 48:rtc: setting system clock to 2000-01-01
00:02:47 UTC (946684967)
 sr_init: No PMIC hook to init smartreflex
 smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
 smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
 hsusb2_vbus: disabling
 VPLL2: disabling
 VUSB3V1: disabling
-BTRFS: device fsid 2e050bbb-1520-425e-a215-1e5bf865c7dc devid 1 transid
1189 /dev/root
-BTRFS info (device mmcblk0p2): disk space caching is enabled
-BTRFS: detected SSD devices, enabling SSD mode
-VFS: Mounted root (btrfs filesystem) readonly on device 0:13.
-devtmpfs: mounted
-Freeing unused kernel memory: 316K (c057a000 - c05c9000)
-BTRFS info (device mmcblk0p2): disk space caching is enabled
-
-(none) login: [    5.252380] SysRq : Resetting
+Waiting for root device /dev/mmcblk0p2...
+mmc0: card never left busy state
+mmc0: error -110 whilst initialising SD card

I didn't change a thing, I just pressed reset. As you see the content
of the TWL registers don't seem to be that important since it was the
same at the time of the dump. And the mmc didn't came back.

> 
> Regards,
> 
> Tony
> 
Sebastian
