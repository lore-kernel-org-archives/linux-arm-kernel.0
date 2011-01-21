From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 21 Jan 2011 13:53:06 +0100
Subject: [PATCH] mmci: fixup broken_blockend variant patch v2
In-Reply-To: <AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
References: <1295275071-13146-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin67iTj34QBv3T-9+oMdo6q=EsYKf=5ca=6B69s@mail.gmail.com>
	<4D346800.3070603@stericsson.com>
	<20110118121455.GB9719@n2100.arm.linux.org.uk>
	<AANLkTineFJhqMcJbg1YQbPymT537Ef=jVgXLC5uw7DOt@mail.gmail.com>
	<20110119205158.GC6335@n2100.arm.linux.org.uk>
	<AANLkTimGmGStr8wHbJhkOsPcrWQmLFFQQCpgizE8+joj@mail.gmail.com>
Message-ID: <AANLkTim4i8BibVFmn2C4ixRoMrX5mNU9HZjW2KGMXsYZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/20 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2011/1/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>> On Wed, Jan 19, 2011 at 09:34:49PM +0100, Linus Walleij wrote:
>>> 2011/1/18 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>>
>>> > How reliable is the FIFOCNT register ?
>>>
>>> Hmm... the FIFOCNT is just the FIFO.
>>
>> No, FIFOCNT.
>>
>> ?The MCIFifoCnt register contains the remaining number of words to be
>> ?written to or read from the FIFO.
>
> Yeah I B damned that's right. Sorry for the confusion. I'll respin
> the latest patch on the FIFOCNT register instead and test
> tomorrow.
>
> But if the transfer is complete, MCIDataCnt should be valid
> as well. I'll read the datasheet(s) closer and see if I get some
> useful clues about which one is more reliable in the error
> case.

I've looked into this. It appears AFAICT that the FIFOCNT is
reset to zero whenever Tx or Rx is not active, i.e. on an error. So
this register is not helpful for determining the number of blocks
left at an error, it will always be zero at that point.

MCIDATACNT on the other hand comes from the datapath
state machine which in turn controls the FIFO. It is a totally
separate counter inside the state machine, loaded from the
same length register, but updated from the datapath control
machinery.

The latter counter is valid whenever the datapath state machine
is in IDLE state, and it goes to IDLE when an error occurs.
The register value will not be reset until a new transfer sequence
or reset occurs.

To verify I added this patch to print out the registers:

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 60d0c7e..12b213b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -518,7 +518,10 @@ mmci_data_irq(struct mmci_host *host, struct
mmc_data *data,
                remain = readl(host->base + MMCIDATACNT) << 2;
                success = data->blksz * data->blocks - remain;

-               dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status
%08x)\n", status);
+               dev_err(mmc_dev(host->mmc), "MCI ERROR IRQ (status
%08x) lost 0x%08x bytes\n", status, remain);
+               dev_err(mmc_dev(host->mmc), "MMCIDATACNT = 0x%08x\n",
readl(host->base + MMCIDATACNT));
+               dev_err(mmc_dev(host->mmc), "MMCIFIFOCNT = 0x%08x\n",
readl(host->base + MMCIFIFOCNT));
+
                if (status & MCI_DATACRCFAIL) {
                        /* Last block was not successful */
                        host->data_xfered = ((success / data->blksz) -
1 * data->blksz);


Then I started to copy a file and ejected the card in the
middle of the transfer:

root at ME:/mnt cp bar.bin /
mmci-pl18x fpga:mmc0: MCI ERROR IRQ (status 00000002) lost 0x00003000 bytes
mmci-pl18x fpga:mmc0: MMCIDATACNT = 0x00000c00
mmci-pl18x fpga:mmc0: MMCIFIFOCNT = 0x00000000

So the more I look at it, I get the impression that MCIDATACNT
is the register to use.

This means that I think the patch I've sent should be the way
forward.

Yours,
Linus Walleij
