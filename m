From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 24 Feb 2016 15:48:57 +0000
Subject: [PATCH] ARM: realview: DT support for the PBA8
In-Reply-To: <56CDA0F0.9050608@arm.com>
References: <1456303714-31039-1-git-send-email-linus.walleij@linaro.org>
 <56CDA0F0.9050608@arm.com>
Message-ID: <56CDD0E9.70504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/16 12:24, Robin Murphy wrote:
> Hi Linus,
>
> On 24/02/16 08:48, Linus Walleij wrote:
>> This adds a devicetree for the ARM RealView PBA8 platform,
>> also known as HBI-0178, "RealView(R) Platform Baseboard for
>> Cortex(TM)-A8".
>>
>> Tested in QEMU with -M realview-pb-a8 and works like a charm,
>> however with these annoying boot messages:
>>
>> of_amba_device_create(): amba_device_add()
>>      failed (-19) for /soc/sysctl at 10001000
>> of_amba_device_create(): amba_device_add()
>>      failed (-19) for /soc/ssp at 1000d000
>> of_amba_device_create(): amba_device_add()
>>      failed (-19) for /soc/timer at 10018000
>> of_amba_device_create(): amba_device_add()
>>      failed (-19) for /soc/timer at 10019000
>> of_amba_device_create(): amba_device_add()
>>      failed (-19) for /soc/sysctl at 1001a000
>>
>> I think this is because these PrimeCells do not exist in the
>> QEMU machine model but would work fine on the real hardware.
>> QEMU still works, because the SP810 clocks will anyway probe,
>> as they are not amba_devices but use the special CLK_OF_DECLARE()
>> probing macro.
>
> And here I thought that big black box on the far corner of my desk was
> only good for taking up space. I have no idea of its provenance, but
> here's what it had to say (using appended dtb and a hack in the
> decompressor to set r1=-1, r2=0 because I can't be bothered faffing with
> a 2010-vintage u-boot):
>
> RealView PBA8 #go 0x7fc0
> ## Starting application at 0x00007FC0 ...
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0

[...]

> pl061_gpio 10013000.gpio: PL061 GPIO chip @0x10013000 registered
> pl061_gpio 10014000.gpio: PL061 GPIO chip @0x10014000 registered
> pl061_gpio 10015000.gpio: PL061 GPIO chip @0x10015000 registered

[...]

> mmci-pl18x 10005000.mmcsd: Got CD GPIO
> mmci-pl18x 10005000.mmcsd: Got WP GPIO

[...]

> Waiting for root device /dev/mmcblk0p1...
>
>
> It then fails to notice my SD card, even if I eject and reinsert it :(

Ah, it's because it's requesting those GPIOS from &gpio1, rather than 
&gpio2 where they really are. With that fixed up the card detect now 
works, but apparently nothing I have around my desk actually supports 
3.3V...

Robin.
