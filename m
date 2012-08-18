From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 Aug 2012 01:06:50 +0200
Subject: [PATCH 0/6] Integrator devicetree support
In-Reply-To: <201208161344.55723.arnd@arndb.de>
References: <1345119317-22600-1-git-send-email-linus.walleij@linaro.org>
 <201208161344.55723.arnd@arndb.de>
Message-ID: <CACRpkdYYgdzAU=nyL7dQbdMLx3z3G+K7ba0uJe1=aX=BLeF_sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 3:44 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 16 August 2012, Linus Walleij wrote:
>> This patch set moves all the non-DT platform code into
>> #ifndef CONFIG_OF sections for clarity. The plan is to
>> delete them after deprecation.
>
> I'm fine with your playing around with this in any way you
> like, but I think in general we should have a new CONFIG_ATAG
> symbol, so you can build a kernel that supports booting
> both with and without DT for the same platform, depending
> on what the boot loader supports.
>
> Then you can enclose all the non-DT sections in #ifdef
> CONFIG_ATAG and we can remove them at some later stage.

Since we already have CONFIG_USE_OF I think
CONFIG_USE_ATAGS is more apropriate, but I get the
idea. So it begins like this:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..0764ef7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1907,6 +1907,12 @@ endmenu

 menu "Boot options"

+config USE_ATAGS
+       bool "ATAGS support"
+       default y
+       help
+         Include support for ATAGS-based machine descriptions.
+
 config USE_OF
        bool "Flattened Device Tree support"
        select OF
@@ -2110,6 +2116,7 @@ config KEXEC

 config ATAGS_PROC
        bool "Export atags in procfs"
+       depends on USE_ATAGS
        depends on KEXEC
        default y
        help

But then we hit #ifdeffing and compiling out a lot of dangerous stuff
in arch/arm/kernel and then I get the creeps. I can try, but I think
this is typical Nico territory for example...

Yours,
Linus Walleij
