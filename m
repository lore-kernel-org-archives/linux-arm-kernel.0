From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 20 Jul 2015 11:08:47 -0700
Subject: [PATCH v5 07/12] mtd: nand: add Samsung K9GBG08U0A-M to nand_ids
 table
In-Reply-To: <55621B83.4040909@vanguardiasur.com.ar>
References: <1431356341-31640-1-git-send-email-antoine.tenart@free-electrons.com>
 <1431356341-31640-8-git-send-email-antoine.tenart@free-electrons.com>
 <555792FC.8030407@vanguardiasur.com.ar>
 <20150520140631.GN22054@kwain>
 <555C9584.1030609@vanguardiasur.com.ar>
 <20150520142409.GP22054@kwain> <20150520144341.GQ22054@kwain>
 <55621B83.4040909@vanguardiasur.com.ar>
Message-ID: <20150720180847.GH24125@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

On Sun, May 24, 2015 at 03:42:11PM -0300, Ezequiel Garcia wrote:
> On 05/20/2015 11:43 AM, Antoine Tenart wrote:
> [..]
> >>
> >> I just had a look on the datasheet, and I you're right, the nand should
> >> support JDEC. However I get a "No NAND device found" error when
> >> reverting this patch.
> >>
> >> It seems nand_flash_detect_jedec() is not reading "JDEC" and is returning
> >> directly. I'm having a look at this.
> > 
> > So, I can read 'J', 'E', 'D' and 'E' but then I got 0xff's. So I tried
> > to only check of JEDE in nand_flash_detect_jedec() but the JEDEC
> > parameter page was then not valid.
> > 
> 
> This uncovers two different bugs in the driver.
> 
> 1. read_id_bytes is either '2' or '4', but JEDEC detections needs at
> least 5 bytes.
> 
> 2. The initial buffer (to read the ID and the parameter page) has
> 256 bytes, but the JEDEC parameter page is 512-bytes.
> 
> And while at it, the driver doesn't seem to support reading the
> redundant parameter pages (recently reported on barebox ML [1]). So this
> is a third bug.
> 
> Would you try setting read_id_bytes to '5' and also increasing the READ_PARAM
> transfer length? Something like this:

I'm trying to parse through the latest pxa3xx_nand patches, and I'm a
bit lost. Did this piece get dropped on the floor?

At any rate, it looks like there are a few more things to fix in
Antoine's latest work, so I can't quite take them. Correct me if I'm
misunderstanding.

Thanks,
Brian

> diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
> index 1259cc5..851372f 100644
> --- a/drivers/mtd/nand/pxa3xx_nand.c
> +++ b/drivers/mtd/nand/pxa3xx_nand.c
> @@ -48,7 +48,7 @@
>   * STATUS, READID and PARAM. The largest of these is the PARAM command,
>   * needing 256 bytes.
>   */
> -#define INIT_BUFFER_SIZE	256
> +#define INIT_BUFFER_SIZE	2048
>  
>  /* registers and bit definitions */
>  #define NDCR		(0x00) /* Control register */
> @@ -899,18 +899,18 @@ static int prepare_set_command(struct pxa3xx_nand_info *info, int command,
>  		break;
>  
>  	case NAND_CMD_PARAM:
> -		info->buf_count = 256;
> +		info->buf_count = 2048;
>  		info->ndcb0 |= NDCB0_CMD_TYPE(0)
>  				| NDCB0_ADDR_CYC(1)
>  				| NDCB0_LEN_OVRD
>  				| command;
>  		info->ndcb1 = (column & 0xFF);
> -		info->ndcb3 = 256;
> -		info->data_size = 256;
> +		info->ndcb3 = 2048;
> +		info->data_size = 2048;
>  		break;
> 
> [1] http://lists.infradead.org/pipermail/barebox/2015-May/023515.html
> 
