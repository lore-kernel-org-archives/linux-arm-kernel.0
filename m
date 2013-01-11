From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 11:11:16 -0800
Subject: [PATCH 4/4] ARM: uncompress: support uncompress debug for
 multiplatform build
In-Reply-To: <1355319945-3199-5-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
 <1355319945-3199-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130111191116.GA999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 12, 2012 at 09:45:45PM +0800, Shawn Guo wrote:
> When moving to multiplatform build, platforms lose the output from
> decompressor.  Not only does it mean that we will never see message
> "Uncompressing Linux... done, booting the kernel.", but also that
> the debug facility in arch/arm/boot/compressed/head.S outputs nothing
> even DEBUG is turned on.
> 
> The patch follows the approach handling DEBUG_LL to create a Kconfig
> symbol CONFIG_UNCOMPRESS_INCLUDE for choosing the correct uncompress
> header.  For traditional build, mach/uncompress.h will be included in
> arch/arm/boot/compressed/misc.c.  For multiplatform build with none
> DEBUG_LL port enabled, debug/uncompress/dummy.h will be used.  And
> for multiplatform build with a DEBUG_LL port, platform specific
> uncompress header like debug/uncompress/imx.h will come to play.
> 
> Different from traditional build that uncompress output and DEBUG_LL
> are two separated pieces, for multiplatform build uncompress output
> becomes a subset of DEBUG_LL and will not work unless DEBUG_LL is
> enabled.
> 
> The arch/arm/include/debug/uncompress/imx.h is cleaned up and added
> here as an example to show how this approach works.

Since this requires you to define a debug uart to get uncompress output,
it would make more sense to do a generic wrapper that uses the debug
code generically, instead of having to add this kind of wrapper for
every platform. That would solve it for all of them at once.


-Olof
