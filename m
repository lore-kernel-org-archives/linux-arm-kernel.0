From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 9 May 2015 10:31:59 +0200
Subject: Bulid regression with VDSO enabled
In-Reply-To: <554D276D.9040205@mentor.com>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com>
 <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
 <554D276D.9040205@mentor.com>
Message-ID: <CAKv+Gu_i6Cjr-+mYLkw=Oo6HPQkRTGwjFf5o5QX6bgiGsVFDYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On 8 May 2015 at 23:15, Nathan Lynch <Nathan_Lynch@mentor.com> wrote:
> On 05/08/2015 11:08 AM, Stefan Agner wrote:
>> On 2015-05-08 17:27, Nathan Lynch wrote:
>>> On 05/08/2015 06:13 AM, Stefan Agner wrote:
>>>> Also, I used the BFD linker by adding LD=${CROSS_COMPILE}ld.bfd to the
>>>> build command. Interestingly thought, I had the same issue when using
>>>> gold linker...
>>>
>>> When I try this, ld.gold is used regardless.
>>>
>>> You can tell by doing and checking for a NT_GNU_GOLD_VERSION note:
>>>
>>> $ readelf -n arch/arm/vdso/vdso.so.raw
>>>
>>> Displaying notes found at file offset 0x000001bc with length 0x00000040:
>>>   Owner                 Data size       Description
>>>   GNU                  0x00000009       NT_GNU_GOLD_VERSION (gold version)
>>>   GNU                  0x00000014       NT_GNU_BUILD_ID (unique build
>>> ID bitstring)
>>>     Build ID: f025409550acb7f955c61d95691291da078e6688
>>
>> Hm, you are right. When deleting moving ld.bfd to ld, which makes the
>> BFD linker as default, compiling works flawless.
>>
>> However, so far LD=${CROSS_COMPILE}ld.bfc seems to work for other build
>> objects, at least those do not have this note. For instance time.o does
>> not return anything:
>>
>> $ readelf -n arch/arm/kernel/time.o
>
> This is just an object file that hasn't been linked, but your general
> point stands -- LD is honored by other parts of the build.
>
>

I suppose this implies that the build only chokes on --pic-veneer when
linking the VDSO, and nowhere else?

>> So it seems to be a vdso.so.raw specific problem not using the specified
>> linker...?
>
> Yes, since it's produced by an invocation of $(CC) which is expected
> to call the linker implicitly, and this is how the toolchain's default
> linker ends up getting used even when you set LD on the command line.
>
> If I'm not mistaken, implicitly performing a link through the compiler
> seems to be 1) conventional for all VDSOs, not just ARM's, but 2) unusual
> for other parts of the kernel build.
>
> I suppose it's possible to make arch/arm/vdso/Makefile honor LD, but it
> would basically entail a rewrite.  In the meantime, using -fuse-ld=bfd
> may suffice:
>
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index 8aa791051029..da0ce897edde 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -43,6 +43,7 @@ quiet_cmd_vdsold = VDSO    $@
>        cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) \
>                     $(call cc-ldoption, -Wl$(comma)--build-id) \
>                     -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
> +                   $(call cc-option, -fuse-ld=bfd) \
>                     -Wl,-z,common-page-size=4096 -o $@
>
>  quiet_cmd_vdsomunge = MUNGE   $@
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
