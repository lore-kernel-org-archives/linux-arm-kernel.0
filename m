From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 May 2012 00:13:01 -0700
Subject: [PATCH] mmc: omap: Fix broken reg_shift initialization
In-Reply-To: <20120529130312.GE12766@atomide.com>
References: <20120528132147.GC12766@atomide.com>
 <CAPDyKFrcviT3_Fz13LpFJ+1oKxQ5LKswN7EmzVcWTJkiiDWusA@mail.gmail.com>
 <20120529074047.GE16340@arwen.pp.htv.fi>
 <20120529124732.GD12766@atomide.com>
 <20120529125024.GM9577@arwen.pp.htv.fi>
 <20120529130312.GE12766@atomide.com>
Message-ID: <20120530071300.GH12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit fa550189 (mmc: core: Prevent eMMC VCC supply to be cut from late init)
slightly affected timings for how things are done for the omap MMC driver
causing the MMC cards not getting detected any longer.

Turns out this was caused by buggy reg_shift initialization in the omap
MMC driver that was happening after mmc_add_host() was being called.

Fix this by initializing reg_shift before mmc_add_host() is called.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Heh found it! Chris, maybe Cc stable on this one?

--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1485,6 +1485,7 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 	}
 
 	host->nr_slots = pdata->nr_slots;
+	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
 
 	host->mmc_omap_wq = alloc_workqueue("mmc_omap", 0, 0);
 	if (!host->mmc_omap_wq)
@@ -1500,8 +1501,6 @@ static int __devinit mmc_omap_probe(struct platform_device *pdev)
 		}
 	}
 
-	host->reg_shift = (cpu_is_omap7xx() ? 1 : 2);
-
 	return 0;
 
 err_destroy_wq:
