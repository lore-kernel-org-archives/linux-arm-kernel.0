From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 Jan 2013 09:59:16 +0000
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <20130126094855.GI30594@opensource.wolfsonmicro.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
 <201301260917.28028.arnd@arndb.de>
 <20130126094855.GI30594@opensource.wolfsonmicro.com>
Message-ID: <20130126095916.GB23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 05:49:29PM +0800, Mark Brown wrote:
> Oh, ffs.  This is a false positive from the compiler - there is no case
> where it can actually do this as we will bail out before the walk if the
> list is empty so we'll always take at least one trip through our
> list_for_each_entry() and either return or set ret.  It should be smart
> enough to work out that the list_empty() means list_for_each_entry()
> will iterate over at least one entry or more conservative in what it
> warns about.

Why not code the function in a way that avoids the problem altogether?

	/*
	 * This should never happen; we return above if we fail to
	 * allocate and we should never be in this code if there are
	 * no registers at all.
	 */
-	if (list_empty(&map->debugfs_off_cache)) {
-		WARN_ON(list_empty(&map->debugfs_off_cache));
-		return base;
-	}
+	WARN_ON(list_empty(&map->debugfs_off_cache));
+	ret = base;

	/* Find the relevant block */
	list_for_each_entry(c, &map->debugfs_off_cache, list) {
		if (from >= c->min && from <= c->max) {
			*pos = c->min;
			return c->base_reg;
		}

		*pos = c->min;
		ret = c->base_reg;
	}

	return ret;
