From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 7 Nov 2013 16:46:00 -0800
Subject: [PATCH v4 26/31] mtd: nand: pxa3xx: Introduce multiple page
 I/O support
In-Reply-To: <20131107234459.GB2467@localhost>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1383837455-30721-27-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131107234459.GB2467@localhost>
Message-ID: <20131108004600.GZ20061@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I haven't taken a look at all your changes yet, but I'll get this
comment off my chest while it's still fresh :)

On Thu, Nov 07, 2013 at 08:45:00PM -0300, Ezequiel Garcia wrote:
> Hello,
> 
> I have a concern about the ECC mode and strength determination.
> 
> On Thu, Nov 07, 2013 at 12:17:30PM -0300, Ezequiel Garcia wrote:
> [..]
> > @@ -1152,7 +1289,28 @@ static int armada370_ecc_init(struct pxa3xx_nand_info *info,
> >  			      struct nand_ecc_ctrl *ecc,
> >  			      int strength, int page_size)
> >  {
> > -	/* Unimplemented yet */
> > +	if (strength == 4 && page_size == 4096) {
> > +		info->ecc_bch = 1;
> > +		info->chunk_size = 2048;
> > +		info->spare_size = 32;
> > +		info->ecc_size = 32;
> > +		ecc->mode = NAND_ECC_HW;
> > +		ecc->size = info->chunk_size;
> > +		ecc->layout = &ecc_layout_4KB_bch4bit;
> > +		ecc->strength = 16;
> > +		return 1;
> > +
> > +	} else if (strength == 8 && page_size == 4096) {
> > +		info->ecc_bch = 1;
> > +		info->chunk_size = 1024;
> > +		info->spare_size = 0;
> > +		info->ecc_size = 32;
> > +		ecc->mode = NAND_ECC_HW;
> > +		ecc->size = info->chunk_size;
> > +		ecc->layout = &ecc_layout_4KB_bch8bit;
> > +		ecc->strength = 16;
> > +		return 1;
> > +	}
> >  	return 0;
> >  }
> >  
> 
> The above shows I tried to be very careful (aka paranoid) in the ECC
> mode determination. Please note that what I call "ECC mode", is
> determined by the chunk->size value only.
> 
> As the included documentation explains this controller supports two
> different BCH ECC strength: 16-over-1024, or 16-over-2048. Setting the chunk
> size to either 1024 or 2048 is what determines which of the above will
> actually take effect.
> 
> In past mails, we've refered to these two as BCH4 or BCH8, but this is not
> really accurate (as Brian has pointed out) so I droped that terms in
> favor of the real thing: 16 correctable bits over 1024 data bytes, or
> 16 correctable bits over 2048 data bytes.
> 
> In turn, such BCH mode setting affects heavily the page layout, because
> after each transfered chunk (which is either 1024+spare or 2048+spare)
> the controller reads and writes a 30B ECC region.
> 
> In other words, the kernel cannot arbitrarily change this setting, or
> the image won't be readable/writeable any longer.
> 
> For this reason, I'm starting to think the above method of picking
> the "ECC mode" based solely on the page size or the strength is slightly
> fragile (future developers might come and "improve" the driver breaking
> images).
> 
> Besides: what if a user wants the kernel to use a "higher" than
> required strength?
> 
> In conclusion: I'm starting to think a better (and long-term safer)
> approach is to set the ECC mode in the DT. I know this sucks, but from
> my point of view the flash device contains an image that "must" be
> read/write with a given ECC mode, and this ECC mode is by no means
> discoverable.

I think that's the way to go, in general. We can get by with
"implementation defined behavior" (i.e., make the driver do what makes
sense) for now, but to avoid breakage in the future, the bootloader
needs to specify what ECC configuration is required -- via DT. But your
current patch is still probably fine without it, since you're supporting
new hardware.

> Now, let's suppose we want to set this in the DT: what property
> would we use? "marvell,nand-ecc-opt = 16-2048"? (a bit odd, no?).
> 
> What do you think?

If ECC is purely determined by the chunk size, then why not just:

  marvell,nand-chunk-size = 2048;
  (with a value of 2048, 1024, or 512?)

Brian
