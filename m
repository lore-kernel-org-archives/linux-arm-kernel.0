From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Oct 2016 17:54:28 +0200
Subject: [PATCH] mtd: nand: Add OX820 NAND Support
In-Reply-To: <0f5398bb-52f1-d5bb-834c-dead4f708fd3@baylibre.com>
References: <20161019145523.6763-1-narmstrong@baylibre.com>
 <20161019173704.75592f52@bbrezillon>
 <0f5398bb-52f1-d5bb-834c-dead4f708fd3@baylibre.com>
Message-ID: <20161019175428.6ea3998d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Oct 2016 17:46:01 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> >> +/* Single CS command control */
> >> +static void oxnas_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
> >> +				unsigned int ctrl)
> >> +{
> >> +	struct nand_chip *chip = mtd_to_nand(mtd);
> >> +	struct oxnas_nand *oxnas = nand_get_controller_data(chip);
> >> +
> >> +	if (ctrl & NAND_CTRL_CHANGE) {
> >> +		if (ctrl & NAND_CLE)
> >> +			oxnas->ctrl = OXNAS_NAND_CMD_CLE;
> >> +		else if (ctrl & NAND_ALE)
> >> +			oxnas->ctrl = OXNAS_NAND_CMD_ALE;
> >> +		else
> >> +			oxnas->ctrl = 0;
> >> +	}
> >> +
> >> +	if (cmd != NAND_CMD_NONE)
> >> +		writeb(cmd, oxnas->io_base + oxnas->ctrl);  
> > 
> > There's no need to test the NAND_CTRL_CHANGE here, and I don't think
> > the CLE or ALE flag is ever set when cmd == CMD_NONE. So, you can kill
> > the ->ctrl field and simply do:
> > 
> > 	if (ctrl & NAND_CLE)
> > 		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_CLE);
> > 	else if (ctrl & NAND_ALE)
> > 		writeb(cmd, oxnas->io_base + OXNAS_NAND_CMD_ALE);
> >   
> >> +}  
> 
> Hmm, except it's needed back in the oxnas_nand_write_buf() call (don't ask me why)
> so I don't see how to simplify more this function.

Are you sure? Can you add a WARN(oxnas->ctrl) in oxnas_nand_write_buf()
to check if it's ever the case? I'm almost sure there is a call to
->cmd_ctrl() with none of the CLE and ALE flags set before the
->write_buf() call.
