From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 23 Jun 2011 13:44:16 +0300
Subject: [PATCH] MTD: pxa3xx_nand: enable multiple chip select support
In-Reply-To: <BANLkTi=YFeVYfsp+68OA_vCF6LnJpqF-ag@mail.gmail.com>
References: <1308712645-5986-1-git-send-email-leiwen@marvell.com>	<4E01F1E7.5010707@compulab.co.il>
	<BANLkTi=YFeVYfsp+68OA_vCF6LnJpqF-ag@mail.gmail.com>
Message-ID: <4E031900.50108@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lei,

On 06/23/11 09:35, Lei Wen wrote:
> Hi Igor,
>
> On Wed, Jun 22, 2011 at 9:45 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>> On 06/22/11 06:17, Lei Wen wrote:
>>> Current pxa3xx_nand controller has two chip select which
>>> both be workable. This patch enable this feature.
>>>
>>> Update platform driver to support this feature.
>>>
>>> Another notice should be taken that:
>>> When you want to use this feature, you should not enable the
>>> keep configuration feature, for two chip select could be
>>> attached with different nand chip. The different page size
>>> and timing requirement make the keep configuration impossible.
>> You should _also_ put this comment inside the pxa3xx_nand.h
>> may be even inside the pxa3xx_nand_platform_data structure,
>> so people would not have to search the git log to find this problem.
> How about just throw out a BUG() to force people cannot set keep_config
> when supported cs num more than 1? Also appended with the comments above?

I don't think BUG() is a good idea, instead what you can do
is force the user of the _new_ feature to _not_ use the keep_config
by overriding the keep_config to 0 and printing a warning
that keep_config is prohibited with multiple chip selects feature and
that it will be disabled.
Of course you will still need to put a comment inside the pxa3xx_nand.h.

>>> Signed-off-by: Lei Wen <leiwen@marvell.com>
>>> ---
>>>  arch/arm/mach-mmp/aspenite.c                 |    5 +-
>>>  arch/arm/mach-pxa/cm-x300.c                  |    5 +-
>>>  arch/arm/mach-pxa/colibri-pxa3xx.c           |    5 +-
>>>  arch/arm/mach-pxa/littleton.c                |    5 +-
>>>  arch/arm/mach-pxa/mxm8x10.c                  |    9 +-
>>>  arch/arm/mach-pxa/raumfeld.c                 |    5 +-
>>>  arch/arm/mach-pxa/zylonite.c                 |    5 +-
>>>  arch/arm/plat-pxa/include/plat/pxa3xx_nand.h |    8 +-
>>>  drivers/mtd/nand/pxa3xx_nand.c               |  735 +++++++++++++++-----------
>>>  9 files changed, 444 insertions(+), 338 deletions(-)

[...]

