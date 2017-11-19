From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun, 19 Nov 2017 09:45:04 +0530
Subject: [PATCH 5/5 v3] ASoC: intel: mfld: Handle return value of
 platform_get_irq
In-Reply-To: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
Message-ID: <64135c4647a3a94261a669d7f49611a356f334bf.1511062844.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              Return EIO insted of ctx->irq_num.

 sound/soc/intel/boards/mfld_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acf..c819210 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -372,6 +372,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 	/* retrive the irq number */
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -ENODEV;
 
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
-- 
2.7.4
