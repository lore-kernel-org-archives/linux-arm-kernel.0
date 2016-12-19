From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 19 Dec 2016 22:53:02 +0100
Subject: [PATCH] ARM: dts: imx: Pass an empty 'chosen' node
In-Reply-To: <CAOMZO5Be3f4YmGO0FJbeGZO55CJd9P9QO28SfhPLYuivtSHk7w@mail.gmail.com>
References: <1482161298-32624-1-git-send-email-fabio.estevam@nxp.com>
 <20161219184130.o2dpr7lie256hq76@pengutronix.de>
 <CAOMZO5Be3f4YmGO0FJbeGZO55CJd9P9QO28SfhPLYuivtSHk7w@mail.gmail.com>
Message-ID: <20161219215302.zthpc23hqm7375dx@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 07:30:25PM -0200, Fabio Estevam wrote:
> Hi Uwe,
> 
> On Mon, Dec 19, 2016 at 4:41 PM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > wouldn't it be better to fix the decompressor code to eventually create
> > the /chosen node when it doesn't exist?
> 
> Thanks for the suggestion.
> 
> I don't have a Barebox setup handy, but would the following change fix
> it as you propose?
> 
> --- a/arch/arm/boot/compressed/atags_to_fdt.c
> +++ b/arch/arm/boot/compressed/atags_to_fdt.c
> @@ -66,13 +66,21 @@ static uint32_t get_cell_size(const void *fdt)
>         return cell_size;
>  }
> 
> -static void merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
> +static int merge_fdt_bootargs(void *fdt, const char *fdt_cmdline)
>  {
>         char cmdline[COMMAND_LINE_SIZE];
>         const char *fdt_bootargs;
>         char *ptr = cmdline;
> +       int chosen_off;
>         int len = 0;
> 
> +       /* find or add chosen node */
> +       chosen_off = fdt_path_offset(fdt, "/chosen");
> +       if (chosen_off == -FDT_ERR_NOTFOUND)
> +               chosen_off = fdt_add_subnode(fdt, 0, "chosen");
> +       if (chosen_off < 0)
> +               return chosen_off;

I would have done:

	ret = fdt_add_subnode(fdt, 0, "chosen")
	if (ret < 0 && ret != -FDT_ERR_EXISTS)
		return -ESOMETHING;

but I don't have the right machine@hand. Will check tomorrow.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
