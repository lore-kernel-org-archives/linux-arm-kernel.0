From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 18:00:30 +0000
Subject: [RFC 07/18] regmap: debugfs: Always create "registers" &
 "access" files
In-Reply-To: <1389202297.23721.33.camel@hornet>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-8-git-send-email-pawel.moll@arm.com>
 <20131224121912.GX30815@sirena.org.uk>
 <1389202297.23721.33.camel@hornet>
Message-ID: <20140108180030.GR31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 05:31:37PM +0000, Pawel Moll wrote:
> On Tue, 2013-12-24 at 12:19 +0000, Mark Brown wrote:

> > No, we need to find a better way of doing this such as checking to see
> > if register zero is accessible in some way.  We want to avoid having
> > those files if there's no way of populating them since this is useful
> > information for tooling.

> Something like this then?

> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
> index c5471cd..45d812c 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -511,7 +511,7 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
>  	debugfs_create_file("range", 0400, map->debugfs,
>  			    map, &regmap_reg_ranges_fops);
>  
> -	if (map->max_register) {
> +	if (map->max_register || regmap_readable(map, 0)) {

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/92af00ff/attachment.sig>
