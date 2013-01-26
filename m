From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 26 Jan 2013 17:49:29 +0800
Subject: [PATCH 11/19] regmap: avoid undefined return from
 regmap_read_debugfs
In-Reply-To: <201301260917.28028.arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359123276-15833-12-git-send-email-arnd@arndb.de>
 <20130126044219.GA10580@opensource.wolfsonmicro.com>
 <201301260917.28028.arnd@arndb.de>
Message-ID: <20130126094855.GI30594@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 09:17:27AM +0000, Arnd Bergmann wrote:
> On Saturday 26 January 2013, Mark Brown wrote:
> > On Fri, Jan 25, 2013 at 02:14:28PM +0000, Arnd Bergmann wrote:

> > > Gcc warns about the case where regmap_read_debugfs tries

> > Are you sure about that function name?

> Yes, regmap_read_debugfs uses the return value from
> regmap_debugfs_get_dump_start, for which gcc found
> a path that returns the uninitialized value.

> > > to walk an empty map->debugfs_off_cache list, which results
> > > in uninitialized variable getting returned.

This is the bit that makes me think you're talking about the wrong
function - regmap_debugfs_read() never looks at the off_cache list.

> > > Setting this variable to 0 first avoids the warning and
> > > the potentially undefined value.

> > This probably won't apply against current code as there's already a
> > better fix there, in general just picking a value to initialise masks
> > errors.

> I agree on the general rule not to do this, and I'm trying to avoid it
> in the cases where I can find a better fix, but here I could not
> (mostly because I could not figure out what this code actually
> does. Thanks for taking a look.

> Which code is the current version? Is your fix headed for 3.8 inclusion?

It's all in mainline already.

> I still see the warning in 3.8-rc5 as well as yesterday's linux-next,
> with gcc-4.6, 4.7 and 4.8-pre.

Oh, ffs.  This is a false positive from the compiler - there is no case
where it can actually do this as we will bail out before the walk if the
list is empty so we'll always take at least one trip through our
list_for_each_entry() and either return or set ret.  It should be smart
enough to work out that the list_empty() means list_for_each_entry()
will iterate over at least one entry or more conservative in what it
warns about.

In any case, your change will break things - this is an example of why
just picking a random value to assign is unhelpful.  You'd need to
return base to avoid confusing the callers but even then doing it at the
start of the function is overkill, it excludes a bunch of paths.  I
guess we can work around it by putting a redundant assignment of pos and
ret before the loop :/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130126/252c1e41/attachment.sig>
