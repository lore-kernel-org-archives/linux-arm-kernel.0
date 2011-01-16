From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sun, 16 Jan 2011 22:11:57 +0100
Subject: mmci: U300 "sync with blockend" broken for multi-block?
In-Reply-To: <20110114224439.GR15996@n2100.arm.linux.org.uk>
References: <AANLkTimYb6TxLj4SamxRwUgykf9JyW5y9gbejOUXqZ7K@mail.gmail.com>
	<20110101121048.GB25924@n2100.arm.linux.org.uk>
	<AANLkTi=4SrxX-oCx-XXd+oib64j8RhMLdsQD1oWGxgU1@mail.gmail.com>
	<20110105164344.GD8638@n2100.arm.linux.org.uk>
	<AANLkTim4J8xrj9axhsu4=_7YkEy_ndiJ6cjDNf2WfzEg@mail.gmail.com>
	<20110114224439.GR15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikVcqQup8pB6fnUEK=bWtNBqT2nV6P6Tjmy+b-X@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/14 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jan 14, 2011 at 09:13:05PM +0100, Linus Walleij wrote:
>> 2011/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>
>> > Any chance of pr_debug'ing the complete status register each time you
>> > service an interrupt? ?You'll probably need to set the kernel log
>> > buffer fairly large to ensure that you capture everything.
>>
>> I did this test now.
>
> Just to complete the picture, can I see the patch between the version
> which produced this and mainline?

Sure, but I patched on top of the pending DMA-patches, since I
needed to test the workings in DMA mode. Here is that patch, if
you want the entire DMA patch series too I can resend them:

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index af0cae9..8ae32d9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -81,7 +81,7 @@ static struct variant_data variant_u300 = {
        .fifohalfsize           = 8 * 4,
        .clkreg_enable          = 1 << 13, /* HWFCEN */
        .datalength_bits        = 16,
-       .broken_blockend        = true,
+       .broken_blockend        = false,
        .sdio                   = true,
 };

@@ -414,7 +414,8 @@ static void mmci_start_data(struct mmci_host
*host, struct mmc_data *data)
        void __iomem *base;
        int blksz_bits;

-       dev_dbg(mmc_dev(host->mmc), "blksz %04x blks %04x flags %08x\n",
+       dev_info(mmc_dev(host->mmc), "\n");
+       dev_info(mmc_dev(host->mmc), "START DATA: blksz %04x blks %04x
flags %08x\n",
                data->blksz, data->blocks, data->flags);

        host->data = data;
@@ -480,10 +481,10 @@ static void mmci_start_data(struct mmci_host
*host, struct mmc_data *data)

        writel(datactrl, base + MMCIDATACTRL);
        irqmask0 = readl(base + MMCIMASK0);
-       if (variant->broken_blockend)
-               irqmask0 &= ~MCI_DATABLOCKENDMASK;
-       else
-               irqmask0 |= MCI_DATABLOCKENDMASK;
+       // if (variant->broken_blockend)
+       //      irqmask0 &= ~MCI_DATABLOCKENDMASK;
+       // else
+               irqmask0 |= MCI_DATABLOCKENDMASK;
        irqmask0 &= ~MCI_DATAENDMASK;
        writel(irqmask0, base + MMCIMASK0);
        mmci_set_mask1(host, irqmask1);
@@ -523,6 +524,16 @@ mmci_data_irq(struct mmci_host *host, struct
mmc_data *data,
 {
        struct variant_data *variant = host->variant;

+       if ((status & MCI_DATABLOCKEND) &&
+           (status & MCI_DATAEND)) {
+               dev_info(mmc_dev(host->mmc), "MCI_DATABLOCKEND &&
MCI_DATAEND\n");
+               dev_info(mmc_dev(host->mmc), "xfered according to no
of blockends = 0x%08x, expected: 0x%08x\n", host->data_xfered +
data->blksz, data->blksz * data->blocks);
+       } else if (status & MCI_DATABLOCKEND) {
+               dev_info(mmc_dev(host->mmc), "MCI_DATABLOCKEND\n");
+       } else if (status & MCI_DATAEND) {
+               dev_info(mmc_dev(host->mmc), "MCI_DATAEND\n");
+       }
+
        /* First check for errors */
        if (status &
(MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
                dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status
%08x)\n", status);
@@ -589,8 +600,10 @@ mmci_data_irq(struct mmci_host *host, struct
mmc_data *data,
                 */
                if (!variant->broken_blockend && !host->dma_on_current_xfer)
                        host->data_xfered += data->blksz;
-               if (host->data_xfered == data->blksz * data->blocks)
+               if (host->data_xfered == data->blksz * data->blocks) {
                        host->last_blockend = true;
+                       dev_info(mmc_dev(host->mmc), "THIS IS THE LAST
MCI_DATABLOCKEND\n");
+               }
        }

        if (status & MCI_DATAEND)


Yours,
Linus Walleij
