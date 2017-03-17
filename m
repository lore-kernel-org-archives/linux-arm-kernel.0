From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Mar 2017 12:04:58 +0000
Subject: [PATCH] arm: Fix text patching via fixmap with virtually tagged
 D-caches
In-Reply-To: <20170316133609.22679-1-tixy@linaro.org>
References: <20170316133609.22679-1-tixy@linaro.org>
Message-ID: <20170317120458.GC21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 01:36:09PM +0000, Jon Medhurst wrote:
> When __patch_text_real changes an instruction via a fixmap on systems
> with a virtually tagged cache, there may still be a stale entry in the
> data cache for the real instruction address. Fix this by also flushing
> the cache at that address.

The flush_icache_range() function cleans the data cache, and invalidates
the instruction cache so that the new instruction is visible to the
instruction path, but leaves the data visible in the data cache.

> One consequence of this issue is that if a kprobe is added then removed,
> the D-cache may still hold the breakpoint instruction from when the
> probe was active. In that situation, when re-inserting the kprobe, the
> kernel thinks the instruction being probed is a breakpoint instruction
> and will reject the attempt. This shows up with test failures when
> enabling CONFIG_ARM_KPROBES_TEST on a device with a Marvel Kirkwood SoC
> and also enabling CONFIG_STRICT_KERNEL_RWX which triggers the use of
> fixmaps.

flush_icache_range() assumes that we write through the same alias that
the instruction will be executed from.  Since the strict memory
permissions, and the modifications that this has caused, this simply is
no longer true.

I wonder whether a better solution would be to change flush_icache_range()
to flush the data cache for the region instead of merely cleaning it.

The only performance regression I can think would be that module load
would end up flushing out all the data cache lines for the module rather
than just cleaning them, but loading a module is not a fast path so it
probably doesn't matter.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
