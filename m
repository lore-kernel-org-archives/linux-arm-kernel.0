From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 15 Mar 2016 21:26:08 +0100
Subject: [OpenWrt-Devel] ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <16727306.4g6uRjH7LT@wuerfel>
References: <201603101013.04618.arnd@arndb.de>
 <3cbff06f821f529e67cf75580ee89732@advem.lv>
 <alpine.LNX.2.00.1603111721340.13469@T420s>
 <16727306.4g6uRjH7LT@wuerfel>
Message-ID: <CAKv+Gu-jHrnpkhE-TzA9FXd_tfm0kLKihXH9SpUcexsqEtmsWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 March 2016 at 16:59, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 March 2016 17:56:12 Hans Ulli Kroll wrote:
>> On Fri, 11 Mar 2016, Roman Yeryomin wrote:
>> > On 2016-03-11 08:48, John Crispin wrote:
>> > > On 11/03/2016 06:44, Hans Ulli Kroll wrote:
>
>> > As to the numbers I think that people like me (or others trying out OpenWrt)
>> > usually don't go to the forums, so number of questions there doesn't tell much
>> > (but even there latest messages are from last month, so not dead at all).
>> > Maybe number of downloads from downloads.openwrt.org can tell more but I would
>> > guess that actual users would rather compile it themselves.
>>
>> The support thread on the german board is very long, so most of the
>> questions are answered there. The experienced don't need this, so the
>> numbers *are* wrong.
>>
>> And I'm using two of the NAS boxes for backup and another for kernel work
>>
>> > So I vote for not killing it at least until it's supported by kernel.
>> >
>>
>> ACK !!
>
> Thanks everyone for the input. So if OpenWRT wants to keep the support
> for the Gemini platform, I see two ways forward:
>
> - have a separate toolchain for target/linux/gemini when the other
>   platforms upgrade to gcc-7. That means no action needed for now,
>   but possibly more work to keep it going in the long run
>
> - make the upstream kernel work with compilers that lack -march=armv4
>   support.
>
> I think we want the second one if at all possible, as it also addresses
> most of the other affected platforms (not rpc, which requires -march=armv3).
>
> The patch below might be enough, passing -march=armv4t whenever -march=armv4
> is not supported, and passing --fix-v4bx whenever we build for ARMv4:
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 9fb3fee0e908..3c312d37a83a 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -19,6 +19,11 @@ LDFLAGS_vmlinux      += --be8
>  LDFLAGS_MODULE += --be8
>  endif
>
> +ifeq ($(CONFIG_CPU_32v4),y)
> +LDFLAGS_vmlinux        += $(call ld-option,--fix-v4bx)
> +LDFLAGS_MODULE += $(call ld-option,--fix-v4bx)

Does this have any effect on partial linking? I would expect the
module loader to handle the R_ARM_V4BX relocation in this case

> +endif
> +
>  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
>  LDFLAGS_MODULE += -T $(srctree)/arch/arm/kernel/module.lds
>  endif
> @@ -75,7 +80,7 @@ arch-$(CONFIG_CPU_32v6K)      =-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,
>  endif
>  arch-$(CONFIG_CPU_32v5)                =-D__LINUX_ARM_ARCH__=5 $(call cc-option,-march=armv5te,-march=armv4t)
>  arch-$(CONFIG_CPU_32v4T)       =-D__LINUX_ARM_ARCH__=4 -march=armv4t
> -arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 -march=armv4
> +arch-$(CONFIG_CPU_32v4)                =-D__LINUX_ARM_ARCH__=4 $(call cc-option,-march=armv4,-march=armv4t)
>  arch-$(CONFIG_CPU_32v3)                =-D__LINUX_ARM_ARCH__=3 -march=armv3
>
>  # Evaluate arch cc-option calls now
> @@ -93,8 +98,8 @@ tune-$(CONFIG_CPU_ARM922T)    =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_ARM925T)     =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_ARM926T)     =-mtune=arm9tdmi
>  tune-$(CONFIG_CPU_FA526)       =-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_SA110)       =-mtune=strongarm110
> -tune-$(CONFIG_CPU_SA1100)      =-mtune=strongarm1100
> +tune-$(CONFIG_CPU_SA110)       =$(call cc-option,-mtune=strongarm110)
> +tune-$(CONFIG_CPU_SA1100)      =$(call cc-option,-mtune=strongarm1100)
>  tune-$(CONFIG_CPU_XSCALE)      =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
>  tune-$(CONFIG_CPU_XSC3)                =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
>  tune-$(CONFIG_CPU_FEROCEON)    =$(call cc-option,-mtune=marvell-f,-mtune=xscale)
>
> Does this look reasonable?
>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
