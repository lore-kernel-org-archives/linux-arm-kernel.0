From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:53:34 +0100
Subject: [PATCH 12/14] ARM: shmobile: rcar-gen2: Fix error check in regulator
 quirk
In-Reply-To: <cover.1521211738.git.horms+renesas@verge.net.au>
References: <cover.1521211738.git.horms+renesas@verge.net.au>
Message-ID: <60fc75bdf5b1b8ed3e0a372b7b35f27726ff542b.1521211738.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

On systems with two regulators, a bogus error message is printed on
success:

    i2c 6-0058: i2c error 2

While adding support for Stout, the number of messages to send was
made variable, but the corresponding return value check of
i2c_transfer() wasn't updated.

Fixes: ff938cd14d67a704 ("ARM: shmobile: stout: enable R-Car Gen2 regulator quirk")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 27fb3a5ec73e..93f628acfd94 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -98,7 +98,7 @@ static int regulator_quirk_notify(struct notifier_block *nb,
 
 		dev_info(&client->dev, "clearing da9063/da9210 interrupts\n");
 		ret = i2c_transfer(client->adapter, da9xxx_msgs, len);
-		if (ret != ARRAY_SIZE(da9xxx_msgs))
+		if (ret != len)
 			dev_err(&client->dev, "i2c error %d\n", ret);
 	}
 
-- 
2.11.0
