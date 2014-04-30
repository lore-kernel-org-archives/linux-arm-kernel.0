From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Apr 2014 11:22:44 +0100
Subject: [RFC 07/47] mtd: nand: stm_nand_bch: initialise the BCH Controller
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAB5CB7@DBDE04.ent.ti.com>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-8-git-send-email-lee.jones@linaro.org>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5CB7@DBDE04.ent.ti.com>
Message-ID: <20140430102244.GK29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Mar 2014, Gupta, Pekon wrote:

> Hi Lee,
> 
> >From: Lee Jones [mailto:lee.jones at linaro.org]
> missing commit log :-)
> Though $subject is self-explanatory, but you can add more description about
> assumption and hardware caveats about the controller, and its use.
> 
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> > drivers/mtd/nand/stm_nand_bch.c | 56 +++++++++++++++++++++++++++++++++++++++++
> > include/linux/mtd/stm_nand.h    | 20 +++++++++++++++
> > 2 files changed, 76 insertions(+)
> >
> >diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
> >index 76a0d02..1a93f8d 100644
> >--- a/drivers/mtd/nand/stm_nand_bch.c
> >+++ b/drivers/mtd/nand/stm_nand_bch.c
> >@@ -14,6 +14,7 @@
> >
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> >+#include <linux/delay.h>
> > #include <linux/io.h>
> > #include <linux/interrupt.h>
> > #include <linux/device.h>
> >@@ -102,6 +103,56 @@ static void nandi_disable_interrupts(struct nandi_controller *nandi,
> > 	writel(val, nandi->base + NANDBCH_INT_EN);
> > }
> >
> >+static void nandi_init_bch(struct nandi_controller *nandi, int emi_bank)
> >+{
> >+	dev_dbg(nandi->dev, "%s\n", __func__);
> >+
> >+	/* Initialise BCH Controller */
> >+	emiss_nandi_select(STM_NANDI_BCH);
> >+
> >+	/* Reset and disable boot-mode controller */
> >+	writel(BOOT_CFG_RESET, nandi->base + NANDBCH_BOOTBANK_CFG);
> >+	udelay(1);
> >+	writel(0x00000000, nandi->base + NANDBCH_BOOTBANK_CFG);
> 
> Why using 'udelay' ?
> Isn't there any status register which tells you that controller is reset / initialized ?
> Or may be polling on NANDBCH_BOOTBANK_CFG may itself give you status.

Documenation says:

  "The soft reset bit has to be reset to ?0? to de-assert the soft
   reset. The soft reset bit is expected to be asserted for at least
   one clock cycle for proper reset"

> >+
> >+	/* Reset AFM controller */
> >+	writel(CFG_RESET, nandi->base + NANDBCH_CONTROLLER_CFG);
> >+	udelay(1);
> >+	writel(0x00000000, nandi->base + NANDBCH_CONTROLLER_CFG);
> >+
> >+	/* Set EMI Bank */
> >+	writel(0x1 << emi_bank, nandi->base + NANDBCH_FLEX_MUXCTRL);
> >+
> >+	/* Reset ECC stats */
> >+	writel(0x7f0, nandi->base + NANDBCH_CONTROLLER_CFG);
> >+	udelay(1);
> >+
> "0x7f0" ?? please use Macro instead.

Sure.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
