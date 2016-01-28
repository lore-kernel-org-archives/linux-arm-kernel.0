From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 Jan 2016 18:54:11 +0000 (UTC)
Subject: [PATCH 1/2] ARM: kernel: add support for cpu cache information
References: <1424716091-22914-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <loom.20160128T191752-889@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sudeep Holla <sudeep.holla <at> arm.com> writes:

> 
> This patch adds support for cacheinfo on ARM platforms.
> 
> On ARMv7, the cache hierarchy can be identified through Cache Level ID
> register(CLIDR) while the cache geometry is provided by Cache Size ID
> register(CCSIDR).
> 
> On architecture versions before ARMv7, CLIDR and CCSIDR is not
> implemented. The cache type register(CTR) provides both cache hierarchy
> and geometry if implemented. For implementations that doesn't support
> CTR, we need to list the probable value of CTR if it was implemented
> along with the cpuid for the sake of simplicity to handle them.
> 
> Since the architecture doesn't provide any way of detecting the cpus
> sharing particular cache, device tree is used fo the same purpose.
> On non-DT platforms, first level caches are per-cpu while higher level
> caches are assumed system-wide.
> 
> This is based on the newly introduced generic cacheinfo infrastructure
> through the commit 246246cbde5e ("drivers: base: support cpu cache
> information interface to userspace via sysfs")
> 
> Signed-off-by: Sudeep Holla <sudeep.holla <at> arm.com>
> Tested-by: Stephen Boyd <sboyd <at> codeaurora.org>
> Cc: Russell King <linux <at> arm.linux.org.uk>
> Cc: Will Deacon <will.deacon <at> arm.com>
> Cc: linux-arm-kernel <at> lists.infradead.org
> ---

It does not appear this patch has been merged yet, I gave it a spin on a
Brahma-B15 based system which has a similar cache hierarchy to the
Cortex-A15, and therefore, has no cache properties listed in Device Tree,
since everything is built-in.

This makes cache_setup_of_node() do the following:

[    1.195477] cache_setup_of_node: this_leaf->level = 1
[    1.200543] cache_setup_of_node: this_leaf->level = 1
[    1.205656] cache_setup_of_node: this_leaf->level = 2
[    1.210721] cache_shared_cpu_map_setup: cache_setup_of_node: -2

Removing the last hunk which does this:

        if (index != cache_leaves(cpu)) /* not all OF nodes populated */
                return -ENOENT;

Allows me to browse the cache properties in sysfs, and they seem to be
consistent with what the hardware features.

Should there be some special casing for CPUs which have a built-in cache?
Did we reach an agreement as to whether these patches are worthy being
merged? ARM64 has it now, and at least, for consistency with other
architectures, it would be nice to have this as well.

Thanks!
