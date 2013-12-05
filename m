From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 5 Dec 2013 14:45:18 -0800
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <20131205222352.GA2469@localhost>
References: <20131126124003.GA2344@localhost> <87zjopd240.fsf@natisbad.org>
 <87wqjtbm8r.fsf@natisbad.org> <20131128185040.GA13182@localhost>
 <87bo12kcyt.fsf@natisbad.org> <20131202103305.GB2466@localhost>
 <87siubneuf.fsf@natisbad.org> <20131203002225.GA5333@localhost>
 <20131205212333.GM27149@ld-irv-0074.broadcom.com>
 <20131205222352.GA2469@localhost>
Message-ID: <20131205224518.GO27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 07:23:53PM -0300, Ezequiel Garcia wrote:
> On Thu, Dec 05, 2013 at 01:23:33PM -0800, Brian Norris wrote:
> > On Mon, Dec 02, 2013 at 09:22:26PM -0300, Ezequiel Garcia wrote:
> > > Now, why does NAND reserve eight blocks, if there are only two tables?
> > > Well, you'll be able to find this in the driver:
> > > 
> > > static struct nand_bbt_descr bbt_main_descr = {
> > > 	/* stuff */
> > > 	.maxblocks = 8,         /* Last 8 blocks in each chip */
> > > };
> > > 
> > > The snippet above asks the NAND core to scan the last 8 blocks when searching
> > > for the in-flash bad block table. The NAND core will also reserve these
> > > 8 blocks as the maximum amount of blocks that can be used to store a bad
> > > block table (I guess that's in case one block gets 'really' bad).
> > 
> > That doesn't reflect mainline, where you'll see:
> > 
> 
> I wasn't mentioning nand_bbt.c but rather the pxa3xx-nand custom
> nand_bbt_descr.
> 
> $ grep "maxblocks =" drivers/mtd/nand/pxa3xx_nand.c 
>  	.maxblocks = 8,		/* Last 8 blocks in each chip */
> 	.maxblocks = 8,		/* Last 8 blocks in each chip */

Ah, I forgot about that.

> > static struct nand_bbt_descr bbt_main_descr = {
> > ...
> >         .maxblocks = NAND_BBT_SCAN_MAXBLOCKS,
> > ...
> > };
> > 
> > Where NAND_BBT_SCAN_MAXBLOCKS == 4.
> > 
> 
> Do you think using 8 is too much? (I'd agree at changing it)
> Does it break anything to lower it to 4?

I think it's primarily a concern if you have too many consecutive bad
blocks at the end of your flash (factory, or from wear). On a pristine
flash, the table will only ever be in the last 2 blocks, and so 4 blocks
is a reasonable guess at the maximum needed, leaving room for two blocks
to go bad.

So, you'd only have a problem if 3 or more of the last 4 blocks go bad.

Brian
