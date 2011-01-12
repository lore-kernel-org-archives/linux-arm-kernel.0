From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 12 Jan 2011 09:11:47 +0100
Subject: [PATCH v2] ARM: Change misleading warning when
	CONFIG_CMDLINE_FORCE is used
In-Reply-To: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
References: <1294789556-3870-1-git-send-email-holler@ahsoftware.de>
Message-ID: <20110112081147.GA24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 12, 2011 at 12:45:56AM +0100, Alexander Holler wrote:
> When CONFIG_CMDLINE_FORCE is used, the warning
> 
>   Ignoring unrecognised tag 0x54410009
> 
> was displayed. Change this to
> 
>   Ignoring tag cmdline (using the default kernel command line)
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>  arch/arm/kernel/setup.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 336f14e..eed2425 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -649,15 +649,17 @@ static int __init parse_tag_revision(const struct tag *tag)
>  
>  __tagtable(ATAG_REVISION, parse_tag_revision);
>  
> -#ifndef CONFIG_CMDLINE_FORCE
>  static int __init parse_tag_cmdline(const struct tag *tag)
>  {
> +#ifndef CONFIG_CMDLINE_FORCE
>  	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
> +#else
> +	pr_warning("Ignoring tag cmdline (using the default kernel command line)\n");
> +#endif /* CONFIG_CMDLINE_FORCE */
Does it make sense at all to disable CONFIG_CMDLINE_FORCE?  If not, I
suggest to remove it.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
