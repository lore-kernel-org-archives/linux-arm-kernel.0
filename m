From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 14 May 2014 11:00:23 +0900
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <53727D9E.9050800@suse.de>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
 <536A57FA.2090608@wwwdotorg.org> <536AC45F.6080608@nvidia.com>
 <536CE414.5030406@suse.de> <536CF33A.3020906@wwwdotorg.org>
 <53727D9E.9050800@suse.de>
Message-ID: <5372CE37.1080601@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 05:16 AM, Andreas F?rber wrote:
> Am 09.05.2014 17:24, schrieb Stephen Warren:
>> On 05/09/2014 08:20 AM, Andreas F?rber wrote:
>>> Am 08.05.2014 01:40, schrieb Alex Courbot:
>>>> On 05/08/2014 12:57 AM, Stephen Warren wrote:
>>>>> On 05/06/2014 09:18 PM, Alexandre Courbot wrote:
>>>>>> Console rotation is needed for devices like Tegra Note 7 and NVIDIA
>>>>>> SHIELD to get the boot console in the expected orientation.
>>>>>
>>>>> I've squashed this into Tegra's for-3.16/defconfig branch.
>>>>>
>>>>> Can you please also update multi_v7_defconfig, and send that change to
>>>>> arm-soc (arm at kernel.org) to be applied. Thanks.
>>>>
>>>> I omitted doing this for now because the devices that require this
>>>> option (TN7/SHIELD) need a custom build with appended DTB and/or
>>>> command-line anyway. Therefore they cannot use a multi-mach kernel
>>>
>>> What does appending a .dtb have to do with whether or not to use a
>>> multi-mach kernel? We package zImage/uImage and .dtbs separately, so
>>> surely the multi_v7_defconfig should be kept working with Tegra devices.
>>> Appending a .dtb only comes into play for preparing installation images.
>>
>> That would be a reasonable argument if generic distro installers or
>> kernel packages were likely to support the TN7 and SHIELD. However,
>> given the bootloader situation there and the need for a custom kernel
>> anyway for APPENDED_DTB, I assume that's not the case on this particular
>> device?
>
> The Shield we probably don't, the TN7 I don't know. I was more concerned
> about the shortened justification.
>
>> If you do intend to support this device with SuSe installer and kernel
>> packages, could you give an outline of how you do so?
>
> I gave a presentation at embedded world Conference 2014 on how standard
> distributions work on ARM/AArch64, but I fear the slides are not online.
>
> As far as possible, we use a single kernel source and a "default" or
> "lpae" v7 multi-platform config with lots of modules enabled.
>
> http://kernel.opensuse.org/cgit/kernel-source/tree/config/armv7hl [*]
>
> I just double-checked, and we do have CONFIG_ARM_APPENDED_DTB=y enabled.
> It does not restrict supplying the .dtb the "normal" way AIUI.
>
> Our Open Build Service instance then builds a kernel-default .rpm
> package containing zImage and modules. The .dts files are separately
> compiled and packaged as, e.g., dtb-tegra2 for /boot/dtb/tegra20-*.dtb.
>
> For building initrd, U-Boot boot.scr (including kernel command line) and
> installation image, we use Kiwi.
>
> Anyway, we don't rely on the defconfigs for our distro, so do as you see
> fit; just gently reminding that it's not feasible for everyone to build
> kernels per device, as the above comment seemed to suggest.

To be completely clear, we didn't expect these devices to be of interest 
to distros, due to the limitation of their bootloaders.

Both SHIELD and TN7 come with a locked bootloader and cannot use U-boot. 
The bootloader can only boot a kernel from a dedicated, raw boot 
partition (Android style), can only pass a device tree from another raw 
"dtb" partition, and will fill it with plenty of dirty command-line 
options that make mainline unusable. That seems to be a lot for distros 
to handle, so at this stage we'd rather advise users to use a root FS 
image of their favorite distro along with a self-compiled kernel.

That being said I only have a short-range view of the issue, so if you 
know of a way a distro installer could handle this and think it is worth 
doing, I'll be happy to cooperate here.

Thanks,
Alex.
