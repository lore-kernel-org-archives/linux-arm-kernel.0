From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 29 Nov 2017 21:47:14 +0530
Subject: [PATCH 5/5 v4] ASoC: intel: mfld: Handle return value of
 platform_get_irq
In-Reply-To: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
References: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <3c83856bd9f1f23d1e0f5e8753d3998ae4785e37.1511970158.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              Return -ENODEV insted of irq.
changes in v4 :
              Add separate error for irq == 0 and irq < 0.

 sound/soc/intel/boards/mfld_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/boards/mfld_machine.c b/sound/soc/intel/boards/mfld_machine.c
index 6f44acf..7cb44fd 100644
--- a/sound/soc/intel/boards/mfld_machine.c
+++ b/sound/soc/intel/boards/mfld_machine.c
@@ -372,6 +372,8 @@ static int snd_mfld_mc_probe(struct platform_device *pdev)
 
 	/* retrive the irq number */
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq < 0 ? irq : -ENODEV;
 
 	/* audio interrupt base of SRAM location where
 	 * interrupts are stored by System FW */
-- 
2.7.4
