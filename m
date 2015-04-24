From: john.tobias.ph@gmail.com (John Tobias)
Date: Thu, 23 Apr 2015 17:50:33 -0700
Subject: Broadcom 43340 module on iMX6DL
In-Reply-To: <55394141.1080601@broadcom.com>
References: <CACUGKYMXr3ASbB9fCk+GBnpfMC1kf_+NxDsOF_FODBKRAN9YvQ@mail.gmail.com>
 <55393C45.3060105@broadcom.com>
 <CACUGKYPHKGoLEfNPNvtHwtCA9jB_ZLamzF_PViDfQnpnc8Y-=A@mail.gmail.com>
 <55394141.1080601@broadcom.com>
Message-ID: <CACUGKYNxg62zAozJ1K4FEoqxeVwE8B2Wr3L9ZsND=HaWY7sitw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Guys,

I have a follow up questions:


When the I power up the brcm44340 without loading the driver, the
sdhci-esdhc-imx host controller configured it with the following info
(cat /sys/kernel/debug/mmc0/ios):
clock: 50000000 Hz
actual clock: 49500000 Hz
vdd: 17 (2.9 ~ 3.0 V)
bus mode: 2 (push-pull)
chip select: 0 (don't care)
power mode: 2 (on)
bus width: 2 (4 bits)
timing spec: 2 (sd high-speed)
signal voltage: 0 (3.30 V)


Then, when I load the bcmdhd driver, the driver changed the clock to:
clock: 400000 Hz
actual clock: 386718 Hz
vdd: 17 (2.9 ~ 3.0 V)
bus mode: 2 (push-pull)
chip select: 0 (don't care)
power mode: 2 (on)
bus width: 0 (1 bits)
timing spec: 0 (legacy)
signal voltage: 0 (3.30 V)

Trace from sdhci-esdhc-imx:
MMC0: sdhci-esdhc-imx:  desired SD clock: 400000, actual: 386718
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 400000, actual: 386718
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 400000, actual: 386718
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 400000, actual: 386718
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 400000, actual: 386718
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 300000, actual: 281250
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 300000, actual: 281250
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 300000, actual: 281250
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 300000, actual: 281250
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 300000, actual: 281250
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  change pinctrl state for uhs 0
MMC0: sdhci-esdhc-imx:  desired SD clock: 200000, actual: 193359

Does the driver need to change the clock when loading the firmware?.

Is it possible to tell to the driver to skip changing the clock?.

Or any work around for the problem?.

Note: attached is a verbose logs of the driver.

Regards,

John

On Thu, Apr 23, 2015 at 12:00 PM, Arend van Spriel <arend@broadcom.com> wrote:
> + John Stultz
>
>
> On 04/23/15 20:44, John Tobias wrote:
>>
>> Thanks Dmitry for the info.
>>
>> Arend:
>>
>> Yes, it's an android... Here's the info:
>>
>> 00060e80  de 02 f0 18 8c 00 e8 5e  8f 00 37 a3 00 e0 5e 8a
>> |.......^..7...^.|
>> 00060e90  f4 77 a2 00 02 de 02 f0  00 00 01 bc 60 03 00 07
>> |.w..........`...|
>> 00060ea0  aa 01 bc 60 03 00 07 ab  01 bc 60 03 00 07 b7 01
>> |...`......`.....|
>> 00060eb0  bc 60 13 08 17 a1 00 02  5e 02 f0 01 28 00 b0 40
>> |.`......^...(..@|
>> 00060ec0  67 00 17 a3 01 80 60 02  03 37 a2 00 02 5e 02 f0
>> |g.....`..7...^..|
>> 00060ed0  01 2c 00 b0 5e 8f 00 17  a2 00 02 5e 02 f0 01 2c
>> |.,..^......^...,|
>> 00060ee0  00 02 de 02 f0 00 00 01  bc 60 63 00 10 7b 00 b0
>> |.........`c..{..|
>> 00060ef0  5e 8b 00 10 7a 01 ac 60  7e f4 30 75 02 87 41 d7
>> |^...z..`~.0u..A.|
>> 00060f00  00 18 9c 00 02 de 02 f0  00 00 01 bc 60 63 00 10
>> |............`c..|
>> 00060f10  7b 00 b0 5e 8b 00 10 7a  01 ac 60 be f4 30 75 02
>> |{..^...z..`..0u.|
>> 00060f20  87 41 d7 00 18 a1 00 02  de 02 f0 00 00 00 00 00
>> |.A..............|
>> 00060f30  00 00 00 00 7c ac 00 00  2d cb a7 58 06 0a be 31
>> |....|...-..X...1|
>> 00060f40  b1 8d a0 53 00 5b 07 49  45 13 20 4e 7d 7e 47 28  |...S.[.IE.
>> N}~G(|
>> 00060f50  08 7c 77 d2 bc 44 87 13  01 bd 32 08 01 00 34 33
>> |.|w..D....2...43|
>> 00060f60  33 34 31 62 30 2d 72 6f  6d 6c 2f 73 64 69 6f 2d
>> |341b0-roml/sdio-|
>> 00060f70  61 67 2d 70 6e 6f 2d 70  32 70 2d 63 63 78 2d 65
>> |ag-pno-p2p-ccx-e|
>> 00060f80  78 74 73 75 70 2d 70 72  6f 70 74 78 73 74 61 74
>> |xtsup-proptxstat|
>> 00060f90  75 73 2d 64 6d 61 74 78  72 63 2d 72 78 6f 76 2d
>> |us-dmatxrc-rxov-|
>> 00060fa0  70 6b 74 66 69 6c 74 65  72 2d 6b 65 65 70 61 6c
>> |pktfilter-keepal|
>> 00060fb0  69 76 65 2d 61 6f 65 2d  76 73 64 62 2d 73 72 2d
>> |ive-aoe-vsdb-sr-|
>> 00060fc0  77 61 70 69 2d 77 6c 31  31 64 2d 61 75 74 6f 61
>> |wapi-wl11d-autoa|
>> 00060fd0  62 6e 2d 6c 70 63 2d 70  63 6c 6f 73 65 2d 70 32
>> |bn-lpc-pclose-p2|
>> 00060fe0  70 6f 2d 77 6c 31 31 75  20 56 65 72 73 69 6f 6e  |po-wl11u
>> Version|
>> 00060ff0  3a 20 36 2e 31 30 2e 31  39 30 2e 34 39 20 43 52  |: 6.10.190.49
>> CR|
>> 00061000  43 3a 20 61 37 35 38 33  34 64 32 20 44 61 74 65  |C: a75834d2
>> Date|
>> 00061010  3a 20 54 75 65 20 32 30  31 34 2d 30 36 2d 31 37  |: Tue
>> 2014-06-17|
>> 00061020  20 31 31 3a 34 39 3a 32  31 20 50 44 54 20 46 57  | 11:49:21 PDT
>> FW|
>> 00061030  49 44 20 30 31 2d 38 37  34 34 62 63 64 32 0a 00  |ID
>> 01-8744bcd2..|
>> 00061040  e2 00                                             |..|
>> 00061042
>>
>>
>> I just took the firmware in linux-firmware repo and I am not sure if
>> that's the correct one..
>
>
> By the name of the file I suspected you did. Personally, I verified the
> firmware works on 43341. John Stultz tested both 43340 and 43341 with this
> firmware.
>
> Your log says: chip:0xa94c rev:0x2
>
> I will have to check whether that is correct revision for this firmware. I
> can check. You could try the brcmfmac4334-sdio.bin file instead. All bets
> are off, but it can not get worse. ;-)
>
> Gr. AvS
>
>
>> Regards,
>>
>> John
>>
>>
>> On Thu, Apr 23, 2015 at 11:39 AM, Arend van Spriel<arend@broadcom.com>
>> wrote:
>>>
>>> On 04/23/15 20:10, John Tobias wrote:
>>>>
>>>>
>>>> Hello Guys,
>>>>
>>>> I am trying to use the bcmdhd wifi driver 43340 module on iMX6DL
>>>> processor using kernel Freescale GA (3.10.53).
>>>>
>>>> I am having an issue with the sdio registration. I would like to know
>>>> if anyone here had the same issue and how did you solve it?.
>>>>
>>>>
>>>> Entry: wifi_add_dev
>>>> Entry: wifi_add_dev
>>>> Entry: wifi_probe
>>>> wifi_probe: calling wifi_set_power on
>>>> Entry: wifi_set_power
>>>> wifi_set_power = 1
>>>> wifi_set_carddetect = 1
>>>> mmc0: queuing unknown CIS tuple 0x80 (7 bytes)
>>>> mmc0: queuing unknown CIS tuple 0x80 (6 bytes)
>>>> mmc0: queuing unknown CIS tuple 0x91 (3 bytes)
>>>> mmc0: new high speed SDIO card at address 0001
>>>>
>>>> Dongle Host Driver, version 1.88.45 (r)
>>>> Compiled in drivers/net/wireless/bcmdhd on Apr 23 2015 at 00:40:05
>>>> F1 signature OK, socitype:0x1 chip:0xa94c rev:0x2 pkg:0x0
>>>> DHD: dongle ram size is set to 524288(orig 524288) at 0x0
>>>> wl_create_event_handler(): thread:wl_event_handler:3ba started
>>>> CFG80211-ERROR) wl_event_handler : tsk Enter, tsk = 0x96741444
>>>> dhd_attach(): thread:dhd_watchdog_thread:3bb started
>>>> dhd_attach(): thread:dhd_dpc:3bc started
>>>> dhd_attach(): thread:dhd_rxf:3bd started
>>>> dhd_attach(): thread:dhd_sysioc:3be started
>>>> wifi_get_mac_addr
>>>> dhdsdio_write_vars: Download, Upload and compare of NVRAM succeeded.
>>>>
>>>>
>>>> Times out here...
>>>> dhd_module_init: sdio_register_driver timeout or error
>>>>
>>>> dhd_bus_init: enable 0x06, ready 0x02 (waited 3006383us)
>>>
>>>
>>>
>>> This means it failed to enable function 2. My guess would be the firmware
>>> did not come up.
>>>
>>>> dhd_bus_start failed bus is not ready
>>>> dhdsdio_probe: dhd_bus_start failed
>>>> dhd_detach(): thread:dhd_sysioc:3be terminated OK
>>>> dhd_detach(): thread:dhd_watchdog_thread:3bb terminated OK
>>>> dhd_dpc_thread: Unexpected up_cnt 0
>>>> dhd_detach(): thread:dhd_dpc:3bc terminated OK
>>>> dhd_detach(): thread:dhd_rxf:3bd terminated OK
>>>> CFG80211-ERROR) wl_event_handler : was terminated
>>>> wl_destroy_event_handler(): thread:wl_event_handler:3ba terminated OK
>>>> dhd_osl_detach: MEMORY LEAK 156 bytes
>>>> ## wifi_remove
>>>> Entry: wifi_set_power
>>>> wifi_set_power = 0
>>>> navdy_wifi_power: 0
>>>> wifi_set_carddetect = 0
>>>> insmod: init_module '/system/lib/modules/bcmdhd.ko' failed (No such
>>>> device)
>>>> # mmc0: card 0001 removed
>>>>
>>>>
>>>> Note: I ran the command below to load the driver:
>>>> insmod /system/lib/modules/bcmdhd.ko
>>>> firmware_path=/system/vendor/firmware/brcmfmac43340-sdio.bin
>>>> nvram_path=/system/vendor/firmware/bcmdhd.cal
>>>
>>>
>>>
>>> So this is an Android image, right? Can you do hexdump, ie.:
>>>
>>> $ hexdump -C brcmfmac43340-sdio.bin | tail -30
>
>
>>> Regards,
>>> Arend
>>>
>>>> Regards,
>>>>
>>>> John
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
>>>> in
>>>> the body of a message to majordomo at vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>>>
>>>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: brcm44340.logs
Type: application/octet-stream
Size: 20338 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150423/a63922cf/attachment-0001.obj>
