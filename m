From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 4 Nov 2013 09:24:54 -0300
Subject: [PATCH v2 10/27] mtd: nand: pxa3xx: Replace host->page_size by
 mtd->writesize
In-Reply-To: <20131103225211.GD5896@gmail.com>
References: <1382137374-21251-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1382137374-21251-11-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131103225211.GD5896@gmail.com>
Message-ID: <20131104122453.GE2516@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 03, 2013 at 05:52:13PM -0500, Huang Shijie wrote:
> On Fri, Oct 18, 2013 at 08:02:37PM -0300, Ezequiel Garcia wrote:
> > There's no need to privately store the device page size as it's
> > available in mtd structure field mtd->writesize.
> > Also, this removes the hardcoded page size value, leaving the
> > auto-detected value only.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/mtd/nand/pxa3xx_nand.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> > index fe2e27c..83ba036 100644
> > --- a/drivers/mtd/nand/pxa3xx_nand.c
> > +++ b/drivers/mtd/nand/pxa3xx_nand.c
> > @@ -149,7 +149,6 @@ struct pxa3xx_nand_host {
> >  	void			*info_data;
> >  
> >  	/* page size of attached chip */
> > -	unsigned int		page_size;
> >  	int			use_ecc;
> >  	int			cs;
> >  
> > @@ -612,12 +611,12 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
> >  			info->buf_start += mtd->writesize;
> >  
> >  		/* Second command setting for large pages */
> > -		if (host->page_size >= PAGE_CHUNK_SIZE)
> > +		if (mtd->writesize >= PAGE_CHUNK_SIZE)
> >  			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
> >  
> >  	case NAND_CMD_SEQIN:
> >  		/* small page addr setting */
> > -		if (unlikely(host->page_size < PAGE_CHUNK_SIZE)) {
> > +		if (unlikely(mtd->writesize < PAGE_CHUNK_SIZE)) {
> >  			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
> >  					| (column & 0xFF);
> >  
> > @@ -891,7 +890,6 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
> >  	}
> >  
> >  	/* calculate flash information */
> > -	host->page_size = f->page_size;
> you remove this line, but how the following code get the right value:?
> 
> 	chip->ecc.size = host->page_size;
> this line in the pxa3xx_nand_scan.
> 

Ah, nice catch. I guess it splipped through the million rebases I did...

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
