From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 2 Mar 2017 16:46:58 +0000
Subject: [PATCH] arm64: restore get_current() optimisation
In-Reply-To: <086dff0b-126d-b5b7-e877-d3d46efce618@nvidia.com>
References: <1483468021-8237-1-git-send-email-mark.rutland@arm.com>
 <ee26a4f0-e3e9-fb44-fe7c-c40a15c33b38@nvidia.com>
 <20170302123507.GD19632@leverpostej>
 <086dff0b-126d-b5b7-e877-d3d46efce618@nvidia.com>
Message-ID: <20170302164654.GP19632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 03:30:26PM +0000, Jon Hunter wrote:
> On 02/03/17 12:35, Mark Rutland wrote:
> > On Thu, Mar 02, 2017 at 11:35:06AM +0000, Jon Hunter wrote:
> >> On 03/01/17 18:27, Mark Rutland wrote:

> >> I noticed that with v4.10 I am seeing the following panic ...

> This is with Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4. I have also tried ...
> 
> gcc version 5.3.1 20160412 (Linaro GCC 5.3-2016.05) 
> gcc version 6.2.1 20161016 (Linaro GCC 6.2-2016.11)
> 
> ... and see the same panic.

So far I've been testing with the Linaro 15.08 toolchain; I'll give
these a go.

[...]

> >> [  184.566458] PC is at regcache_flat_read+0x14/0x20
> >> [  184.571155] LR is at regcache_read+0x50/0x78
> >> [  184.575417] pc : [<ffff0000085d0c6c>] lr : [<ffff0000085cefa8>] pstate: 400001c5
> > 
> > Judging by the PC, that read could be any of:
> > 
> > * the read of map->cache at the start of regcache_flat_read()
> > 
> > * an inlined regcache_get_index_by_order()'s read of map->reg_stride_order
> > 
> > * the read of cache[regcache_flat_get_index(map, reg)]
> > 
> > ... so it seems either map or map->cache is dodgy.
> > 
> > If you're can addr2line that PC, that should tell us which access is
> > blowing up, and therefore which pointer is dodgy.
> > 
> > We'll want the full output considering inlined functions, i.e.
> > 
> > ${CROSS_COMPILE}addr2line -ife vmlinux 0xffff0000085d0c6c
> 
> This shows ...
> 
> regcache_flat_read
> /home/jonathanh/workdir/tegra/korg-linux.git/drivers/base/regmap/regcache-flat.c:60

Ok, so it appears that either map->cache is dodgy, or the reg passed to
regcache_flat_read() is bogus, and we end up generating a cache index
that is well out of bounds.

Perhaps a caller is deriving that from an uninitialised variable? The
code and stack layout changes as a result of my patch could easily
tickle that.

I'm not at all familiar with regmap, but IIUC we can catch that with:

---->8----
diff --git a/drivers/base/regmap/regcache-flat.c b/drivers/base/regmap/regcache-flat.c
index 4d2e50b..2d42c01 100644
--- a/drivers/base/regmap/regcache-flat.c
+++ b/drivers/base/regmap/regcache-flat.c
@@ -57,6 +57,8 @@ static int regcache_flat_read(struct regmap *map,
 {
        unsigned int *cache = map->cache;
 
+       BUG_ON(reg > map->max_register);
+
        *value = cache[regcache_flat_get_index(map, reg)];
 
        return 0;
---->8----

> > If the commit in question is resulting in get_current() behaving differently,
> > it *might* be possible to detect with the hack below. I haven't seen it blow up
> > on my test systems.
> 
> Unfortunately, that did not catch it :-(

That would seem to imply that get_current() is returning the right value.

So, I'd suspect that we've uncovered a latent bug elsewhere.

If the reg index isn't out-of-bounds, it would imply that either the
regmap data is getting corrupted somewhere, or it isn't initialised
correctly.

Can we log when the regmap and regcache in question are initialised,
dumping their addresses? That way we can see if they're getting
clobbered behind our backs.

> > Otherwise, it might be worth giving KASAN a go; that might detect data
> > corruption. If you have a recent enough toolchain, you only need enable
> > CONFIG_KASAN. This will make your kernel Image a fair amount larger.
> 
> I enabled this with gcc 6.2.1 but now the PC is at __asan_load4 ...

That's expected if the dodgy address is sufficiently dodgy, so we can ignore
this. KASAN has a shadow of all mapped memory, and if you try to access
something that falls outside of mapped memory it can also fall outside
of the mapped shadow.

KASAN didn't detect anything before that, so it's unlikely to help us
here.

Thanks,
Mark.
