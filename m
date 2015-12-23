From: andy.yan@rock-chips.com (Andy Yan)
Date: Wed, 23 Dec 2015 17:31:45 +0800
Subject: [PATCH v1 0/6] misc: add reboot mode driver
In-Reply-To: <20151222164742.GA8623@piout.net>
References: <1450774949-23901-1-git-send-email-andy.yan@rock-chips.com>
 <20151222164742.GA8623@piout.net>
Message-ID: <567A6A01.8080305@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre:

On 2015?12?23? 00:47, Alexandre Belloni wrote:
> Hi,
>
> On 22/12/2015 at 17:02:29 +0800, Andy Yan wrote :
>> This driver parse the reboot commands like "reboot loader"
>> and "reboot recovery" to get a boot mode described in the
>> device tree , then call the vendor specific write interfae
>> to store the boot mode in some place like special register
>> or sram , which can be read by the bootloader after system
>> reboot.
>>
>> This is commonly done on Android based devices, in order to
>> reboot the device into fastboot or recovery mode.
>>
>> Before this patch , I have try some hack on[0], and then found
>> John Stultz also doing the same work[1].
>>
>> As John is busy these days, I go on with this work.
>>
>> [0]https://patchwork.kernel.org/patch/7647751/
>> [1]https://patchwork.kernel.org/patch/7802391/
>>
>> Changes in v1:
>> - fix the embarrassed compile warning
>> - correct the maskrom magic number
>> - check for the normal reboot
>> - correct the maskrom magic number
>> - use macro defined in rockchip_boot-mode.h for reboot-mode DT node
>>
>> Andy Yan (6):
>>    dt-bindings: misc: add document for reboot-mode driver
>>    dt-bindings: soc: add document for rockchip reboot-mode driver
>>    misc: add reboot mode driver
>>    soc: rockchip: add reboot mode driver
>>    ARM: dts: rockchip: add reboot-mode node
>>    ARM64: dts: rockchip: add reboot-mode node
>>
> This seems nice and useful, some further ideas:
>
>>   .../devicetree/bindings/misc/reboot-mode.txt       | 41 +++++++++
>>   .../bindings/soc/rockchip/rockchip,reboot-mode.txt | 39 +++++++++
>>   arch/arm/boot/dts/rk3288.dtsi                      | 26 ++++++
>>   arch/arm/boot/dts/rk3xxx.dtsi                      | 26 ++++++
>>   arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 26 ++++++
>>   drivers/misc/Kconfig                               |  7 ++
>>   drivers/misc/Makefile                              |  1 +
>>   drivers/misc/reboot_mode.c                         | 96 ++++++++++++++++++++++
> I think this actually belongs to drivers/power/reset/ instead of misc

    I also have the idea to put is in drivers/power/reset,  But considering
    this driver have not bind anything about power, so I put it in 
driver/misc
    at last. So I hope if some people can give more suggestions here.
>
>>   drivers/soc/rockchip/Kconfig                       |  9 ++
>>   drivers/soc/rockchip/Makefile                      |  1 +
>>   drivers/soc/rockchip/reboot.c                      | 68 +++++++++++++++
> And maybe that part could be made generic instead of rockchip specific.
> It simply uses a regmap to do the accesses, I guess a lot of other
> platforms will do that. We have syscon-reboot and syscon-poweroff for example.
>
> I think then we can extend the "framework" by having generic drivers to
> store the value in eeprom or nvram for example.
>

    I also hope the write interface can be generic. But I found some 
platform
    use different hardware to store the value. For example, John's patch 
use
    SRAM on qcom apq8064 to store value for nexus7. It seems there also have
    some platform use dram or nvram to store it. And these different 
hardware use
    different write method. I don't have a generic way to handle this.

    I have a idea to handle it like this:

+static const struct of_device_id reboot_mode_dt_match[] = {
+        { .compatible = "linux,reboot-mode-sfr",    /*for magic value 
stored in special function register, which  can be accessed by regmap*/
+                .data = (void *)&reboot-mode-sfr },
+        { .compatible = "linux,reboot-mode-sram",  /*for magic value 
stored in
+                .data = (void *)&reboot-mode-sram },
+        { .compatible = "linux,reboot-mode-sdram",
+                .data = (void *)&reboot-mode-sdram }, /*for magic value 
stored
+        { .compatible = "rockchip,reboot-mode-nvram",
+                .data = (void *)&reboot-mode-nvram },
+        {},
+};

    the data point to different hardware access method.

   Hope to see more suggestions from you.
