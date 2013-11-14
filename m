From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 14 Nov 2013 14:25:54 -0800
Subject: [PATCH v5 09/14] mtd: nand: pxa3xx: Move the data buffer clean
 to prepare_start_command()
In-Reply-To: <1384464339-6817-10-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1384464339-6817-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1384464339-6817-10-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131114222554.GT9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 06:25:34PM -0300, Ezequiel Garcia wrote:
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -633,6 +636,19 @@ static void prepare_start_command(struct pxa3xx_nand_info *info, int command)
>  		info->ndcb2 = 0;
>  		break;
>  	}
> +
> +	/*
> +	 * If we are about to isse a read command, or about to set

s/isse/issue/

> +	 * the write address, then clean the data buffer.
> +	 */
> +	if (command == NAND_CMD_READ0 ||
> +	    command == NAND_CMD_READOOB ||
> +	    command == NAND_CMD_SEQIN) {
> +

Superfluous blank line?

> +		info->buf_count = mtd->writesize + mtd->oobsize;
> +		memset(info->data_buff, 0xFF, info->buf_count);
> +	}
> +
>  }
>  
>  static int prepare_set_command(struct pxa3xx_nand_info *info, int command,

I'll make these changes myself, if I take the series. The rest of the
series is looking good so far (up to this point), so it's not worth a
respin.

Brian
