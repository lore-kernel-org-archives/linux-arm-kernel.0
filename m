From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 May 2012 19:03:03 +0000
Subject: [PATCH] clkdev: Add default clkdev.h
In-Reply-To: <1337005167-22628-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1337005167-22628-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <201205141903.04121.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 May 2012, Mark Brown wrote:
> Ease the deployment of clkdev by providing a default asm/clkdev.h which
> will be used if the arch does not have an include/asm/clkdev.h.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/asm-generic/Kbuild.asm |    4 ++++
>  include/asm-generic/clkdev.h   |   26 ++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100644 include/asm-generic/clkdev.h
> 

Good idea!

>diff --git a/include/asm-generic/Kbuild.asm b/include/asm-generic/Kbuild.asm
>index c5d2e5d..da121e0 100644
>--- a/include/asm-generic/Kbuild.asm
>+++ b/include/asm-generic/Kbuild.asm
>@@ -13,6 +13,10 @@ ifneq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/a.out.h \
> header-y += a.out.h
> endif
> 
>+ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/clkdev.h),)
>+generic-y += clkdev.h
>+endif
>+
> header-y += auxvec.h
> header-y += bitsperlong.h
> header-y += byteorder.h

I'm not completely sure about this part. It should work just fine, but we haven't
done this for any of the other asm/* headers. If we decide to list generic header
files  in Kconfig.asm that automatically get added to architectures, I would prefer
doing it with a nicer syntax so we can do it for a lot of the other header files
too. For now, I'd prefer to just add the file manually to the asm/Kbuild files
in the architectures where it makes sense (e.g. all but s390).

	Arnd
