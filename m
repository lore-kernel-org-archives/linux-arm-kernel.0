From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 13 Nov 2009 10:37:02 +0200
Subject: NAND: failure reported with mtd_oobtest(read delay violated)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC012@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA5CC012@dbde02.ent.ti.com>
Message-ID: <1258101422.21596.1191.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2009-11-12 at 21:28 +0530, Govindarajan, Sriramakrishnan wrote:
> Hello,
> On the OMAP3 EVM platform we are seeing failures when we run the mtd_oobtest repeatedly (overnight). Usually the failures are reported after 40-45 iterations.
> 
> Further analysis with logic analyzer seems to indicate that for the specific instance where failure is observed, the time delay between dispatching the READ0 command and the start of read operation is violated. (udelay loop would start even before the write is reflected on the HW)
> 
> OMAP3EVM implementation relies on command delay(chip_delay set to 50ms) and doesn't use wait pin monitoring. By adding a data memory barrier dmb() instruction right after the command phase the issue seems to be resolved.
> 
> Have we seen similar behavior on other platforms that rely on command delay and do we specifically require a dmb() after the command is written?
> 
> DIFF Details:(will post this a patch once I hear your review comments)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 2211386..8df3780 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -651,6 +651,7 @@ static void nand_command_lp(struct mtd_info *mtd, unsigned int command,
>                                NAND_NCE | NAND_CLE | NAND_CTRL_CHANGE);
>                 chip->cmd_ctrl(mtd, NAND_CMD_NONE,
>                                NAND_NCE | NAND_CTRL_CHANGE);
> +               dmb();

Did you try using 'wmb()' instead? Not 100% sure, but it looks like the
barrier you need. However, if you read
'Documentation/memory-barriers.txt', you will probably find the right
way to go.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
