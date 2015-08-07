From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sat, 8 Aug 2015 07:37:55 +0800
Subject: [RFC PATCH v4 1/9] mmc: dw_mmc: Add external dma interface support
In-Reply-To: <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <1438843491-23853-1-git-send-email-shawn.lin@rock-chips.com>
 <CAGhQ9VxUYvgGD=K3J3cQ0CNpCC-RfGE9cxhBHnTeAU2CmWkiKA@mail.gmail.com>
Message-ID: <55C54153.2070709@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2015/8/8 5:32, Joachim Eastwood ??:
> Hi Shawn,
>
> On 6 August 2015 at 08:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>> DesignWare MMC Controller can supports two types of DMA
>> mode: external dma and internal dma. We get a RK312x platform
>> integrated dw_mmc and ARM pl330 dma controller. This patch add
>> edmac ops to support these platforms. I've tested it on RK312x
>> platform with edmac mode and RK3288 platform with idmac mode.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
>> @@ -2256,26 +2373,30 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>>
>>          }
>>
>> -#ifdef CONFIG_MMC_DW_IDMAC
>> -       /* Handle DMA interrupts */
>> -       if (host->dma_64bit_address == 1) {
>> -               pending = mci_readl(host, IDSTS64);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_TI |
>> -                                                       SDMMC_IDMAC_INT_RI);
>> -                       mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
>> -                       host->dma_ops->complete(host);
>> -               }
>> -       } else {
>> -               pending = mci_readl(host, IDSTS);
>> -               if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI)) {
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_TI |
>> -                                                       SDMMC_IDMAC_INT_RI);
>> -                       mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>> -                       host->dma_ops->complete(host);
>> +       if (host->use_dma == TRANS_MODE_IDMAC) {
>
> Doing:
> if (host->use_dma != TRANS_MODE_IDMAC)
>      return IRQ_HANDLED;
>

Okay.

> Could save you the extra level of identation you add below.
>
>> +               /* Handle DMA interrupts */
>> +               if (host->dma_64bit_address == 1) {
>> +                       pending = mci_readl(host, IDSTS64);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS64,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS64, SDMMC_IDMAC_INT_NI);
>> +                               host->dma_ops->complete((void *)host);
>> +                       }
>> +               } else {
>> +                       pending = mci_readl(host, IDSTS);
>> +                       if (pending & (SDMMC_IDMAC_INT_TI |
>> +                                      SDMMC_IDMAC_INT_RI)) {
>> +                               mci_writel(host, IDSTS,
>> +                                          SDMMC_IDMAC_INT_TI |
>> +                                          SDMMC_IDMAC_INT_RI);
>> +                               mci_writel(host, IDSTS, SDMMC_IDMAC_INT_NI);
>> +                               host->dma_ops->complete((void *)host);
>> +                       }
>>                  }
>>          }
>> -#endif
>>
>>          return IRQ_HANDLED;
>>   }
>
>
>> @@ -2437,6 +2567,21 @@ static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
>>   static void dw_mci_init_dma(struct dw_mci *host)
>>   {
>>          int addr_config;
>> +       int trans_mode;
>> +       struct device *dev = host->dev;
>> +       struct device_node *np = dev->of_node;
>> +
>> +       /* Check tansfer mode */
>> +       trans_mode = (mci_readl(host, HCON) >> 16) & 0x3;
>
> I think it would be nice if you could add some defines for 16 and 0x03
> or add a macro like SDMMC_GET_FCNT() that is in dw_mmc.h.
>

yes, it's better to avoid magic number for register operation to make
others understand w/o checking databook for details. And might more than 
one (e.g "Check ADDR_CONFIG bit in HCON to find IDMAC address bus 
width") should be modified.

Although one patch only do one thing, I will drop by to make it in v5.

>> +       if (trans_mode == 0) {
>> +               trans_mode = TRANS_MODE_IDMAC;
>> +       } else if (trans_mode == 1 || trans_mode == 2) {
>> +               trans_mode = TRANS_MODE_EDMAC;
>> +       } else {
>> +               trans_mode = TRANS_MODE_PIO;
>> +               goto no_dma;
>> +       }
>> +
>>          /* Check ADDR_CONFIG bit in HCON to find IDMAC address bus width */
>>          addr_config = (mci_readl(host, HCON) >> 27) & 0x01;
>
> I'll try to get this patch tested on my lpc18xx platform soon.
> btw, the HCON reg on lpc18xx reads as 0x00e42cc1 (address 0x40004070).
>

yes, HCON[17:16] is 2b'00 means your lpc18xx use IDMAC.

>
> regard,
> Joachim Eastwood
>
>
>


-- 
Shawn Lin
