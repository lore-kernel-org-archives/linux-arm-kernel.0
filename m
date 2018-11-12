From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 12 Nov 2018 04:20:19 +0100
Subject: [PATCH v3 10/18] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
In-Reply-To: <20181112032027.653931-1-lkundrak@v3.sk>
References: <20181112032027.653931-1-lkundrak@v3.sk>
Message-ID: <20181112032027.653931-11-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
and 72 interrupts. Don't reset the "route to SP" bit (4).

I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
was not helpful.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v1:
- Adjusted wording & ack from Pavel

 drivers/irqchip/irq-mmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 25f32e1d7764..1ed38f9f1d0a 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -190,7 +190,7 @@ static const struct mmp_intc_conf mmp_conf = {
 static const struct mmp_intc_conf mmp2_conf = {
 	.conf_enable	= 0x20,
 	.conf_disable	= 0x0,
-	.conf_mask	= 0x7f,
+	.conf_mask	= 0x60,
 };
 
 static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
-- 
2.19.1
