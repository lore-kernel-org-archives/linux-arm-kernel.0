From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jan 2013 09:17:27 +0000
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <20130126044219.GA10580@opensource.wolfsonmicro.com>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
Message-ID: <201301260917.28028.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 January 2013, Mark Brown wrote:
> On Fri, Jan 25, 2013 at 02:14:28PM +0000, Arnd Bergmann wrote:
> > Gcc warns about the case where regmap_read_debugfs tries
> 
> Are you sure about that function name?

Yes, regmap_read_debugfs uses the return value from
regmap_debugfs_get_dump_start, for which gcc found
a path that returns the uninitialized value.

> > to walk an empty map->debugfs_off_cache list, which results
> > in uninitialized variable getting returned.
> 
> > Setting this variable to 0 first avoids the warning and
> > the potentially undefined value.
> 
> This probably won't apply against current code as there's already a
> better fix there, in general just picking a value to initialise masks
> errors.

I agree on the general rule not to do this, and I'm trying to avoid it
in the cases where I can find a better fix, but here I could not
(mostly because I could not figure out what this code actually
does. Thanks for taking a look.

Which code is the current version? Is your fix headed for 3.8 inclusion?

I still see the warning in 3.8-rc5 as well as yesterday's linux-next,
with gcc-4.6, 4.7 and 4.8-pre.

	Arnd
