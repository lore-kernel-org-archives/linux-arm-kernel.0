From: raj.khem@gmail.com (Khem Raj)
Date: Tue, 04 Oct 2011 19:04:09 -0700
Subject: [PATCH 05/11] ARM: vfp: use -mfloat-abi=soft to build vfp
In-Reply-To: <20111003140411.GB2117@arm.com>
References: <1317496920-7764-1-git-send-email-arnd@arndb.de>
	<1317496920-7764-6-git-send-email-arnd@arndb.de>
	<20111003140411.GB2117@arm.com>
Message-ID: <4E8BBB19.8080303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/3/2011 7:04 AM, Dave Martin wrote:
> On Sat, Oct 01, 2011 at 09:21:54PM +0200, Arnd Bergmann wrote:
>> Distros are starting to ship with toolchains defaulting to
>> hardfloat. Using such a compiler to build the kernel fails
>> in the VFP directory with
>>
>> arch/arm/vfp/entry.S:1:0: sorry, unimplemented: -mfloat-abi=hard and VFP
>>
>> Adding -mfloat-abi=soft to the gcc command line fixes this.
>>
>> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
>> ---
>>   arch/arm/vfp/Makefile |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/vfp/Makefile b/arch/arm/vfp/Makefile
>> index 6de73aa..a81404c 100644
>> --- a/arch/arm/vfp/Makefile
>> +++ b/arch/arm/vfp/Makefile
>> @@ -7,7 +7,7 @@
>>   # ccflags-y := -DDEBUG
>>   # asflags-y := -DDEBUG
>>
>> -KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp)
>> +KBUILD_AFLAGS	:=$(KBUILD_AFLAGS:-msoft-float=-Wa,-mfpu=softvfp+vfp -mfloat-abi=soft)
>
> Although -mfpu=softvfp+vfp and -mfloat-abi=soft look mutually
> contradictory, this seems to have the correct effect, i.e. the
> assembler allows floating-point instructions but marks the resulting
> object as using the soft-float calling conventions.

I was wondering if this could also be achieved with -mfloat-abi=softfp 
this will also add Tag_FP_arch: VFPv2 into .attributes section and 
-Wa,-mfpu=softvfp+vfp may not be needed.

>
> The binutils documentation also seems to confirm that that's what
> should happen.
>
> I don't see another combination of options for getting this effect.
>
>
> So, if you like:
>
> Reviewed-by: Dave Martin<dave.martin@linaro.org>
>
> Cheers
> ---Dave
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
