From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 11 Feb 2015 17:31:19 +0100
Subject: [PATCH 5/9] mtd: pxa3xx_nand: add support for the Marvell Berlin
 nand controller
In-Reply-To: <20150209005503.3fad39c7@bbrezillon>
References: <1422367816-4257-1-git-send-email-antoine.tenart@free-electrons.com>
 <1422367816-4257-6-git-send-email-antoine.tenart@free-electrons.com>
 <20150209005503.3fad39c7@bbrezillon>
Message-ID: <20150211163119.GG11169@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris,

On Mon, Feb 09, 2015 at 12:55:03AM +0100, Boris Brezillon wrote:
> On Tue, 27 Jan 2015 15:10:12 +0100
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> 
> >  
> > +		if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2 &&
> > +				info->ndcb0 & NDCB0_LEN_OVRD)
> > +			nand_writel(info, NDCB0,
> > +					info->chunk_size + info->oob_size);
> > +
> 
> Why don't you reuse the following if statement (which is doing the
> exact same thing, except for the size being stored in ndbc3 when
> the command is created).

I'll update to reuse this!

> Moreover, I'm pretty sure you don't want to add oob_size on the 2nd
> chunk, but only on the last one.
> Doing that will only work for 4K pages (2 * max_chunk_size), and you
> add support for 8K pages NANDs in this patch.

Yep. As a matter of fact, oob_size was equl to 0 in this case because of
some dirty hacks. I'll remove them and will send a v2 with a proper
solution.

> >  
> > +	if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2)
> > +		chip->cmdfunc = nand_cmdfunc_berlin;
> 
> Your cmdfunc looks like the nand_cmdfunc_extended one, and this one is
> only used for NAND chips that have writesize > PAGE_CHUNK_SIZE.
> 
> Is your cmdfunc supporting accesses to NAND chips with smaller pages ?
> If you're unsure, maybe you should add a check here, and refuse to
> probe such NAND chips.

I currently have no idea, so I'll add a check here.

> >  
> > -	num = ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1;
> > -	for (i = 0; i < num; i++) {
> > -		if (i < pdata->num_flash)
> > -			f = pdata->flash + i;
> > -		else
> > -			f = &builtin_flash_types[i - pdata->num_flash + 1];
> > +	if (info->variant == PXA3XX_NAND_VARIANT_BERLIN2)
> > +		flash_types = berlin_builtin_flash_types;
> > +	else
> > +		flash_types = builtin_flash_types;
> >  
> > -		/* find the chip in default list */
> > +	for (i = 0; (f = &flash_types[i]); i++)
> >  		if (f->chip_id == id)
> >  			break;
> > +
> > +	if (f == NULL) {
> > +		for (i = 0; i < pdata->num_flash; i++) {
> > +			f = pdata->flash + i;
> > +			if (f->chip_id == id)
> > +				break;
> > +		}
> >  	}
> 
> You're changing the matching order here, the initial order was:
> 
> 1/ pdata definition
> 2/ builtin types
> 
> and you're now doing:
> 
> 1/ builtin types
> 2/ pdata definition

Oops...

Thanks for the review!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
