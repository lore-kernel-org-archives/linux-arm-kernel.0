From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 10 Aug 2010 16:43:42 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <801va635f7.fsf@merkur.tec.linutronix.de> (John Ogness's message
	of "Tue, 10 Aug 2010 16:31:40 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
Message-ID: <80tyn21qap.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-10, John Ogness <john.ogness@linutronix.de> wrote:
>> For this patch I decided to initialize every bit in NFC_V1_V2_CONFIG1
>> from scratch so that we do not depend on any reset or bootloader
>> values.  I think this is cleaner so I propose that we use my version
>> of the patch.
>
> I agree that initializing all the bits is better. But you need to set
> the mask as well. Your latest patches clear the mask when initializing
> V1_V2_CONFIG1 and V3_CONFIG2. For non-i.MX21 the mask should always be
> set except when explicitly waiting for an interrupt in wait_op_done().

Sorry, that last patch was crap. It wasn't setting the mask for v1/v2. I
should have noticed it sooner because without the mask an extra
interrupt is visible during boot. Here is the correct patch to fix the
masking issue.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
===================================================================
--- linux-2.6-454a740.orig/drivers/mtd/nand/mxc_nand.c
+++ linux-2.6-454a740/drivers/mtd/nand/mxc_nand.c
@@ -789,6 +789,9 @@ static void preset_v1_v2(struct mtd_info
 	if (nfc_is_v21())
 		config1 |= NFC_V2_CONFIG1_FP_INT;
 
+	if (!cpu_is_mx21())
+		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
+
 	if (nfc_is_v21() && mtd->writesize) {
 		uint16_t pages_per_block = mtd->erasesize / mtd->writesize;
 
@@ -846,6 +849,7 @@ static void preset_v3(struct mtd_info *m
 		NFC_V3_CONFIG2_2CMD_PHASES |
 		NFC_V3_CONFIG2_SPAS(mtd->oobsize >> 1) |
 		NFC_V3_CONFIG2_ST_CMD(0x70) |
+		NFC_V3_CONFIG2_INT_MSK |
 		NFC_V3_CONFIG2_NUM_ADDR_PHASE0;
 
 	if (chip->ecc.mode == NAND_ECC_HW)