>>> diff --git a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>>> index 442301f..34a3f52 100644
>>> --- a/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>>> +++ b/arch/arm/plat-pxa/include/plat/pxa3xx_nand.h
>>> @@ -41,6 +41,8 @@ struct pxa3xx_nand_flash {
>>>       struct pxa3xx_nand_timing *timing;      /* NAND Flash timing */
>>>  };
>>>
>>> +/* The max num of chip select current support */
>> /* The maximum number of chip selects currently supported */
>>
>>> +#define NUM_CHIP_SELECT              (2)
>>>  struct pxa3xx_nand_platform_data {
>>>
>>>       /* the data flash bus is shared between the Static Memory
>>> @@ -52,8 +54,10 @@ struct pxa3xx_nand_platform_data {
>>>       /* allow platform code to keep OBM/bootloader defined NFC config */
>>>       int     keep_config;
>>>
>>> -     const struct mtd_partition              *parts;
>>> -     unsigned int                            nr_parts;
>>> +     /* indicate how many chip select would be used for this platform */
>> /* indicate how many chip selects will be used */
>>
>>> +     int     cs_num;
>> This name is too confusing, I think even num_cs is better or cs_count?
>> Also, may be align it with the others?
>  I prefer the num_cs.

Good.

>>> +     const struct mtd_partition              *parts[NUM_CHIP_SELECT];
>>> +     unsigned int                            nr_parts[NUM_CHIP_SELECT];
>>>
>>>       const struct pxa3xx_nand_flash *        flash;
>>>       size_t                                  num_flash;
>>> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
>>> index 30689cc..259b8d5 100644
>>> --- a/drivers/mtd/nand/pxa3xx_nand.c
>>> +++ b/drivers/mtd/nand/pxa3xx_nand.c

[...]

>>> @@ -123,63 +126,63 @@ enum {
>>>  struct pxa3xx_nand_info {
>>>       struct nand_chip        nand_chip;
>>>
>>> -     struct nand_hw_control  controller;
>>> -     struct platform_device   *pdev;
>>>       struct pxa3xx_nand_cmdset *cmdset;
>>> +     /* page size of attached chip */
>>> +     uint16_t                page_size;
>>> +     uint8_t                 chip_select;
>>> +     uint8_t                 use_ecc;
>>> +
>>> +     /* calculated from pxa3xx_nand_flash data */
>>> +     uint8_t                 col_addr_cycles;
>>> +     uint8_t                 row_addr_cycles;
>>> +     uint8_t                 read_id_bytes;
>>> +
>>> +     /* cached register value */
>>> +     uint32_t                reg_ndcr;
>>> +     uint32_t                ndtr0cs0;
>>> +     uint32_t                ndtr1cs0;
>>>
>>> +     void                    *nand_data;
>>> +};
>>> +
>>> +struct pxa3xx_nand {
>>>       struct clk              *clk;
>>>       void __iomem            *mmio_base;
>>>       unsigned long           mmio_phys;
>>> +     struct nand_hw_control  controller;
>>> +     struct completion       cmd_complete;
>>> +     struct platform_device   *pdev;
>> please, align
> Do you still mean cs_num? What this comment refer to?

No, I mean the white space before *pdev - it is not aligned with all others

>>> -     unsigned int            buf_start;
>>> -     unsigned int            buf_count;
>>> -
>>> -     struct mtd_info         *mtd;
>>>       /* DMA information */
>>>       int                     drcmr_dat;
>>>       int                     drcmr_cmd;
>>> -
>>> -     unsigned char           *data_buff;
>>> -     unsigned char           *oob_buff;
>>> -     dma_addr_t              data_buff_phys;
>>> -     size_t                  data_buff_size;
>>>       int                     data_dma_ch;
>>> -     struct pxa_dma_desc     *data_desc;
>>> +     dma_addr_t              data_buff_phys;
>>>       dma_addr_t              data_desc_addr;
>>> +     struct pxa_dma_desc     *data_desc;
>>>
>>> -     uint32_t                reg_ndcr;
>>> -
>>> -     /* saved column/page_addr during CMD_SEQIN */
>>> -     int                     seqin_column;
>>> -     int                     seqin_page_addr;
>>> +     struct pxa3xx_nand_info *info[NUM_CHIP_SELECT];
>>> +     uint32_t                command;
>>> +     uint16_t                data_size;      /* data size in FIFO */
>>> +     uint16_t                oob_size;
>>> +     unsigned char           *data_buff;
>>> +     unsigned char           *oob_buff;
>>> +     uint32_t                buf_start;
>>> +     uint32_t                buf_count;
>>>
>>>       /* relate to the command */
>>>       unsigned int            state;
>>> -
>>> +     uint8_t                 chip_select;
>>>       int                     use_ecc;        /* use HW ECC ? */
>>>       int                     use_dma;        /* use DMA ? */
>>>       int                     is_ready;
>>> -
>>> -     unsigned int            page_size;      /* page size of attached chip */
>>> -     unsigned int            data_size;      /* data size in FIFO */
>>>       int                     retcode;
>>> -     struct completion       cmd_complete;
>>>
>>>       /* generated NDCBx register values */
>>> +     uint8_t                 total_cmds;
>>>       uint32_t                ndcb0;
>>>       uint32_t                ndcb1;
>>>       uint32_t                ndcb2;
>>> -
>>> -     /* timing calcuted from setting */
>>> -     uint32_t                ndtr0cs0;
>>> -     uint32_t                ndtr1cs0;
>>> -
>>> -     /* calculated from pxa3xx_nand_flash data */
>>> -     size_t          oob_size;
>>> -     size_t          read_id_bytes;
>>> -
>>> -     unsigned int    col_addr_cycles;
>>> -     unsigned int    row_addr_cycles;
>>>  };
>> It looks like if you switch the names of the structures above,
>> then the patch will be much shorter and cleaner,
>> but will it make structures meaning confusion?
> Could you elaborate more about this? Do you means no need to create a seperated
> structure?

No, if you have 2 chips, then certainly you'd better have a separate
structure for the chip description.

What I was wondering, is that there are many places in the patch where
you change the "info" to "nand", may be this can be avoided if you keep
the structure that describes the controller ("pxa3xx_nand" in the patch)
named "pxa3xx_nand_info" and the new structure that describes the chip
will be named something else like pxa3xx_nand_chip or anything like this.
This way, your patch will not have to change the "info" to "nand" in many
places (or maybe even all places) and will be much shorter and will include
only functional changes.



[...]

>>>  static irqreturn_t pxa3xx_nand_irq(int irq, void *devid)
>>>  {
>>> -     struct pxa3xx_nand_info *info = devid;
>>> -     unsigned int status, is_completed = 0;
>>> +     struct pxa3xx_nand *nand = devid;
>>> +     struct pxa3xx_nand_info *info;
>>> +     unsigned int status, is_completed = 0, cs;
>>> +     unsigned int ready, cmd_done, page_done, badblock_detect;
>>>
>>> -     status = nand_readl(info, NDSR);
>>> +     cs              = nand->chip_select;
>>> +     ready           = (cs) ? NDSR_RDY : NDSR_FLASH_RDY;
>>> +     cmd_done        = (cs) ? NDSR_CS1_CMDD : NDSR_CS0_CMDD;
>>> +     page_done       = (cs) ? NDSR_CS1_PAGED : NDSR_CS0_PAGED;
>>> +     badblock_detect = (cs) ? NDSR_CS1_BBD : NDSR_CS0_BBD;
>> This is confusing... do you use to ?: operator for differentiating between
>> cs = 0 and cs = 1?
>> I think this is a bad idea.
>> Moreover, the use of ?: is discouraged among the kernel.
> I could use if/else to replace this statement.

or switch, what ever you like, but please, don't leave it like
if (cs) ..., because this is confusing it has a meaning of "cs is good or bad?",
while actually, you want to know if it is 0 or 1 (both values are good).


[...]

>>> -static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
>>> +static int prepare_command_pool(struct pxa3xx_nand *nand, int command,
>>>               uint16_t column, int page_addr)
>>>  {
>>>       uint16_t cmd;
>>>       int addr_cycle, exec_cmd, ndcb0;
>>> -     struct mtd_info *mtd = info->mtd;
>>> +     struct mtd_info *mtd;
>>> +     struct pxa3xx_nand_info *info = nand->info[nand->chip_select];
>>>
>>> -     ndcb0 = 0;
>>> +     mtd = get_mtd_by_info(info);
>>> +     ndcb0 = (nand->chip_select) ? NDCB0_CSEL : 0;
>> This one is confusing too...
>> Besides, you don't need the parenthesis.
> Got that. I would fix it.

Good, my previous explanation also applies here.
Thanks


[...]

>>>  static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
>>>  {
>>> -     struct mtd_info *mtd = info->mtd;
>>> +     struct pxa3xx_nand *nand = info->nand_data;
>>> +     struct mtd_info *mtd = get_mtd_by_info(info);
>>>       struct nand_chip *chip = mtd->priv;
>>>
>>>       /* use the common timing to make a try */
>>> -     pxa3xx_nand_config_flash(info, &builtin_flash_types[0]);
>>> +     if (pxa3xx_nand_config_flash(info, &builtin_flash_types[0]))
>>> +             return 0;
>>>       chip->cmdfunc(mtd, NAND_CMD_RESET, 0, 0);
>>> -     if (info->is_ready)
>>> +     if (nand->is_ready)
>>>               return 1;
>>>       else
>>>               return 0;
>> I think it is time to change this function return convention to propagate
>> errors and not just 0 or 1, (may be in separate patch) what do you think?
> How about return 0 when sensing the READY signal, or return -ENODEV?

Yes, this should be fine, but also don't forget about
pxa3xx_nand_config_flash() function call - it can return 0 or -EINVAL
and it should also propagate instead of being squashed.

>>> @@ -882,7 +908,8 @@ static int pxa3xx_nand_sensing(struct pxa3xx_nand_info *info)
>>>  static int pxa3xx_nand_scan(struct mtd_info *mtd)
>>>  {
>>>       struct pxa3xx_nand_info *info = mtd->priv;
>>> -     struct platform_device *pdev = info->pdev;
>>> +     struct pxa3xx_nand *nand = info->nand_data;
>>> +     struct platform_device *pdev = nand->pdev;
>>>       struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
>>>       struct nand_flash_dev pxa3xx_flash_ids[2], *def = NULL;
>>>       const struct pxa3xx_nand_flash *f = NULL;
>>> @@ -891,27 +918,25 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
>>>       uint64_t chipsize;
>>>       int i, ret, num;
>>>
>>> +     nand->chip_select = info->chip_select;
>>>       if (pdata->keep_config && !pxa3xx_nand_detect_config(info))
>>>               goto KEEP_CONFIG;
>>>
>>>       ret = pxa3xx_nand_sensing(info);
>>>       if (!ret) {
>>> -             kfree(mtd);
>>> -             info->mtd = NULL;
>>> -             printk(KERN_INFO "There is no nand chip on cs 0!\n");
>>> +             free_cs_resource(info, nand->chip_select);
>>> +             printk(KERN_INFO "There is no nand chip on cs %d!\n",
>>> +                             nand->chip_select);
>>>
>>>               return -EINVAL;

after the change of pxa3xx_nand_sensing() function,
you should change the above "return -EINVAL;" into "return ret;"



[...]


-- 
Regards,
Igor.
