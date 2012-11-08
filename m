From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 14:08:41 +0000
Subject: [PATCH V6 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <508666A6.9040701@free-electrons.com>
References: <CAHkRjk7YdzB_RMCjY7SkzPVwEvuk17akJxaNeNmAuqZpwX_kfQ@mail.gmail.com>
 <20121023090154.GP21164@n2100.arm.linux.org.uk>
 <508666A6.9040701@free-electrons.com>
Message-ID: <201211081408.41983.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced l2_wt_override should be in the same #ifdef
as the code using it, otherwise we get:

arch/arm/mm/cache-l2x0.c:37:12: warning: 'l2_wt_override' defined but not used

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Tuesday 23 October 2012, Gregory CLEMENT wrote:
> @@ -33,6 +34,11 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
>  static u32 l2x0_way_mask;      /* Bitmask of active ways */
>  static u32 l2x0_size;
>  static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
> +static int l2_wt_override;
> +
> +/* Aurora don't have the cache ID register available, so we have to
> + * pass it though the device tree */
> +static u32  cache_id_part_number_from_dt;


diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 92ee4a0..6911b8b 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -34,7 +34,6 @@ static DEFINE_RAW_SPINLOCK(l2x0_lock);
 static u32 l2x0_way_mask;	/* Bitmask of active ways */
 static u32 l2x0_size;
 static unsigned long sync_reg_offset = L2X0_CACHE_SYNC;
-static int l2_wt_override;
 
 /* Aurora don't have the cache ID register available, so we have to
  * pass it though the device tree */
@@ -424,6 +423,8 @@ void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask)
 }
 
 #ifdef CONFIG_OF
+static int l2_wt_override;
+
 /*
  * Note that the end addresses passed to Linux primitives are
  * noninclusive, while the hardware cache range operations use
