From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 12:04:19 -0700
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <20130206093236.GD17833@n2100.arm.linux.org.uk>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
 <20130204160133.GH17786@n2100.arm.linux.org.uk>
 <20130206093236.GD17833@n2100.arm.linux.org.uk>
Message-ID: <5112A933.4090108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 02:32 AM, Russell King - ARM Linux wrote:
> On Mon, Feb 04, 2013 at 04:01:33PM +0000, Russell King - ARM Linux wrote:
>> On Fri, Jan 18, 2013 at 10:45:20AM +0800, Shawn Guo wrote:
>>> Instead of giving zero support of uncompress debug for multiplatform
>>> build, the patch turns uncompress debug into one part of DEBUG_LL
>>> support.  When DEBUG_LL is turned on for a particular platform,
>>> uncompress debug works too for that platform.
>>>
>>> It reuses the platform DEBUG_LL macros by creating a simple
>>> arch/arm/boot/compressed/debug.S with CONFIG_DEBUG_LL_INCLUDE
>>> included there, and implements a generic putc() using those macros.
>>
>> Ok, I've applied this on the previso that _no one_ in future whinges if
>> the debug infrastructure doesn't quite meet their expectation.  The
>> debug infrastructure remains first and foremost that: a simple debug
>> infrastructure suitable for use in the early assembly and the like.
>>
>> That is its primary concern and trumps any requirements from consoles,
>> early printk, decompressor output, and the like.
> 
> ... and now I've dropped the two patches because it causes build failures
> for all OMAP and PXA platforms.

It also breaks tegra_defconfig. For reference, the (or perhaps just a)
reason here is that arch/arm/include/debug/tegra.S references symbol
tegra_uart_config, which is declared in arch/arm/mach-tegra/common.c,
which isn't part of the decompressor build. Tegra's uncompress.h doesn't
touch this symbol, hence avoids this problem.

I'd guess OMAP is broken for similar reasons, since when I created the
tegra_uart_config symbol I was inspired by the OMAP DEBUG_LL code.

Perhaps the patch can be re-cast to only affect multi-platform kernels,
and leave unconverted platforms using uncompress.h (at least, I assume
that must be the problem).
