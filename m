From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 19 Jan 2017 20:37:40 +0100
Subject: [PATCH v3 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
 <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
 <7e5fb21d-35bd-6ac3-9e6f-cffed656997f@siemens.com>
Message-ID: <e692c4a9-6320-b9e0-d6e7-f58bbe6ba867@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using the a device with edge-triggered interrupts, such as MSIs,
the interrupt handler has to ensure that there is a point in time during
its execution where all interrupts sources are silent so that a new
event can trigger a new interrupt again.

This is achieved here by disabling all interrupt sources for a moment
before processing them according to the status register. If a new
interrupt should have arrived after we read the status, it will now
re-trigger the interrupt, even in edge mode.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Successfully tested by now.

Changes to v2:
- avoid inner looping by making the hardware retrigger on "forgotten"
  IRQ sources

 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0d10090..f9c2329 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -785,6 +785,9 @@ static irqreturn_t ssp_int(int irq, void *dev_id)
 	if (!(status & mask))
 		return IRQ_NONE;
 
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg & ~drv_data->int_cr1);
+	pxa2xx_spi_write(drv_data, SSCR1, sccr1_reg);
+
 	if (!drv_data->master->cur_msg) {
 		handle_bad_msg(drv_data);
 		/* Never fail */
-- 
2.1.4

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/035bfd45/attachment.sig>
