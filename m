From: ykk@rock-chips.com (Yakir Yang)
Date: Sat, 10 Oct 2015 22:31:17 +0800
Subject: [PATCH v5 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <5615BB93.9020008@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1442906428-2609-1-git-send-email-ykk@rock-chips.com>
 <5614BADD.1070307@rock-chips.com> <5614DBE2.6080102@osg.samsung.com>
 <5614DFBC.8060105@rock-chips.com> <5614E553.6060108@osg.samsung.com>
 <5614FC6B.4080702@rock-chips.com> <56150128.2070309@osg.samsung.com>
 <5615BB93.9020008@rock-chips.com>
Message-ID: <56192135.2080608@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 10/08/2015 08:40 AM, Yakir Yang wrote:
> On 10/07/2015 07:25 PM, Javier Martinez Canillas wrote:
>> On 10/07/2015 01:05 PM, Yakir Yang wrote:
>>> On 10/07/2015 05:26 PM, Javier Martinez Canillas wrote:
>>>> On 10/07/2015 11:02 AM, Yakir Yang wrote:
>>>>> On 10/07/2015 04:46 PM, Javier Martinez Canillas wrote:
>>>>>> On 10/07/2015 08:25 AM, Yakir Yang wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Friendly ping.....   :)
>>>>>>>
>>>>>>>
>>>>>>> Best regards,
>>>>>>> - Yakir
>>>>>>>
>>>>>>>
>>>>>> Do you have a tree that I can use to test these patches?
>>>>> Wow, thanks a lot, I do have a tree on github 
>>>>> [https://github.com/yakir-Yang/linux/tree/analogix_dp],
>>>>> crossing my finger, wish things works......    ;)
>>>>>
>>>> I tried your analogix_dp branch on an Exynos5800 Peach Pi Chromebook
>>>> but the machine didn't boot. Unfortunately I need to do some soldering
>>>> to have a serial console on this board so don't have a kernel boot 
>>>> log.
>>>>
>>>> I'll let you know if I can get more info about this issue.
>>> Whoops, sorry for the failed, much appreciated for your works.
>>>
>>> Besides, I thought maybe I can find a Peach Pit Chromebook in my side,
>>> I remember that some of our guys have brought one, but previously I
>>> thought that mainline kernel wouldn't run on Peach Pit directly.
>>>
>> Great, mainline works correctly on all Exynos based Chromebooks.
>>
>>> Maybe you can email me the method the run mainline kernel on Peach
>>> Pit, so I can debug the analogix_dp driver at the same time, that would
>>> be great.
>> I wrote a little blog post explaining how to run mainline on these 
>> boards:
>>
>> http://blogs.s-osg.org/install-linux-mainline-kernel-distro-exynos-chromebooks/ 
>>
>>
>> That explains the simplest setup though so if you need a different one
>> (i.e: chain loading a non verified u-boot) or if you have any questions,
>> feel free to contact me in private and I can help you with the setup.
>>
>
> Ah, thanks, gonna to step-by-step.

Thanks for your great material, although I meet some problems in the 
step-by-step
process, and failed at this way to setup mainline kernel environment on 
Exynos chromebooks.

But i do find another way to install mainline kernel to Exynos Chromebook:
1. Install any ChromeOS image into a USB media device (like dd tools)
2. "enable_dev_usb_boot" on Exynos chromebooks which would allowed boot 
from USB.
3. Flash the mainline kernel into the KERNEL-A and KERNEL-B partitions 
on host PC.
4. Insert USB device into Exynos chromebooks, and press CTRL+U, boot 
into USB OS.

And it's better to enable pstore function on mainline kernel, so we can 
analysis the last log when
the mainline kernel crashed. After enable PSTORE_RAM in .config, we 
still need add ramoops node
into file, like:
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -750,6 +750,15 @@
                 iommu = <&sysmmu_gsc3>;
         };

+       ramoops: ramoops {
+               compatible = "ramoops";
+               name = "ramoops";
+               reg = <0x41f00000 0x100000>;
+               record-size = <0x20000>;
+               dump-oops;
+               status = "okay";
+       };
+
         hdmi: hdmi {
                 compatible = "samsung,exynos4212-hdmi";
                 reg = <0x14530000 0x70000>;


Aha, I have tested this series on two Exynos Chromebooks that I 
borrowed(Snow and Peach Pit)
with previously method (actually I believed it's a common method without 
broken the original
ChromeOS image).

And I do find the crash place that make you failed at this series, here 
is the diff changes:
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c 
b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 5f8fc11..bcbc009 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1169,6 +1169,7 @@ static int analogix_dp_create_bridge(struct 
drm_device *drm_dev,

         dp->bridge = bridge;

+       dp->encoder->bridge = bridge;
         bridge->driver_private = dp;
         bridge->encoder = dp->encoder;
         bridge->funcs = &analogix_dp_bridge_funcs;
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -151,7 +151,7 @@
         samsung,color-depth = <1>;
         samsung,link-rate = <0x06>;
         samsung,lane-count = <2>;
-       hpd-gpio = <&gpx2 6 0>;
+       hpd-gpios = <&gpx2 6 0>;

         ports {
                 port at 0 {


Anyway I'm going to send the v6 series, thanks for your good idea.

- Yakir

>
> - Yakir
>
>>>> Also, there is Kconfig recursive dependency that you may want to fix:
>>>>
>>>> $ make exynos_defconfig
>>>> drivers/video/fbdev/Kconfig:5:error: recursive dependency detected!
>>>> drivers/video/fbdev/Kconfig:5: symbol FB is selected by 
>>>> DRM_KMS_FB_HELPER
>>>> drivers/gpu/drm/Kconfig:34: symbol DRM_KMS_FB_HELPER depends on 
>>>> DRM_KMS_HELPER
>>>> drivers/gpu/drm/Kconfig:28: symbol DRM_KMS_HELPER is selected by 
>>>> DRM_ANALOGIX_DP
>>>> drivers/gpu/drm/bridge/analogix/Kconfig:1: symbol DRM_ANALOGIX_DP 
>>>> is selected by DRM_EXYNOS_DP
>>>> drivers/gpu/drm/exynos/Kconfig:57: symbol DRM_EXYNOS_DP depends on 
>>>> DRM_EXYNOS_FIMD
>>>> drivers/gpu/drm/exynos/Kconfig:19: symbol DRM_EXYNOS_FIMD depends 
>>>> on FB_S3C
>>>> drivers/video/fbdev/Kconfig:2023: symbol FB_S3C depends on FB
>>> Yeah, recursive dependency detected, guess I should remove the
>>> "DRM_KMS_HELPER" from bridge analogix_dp Kconfig file, thanks
>>> for your remind.
>>>
>>> --- a/drivers/gpu/drm/bridge/analogix/Kconfig
>>> +++ b/drivers/gpu/drm/bridge/analogix/Kconfig
>>> @@ -1,4 +1,3 @@
>>>   config DRM_ANALOGIX_DP
>>>          tristate
>>>          depends on DRM
>>> -       select DRM_KMS_HELPER
>>>
>>>
>> That fixes the recursive dependency issue indeed. Thanks.
>>
>>> Thanks,
>>> - Yakir
>> Best regards,
>
