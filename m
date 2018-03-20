From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Mar 2018 23:18:33 +0000
Subject: [PATCH 5/5] ARM: add support for building ARM kernel with clang
In-Reply-To: <20180320230206.25289-6-stefan@agner.ch>
References: <20180320230206.25289-1-stefan@agner.ch>
 <20180320230206.25289-6-stefan@agner.ch>
Message-ID: <20180320231832.GK2743@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 12:02:06AM +0100, Stefan Agner wrote:
> Use cc-options call for compiler options which are not available
> in clang. With this patch an ARMv7 multi platform kernel can be
> successfully build using clang (tested with version 5.0.1).
> 
> Based-on-patches-by: Behan Webster <behanw@converseincode.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index e9e3fde3c657..20e9fee1ccc5 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -39,7 +39,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-mno-unaligned-access)
>  endif
>  
>  ifeq ($(CONFIG_FRAME_POINTER),y)
> -KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
> +KBUILD_CFLAGS	+=-fno-omit-frame-pointer $(call cc-option,-mapcs,) $(call cc-option,-mno-sched-prolog,)

Some of these options here are to ensure that we generate the following
code, so we can backtrace:

	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4

If clang isn't producing that code at the start of functions with
CONFIG_FRAME_POINTER=y, then backtracing will not work, and arguably
CONFIG_FRAME_POINTER=y is useless there.  In that circumstance, it's
probably better to fail so the user can configure something more
debuggable, rather than having the kernel potentially producing
undebuggable oopses.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
