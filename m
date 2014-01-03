From: giometti@enneenne.com (Rodolfo Giometti)
Date: Fri, 3 Jan 2014 16:32:50 +0100
Subject: NAND support for Armada 370
In-Reply-To: <20140103145336.GA9618@localhost>
References: <20140102124407.GF10251@enneenne.com>
 <20140102144236.270c4a6a@skate>
 <20140103112926.GP10251@enneenne.com>
 <20140103145336.GA9618@localhost>
Message-ID: <20140103153249.GR10251@enneenne.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 11:53:37AM -0300, Ezequiel Garcia wrote:
> >    pxa3xx-nand f10d0000.nand: This platform can't do DMA on this device
> >    NAND device: Manufacturer ID: 0x2c, Chip ID: 0xf1 (Micron MT29F1G08ABADAWP)
> >    NAND device: 128MiB, SLC, page size: 2048, OOB size: 64
> 
> Great! Your NAND is now detected...
> 
> >    pxa3xx-nand f10d0000.nand: ECC strength 4 at page size 2048 is not supported
> >    pxa3xx-nand f10d0000.nand: failed to scan nand at cs 0
> > 
> > So I suppose I should modify function pxa_ecc_init() in file
> > drivers/mtd/nand/pxa3xx_nand.c in order to support my NAND chip, is
> > that right? Have you any advice for me about it? :)
> > 
> 
> Can you modify the above message so the ECC step size is also printed?

Here my modification:

   diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
   index 31aae53..3e4519f 100644
   --- a/drivers/mtd/nand/pxa3xx_nand.c
   +++ b/drivers/mtd/nand/pxa3xx_nand.c
   @@ -1498,6 +1508,8 @@ KEEP_CONFIG:
    
           ecc_strength = chip->ecc_strength_ds;
           ecc_step = chip->ecc_step_ds;
   +       dev_info(&info->pdev->dev, "ECC strength %d, ECC step size %d\n",
   +                       ecc_strength, ecc_step);
    
           /* Set default ECC strength requirements on non-ONFI devices */
           if (ecc_strength < 1 && ecc_step < 1) {

and the corresponding output:

   pxa3xx-nand f10d0000.nand: ECC strength 4, ECC step size 512

> I'll help you prepare a suitable fix to support your NAND.

Great. Thanks! :-)

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti at enneenne.com
Linux Device Driver                          giometti at linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
