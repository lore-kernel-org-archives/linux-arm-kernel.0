From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 2 Apr 2012 12:54:02 +0800
Subject: [PATCH 2/4] ARM: mxs: factor out dynamic amba device allocator
In-Reply-To: <1333329698-31666-1-git-send-email-linus.walleij@linaro.org>
References: <1333329698-31666-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120402045400.GB910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 03:21:38AM +0200, Linus Walleij wrote:
> Replace the local amba device allocator with the core code from
> the bus driver.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

It works with my testing.  And you can add my ack with the changes
below folded, which are primarily to fix the compile warnings.

  CC      arch/arm/mach-mxs/mach-mx23evk.o
In file included from arch/arm/mach-mxs/mach-mx23evk.c:26:0:
arch/arm/mach-mxs/devices-mx23.h:16:19: warning: function declaration isn?t a prototype [-Wstrict-prototypes]

  CC      arch/arm/mach-mxs/mach-mx28evk.o
In file included from arch/arm/mach-mxs/mach-mx28evk.c:32:0:
arch/arm/mach-mxs/devices-mx28.h:16:19: warning: function declaration isn?t a prototype [-Wstrict-prototypes]

Regards,
Shawn

--8<---

--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -13,7 +13,8 @@
 #include <mach/mxsfb.h>
 #include <linux/amba/bus.h>

-static inline int mx23_add_duart() {
+static inline int mx23_add_duart(void)
+{
        struct amba_device *d;

        d = amba_ahb_device_add(NULL, "duart", MX23_DUART_BASE_ADDR, SZ_8K,
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index b46c6d1..84b2960 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -13,7 +13,8 @@
 #include <mach/mxsfb.h>
 #include <linux/amba/bus.h>

-static inline int mx28_add_duart() {
+static inline int mx28_add_duart(void)
+{
        struct amba_device *d;

        d = amba_ahb_device_add(NULL, "duart", MX28_DUART_BASE_ADDR, SZ_8K,
@@ -21,7 +22,6 @@ static inline int mx28_add_duart() {
        return IS_ERR(d) ? PTR_ERR(d) : 0;
 }

-
 extern const struct mxs_auart_data mx28_auart_data[] __initconst;
 #define mx28_add_auart(id)     mxs_add_auart(&mx28_auart_data[id])
 #define mx28_add_auart0()              mx28_add_auart(0)
