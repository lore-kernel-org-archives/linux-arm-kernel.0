From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 29 Jul 2014 08:31:45 +0200
Subject: [PATCHv4 5/5] mtd: gpmi: prevent creating a new BBT when
 blockmark swapping is disabled
In-Reply-To: <20140728052906.GA3095@norris-Latitude-E6410>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-4-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-5-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-6-git-send-email-LW@KARO-electronics.de>
 <20140728052906.GA3095@norris-Latitude-E6410>
Message-ID: <20140729083145.647b77fc@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Brian Norris wrote:
> Hi Lothar,
> 
> On Thu, Jun 12, 2014 at 03:20:45PM +0200, Lothar Wa?mann wrote:
> > Without blockmark swapping, there is no use in creating a BBT from
> > scratch, so use a BBT descriptor with NAND_BBT_CREATE unset in this
> > case.
> 
> I'm curious: what is your plan if there is no BBT available on your
> device, or if it ever gets corrupted? IIUC, nand_bbt will just assume
> you have no bad blocks, and it will never write a bad block table to
> flash. This also means no subsequent discoverable bad blocks can be
> recorded across power cycles, I believe.
> 
That won't happen (unless it's not possible to create a BBT because all
the possible blocks for the BBT are bad), because the bootloader will
have created one before Linux is started.

> Maybe you don't want to specify your own nand_bbt_descr's at all, but
> you just need to set:
> 
> 	chip->bbt_options |= NAND_BBT_CREATE_EMPTY | NAND_BBT_NO_OOB;
> 
> (Note: there's a little bit of fuzziness about NAND_BBT_* flags, where
> some are targeted for the nand_chip::bbt_options field, and others
> belong in struct nand_bbt_descr::options.)
> 
> But if for some reason we need to keep this patch, a comment below:
> 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c |   28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > index 37537b4..fc710d7 100644
> > --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> > @@ -43,6 +43,29 @@ static struct nand_bbt_descr gpmi_bbt_descr = {
> >  	.pattern	= scan_ff_pattern
> >  };
> >  
> > +static uint8_t bbt_pattern[] = {'B', 'b', 't', '0' };
> > +static uint8_t mirror_pattern[] = {'1', 't', 'b', 'B' };
> > +
> > +static struct nand_bbt_descr bbt_main_no_oob_descr = {
> > +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_WRITE |
> > +	NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP |
> > +	NAND_BBT_NO_OOB,
> 
> Please indent the above two lines a bit, preferably matching the
> indentation of NAND_BBT_LASTBLOCK. It should be clear that this is a
> continuation of the '.options' initialization.
> 
OK.

> > +	.len = 4,
> > +	.veroffs = 4,
> > +	.maxblocks = NAND_BBT_SCAN_MAXBLOCKS,
> > +	.pattern = bbt_pattern,
> > +};
> > +
> > +static struct nand_bbt_descr bbt_mirror_no_oob_descr = {
> > +	.options = NAND_BBT_LASTBLOCK | NAND_BBT_WRITE |
> > +	NAND_BBT_2BIT | NAND_BBT_VERSION | NAND_BBT_PERCHIP |
> > +	NAND_BBT_NO_OOB,
> 
> Same here.
> 
> > +	.len = 4,
> > +	.veroffs = 4,
> > +	.maxblocks = NAND_BBT_SCAN_MAXBLOCKS,
> > +	.pattern = mirror_pattern,
> > +};
> > +
> >  /*
> >   * We may change the layout if we can get the ECC info from the datasheet,
> >   * else we will use all the (page + OOB).
> > @@ -1728,8 +1751,11 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
> >  			chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
> >  
> >  		if (of_property_read_bool(this->dev->of_node,
> > -						"fsl,no-blockmark-swap"))
> > +						"fsl,no-blockmark-swap")) {
> >  			this->swap_block_mark = false;
> > +			chip->bbt_td = &bbt_main_no_oob_descr;
> > +			chip->bbt_md = &bbt_mirror_no_oob_descr;
> 
> My initial recommendation for this patch and the previous patch means
> that you could just drop both patches and replace them with the
> following:
> 
> 			/* Comment here to explain why... */
> 			chip->bbt_options |= NAND_BBT_CREATE_EMPTY |
> 					     NAND_BBT_NO_OOB |
> 					     NAND_BBT_NO_OOB_BBM;
OK.

Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
