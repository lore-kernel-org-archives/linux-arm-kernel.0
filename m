From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jun 2014 07:45:07 +0200
Subject: [PATCH] regmap: Fix debugfs-file 'registers' mode
In-Reply-To: <1403961791-15376-1-git-send-email-mpa@pengutronix.de>
References: <1403961791-15376-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140630054507.GX14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Sat, Jun 28, 2014 at 03:23:11PM +0200, Markus Pargmann wrote:
> The macro "REGMAP_ALLOW_WRITE_DEBUGFS" can be used to enable write
minor nit: I'd not call it "macro", but "cpp symbol" because macro
sounds more function-like. (There is another "macro" at the end of the
commit log.)

> support on the registers file in the debugfs. The mode of the file is
> fixed to 0400 so it is not possible to write the file ever.
> 
> This patch fixes the mode by setting it to the correct value depending
> on the macro.
> 
> Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
> 
> Hi,
> 
> as the kconfig option will probably not be merged, I extracted the mode fix of
> my previous patch.
> 
> Regards,
> 
> Markus
> 
>  drivers/base/regmap/regmap-debugfs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index 45d812c0ea77..f45a0a0e0371 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -512,7 +512,14 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
>  			    map, &regmap_reg_ranges_fops);
>  
>  	if (map->max_register || regmap_readable(map, 0)) {
> -		debugfs_create_file("registers", 0400, map->debugfs,
> +		unsigned int registers_mode;
> +
> +		if (IS_ENABLED(REGMAP_ALLOW_WRITE_DEBUGFS))
> +			registers_mode = 0600;
> +		else
> +			registers_mode = 0400;
> +
> +		debugfs_create_file("registers", registers_mode, map->debugfs,
>  				    map, &regmap_map_fops);
debugfs_create_file takes an umode_t as 2nd parameter. Maybe you should
pick that type for registers_mode here, too?

Best regards
Uwe

>  		debugfs_create_file("access", 0400, map->debugfs,
>  				    map, &regmap_access_fops);

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
