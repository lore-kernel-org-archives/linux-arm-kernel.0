From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 28 Nov 2013 15:50:41 -0300
Subject: [PATCH v5 00/14] Armada 370/XP NAND support
In-Reply-To: <87wqjtbm8r.fsf@natisbad.org>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <87d2lp28pd.fsf@natisbad.org> <20131125120335.GD2408@localhost>
 <87r4a4f5gr.fsf@natisbad.org> <20131126124003.GA2344@localhost>
 <87zjopd240.fsf@natisbad.org> <87wqjtbm8r.fsf@natisbad.org>
Message-ID: <20131128185040.GA13182@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnaud,

On Wed, Nov 27, 2013 at 09:52:52PM +0100, Arnaud Ebalard wrote:
> 
> arno at natisbad.org (Arnaud Ebalard) writes:
> 
> > Well, I guess the bad block the driver put in the bbt are not that bad
> > in practice, i.e. they were mistakenly marked that way. I also
> > guess^Whope there is a some low level command I could use to simply
> > clear the bbt (the NAND had no bad block prior to the test). Any help
> > would be appreciated on that point.
> 
> Replying to myself w/ the solution: just in case it happens to someone
> else, it's as simple as using flash_erase w/ -N option on a kernel
> modified (in drivers/mtd/nand/nand_base.c) to allow write to a bad
> block w/ the following patch:
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index bd39f7b..e70ef60 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -2591,6 +2591,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
>         instr->state = MTD_ERASING;
>  
>         while (len) {
> +#if 0
>                 /* Check if we have a bad block, we do not erase bad blocks! */
>                 if (nand_block_checkbad(mtd, ((loff_t) page) <<
>                                         chip->page_shift, 0, allowbbt)) {
> @@ -2599,6 +2600,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
>                         instr->state = MTD_ERASE_FAILED;
>                         goto erase_exit;
>                 }
> +#endif
>  
>                 /*
>                  * Invalidate the page cache, if we erase the block which
> 
> 
> After a reboot on that modified kernel, a simple call to flash_erase
> using -N option will erase the badblocks:
> 
>  # flash_erase -N /dev/mtd4 0 0 
> 
> Then, at next reboot an empty bad block table is recreated.
> 
> NAND:  (ID 0xf1ad)      128 MiB
> Bad block table not found for chip 0
> Bad block table not found for chip 0
> Bad block table written to 0x000007fe0000, version 0x01
> Bad block table written to 0x000007fc0000, version 0x01
> FPU not initialized
> USB 0: Host Mode
> USB 1: Host Mode
> 

Yup, I'm using the same hack to clean the (not really) bad blocks from
the table. FWIW, the MTD people has been playing with some idea to
kernel support to unmark bad blocks from the bad block table, but
nothing was merged and (AFAIK) nobody is working on it. So patches are
welcome!

> Ezequiel, I am back in business to test a v2 ;-)

Well, I'm not sure yet what's going on. Do you have any spare NAND partition
to run some destructive testings?

In that case, please run:

$ nandtest /dev/mtd{X}

Be careful as you _will_ destroy all your data on that partition!

Thanks for such brave testings!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
