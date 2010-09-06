From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 6 Sep 2010 10:35:03 +0200
Subject: [PATCH] ARM: PL330: Accept revisions of the dmac
In-Reply-To: <AANLkTikeTyUtUQEobgi0eQX47jO0CQ2oGusojHv1ymED@mail.gmail.com>
References: <1283502656-15445-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTimC5Ru-cTGVynnCu2NntHrHa9pB1HSGWEEJNZT7@mail.gmail.com>
	<AANLkTikeTyUtUQEobgi0eQX47jO0CQ2oGusojHv1ymED@mail.gmail.com>
Message-ID: <AANLkTims+16hJT5m3e+_9vf5wfvtRyArHV2ttzbHxid9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/5 Jassi Brar <jassisinghbrar@gmail.com>:
> [Me]
>> Jassi, this kind of macros already exist in <linux/amba/bus.h>
>> can't you just #include that and use these instead?
> You mean to use amba_config/rev et al ?
>
> But they work on struct amba_device *, and I have to form those
> structs just to make use of the macros.

Ah I get it...

But maybe we should refactor <linux/amba/bus.h> then?
Something like this:

From: Linus Walleij <linus.walleij@stericsson.com>
Date: Mon, 6 Sep 2010 10:29:26 +0200
Subject: [PATCH] ARM: move the PrimeCell IDs to use macros

This make four macros for the PrimeCell ID register available to
drivers that use them witout using the PrimeCell/AMBA bus
abstraction and struct amba_device. It also moves the magic
PrimeCell CID "B105F00D" to the bus.h header file.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/amba/bus.c       |    2 +-
 include/linux/amba/bus.h |   15 +++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d31590e..2737b97 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -298,7 +298,7 @@ int amba_device_register(struct amba_device *dev,
struct resource *parent)

                amba_put_disable_pclk(dev);

-               if (cid == 0xb105f00d)
+               if (cid == AMBA_CID)
                        dev->periphid = pid;

                if (!dev->periphid)
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index b0c1740..4c0f5a3 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -20,6 +20,7 @@
 #include <linux/resource.h>

 #define AMBA_NR_IRQS   2
+#define AMBA_CID       0xb105f00d

 struct clk;

@@ -70,9 +71,15 @@ void amba_release_regions(struct amba_device *);
 #define amba_pclk_disable(d)   \
        do { if (!IS_ERR((d)->pclk)) clk_disable((d)->pclk); } while (0)

-#define amba_config(d) (((d)->periphid >> 24) & 0xff)
-#define amba_rev(d)    (((d)->periphid >> 20) & 0x0f)
-#define amba_manf(d)   (((d)->periphid >> 12) & 0xff)
-#define amba_part(d)   ((d)->periphid & 0xfff)
+/* Some drivers don't use the struct amba_device */
+#define AMBA_CONFIG_BITS(a) ((a >> 24) & 0xff)
+#define AMBA_REV_BITS(a) ((a >> 20) & 0x0f)
+#define AMBA_MANF_BITS(a) ((a >> 12) & 0xff)
+#define AMBA_PART_BITS(a) (a & 0xfff)
+
+#define amba_config(d) AMBA_CONFIG_BITS((d)->periphid)
+#define amba_rev(d)    AMBA_REV_BITS((d)->periphid)
+#define amba_manf(d)   AMBA_MANF_BITS((d)->periphid)
+#define amba_part(d)   AMBA_PART_BITS((d)->periphid)

 #endif
-- 
1.7.2.2

Then you can use AMBA_CONFIG_BITS() etc.

If Russell likes it I'll put it in the patch tracker.

Come to think about it, we have this enum in the bus.h:

enum amba_vendor {
        AMBA_VENDOR_ARM = 0x41,
        AMBA_VENDOR_ST = 0x80,
};

What byte value is Samsung using for vendor?

Yours,
Linus Walleij
