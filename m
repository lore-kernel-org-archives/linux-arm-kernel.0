From: mike@tubby.org (Mike Tubby)
Date: Mon, 9 Oct 2017 12:56:10 +0100
Subject: iMX6 PCIE IRQ not working with ath9k based Wifi
In-Reply-To: <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
References: <348346fa-1d70-1d08-9a32-18b660328e4f@tubby.org>
 <CAK8P3a0bF7=bbWBS9+7uBYp+yGpDUfS_QCX6K4i3WJv9mbgvEA@mail.gmail.com>
Message-ID: <d20644ba-0e1b-0fb4-41ba-d1d604800382@tubby.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/9/2017 11:19 AM, Arnd Bergmann wrote:
> On Sat, Oct 7, 2017 at 5:51 PM, Mike Tubby <mike@tubby.org> wrote:
>> Arnd, Tim
>>
>> I have an iMX6 based SMARC module and custom motherboard with an mPCIE slot
>> into which I have a SparkLAN WPEA-127N Atheros 93xx family based Wifi card
>> which needs to be an access point and it doesn't work - basically I can get
>> it all set up and hostapd says it has gone active but it hangs and never
>> transmits and I think I'm having a problem with IRQ handling from the PCI
>> bus and as far as I can tell I'm having the issue which you discussed here:
>>
>>      https://patchwork.kernel.org/patch/8687351/
> (adding linux-arm-kernel to Cc, to make sure the discussion is open and
> gets archived)
>
>> My system:
>>
>> root at arm:~# uname -a
>> Linux arm 4.1.15-224155-g2da0623-dirty #1 SMP PREEMPT Wed Apr 20 03:10:57
>> CST 2016 armv7l armv7l armv7l GNU/Linux
>>
>> this is a variant of the Freescale/NXP BSP kernel.
>>
>> root at arm:~# lspci
>> 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01)
>> 01:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter
>> (rev 01)
>>
>> root at arm:~# cat /proc/interrupts
>>             CPU0       CPU1       CPU2       CPU3
>>   16:    1198515     573459      78663       7755       GIC  29 Edge      twd
>>   17:        229          0          0          0       GPC  55 Level
>> i.MX Timer Tick
>>   19:          0          0          0          0       GPC  20 Level
>> snvs-secvio
>>   21:          0          0          0          0       GPC 120 Level
>> mx6-pcie-msi
>>   23:         15          0          0          0       GPC 115 Level
>> 20e0000.hdmi_video
>>   24:          0          0          0          0       GPC  52 Level
>> 2004000.spdif
>>   25:          0          0          0          0       GPC  31 Level
>> 2008000.ecspi
>>   26:          0          0          0          0       GPC  32 Level
>> 200c000.ecspi
>>   27:          0          0          0          0       GPC  26 Level
>> 2020000.serial
>>   28:          0          0          0          0       GPC  46 Level
>> 2028000.ssi
>>   29:          0          0          0          0       GPC  50 Level
>> 2034000.asrc
>>   30:          0          0          0          0       GPC   3 Edge
>> VPU_JPG_IRQ
>>   31:          0          0          0          0       GPC  12 Level
>> VPU_CODEC_IRQ
>>   66:          0          0          0          0  gpio-mxc  28 Edge
>> 2194000.usdhc cd
>> 274:          0          0          0          0       GPC  80 Level
>> 20bc000.wdog
>> 277:          0          0          0          0       GPC  49 Level
>> imx_thermal
>> 287:          0          0          0          0       GPC 124 Level
>> 20e4000.dcic
>> 288:          0          0          0          0       GPC 125 Level
>> 20e8000.dcic
>> 289:          4          0          0          0       GPC   2 Level
>> sdma
>> 290:        189          0          0          0       GPC  43 Level
>> 2184000.usb
>> 291:        128          0          0          0       GPC  40 Level
>> 2184200.usb
>> 292:     226854          0          0          0       GPC 118 Level
>> 2188000.ethernet
>> 293:          0          0          0          0       GPC 119 Level
>> 2188000.ethernet
>> 294:       5409          0          0          0       GPC  23 Level
>> mmc1
>> 295:        335          0          0          0       GPC  25 Level
>> mmc3
>> 296:        386          0          0          0       GPC  36 Level
>> 21a0000.i2c
>> 297:        262          0          0          0       GPC  37 Level
>> 21a4000.i2c
>> 298:         46          0          0          0       GPC  38 Level
>> 21a8000.i2c
>> 300:          0          0          0          0       GPC  18 Level
>> vdoa
>> 301:        190          0          0          0       GPC  27 Level
>> 21e8000.serial
>> 302:          0          0          0          0       GPC  29 Level
>> 21f0000.serial
>> 303:          0          0          0          0       GPC  30 Level
>> 21f4000.serial
>> 304:         20          0          0          0       GPC   6 Level
>> 2400000.ipu
>> 305:          0          0          0          0       GPC   5 Level
>> 2400000.ipu
>> 306:          0          0          0          0       GPC 107 Level
>> mmdc_1
>> 307:          0          0          0          0       GPC 112 Level
>> mmdc_1
>> 308:          0          0          0          0       GPC 113 Level
>> mmdc_1
>> 309:          0          0          0          0       GPC 114 Level
>> mmdc_1
>> 312:          1          0          0          0       GPC  11 Level
>> galcore interrupt service for 2D
>> 313:        263          0          0          0       GPC  39 Level
>> 2200000.sata
>> 314:          0          0          0          0       GPC   8 Level
>> 2800000.ipu
>> 315:          0          0          0          0       GPC   7 Level
>> 2800000.ipu
>> 316:         14          0          0          0       GIC 137 Level
>> 2101000.jr0
>> 317:          0          0          0          0       GIC 138 Level
>> 2102000.jr1
>> 318:          0          0          0          0   PCI-MSI   0 Edge
>> PCIe PME, aerdrv
>> 350:          0          0          0          0       GPC 123 Level
>> ath9k
>> IPI0:          0          0          0          0  CPU wakeup interrupts
>> IPI1:          0         16          7          4  Timer broadcast
>> interrupts
>> IPI2:       5776     209939       5275       6069  Rescheduling interrupts
>> IPI3:        217         60        231        227  Function call interrupts
>> IPI4:         10         85         97         82  Single function call
>> interrupts
>> IPI5:          0          0          0          0  CPU stop interrupts
>> IPI6:          1          0          0          0  IRQ work interrupts
>> IPI7:          0          0          0          0  completion interrupts
>> Err:          0
>>
>>
>> What I'd like to know is does the patch on patchwork.kernel.org fix it? I
>> note that there was discussion about having to fix it in more places and
>> perhaps in the pcie-designware driver?
>>
>> Was this ever root caused and/or is there now an official fix or a better
>> work around?
>>
>> In my use-case we have only a single mini-PCIE slot connected directly to
>> the SMARC module.
>>
>> Any help/advice would be appreciated.
> The first thing you should check is the interrupt-map property in your
> DTB, to see if it refers to the correct IRQ according to the SoC spec.
> I see  you never got any interrupts for the device, so maybe you
> got the wrong line.
>
> Can you check with 'lspci -tv' how the card is connected? Is there
> any PCIe-PCI bridge between the device and the slot, or maybe
> some other form of PCIe switch?
>
>        Arnd


