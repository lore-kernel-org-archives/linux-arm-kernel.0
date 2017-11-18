From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:26:49 +0530
Subject: [PATCH 5/5 v2] ASoC: intel: mfld: Handle return value of
 platform_get_irq
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
Message-ID: <f77d3cc6ccd2de3f94c0b09c110d970d5c8e0372.1510997815.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 sound/soc/intel/boards/mfld_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acf..77b3162 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -372,6 +372,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 	/* retrive the irq number */
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
 
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
-- 
2.7.4
