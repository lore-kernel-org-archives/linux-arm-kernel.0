From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 10:09:13 +0100
Subject: [PATCH 05/10] ARM: realview: remove private barrier implementation
In-Reply-To: <1448469143-447355-6-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
 <1448469143-447355-6-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYnxC3XhDZFFZMVQQGXtwCQ3kcUGaC99VRc=BuKF6pSow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 5:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The realview barrier implementation tries to avoid calling outer_sync in order
> to not lock up as a result of a bug in the l220 cache controller.
>
> This gets in the way of the multiplatform support, but we can still remove
> it if we make sure that the outer_sync function never gets called, by replacing
> the function pointer with NULL, right after initialization.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

When testing I see that this patch does not compile, but later patches
remove the offending code so it compiles again.

It needs this:

diff --git a/arch/arm/mach-realview/realview_eb.c
b/arch/arm/mach-realview/realview_eb.c
index 4d29535abeba..1a2a89708fb7 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -38,6 +38,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/smp_twd.h>
 #include <asm/system_info.h>
+#include <asm/outercache.h>

 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-realview/realview_pb11mp.c
b/arch/arm/mach-realview/realview_pb11mp.c
index f9817bb5d8fa..5bb460300b6a 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -42,6 +42,7 @@
 #include <asm/mach/flash.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
+#include <asm/outercache.h>

 #include <mach/board-pb11mp.h>
 #include <mach/irqs.h>

I've fixed it up in my tree, but I don't know yet if I'm getting anywhere with
this as my PB11MPCore refuse to boot with these patches. I'm trying to
find the problem...

Yours,
Linus Walleij
