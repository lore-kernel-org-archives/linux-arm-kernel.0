From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Jul 2015 09:38:52 -0700
Subject: [PATCH] ARM: BCM: Restrict Broadcom BCM470X / BCM5301X to non-LPAE
In-Reply-To: <9845978.JUsldTlF3B@wuerfel>
References: <1436897535-3782-1-git-send-email-f.fainelli@gmail.com>
 <4793510.M34v5PmKgi@wuerfel> <55A57F3B.1080909@broadcom.com>
 <9845978.JUsldTlF3B@wuerfel>
Message-ID: <55A68C9C.8000303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/15 03:08, Arnd Bergmann wrote:
> On Tuesday 14 July 2015 14:29:31 Florian Fainelli wrote:
>> On 14/07/15 13:43, Arnd Bergmann wrote:
>>> On Tuesday 14 July 2015 11:12:15 Florian Fainelli wrote:
>>>> Cortex-A9 on at least BCM4708 SoCs are not LPAE capable, booting such a
>>>> kernel will result in the following:
>>>>
>>>> Error: Kernel with LPAE support, but CPU does not support LPAE.
>>>>
>>>> Restrict such SoCs to be built in a configuration that does not enable
>>>> ARM_LPAE.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>
>>>
>>> This is an old problem for all platforms, I think we want a more
>>> generic solution though, instead of adding the !LPAE dependency
>>> for each Cortex-A5/8/9 platform.
>>
>> Fair enough, what do you have in mind? Should we introduce something
>> like CONFIG_V7_A9 and such, and update all platforms to select such
>> symbols such that we can then apply a restriction on other symbols if
>> there needs to be?
>>
>> What if any of these CPUs end-up supporting LPAE, but this cannot be
>> flagged at build time?
> 
> I would introduce special architecture levels for ARMv7+LPAE and/or
> ARMv7VE. I am not entirely sure what combinations exist and whether
> it's enough to add ARMv7VE.
> 
> Basically, I think ARM_LPAE should only be selectable if ARMv7VE
> is the lowest architecture level that is enabled, and all ARMv7VE
> based platforms would have to be changed to depend on ARCH_MULTI_V7VE
> instead of ARCH_MULTI_V7.
> 
> Also, when building an ARMv7VE kernel, we really want to build with
> gcc -march=armv7ve (as long as that is available, possibly falling
> back to -mcpu=cortex-a15), so we build with the idiv instructions.
> The part I'm unclear about is whether there are CPU cores that support
> only idiv but not LPAE or vice versa. If there are, we need an extra
> level.

I like the idea in general, but I think this is going to be a very
tedious job to collect every single CR values for ARMv7 processors to
determine whether they are pure v7 or v7e... Maybe we could use
kernelci.org to start extracting the relevant lines in bootlogs and
people can start adding their own chips one by one?
-- 
Florian
