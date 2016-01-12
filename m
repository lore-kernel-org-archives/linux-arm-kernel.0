From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 12 Jan 2016 19:11:12 +0900
Subject: [PATCH v3] arm: irq: l2c: do not print error in case of missing l2c
 from dtb
In-Reply-To: <5694BABF.3070200@samsung.com>
References: <5694BABF.3070200@samsung.com>
Message-ID: <1452593472-10703-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some architectures the L2 cache controller is integrated in the
processor's block itself and it doesn't use any external cache
controller. This means that an entry in the board's dtb related
to the l2c is not necessary.

Distinguish between error codes and do not print anything in case
l2x0_of_init() doesn't find any L2C DTB entry and returns -ENODEV.

This patch mutes the following error message:

   L2C: failed to init: -19

on boards like odroid-xu4, cortex A7/A15, which don't have
external cache controller.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
Hi,

here is a second version. An alternative would be to print with
pr_dbg, but then it's a matter of taste.

V1, and V2 print a message in case the l2c dtb entry is not found
(the V2 has a better print rephrase suggested by Joe)

V3 ignores the case of -enodev for l2c and doesn't print anything

Thanks,
Andi

 arch/arm/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 1d45320..ece04a4 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -95,7 +95,7 @@ void __init init_IRQ(void)
 			outer_cache.write_sec = machine_desc->l2c_write_sec;
 		ret = l2x0_of_init(machine_desc->l2c_aux_val,
 				   machine_desc->l2c_aux_mask);
-		if (ret)
+		if (ret && ret != -ENODEV)
 			pr_err("L2C: failed to init: %d\n", ret);
 	}
 
-- 
2.6.4
