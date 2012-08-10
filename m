From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 10 Aug 2012 14:15:28 -0300
Subject: [PATCH] mtd: gpmi: add NAND write verify support
In-Reply-To: <201208101704.44984.marex@denx.de>
References: <1344568737-902-1-git-send-email-b32955@freescale.com>
 <201208101325.23075.marex@denx.de>
 <CAMiH66FAVVPLZ9hCyRcNCm1Le2JrCc+55CUw7UCtPjw+31w5gw@mail.gmail.com>
 <201208101704.44984.marex@denx.de>
Message-ID: <CAOMZO5C2qUNPCCbc4jW5+4HZuuhPQ=Lid6UsfgBXNpr44q2p2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Fri, Aug 10, 2012 at 12:04 PM, Marek Vasut <marex@denx.de> wrote:

>> Even there are two nand chips, there is only one gpmi controller.
>
> For now ... yes.

Does this look better?

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand
index 8c0d2f0..5262ef3 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1533,6 +1533,21 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
        gpmi_free_dma_buffer(this);
 }

+static int gpmi_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+       struct nand_chip *nand = mtd->priv;
+       struct gpmi_nand_data *data = container_of(mtd, struct gpmi_nand_data,
+                                                                  mtd);
+       int ret;
+
+       ret = gpmi_ecc_read_page(mtd, nand, data->verify_buf, 0, 0);
+       if (ret)
+               return -EFAULT;
+       if (memcmp(buf, data->verify_buf, len))
+               return -EFAULT;
+       return 0;
+}
+
 static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
 {
        struct mtd_info  *mtd = &this->mtd;
@@ -1555,6 +1570,7 @@ static int __devinit gpmi_nfc_init(struct gpmi_nand_data *
        chip->dev_ready         = gpmi_dev_ready;
        chip->read_byte         = gpmi_read_byte;
        chip->read_buf          = gpmi_read_buf;
+       chip->verify_buf        = gpmi_verify_buf;
        chip->write_buf         = gpmi_write_buf;
        chip->ecc.read_page     = gpmi_ecc_read_page;
        chip->ecc.write_page    = gpmi_ecc_write_page;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand
index 1547a60..cd9bdf7 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -148,6 +148,7 @@ struct gpmi_nand_data {
        /* General-use Variables */
        int                     current_chip;
        unsigned int            command_length;
+       uint8_t                 verify_buf[NAND_MAX_PAGESIZE];

        /* passed from upper layer */
        uint8_t                 *upper_buf;

and then I can also send this separate change to allow multi-instances:

@@ -1630,7 +1646,7 @@ static int __devinit gpmi_nand_probe(struct platform_devic
                return -ENOMEM;
        }

-       this = kzalloc(sizeof(*this), GFP_KERNEL);
+       this = devm_kzalloc(&pdev->dev, sizeof(*this), GFP_KERNEL);
        if (!this) {
                pr_err("Failed to allocate per-device memory\n");
                return -ENOMEM;
