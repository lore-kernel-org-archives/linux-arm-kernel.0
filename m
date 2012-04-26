From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Apr 2012 12:57:28 -0600
Subject: [PATCH] Add the Performance Monitoring Unit to the Trimslice
 device tree
In-Reply-To: <4F9993C3.8050008@redhat.com>
References: <1330740413-29260-1-git-send-email-wcohen@redhat.com>
 <20120305103245.GC31189@mudshark.cambridge.arm.com>
 <4F9597B4.5020208@redhat.com> <4F9966CB.6090504@redhat.com>
 <20120426152246.GI10272@mudshark.cambridge.arm.com>
 <4F9970AD.6090501@wwwdotorg.org> <4F9993C3.8050008@redhat.com>
Message-ID: <4F999A98.6080800@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/26/2012 12:28 PM, William Cohen wrote:
> On 04/26/2012 11:58 AM, Stephen Warren wrote:
>> On 04/26/2012 09:22 AM, Will Deacon wrote:
>>> On Thu, Apr 26, 2012 at 04:16:27PM +0100, William Cohen wrote:
>>>> On 04/23/2012 01:56 PM, William Cohen wrote:
>>>>> Has this patch been pulled into the git tree?  -Will (Cohen)
>>>>
>>>>
>>>> This patch pretty much duplicates what is already done for in board-seaboard.c:
>>>>
>>>> http://lxr.linux.no/#linux+v3.3.3/arch/arm/mach-tegra/board-seaboard.c#L147
>>>>
>>>> I have tested the patch out with oprofile, papi, and perf. Things seem to function properly with the patch on a trimslice.
>>>
>>> Right, that sounds good to me. This should go via the tegra/arm-soc tree.
>>> For some reason, I can't find the original patch in the list archives so
>>> perhaps you could repost it to linux-arm-kernel and CC Olof and Arnd?
>>
>> Is there actually any reason to proceed with this patch? When booting
>> Tegra using device tree (i.e. CONFIG_OF rather than the way the phrase
>> is used in the email subject), the ARM PMU is enabled on all boards. So,
>> I'd recommend switching to DT rather than continuing to patch up the
>> board files, which will hopefully be removed in the nearish future.
>>
>> (BTW, best to cc linux-tegra at vger.kernel.org too)
> 
> Hi Stephen,
> 
> The fedora 17 arm kernels are not yet using the DT. That is the motivations to get this fix into the upstream kernel so that people could use performance monitoring hardware.

Are people using the mainline kernel for Fedora on Tegra then?

> Has the pmu support been verified to work on Nvidia Tegra when using the DT?  In the past I was not successful in getting the trimslice to boot up using device tree. Are there some clear instructions somewhere on how to do this?  

I believe I validated the PMU functionality when booting using DT when I
created the patch to add it to the device tree files.

Booting with DT is very simple. You can do either:

a) Grab arch/arm/boot/tegra-trimslice.dtb from the kernel build tree,
load it into memory from U-Boot just like the kernel and initrd, and
pass the address as the third parameter to "bootm". This is the
preferred option.

b) Enable CONFIG_ARM_APPENDED_DTB, then concatenate zImage and
tegra-trimslice.dtb into a single file, and use that as the kernel
image. this is probably marginally easier to get working the first time
around, since the only difference is you package a slightly different
kernel file onto the boot media.

Either way, I'd recommend passing root=UUID=xxx to the kernel instead of
an explicit block device name, since it's possible the naming is
different between booting with board files and device tree.
