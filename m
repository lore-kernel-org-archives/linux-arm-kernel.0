From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Mon, 11 May 2015 09:27:58 -0500
Subject: Bulid regression with VDSO enabled
In-Reply-To: <c66c257aba00dbedd17883507fc5f896@agner.ch>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com> <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
 <554D276D.9040205@mentor.com> <e376d894ce39c709192a5ffe7ca83762@agner.ch>
 <c66c257aba00dbedd17883507fc5f896@agner.ch>
Message-ID: <5550BC6E.4010005@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2015 08:25 AM, Stefan Agner wrote:
> On 2015-05-09 14:41, Stefan Agner wrote:
>> On 2015-05-08 23:15, Nathan Lynch wrote:
>>> On 05/08/2015 11:08 AM, Stefan Agner wrote:
>>>> On 2015-05-08 17:27, Nathan Lynch wrote:
>>>>> On 05/08/2015 06:13 AM, Stefan Agner wrote:
>>>>>> Also, I used the BFD linker by adding LD=${CROSS_COMPILE}ld.bfd to the
>>>>>> build command. Interestingly thought, I had the same issue when using
>>>>>> gold linker...
>>>>>
>>>>> When I try this, ld.gold is used regardless.
>>>>>
>>>>> You can tell by doing and checking for a NT_GNU_GOLD_VERSION note:
>>>>>
>>>>> $ readelf -n arch/arm/vdso/vdso.so.raw
>>>>>
>>>>> Displaying notes found at file offset 0x000001bc with length 0x00000040:
>>>>>   Owner                 Data size       Description
>>>>>   GNU                  0x00000009       NT_GNU_GOLD_VERSION (gold version)
>>>>>   GNU                  0x00000014       NT_GNU_BUILD_ID (unique build
>>>>> ID bitstring)
>>>>>     Build ID: f025409550acb7f955c61d95691291da078e6688
>>>>
>>>> Hm, you are right. When deleting moving ld.bfd to ld, which makes the
>>>> BFD linker as default, compiling works flawless.
>>>>
>>>> However, so far LD=${CROSS_COMPILE}ld.bfc seems to work for other build
>>>> objects, at least those do not have this note. For instance time.o does
>>>> not return anything:
>>>>
>>>> $ readelf -n arch/arm/kernel/time.o
>>>
>>> This is just an object file that hasn't been linked, but your general
>>> point stands -- LD is honored by other parts of the build.
>>>
>>>
>>>> So it seems to be a vdso.so.raw specific problem not using the specified
>>>> linker...?
>>>
>>> Yes, since it's produced by an invocation of $(CC) which is expected
>>> to call the linker implicitly, and this is how the toolchain's default
>>> linker ends up getting used even when you set LD on the command line.
>>>
>>> If I'm not mistaken, implicitly performing a link through the compiler
>>> seems to be 1) conventional for all VDSOs, not just ARM's, but 2) unusual
>>> for other parts of the kernel build.
>>>
>>> I suppose it's possible to make arch/arm/vdso/Makefile honor LD, but it
>>> would basically entail a rewrite.  In the meantime, using -fuse-ld=bfd
>>> may suffice:
>>>
>>> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
>>> index 8aa791051029..da0ce897edde 100644
>>> --- a/arch/arm/vdso/Makefile
>>> +++ b/arch/arm/vdso/Makefile
>>> @@ -43,6 +43,7 @@ quiet_cmd_vdsold = VDSO    $@
>>>        cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^)
>>> $(filter %.o,$^) \
>>>                     $(call cc-ldoption, -Wl$(comma)--build-id) \
>>>                     -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
>>> +                   $(call cc-option, -fuse-ld=bfd) \
>>>                     -Wl,-z,common-page-size=4096 -o $@
>>>
>>>  quiet_cmd_vdsomunge = MUNGE   $@
>>
>>
>> Thanks Nathan, your solution looks reasonable. I figured that the option
>> is available since GCC 4.8, so it should work probably for most
>> toolchains which try to make use of gold linker as default.
>>
>> Unfortunately, I hit another problem with the configuration on my build
>> host. With your patch applied, I get:
>> collect2: fatal error: cannot find 'ld'
>> compilation terminated.
>> make[2]: *** [arch/arm/vdso/vdso.so.raw] Error 1
>> make[1]: *** [arch/arm/vdso] Error 2
>> make[1]: *** Waiting for unfinished jobs....
> 
> Sorry for the noise, it turns out when using no paths in CROSS_COMPILE
> and instead add the location of the toolchain to PATH properly, this
> second issue is fixed.

I should have mentioned that this is the tradeoff with using -fuse-ld...
the requested linker needs to be in $PATH.

So, you lose if:
1. You're using e.g. CROSS_COMPILE=/usr/local/bin/arm-linux-gnu-gcc;
2. /usr/local/bin isn't in PATH;
3. Your toolchain is configured to use gold by default;
4. And you enable CONFIG_VDSO.

I am okay with accepting this as a limitation if Russell is.
