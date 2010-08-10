From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 10 Aug 2010 16:31:40 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <20100810121912.GG27749@pengutronix.de> (Sascha Hauer's message
	of "Tue, 10 Aug 2010 14:19:12 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
Message-ID: <801va635f7.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-10, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Sorry, last time I sent only up to 09/12, so the patches I explicitely
> mentioned to solve the things from your previous series were missing.
> I just sent them. My versions of the patches differ slightly.

Your version allows a small window between request_irq() and
irq_control() where on the i.MX21 there is a possibility of the
interrupts being disabled twice. Namely, if an interrupt occurs before
irq_control() has had a chance to disable it. IMHO it would be better to
call:

    set_irq_flags(host->irq, IRQF_VALID | IRQF_NOAUTOEN);

for the i.MX21 before requesting the irq. This closes the window.

For non-i.MX21 this window also exists, but since in that situation the
irq hander simply unnecessarily sets a bit, it is not so dramatic. By
masking the interrupt before requesting the irq, the windows is also
closed for non-i.MX21.

> For this patch I decided to initialize every bit in NFC_V1_V2_CONFIG1
> from scratch so that we do not depend on any reset or bootloader
> values.  I think this is cleaner so I propose that we use my version
> of the patch.

I agree that initializing all the bits is better. But you need to set
the mask as well. Your latest patches clear the mask when initializing
V1_V2_CONFIG1 and V3_CONFIG2. For non-i.MX21 the mask should always be
set except when explicitly waiting for an interrupt in wait_op_done().

All the patches (01-12) were tested on an i.MX35 with 16-bit NAND and
work as expected. My only recommendations would be to close the window
at request_irq() and also include the following patch to set the mask
during preset().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-2.6-454a740.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
@@ -788,6 +788,8 @@ static void preset_v1_v2(struct mtd_info
 
 	if (nfc_is_v21())
 		config1 |= NFC_V2_CONFIG1_FP_INT;
+	else
+		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
 
 	if (nfc_is_v21() && mtd->writesize) {
 		uint16_t pages_per_block = mtd->erasesize / mtd->writesize;
@@ -846,6 +848,7 @@ static void preset_v3(struct mtd_info *m
 		NFC_V3_CONFIG2_2CMD_PHASES |
 		NFC_V3_CONFIG2_SPAS(mtd->oobsize >> 1) |
 		NFC_V3_CONFIG2_ST_CMD(0x70) |
+		NFC_V3_CONFIG2_INT_MSK |
 		NFC_V3_CONFIG2_NUM_ADDR_PHASE0;
 
 	if (chip->ecc.mode == NAND_ECC_HW)
