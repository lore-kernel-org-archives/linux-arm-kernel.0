From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Thu, 16 Nov 2017 19:01:47 +0000
Subject: next/master boot: 210 boots: 35 failed, 174 passed with 1
 conflict (next-20171115)
In-Reply-To: <3ddf8ad5-e3d9-49cc-9e20-2d8cdbc9685f@nvidia.com>
References: <5a0c2169.c6a2df0a.13ea3.9c02@mx.google.com>
 <a21b88b2-663d-49fc-527a-87494a23087f@collabora.com>
 <0e2dbcf5-6823-8e48-e2ac-85afa7d6dbaf@collabora.com>
 <3ddf8ad5-e3d9-49cc-9e20-2d8cdbc9685f@nvidia.com>
Message-ID: <e0e9994c-8d2e-f499-e430-1f15bff7b0e6@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/11/17 17:55, Jon Hunter wrote:
>
> On 16/11/17 14:50, Guillaume Tucker wrote:
>> On 16/11/17 14:42, Guillaume Tucker wrote:
>>> On 15/11/17 11:13, kernelci.org bot wrote:
>>>> next/master boot: 210 boots: 35 failed, 174 passed with 1 conflict
>>>> (next-20171115)
>>>>
>>>> Full Boot Summary:
>>>> https://kernelci.org/boot/all/job/next/branch/master/kernel/next-20171115/
>>>>
>>>> Full Build Summary:
>>>> https://kernelci.org/build/next/branch/master/kernel/next-20171115/
>>>>
>>>> Tree: next
>>>> Branch: master
>>>> Git Describe: next-20171115
>>>> Git Commit: 63fb091c80188ec51f53514d07de907c1dd3d61d
>>>> Git URL:
>>>> http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>>>> Tested: 35 unique boards, 16 SoC families, 30 builds out of 213
>>>>
>>>> Boot Regressions Detected:
>>>>
>>>> arm:
>>> [...]
>>>>     multi_v7_defconfig:
>>>>         tegra124-nyan-big:
>>>>             lab-collabora: failing since 11 days (last pass:
>>>> next-20171102 - first fail: next-20171103)
>>>
>>> I've run another automated bisection with some tweaks to remove
>>> known failures and found this breaking change:
>>>
>>>   commit 859eb05676f67d4960130dff36d3368006716110
>>>   Author: Shawn Nematbakhsh <shawnn@chromium.org>
>>>   Date:   Fri Sep 8 13:50:11 2017 -0700
>>>
>>>       platform/chrome: Use proper protocol transfer function
>>>
>>>
>>
>> Should have added, this is essentially the kernel error:
>>
>> [    1.711581] kernel BUG at drivers/platform/chrome/cros_ec_proto.c:34!
>> [    1.718004] Internal error: Oops - BUG: 0 [#1] SMP ARM
>>
>> Please see the links to the LAVA jobs below for the full logs.
> This one is a known issue (which I believe I have mentioned a couple
> times). There is a fix available [0].

Right, it's true that this kernel error showed up in the previous
bisection I ran last week.  As this time it found another commit
I thought it might be worthwhile sharing the result.

> I am not sure that continuing to bisect this is going to bare any fruit
> due to the number of issues plaguing this board at the moment. It seems
> to be a DRM related issue and when I get sometime I will see if I can
> figure out what is causing this. This is the furtherest I have gotten so
> far [1].

Thanks for the update.  Please keep in mind that DRM_MOUVEAU was
disabled in every iteration this time, so there might also be
something else unrelated to DRM.

Agreed, it's not worth bisecting much further.  In fact I found
these issues mostly as a side effect of working on the automatic
bisection mechanism in kernelci.org, and linux-next is especially
tricky to bisect.  On this subject, we'll probably start by
enabling this on stable trees and mainline, then see what we can
do with linux-next and other tricky trees at a later stage.

Thanks,
Guillaume

> [0] https://patchwork.kernel.org/patch/9974835/
> [1] https://www.spinics.net/lists/arm-kernel/msg616616.html
