From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 07 May 2012 18:43:43 +0800
Subject: [PATCH v5] MTD: atmel_nand: Update driver to support Programmable
 Multibit ECC controller
In-Reply-To: <20120503152531.GA2261@parrot.com>
References: <1336048655-29486-1-git-send-email-josh.wu@atmel.com>
 <20120503152531.GA2261@parrot.com>
Message-ID: <4FA7A75F.6060909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Ivan

Thank you for your comments.


On 5/3/2012 11:25 PM, Ivan Djelic wrote:
> On Thu, May 03, 2012 at 01:37:35PM +0100, Josh Wu wrote:
>> The Programmable Multibit ECC (PMECC) controller is a programmable binary
>> BCH(Bose, Chaudhuri and Hocquenghem) encoder and decoder. This controller
>> can be used to support both SLC and MLC NAND Flash devices. It supports to
>> generate ECC to correct 2, 4, 8, 12 or 24 bits of error per sector of data.
>>
>> To use this driver, the user needs to pass in the correction capability and
>> the sector size.
>>
>> This driver has been tested on AT91SAM9X5-EK and AT91SAM9N12-EK with JFFS2,
>> YAFFS2, UBIFS and mtd-utils.
>>
> (...)
>
> Hello Josh,
> Few comments below,
>
>> + * =====================       ================        =================
>> + *                2-bits                 4-bytes                  4-bytes
>> + *                4-bits                 7-bytes                  7-bytes
>> + *                8-bits                13-bytes                 14-bytes
>> + *               12-bits                20-bytes                 21-bytes
>> + *               24-bits                39-bytes                 42-bytes
>> + *
>> + */
>> +static const int ecc_bytes_table[5][2] = {
>> +       {4, 4}, {7, 7}, {13, 14}, {20, 21}, {39, 42}
>>   };
>>
>>   static int cpu_has_dma(void)
>> @@ -288,6 +333,699 @@ static void atmel_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
>>   }
>>
>>   /*
>> + * Return number of ecc bytes per sector according to sector size and
>> + * correction capability
>> + */
>> +static int pmecc_get_ecc_bytes(int cap, int sector_size)
>> +{
>> +       int i, j;
>> +
>> +       switch (cap) {
>> +       case 2:
>> +               i = 0;
>> +               break;
>> +       case 4:
>> +               i = 1;
>> +               break;
>> +       case 8:
>> +               i = 2;
>> +               break;
>> +       case 12:
>> +               i = 3;
>> +               break;
>> +       case 24:
>> +               i = 4;
>> +               break;
>> +       default:
>> +               BUG();
>> +       }
>> +
>> +       switch (sector_size) {
>> +       case 512:
>> +               j = 0;
>> +               break;
>> +       case 1024:
>> +               j = 1;
>> +               break;
>> +       default:
>> +               BUG();
>> +       }
>> +
>> +       return ecc_bytes_table[i][j];
> You could get rid of your table and simplify your function:
>
>        int m;
>
>        m = 12+sector_size/512;
>        return (m*cap+7)/8;

yes, it makes code much simpler. I will use this.
>
>> +static void __iomem *pmecc_get_alpha_to(struct atmel_nand_host *host)
>> +{
>> +       void __iomem *p;
>> +
>> +       switch (host->sector_size) {
>> +       case 512:
>> +               p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_512 +
>> +                       AT_PMECC_LOOKUP_TABLE_SIZE_512 * sizeof(int16_t);
>> +               break;
>> +       case 1024:
>> +               p = host->rom_base + AT_PMECC_LOOKUP_TABLE_OFFSET_1024 +
>> +                       AT_PMECC_LOOKUP_TABLE_SIZE_1024 * sizeof(int16_t);
>> +               break;
> Just being curious here: it looks like your hardware provides hardcoded Galois field lookup tables.
> Do you access these through a cached mapping ? If not, maybe your code would be faster with ram-based tables ?

The ROM code is flash based. It is slower than ram-based tables. It has 
room to improve.
>
>> +static int pmecc_correction(struct mtd_info *mtd, u32 pmecc_stat, uint8_t *buf,
>> +       u8 *ecc)
>> +{
>> +       int                     i, err_nbr;
>> +       uint8_t                 *buf_pos;
>> +       int                     eccbytes;
>> +       struct nand_chip        *nand_chip = mtd->priv;
>> +       struct atmel_nand_host  *host = nand_chip->priv;
>> +
>> +       eccbytes = nand_chip->ecc.bytes;
>> +       for (i = 0; i<  eccbytes; i++)
>> +               if (ecc[i] != 0xff)
>> +                       goto normal_check;
>> +       /* Erased page, return OK */
>> +       return 0;
> Here, you work around the fact that an erased page does not have a valid ecc.
> If an erased page has a bitflip in the ecc bytes region, then your code will jump
> to 'normal_check' and fail (because the page is erased).

yes, you are right. If any bitflip happens in the ecc bytes region of an 
erased page, then pmecc will fail to read this erased page.

> On 4-bit and 8-bit NAND devices, bitflips are very common and the risk of such a failure
> is quite high, especially with a large number of ecc bytes.
>
> There is a cleaner (and faster) workaround: just pretend your HW generates an extra ecc
> byte, always equal to 0. Assume you put this extra byte at the beginning of your ecc layout.
> Now, upon reading, you just need to do something like:
>
>         eccbytes = nand_chip->ecc.bytes;
>         /*
>          * first ecc byte should be zero if page has been programmed,
>          * but tolerate up to 4 bitflips in the same byte (very unlikely)
>          */
>         if (hweight_long(ecc[0])<= 4)
>         	  goto normal_check;
>
>         /* Erased page, return OK */
>         return 0;
>
> On an erased page, even with bitflips, it is _very_ unlikely that ecc[0] would have
> less than 4 bits set out of 8.

This solution sounds better and it is workable for our hardware.
The only problem is the extra byte can cause compatible issue. Since 
current U-boot, bootstrap code and SAM-BA tools (use to flush binary 
into nand flash) are not using extra ecc byte at all.

So I think in this version we won't apply your workaround. In future, if 
we decide to use your workaround, we will apply it to all bootstrap, 
u-boot, SAM-BA.

>
> Regardless of the workaround, skipping ecc check on an erased page still has a drawback: UBIFS
> does not like to find uncorrected bitflips in erased pages.
>
> +static int atmel_nand_pmecc_read_page(struct mtd_info *mtd,
> +               struct nand_chip *chip, uint8_t *buf, int32_t page)
> +{
> +       uint32_t                stat;
> +       int                     eccsize = chip->ecc.size;
> +       uint8_t                 *oob = chip->oob_poi;
> +       struct atmel_nand_host  *host = chip->priv;
> +       uint32_t                *eccpos = chip->ecc.layout->eccpos;
> +
> +       pmecc_writel(host->ecc, CTRL, PMECC_CTRL_RST);
> +       pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DISABLE);
> +       pmecc_writel(host->ecc, CFG, (pmecc_readl(host->ecc, CFG)
> +&  ~PMECC_CFG_WRITE_OP) | PMECC_CFG_AUTO_ENABLE);
> +
> +       pmecc_writel(host->ecc, CTRL, PMECC_CTRL_ENABLE);
> +       pmecc_writel(host->ecc, CTRL, PMECC_CTRL_DATA);
> +
> +       chip->read_buf(mtd, buf, eccsize);
> +       chip->read_buf(mtd, oob, mtd->oobsize);
> +
> +       while ((pmecc_readl(host->ecc, SR)&  PMECC_SR_BUSY))
> +               cpu_relax();
>
> Here it seems to me you feed the hardware ecc engine with the entire page (data+oob).
> Is it possible to feed it with data+oob-eccbytes, i.e. leave out the ecc bytes from the computation ?
> I'm asking this because it probably would allow correcting bitflips in erased pages (if you ever care about this :).

Understand. Currently the PMECC only take into account the ECC bytes for 
computation. we can specify the ECC start and end. In this case it is 
doable.

>
> BR,
> --
> Ivan

Best Regards,
Josh Wu
