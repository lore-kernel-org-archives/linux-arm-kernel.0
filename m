From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 17 Mar 2017 14:00:53 +0000
Subject: [PATCH] arm: Fix text patching via fixmap with virtually tagged
 D-caches
In-Reply-To: <20170317120458.GC21222@n2100.armlinux.org.uk>
References: <20170316133609.22679-1-tixy@linaro.org>
 <20170317120458.GC21222@n2100.armlinux.org.uk>
Message-ID: <1489759253.3063.5.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 12:04 +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 16, 2017 at 01:36:09PM +0000, Jon Medhurst wrote:
> > When __patch_text_real changes an instruction via a fixmap on systems
> > with a virtually tagged cache, there may still be a stale entry in the
> > data cache for the real instruction address. Fix this by also flushing
> > the cache at that address.
> 
> The flush_icache_range() function cleans the data cache, and invalidates
> the instruction cache so that the new instruction is visible to the
> instruction path, but leaves the data visible in the data cache.
> 
> > One consequence of this issue is that if a kprobe is added then removed,
> > the D-cache may still hold the breakpoint instruction from when the
> > probe was active. In that situation, when re-inserting the kprobe, the
> > kernel thinks the instruction being probed is a breakpoint instruction
> > and will reject the attempt. This shows up with test failures when
> > enabling CONFIG_ARM_KPROBES_TEST on a device with a Marvel Kirkwood SoC
> > and also enabling CONFIG_STRICT_KERNEL_RWX which triggers the use of
> > fixmaps.
> 
> flush_icache_range() assumes that we write through the same alias that
> the instruction will be executed from.  Since the strict memory
> permissions, and the modifications that this has caused, this simply is
> no longer true.
> 
> I wonder whether a better solution would be to change flush_icache_range()
> to flush the data cache for the region instead of merely cleaning it.
> 
> The only performance regression I can think would be that module load
> would end up flushing out all the data cache lines for the module rather
> than just cleaning them, but loading a module is not a fast path so it
> probably doesn't matter.

You'd think that it would be a generally true rule that
loading/modifying kernel code isn't on any kind of performance critical
path. Though some uses of flush_icache_range include the BPF JIT
compiler, and in fncpy() which seems to have a big role in suspend. I
don't know fast they are expected to be, or even if they get much use on
the old CPU's which have virtually indexed d-caches.

Speaking of which, would the practical implementation of getting
flush_icache_range to invalidate the d-cache involve fixing up all the
*_coherent_kern_range functions for the different cache implementations?
That seems to me a little fraught with regression risks given that it
wouldn't be possible to test them all. Also, another consideration is
that quite a few implementations seem to share the same code between
_coherent_user_range and _coherent_kern_range. (I'm a little fuzzy on
how these are used, but would coherent_user_range be used when loading
userside binaries? In which case, the performance regression might be
noticable.

BTW, in looking at uses of flush_icache_range, I spotted at least one
more (set_fiq_handler) that seems to write code to a different virtual
address than it's run from.

-- 
Tixy
