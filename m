From: robherring2@gmail.com (Rob Herring)
Date: Wed, 05 Sep 2012 08:25:54 -0500
Subject: [PATCH v2] ARM: initial multiplatform support
In-Reply-To: <201209051036.53031.arnd@arndb.de>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <201209040656.23536.arnd@arndb.de> <50468361.6080605@gmail.com>
 <201209051036.53031.arnd@arndb.de>
Message-ID: <504752E2.4050407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 05:36 AM, Arnd Bergmann wrote:
> On Tuesday 04 September 2012, Rob Herring wrote:
>> On 09/04/2012 01:56 AM, Arnd Bergmann wrote:
>>> On Monday 03 September 2012, Rob Herring wrote:
>>>> On 09/03/2012 11:34 AM, Arnd Bergmann wrote:
>>>>>> @@ -254,27 +254,9 @@ config MMU
>>>>>>  #
>>>>>>  choice
>>>>>>         prompt "ARM system type"
>>>>>> +       depends on !ARCH_MULTIPLATFORM
>>>>>>         default ARCH_VERSATILE
>>>>>
>>>>> Why did you move ARCH_MULTIPLATFORM out of the "choice" statement?
>>>>> If we leave it in there, and make it the default, then we don't
>>>>> even have to change the defconfigs any more (except the versatile
>>>>> one, which is no longer the default), which I think is quite clever
>>>>> and helps git-bisecting across this commit.
>>>>
>>>> We don't have to change and of the defconfigs or .config in this patch.
>>>
>>> How does ARCH_MULTIPLATFORM get set then when building the existing
>>> defconfig files for the converted platforms?
>>
>> Ahhh, right. Those need to be updated. It doesn't really matter if
>> ARCH_MULTIPLATFORM is in the choice or not. It matters if we move
>> platforms out of the choice or not. More on that below.
> 
> But if ARCH_MULTIPLATFORM is one of the choice statements rather than
> a separate option, you don't need to change any of the defconfigs,
> and you can keep using 'make oldconfig' when bisecting over this
> commit.
>>>
>>> I was thinking of other cases actually:
>>>
>>> * device drivers that we don't really care about much but that rely
>>>   on a mach/* header file. In some cases it can be hard to clean up
>>>   those headers, so as an intermediate step, we can just disable the
>>>   drivers when building multiplatform.
>>
>> depends on !ARCH_MULTIPLATFORM ?
> 
> Yes, of course, that is what you'd do in in the drivers, but it only works
> if the same platform can be used both with and without ARCH_MULTIPLATFORM.
> 
>>> * At least the Samsung platforms have files that are built for separate
>>>   platforms in a way that does not work across platforms: 
>>>   arch/arm/plat-samsung/devs.c depends heavily on constants defined
>>>   in mach/*.h header files. When building for DT-only, we can decide to
>>>   just not build this file.
>>
>> I still think that should be possible on a per platform basis, but why
>> mandate that all platforms do that?
> 
> I wasn't suggesting we do that. The platforms that you have already
> converted are all ok to stay multiplatform-only.
> 
>> We have ARCH_FOO in the choice today. Assuming we want to keep the
>> choice name as is to not break configs (as Russell wanted), we have to
>> leave this alone. So then we create ARCH_FOO_MULTI for the mult-platform
>> case and also ARCH_FOO_OPTIONS to avoid duplicating all the per mach
>> selects for ARCH_FOO and ARCH_FOO_MULTI. However, then we have ARCH_FOO
>> as a depends all over the tree. I'd like to avoid having to fix-up all
>> those to be depends on ARCH_FOO_OPTIONS or (ARCH_FOO || ARCH_FOO_MULTI).
> 
> I've been going back and forth a few times between the different methods
> when I created the earlier version of this patch, trying to find the one
> that is least invasive. As you say, creating a new ARCH_FOO_MULTI in parallel
> with the existing (choice) ARCH_FOO means we have to change all the Kconfig
> statements that refer to ARCH_FOO. The good news is that I think we now only
> have to do it inside of the mach-foo directories, which we might want to
> rework anyway so you can more easily build e.g. a THUMB2 kernel that enables
> all the ARMv7 platforms but not the ARMv6 ones.
> 
> All device drivers that have a dependency on a specific platform should
> fall into one of two categories:
> 
> a) Those using platform specific header files. We just decided to not allow
> this in multiplatform kernels, so having a dependency on a symbol that
> only exists for single-platform builds is appropriate.
> 
> b) Drivers that only make sense for one platform but can be built anywhere,
> e.g. after fixing the include path from a). I'd argue that we should allow
> building them anyway, to improve build coverage, so we should better remove
> the dependency, or turn it into a more specific one.

Agreed. There are some other cases like clk drivers which are not
visible options. But changing those are probably manageable.

So to summarize, I'll make ARCH_MULTIPLATFORM part of the choice. The
platforms I converted will stay multi-plat only and don't need
additional kconfig options. Additional platforms converted can choose
whether they want to support both single and multi platform in the kconfig.

Rob