Arnd,

Thanks for your reply.

Here is the output of 'lspic -tv' and 'lspic -v':

root at arm:/boot/uboot# lspci -tv
-[0000:00]---00.0-[01]----00.0? Qualcomm Atheros AR93xx Wireless Network 
Adapter
root at arm:/boot/uboot#

root at arm:/boot/uboot# lspci -v
00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 
[Normal decode])
 ??????? Flags: bus master, fast devsel, latency 0
 ??????? Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
 ??????? Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 ??????? Memory behind bridge: 01100000-011fffff
 ??????? Prefetchable memory behind bridge: 01200000-012fffff
 ??????? [virtual] Expansion ROM at 01300000 [disabled] [size=64K]
 ??????? Capabilities: [40] Power Management version 3
 ??????? Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
 ??????? Capabilities: [70] Express Root Port (Slot-), MSI 00
 ??????? Capabilities: [100] Advanced Error Reporting
 ??????? Capabilities: [140] Virtual Channel
 ??????? Kernel driver in use: pcieport

01:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network 
Adapter (rev 01)
 ??????? Subsystem: Qualcomm Atheros Device 3112
 ??????? Flags: bus master, fast devsel, latency 0, IRQ 350
 ??????? Memory at 01100000 (64-bit, non-prefetchable) [size=128K]
 ??????? [virtual] Expansion ROM at 01200000 [disabled] [size=64K]
 ??????? Capabilities: [40] Power Management version 3
 ??????? Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
 ??????? Capabilities: [70] Express Endpoint, MSI 00
 ??????? Capabilities: [100] Advanced Error Reporting
 ??????? Capabilities: [140] Virtual Channel
 ??????? Capabilities: [300] Device Serial Number 00-00-00-00-00-00-00-00
 ??????? Kernel driver in use: ath9k

If I look at the 'Capabilities [50]' on the PCI bridge I see 'Enable+' 
and on the Atheros kernel driver (ath9k) I see 'Enable-' -- this appears 
to suggest a mis-match.

If I understand correctly the ath9k driver in kernel 4.1.15 we're using 
doesn't enable MSI - so I assume that there is some backwards 
compatibility mode that then is not working because MSI is enabled at 
the CPU end, and hence the patch you referred to is used to turn this off.

At the same time on the mailing list:

https://www.mail-archive.com/ath9k-devel at lists.ath9k.org/msg14332.html

which is part of:

 ??? https://wireless.wiki.kernel.org/en/users/Drivers/ath9k

there is talk of a patch to the ath9k driver to properly implement MSI 
in the updated driver in kernel 4.6

So, for us the question is which way to head:

 ??? a) disable MSI at the CPU and try to use legacy; or

 ??? b) update the ath9k driver to try and enable MSI ?


We will also check the DTS/DTB in case something is mis-assigned.


Regards


Mike Tubby
