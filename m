From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Fri, 4 Apr 2014 14:19:44 +0100 (BST)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
References: <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
Message-ID: <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

After managing to get the card detected on my mirabox, I have been looking 
into getting the thing actually working. With the information from Willy 
and my own investigations I knew there was some issue in the setting up of 
the MSIs for the card. Through adding a copious amount of printk()s I was 
able to determine that the initialisation for the igb driver allocates, 
frees and re-allocates 3 MSIs for the card. I noticed that in doing this 
there was a problem whereby any call to free an MSI was trying to free 
MSI#0. I was able to track this down to the fact that the mapping for the 
IRQ was being disposed before the MSI was actually freed. The below patch 
fixes this problem.

With this patch, I can get one port on the card working. With both ports 
enabled, I still get an OOPS, so some further work is needed.

I would appreciate it if you could test this patch and let me know if you 
find any problems.

Cheers,
Neil

>From 50aa11018059704229dd43ca1016defdda04f90c Mon Sep 17 00:00:00 2001
From: Neil Greatorex <neil@fatboyfat.co.uk>
Date: Fri, 4 Apr 2014 13:47:09 +0100
Subject: [PATCH] irqchip: armada-370-xp: Fix releasing of MSIs

This patch moves the call to irq_dispose_mapping() to after the call to
armada_370_xp_free_msi(). Without this patch, the armada_370_xp_free_msi
function would always free MSI#0, no matter what was passed to it.

Signed-off-by: <neil@fatboyfat.co.uk>
---
  drivers/irqchip/irq-armada-370-xp.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5409564..f5e129e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -157,8 +157,8 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
  					   unsigned int irq)
  {
  	struct irq_data *d = irq_get_irq_data(irq);
-	irq_dispose_mapping(irq);
  	armada_370_xp_free_msi(d->hwirq);
+	irq_dispose_mapping(irq);
  }

  static struct irq_chip armada_370_xp_msi_irq_chip = {
-- 
1.8.3.2
