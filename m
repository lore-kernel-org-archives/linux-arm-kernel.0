From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 25 Oct 2017 14:40:48 +0900
Subject: [PATCH] kbuild: fix dependency of dtbs targets
In-Reply-To: <20171009150523.GT20805@n2100.armlinux.org.uk>
References: <1507091240-12756-1-git-send-email-yamada.masahiro@socionext.com>
 <20171009150523.GT20805@n2100.armlinux.org.uk>
Message-ID: <CAK7LNASCQqaBvERg6NXPym62Dyza00TuZVOWtj0YqLDKPT2D5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.


2017-10-10 0:05 GMT+09:00 Russell King - ARM Linux <linux@armlinux.org.uk>:
> On Wed, Oct 04, 2017 at 01:27:20PM +0900, Masahiro Yamada wrote:
>> The target "dtbs" should depend on "scripts" because it needs to
>> build dtc.  The "prepare" target is unneeded here.
>
> Looks fine for ARM, as the only thing the dtbs should depend on is
> the kernel configuration (to decide which to build) and DT tooling.
>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
>
> --


I found a potential issue on this
because the default DTB install path depends on $(KERNELRELEASE).


In top-level Makefile:
export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)


The include/config/kernel.release is created by "prepare3" target.

If the dependency on "parepare" is removed,
it is possible to run "make dtbs" and "make dtbs_install"
without creating include/config/kernel.release.

So, the $(KERNELRELEASE) could be empty when installing DTB.


Maybe, drop this patch, or reduce the dependency to "parepare3"?







-- 
Best Regards
Masahiro Yamada
