From: shijie8@gmail.com (Huang Shijie)
Date: Sat, 11 Aug 2012 11:15:49 -0400
Subject: [PATCH v4] mtd: gpmi: add NAND write verify support
In-Reply-To: <201208111610.45107.marex@denx.de>
References: <1344737275-18342-1-git-send-email-shijie8@gmail.com>
 <201208111610.45107.marex@denx.de>
Message-ID: <CAMiH66GopNVeKPRQn+KfwRHUoM-Lv8WitX0zAS=Vi=8QAvS-Pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 11, 2012 at 10:10 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Huang Shijie,
>
>> Add NAND write verify support in gpmi-nand driver.
>>
>> This patch fixes a kernel crash when we select
>> CONFIG_MTD_NAND_VERIFY_WRITE=y, and do some write tests:
>>
>> root at freescale /$ dd if=/dev/zero of=/dev/mtd0 bs=128k count=1
>> [   41.070000] Unable to handle kernel NULL pointer dereference at virtual
>> addr0 [   41.080000] pgd = c77ac000
>> [   41.080000] [00000000] *pgd=4773c831, *pte=00000000, *ppte=00000000
>> [   41.090000] Internal error: Oops: 17 [#1] ARM
>> [   41.090000] Modules linked in:
>> [   41.090000] CPU: 0    Not tainted
>> (3.6.0-rc1-next-20120809-00002-ga25d017-d) [   41.090000] PC is at
>> nand_verify_buf+0x18/0x5c
>> [   41.090000] LR is at nand_write_page+0xc0/0x140
>> [   41.090000] pc : [<c023e7d4>]    lr : [<c023fcfc>]    psr: 20000013
>> [   41.090000] sp : c7779de4  ip : 00000000  fp : c6e60000
>> [   41.090000] r10: 00000000  r9 : 00020000  r8 : 00000000
>> [   41.090000] r7 : 00000000  r6 : c6e60000  r5 : c762cb10  r4 : 00000000
>> [   41.090000] r3 : c762c8a8  r2 : 00000800  r1 : c6e60000  r0 : 00000000
>> [   41.090000] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment
>> user [   41.090000] Control: 0005317f  Table: 477ac000  DAC: 00000015
>> [   41.090000] Process dd (pid: 427, stack limit = 0xc7778270)
>> [   41.090000] Stack: (0xc7779de4 to 0xc777a000)
>>       ...
>>
>>       The crash log is fetched from Fabio's patch. thanks to Fabio's hard
> work.
>>
>> Cc: <stable@vger.kernel.org>
>> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
>> Signed-off-by: Huang Shijie <shijie8@gmail.com>
>> ---
>> v3 --> v4:
>>     [1] add credit to Fabio.
>>
>> v2 --> v3:
>>     [1] free the verify_buf when we exit.
>>
>> v1 --> v2:
>>     [1] use the mtd->writesize to allocate the verify buffer.
>>     [2] add new field `verify_buf` in gpmi_nand_data{}
>>
>>     tested this patch on imx6q-arm2 board.
>> ---
>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   25 +++++++++++++++++++++++++
>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |    1 +
>>  2 files changed, 26 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c index 8c0d2f0..e1e4c51 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> @@ -1512,12 +1512,34 @@ static int gpmi_pre_bbt_scan(struct gpmi_nand_data
>> *this) return nand_boot_init(this);
>>  }
>>
>> +static int gpmi_verify_buf(struct mtd_info *mtd, const uint8_t *buf, int
>> len) +{
>> +     struct nand_chip *chip = mtd->priv;
>> +     struct gpmi_nand_data *this = chip->priv;
>> +     int ret;
>> +
>> +     ret = chip->ecc.read_page(mtd, chip, this->verify_buf, 0, 0);
>> +     if (ret)
>> +             return -EFAULT;
>> +     if (memcmp(buf, this->verify_buf, len))
>> +             return -EFAULT;
>> +     return 0;
>> +}
>> +
>>  static int gpmi_scan_bbt(struct mtd_info *mtd)
>>  {
>>       struct nand_chip *chip = mtd->priv;
>>       struct gpmi_nand_data *this = chip->priv;
>>       int ret;
>>
>> +     /*
>> +      * We have gotten the right page size now, use it to allocate
>> +      * the proper verify buffer.
>> +      */
>> +     this->verify_buf = kzalloc(mtd->writesize, GFP_KERNEL);
>
> devm_

emm...
The devm_kzalloc() is the wrong choose in this case. It may makes we
waste much more memory when the NAND page is 8K.

Assume the gpmi uses a 8K page nand chip.  The devm_kzalloc() will
allocate (sizeof(struct devres) + 8K).
It's obvious that the size is bigger then the SLUB_MAX_SIZE. So the
kernel gets 2 with the
get_order(sizeof(struct devres) + 8K) which means we have to use 4
memory page for the verify_buf.
But in actually, we only use 8K memory. So the rest nearly 8K(
sizeof(struct devres) is very small) memory
is wasted.

So I prefer to use the kzalloc() here.

thanks
Huang Shijie



>
>> +     if (!this->verify_buf)
>> +             return -ENOMEM;
>> +
>>       /* Prepare for the BBT scan. */
>>       ret = gpmi_pre_bbt_scan(this);
>>       if (ret)
>> @@ -1531,6 +1553,8 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
>>  {
>>       nand_release(&this->mtd);
>>       gpmi_free_dma_buffer(this);
>> +     kfree(this->verify_buf);
>> +     this->verify_buf = NULL;
>
> Then you won't have to care for this ... I told you at least once before.
>
>>  }
>>
>>  static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
>> @@ -1556,6 +1580,7 @@ static int __devinit gpmi_nfc_init(struct
>> gpmi_nand_data *this) chip->read_byte         = gpmi_read_byte;
>>       chip->read_buf          = gpmi_read_buf;
>>       chip->write_buf         = gpmi_write_buf;
>> +     chip->verify_buf        = gpmi_verify_buf;
>>       chip->ecc.read_page     = gpmi_ecc_read_page;
>>       chip->ecc.write_page    = gpmi_ecc_write_page;
>>       chip->ecc.read_oob      = gpmi_ecc_read_oob;
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h index 1547a60..8ddf115 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
>> @@ -144,6 +144,7 @@ struct gpmi_nand_data {
>>       /* MTD / NAND */
>>       struct nand_chip        nand;
>>       struct mtd_info         mtd;
>> +     uint8_t                 *verify_buf;
>>
>>       /* General-use Variables */
>>       int                     current_chip;
