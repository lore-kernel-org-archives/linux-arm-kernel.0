From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Jan 2014 17:31:37 +0000
Subject: [RFC 07/18] regmap: debugfs: Always create "registers" &
 "access" files
In-Reply-To: <20131224121912.GX30815@sirena.org.uk>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-8-git-send-email-pawel.moll@arm.com>
 <20131224121912.GX30815@sirena.org.uk>
Message-ID: <1389202297.23721.33.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-24 at 12:19 +0000, Mark Brown wrote:
> On Mon, Dec 23, 2013 at 04:23:39PM +0000, Pawel Moll wrote:
> > When a map covers a single register, max_register is equal
> > to 0, so the "registers" & "access" files were not created.
> > 
> > This patch is removing this restriction. It should be save,
> > as the maps not without register 0 should return false
> > for regmap_readable(map, 0).
> 
> No, we need to find a better way of doing this such as checking to see
> if register zero is accessible in some way.  We want to avoid having
> those files if there's no way of populating them since this is useful
> information for tooling.

Something like this then?

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index c5471cd..45d812c 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -511,7 +511,7 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	debugfs_create_file("range", 0400, map->debugfs,
 			    map, &regmap_reg_ranges_fops);
 
-	if (map->max_register) {
+	if (map->max_register || regmap_readable(map, 0)) {
 		debugfs_create_file("registers", 0400, map->debugfs,
 				    map, &regmap_map_fops);
 		debugfs_create_file("access", 0400, map->debugfs,

Other possibility would be replacing max_register with registers_num,
but it looks a massive job...

Pawe?
