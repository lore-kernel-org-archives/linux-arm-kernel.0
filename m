From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 12 Jan 2016 16:24:34 +0900
Subject: [PATCH v2] arm: irq: l2c: do not print error in case of missing l2c
 from dtb
In-Reply-To: <1452582683.7773.102.camel@perches.com>
References: <1452582683.7773.102.camel@perches.com>
Message-ID: <1452583474-11729-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some architectures the L2 cache controller is integrated in the
processor's block itself and it doesn't use any external cache
controller. This means that an entry in the board's dtb related
to the l2c is not necessary.

Distinguish between error codes and print just an information in
case of -ENODEV.

This patch converts the following error message:

   L2C: failed to init: -19

to the following info:

   L2C: no controller entry found in the dtb

on boards like odroid-xu4, cortex A7/A15, which don't have
external cache controller.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---

Thanks Joe,

makes sense!

Andi

 arch/arm/kernel/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 1d45320..714b5d6 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -95,7 +95,9 @@ void __init init_IRQ(void)
 			outer_cache.write_sec = machine_desc->l2c_write_sec;
 		ret = l2x0_of_init(machine_desc->l2c_aux_val,
 				   machine_desc->l2c_aux_mask);
-		if (ret)
+		if (ret == -ENODEV)
+			pr_info("L2C: no controller entry found in the dtb\n");
+		else if (ret)
 			pr_err("L2C: failed to init: %d\n", ret);
 	}
 
-- 
2.6.4
