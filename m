From: stefan@agner.ch (Stefan Agner)
Date: Sat, 09 May 2015 14:41:20 +0200
Subject: Bulid regression with VDSO enabled
In-Reply-To: <554D276D.9040205@mentor.com>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com> <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
 <554D276D.9040205@mentor.com>
Message-ID: <e376d894ce39c709192a5ffe7ca83762@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-08 23:15, Nathan Lynch wrote:
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
>        cmd_vdsold = $(CC) $(c_flags) -Wl,-T $(filter %.lds,$^)
> $(filter %.o,$^) \
>                     $(call cc-ldoption, -Wl$(comma)--build-id) \
>                     -Wl,-Bsymbolic -Wl,-z,max-page-size=4096 \
> +                   $(call cc-option, -fuse-ld=bfd) \
>                     -Wl,-z,common-page-size=4096 -o $@
>  
>  quiet_cmd_vdsomunge = MUNGE   $@


Thanks Nathan, your solution looks reasonable. I figured that the option
is available since GCC 4.8, so it should work probably for most
toolchains which try to make use of gold linker as default.

Unfortunately, I hit another problem with the configuration on my build
host. With your patch applied, I get:
collect2: fatal error: cannot find 'ld'
compilation terminated.
make[2]: *** [arch/arm/vdso/vdso.so.raw] Error 1
make[1]: *** [arch/arm/vdso] Error 2
make[1]: *** Waiting for unfinished jobs....

OpenEmbedded distinguish between three toolchains for the target:
- Native (on the target)
- Host (on the host which builds the whole image, usually x86_64)
- SDK (on a third architecture for application development, usually x86
or x86_64, the toolchain which I published the link to)

I use x86_64 as host and SDK architecture, nevertheless it seems that
the toolchains are configured differently. The Host toolchain (the one
which shows the error above) uses "--enable-gold=default" when
configuring binutils. With that option, ld.bfd is still being built, but
ld is by default gold, without any additional doing (cp/ln -f..).
Currently it seems to me that this difference triggers a problem with
-fuse-ld=bfd.

However, I don't think that this problem invalidates your proposed
solution.

--
Stefan
