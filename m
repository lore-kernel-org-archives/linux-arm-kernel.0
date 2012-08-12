From: marex@denx.de (Marek Vasut)
Date: Sun, 12 Aug 2012 21:14:46 +0200
Subject: [PATCH v4] mtd: gpmi: add NAND write verify support
In-Reply-To: <CAMiH66GopNVeKPRQn+KfwRHUoM-Lv8WitX0zAS=Vi=8QAvS-Pw@mail.gmail.com>
References: <1344737275-18342-1-git-send-email-shijie8@gmail.com>
 <201208111610.45107.marex@denx.de>
 <CAMiH66GopNVeKPRQn+KfwRHUoM-Lv8WitX0zAS=Vi=8QAvS-Pw@mail.gmail.com>
Message-ID: <201208122114.46901.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Huang Shijie,

[...]

> >> +     this->verify_buf = kzalloc(mtd->writesize, GFP_KERNEL);
> > 
> > devm_
> 
> emm...
> The devm_kzalloc() is the wrong choose in this case. It may makes we
> waste much more memory when the NAND page is 8K.
> 
> Assume the gpmi uses a 8K page nand chip.  The devm_kzalloc() will
> allocate (sizeof(struct devres) + 8K).

Don't forget the malloc header and padding around malloc()'d space. So you're 
behind the 2 * PAGESIZE anyway.

> It's obvious that the size is bigger then the SLUB_MAX_SIZE. So the
> kernel gets 2 with the
> get_order(sizeof(struct devres) + 8K) which means we have to use 4
> memory page for the verify_buf.
> But in actually, we only use 8K memory. So the rest nearly 8K(
> sizeof(struct devres) is very small) memory
> is wasted.
> 
> So I prefer to use the kzalloc() here.
> 
> thanks
> Huang Shijie
> 
> >> +     if (!this->verify_buf)
> >> +             return -ENOMEM;
> >> +
> >> 
> >>       /* Prepare for the BBT scan. */
> >>       ret = gpmi_pre_bbt_scan(this);
> >>       if (ret)
> >> 
> >> @@ -1531,6 +1553,8 @@ void gpmi_nfc_exit(struct gpmi_nand_data *this)
> >> 
> >>  {
> >>  
> >>       nand_release(&this->mtd);
> >>       gpmi_free_dma_buffer(this);
> >> 
> >> +     kfree(this->verify_buf);
> >> +     this->verify_buf = NULL;
> > 
> > Then you won't have to care for this ... I told you at least once before.
> > 
> >>  }
> >>  
> >>  static int __devinit gpmi_nfc_init(struct gpmi_nand_data *this)
> >> 
> >> @@ -1556,6 +1580,7 @@ static int __devinit gpmi_nfc_init(struct
> >> gpmi_nand_data *this) chip->read_byte         = gpmi_read_byte;
> >> 
> >>       chip->read_buf          = gpmi_read_buf;
> >>       chip->write_buf         = gpmi_write_buf;
> >> 
> >> +     chip->verify_buf        = gpmi_verify_buf;
> >> 
> >>       chip->ecc.read_page     = gpmi_ecc_read_page;
> >>       chip->ecc.write_page    = gpmi_ecc_write_page;
> >>       chip->ecc.read_oob      = gpmi_ecc_read_oob;
> >> 
> >> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> >> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h index 1547a60..8ddf115 100644
> >> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> >> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> >> @@ -144,6 +144,7 @@ struct gpmi_nand_data {
> >> 
> >>       /* MTD / NAND */
> >>       struct nand_chip        nand;
> >>       struct mtd_info         mtd;
> >> 
> >> +     uint8_t                 *verify_buf;
> >> 
> >>       /* General-use Variables */
> >>       int                     current_chip;
