From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 09:36:22 -0700
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <20130207050434.GA7697@S2101-09.ap.freescale.net>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <20130204160133.GH17786@n2100.arm.linux.org.uk>
 <20130206093236.GD17833@n2100.arm.linux.org.uk>
 <5112A933.4090108@wwwdotorg.org>
 <20130207050434.GA7697@S2101-09.ap.freescale.net>
Message-ID: <5113D806.7090609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 10:04 PM, Shawn Guo wrote:
> On Wed, Feb 06, 2013 at 12:04:19PM -0700, Stephen Warren wrote:
>> On 02/06/2013 02:32 AM, Russell King - ARM Linux wrote:
>>> On Mon, Feb 04, 2013 at 04:01:33PM +0000, Russell King - ARM Linux wrote:
>>>> On Fri, Jan 18, 2013 at 10:45:20AM +0800, Shawn Guo wrote:
>>>>> Instead of giving zero support of uncompress debug for multiplatform
>>>>> build, the patch turns uncompress debug into one part of DEBUG_LL
>>>>> support.  When DEBUG_LL is turned on for a particular platform,
>>>>> uncompress debug works too for that platform.
>>>>>
>>>>> It reuses the platform DEBUG_LL macros by creating a simple
>>>>> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
>>>>> included there, and implements a generic putc() using those macros.
>>>>
>>>> Ok, I've applied this on the previso that _no one_ in future whinges if
>>>> the debug infrastructure doesn't quite meet their expectation.  The
>>>> debug infrastructure remains first and foremost that: a simple debug
>>>> infrastructure suitable for use in the early assembly and the like.
>>>>
>>>> That is its primary concern and trumps any requirements from consoles,
>>>> early printk, decompressor output, and the like.
>>>
>>> ... and now I've dropped the two patches because it causes build failures
>>> for all OMAP and PXA platforms.
>>
>> It also breaks tegra_defconfig. For reference, the (or perhaps just a)
>> reason here is that arch/arm/include/debug/tegra.S references symbol
>> tegra_uart_config, which is declared in arch/arm/mach-tegra/common.c,
>> which isn't part of the decompressor build. Tegra's uncompress.h doesn't
>> touch this symbol, hence avoids this problem.
>>
> Thanks for the info, Stephen.
> 
> From what I see, the patch breaks omap, pxa and tegra build by
> different causes.
...
>> Perhaps the patch can be re-cast to only affect multi-platform kernels,
>> and leave unconverted platforms using uncompress.h (at least, I assume
>> that must be the problem).
> 
> Indeed.  The arch/arm/boot/compressed/debug.S shouldn't be part of
> traditional build but only multiplatform.  Let's force that with the
> change below.
> 
> 8<---
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index c9865f6..13bdd10 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -24,9 +24,11 @@ endif
>  AFLAGS_head.o += -DTEXT_OFFSET=$(TEXT_OFFSET)
>  HEAD   = head.o
>  OBJS   += misc.o decompress.o
> +ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
>  ifeq ($(CONFIG_DEBUG_LL),y)
>  OBJS   += debug.o
>  endif
> +endif
>  FONTC  = $(srctree)/drivers/video/console/font_acorn_8x8.c
> 
>  # string library code (-Os is enforced to keep it much smaller)
> --->8

Yes, that patch fixes the build problem for me, and all decompressor
output and earlyprintk works. Thanks.
