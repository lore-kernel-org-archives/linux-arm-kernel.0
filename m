From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Sun, 6 Apr 2014 16:34:08 +0100 (BST)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
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
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
Message-ID: <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Sat, 5 Apr 2014, Neil Greatorex wrote:

> I will redo the patch with a local variable tomorrow and resend it.
>

As promised, here is the updated patch. As before, I would appreciate 
comments and/or Tested-bys...

Cheers,
Neil

>From e5698a4ae6b21c7e78538e16d293123903abbb40 Mon Sep 17 00:00:00 2001
From: Neil Greatorex <neil@fatboyfat.co.uk>
Date: Sun, 6 Apr 2014 16:10:43 +0100
Subject: [PATCH] irqchip: armada-370-xp: Fix releasing of MSIs

Store the value of d->hwirq in a local variable as the real value is wiped out
by calling irq_dispose_mapping. Without this patch, the armada_370_xp_free_msi
function would always free MSI#0, no matter what was passed to it.

Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
---
  drivers/irqchip/irq-armada-370-xp.c | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5409564..916fae2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -157,8 +157,10 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
  					   unsigned int irq)
  {
  	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
+
  	irq_dispose_mapping(irq);
-	armada_370_xp_free_msi(d->hwirq);
+	armada_370_xp_free_msi(hwirq);
  }

  static struct irq_chip armada_370_xp_msi_irq_chip = {
-- 
1.8.3.2
