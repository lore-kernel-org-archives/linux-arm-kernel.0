From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 31 Jul 2014 13:30:42 +0800
Subject: [PATCH v15 08/12] ARM: config: append lpae configuration
In-Reply-To: <CAOesGMhgWncQ9wafjjDiaZkT1ge-YPe5bjFs9Ebyj7Fg=3YhHQ@mail.gmail.com>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-9-git-send-email-haojian.zhuang@linaro.org>
 <20140729040531.GB8430@quad.lixom.net>
 <CAD6h2NQ-+t0=XvMWR54tzpvkMe+JT4FcLvQFPNJuUea32GDS8g@mail.gmail.com>
 <CAOesGMge6U4B0Eedhi22t=r2gHucEcwcrcGBmkuZ6jAVR1ZoOA@mail.gmail.com>
 <CAD6h2NTK=nARtyRwRPyprOmhLxEwkTFm84s4UqHZr1gEPFBaVw@mail.gmail.com>
 <CAOesGMhgWncQ9wafjjDiaZkT1ge-YPe5bjFs9Ebyj7Fg=3YhHQ@mail.gmail.com>
Message-ID: <CAD6h2NT5BP4Rmz+vfTLSsw19xCNSfXE6wwAhr1Fcrd9VuyXOeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 11:55, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jul 30, 2014 at 7:24 PM, Haojian Zhuang
> <haojian.zhuang@linaro.org> wrote:
>> On 31 July 2014 09:01, Olof Johansson <olof@lixom.net> wrote:
>>> On Tue, Jul 29, 2014 at 3:43 AM, Haojian Zhuang
>>> <haojian.zhuang@linaro.org> wrote:
>>>> On 29 July 2014 12:05, Olof Johansson <olof@lixom.net> wrote:
>>>>> On Mon, Jul 28, 2014 at 09:57:52PM +0800, Haojian Zhuang wrote:
>>>>>> Append multi_v7_lpae_config. In this default configuration,
>>>>>> CONFIG_ARCH_MULTI_V6 is disabled. CONFIG_ARM_LPAE is enabled.
>>>>>
>>>>> NACK. This is the nth time I have had to nack this patch.
>>>>>
>>>>> You are enabling platforms here that don't have LPAE. Don't do that.
>>>>>
>>>>> It's trivial to create a LPAE version of multi_v7 defconfig locally.
>>>>>
>>>>>
>>>>> -Olof
>>>>
>>>> I tried to remove those SoCs that can't support LPAE. But I don't know
>>>> every platform in details.
>>>>
>>>> How about that I only enable HIP04 in multi_v7_lpae_defconfig. If you
>>>> think any platform could be added, please help to list it. Then I
>>>> could append them into the multi_v7_lpae_defconfig.
>>>
>>> I really don't like having to repeat this over and over: Just add LPAE
>>> to a multi_v7_defconfig build when you need to turn it on.
>>>
>>> The alternative is to do this right from the beginning, and move
>>> multi_v7 over to be a v6_v7 defconfig, and also have an lpae+kvm
>>> defconfig for A7/12/15/17 (and mvebu/krait) platforms. But there's
>>> been no need for that yet since all platforms to date can boot without
>>> LPAE just fine -- in fact most of them don't actually need it since
>>> nearly all of them have less memory and for the few of them that do
>>> you just turn on LPAE manually like I suggested.
>>>
>>>
>>> -Olof
>>
>> I can drop both hip04_defconfig & multi_v7_lpae_defconfig. But the
>> problem is that 16GB memory is used in hip04 platform. 64bit memory
>> address is also used in hip04 dts file. So I can't boot kernel without
>> LPAE configuration.
>>
>> If I integrate ARCH_HIP04 & LPAE into hi3xxx_defconfig, both
>> ARCH_HI3XXX & ARCH_X5HD2 don't support LPAE.
>
> There is memory at 0x10000000-0xd0000000 and all I/O is below 4GB. You
> should be able to boot just fine without LPAE, but you won't see all
> memory available.
>

Maybe I didn't express this well. Let's check the memory layout in hip04.

<0x00000000-10000000, 0x00000000-c0000000> & <0x00000004-0xc0000000,
0x00000003-40000000> are two memory regions.

These memory address is 64-bit. When ARM_LPAE is disabled,
memblock_add() parses memory base address & size with 32-bit. Since
ARCH_PHYS_ADDR_T_64BIT is highly depend on ARM_LPAE.

Then these two memory regions become <0x10000000, 0xc0000000> &
<0xc0000000, 0xffffffff>. Lots of IO space are in <0xe0000000,
0xefffffff>. So memory space conflicts when ARM_LPAE is disabled.
Kernel panic will come since it believes IO space is memory.

Only two solutions are available in below.
1. Use hip04_defconfig to declare ARM_LPAE.
2. Use hi3xxx_defconfig, and only declare 2.9GB memory in DTS file
without ARM_LPAE.

I think solution #1 is better. What's your opinion?

Best Regards
Haojian
