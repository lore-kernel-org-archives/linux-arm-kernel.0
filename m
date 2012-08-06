From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Aug 2012 12:12:24 +0100
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <1343775898-28345-2-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
Message-ID: <20120806111224.GA18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 07:04:37PM -0400, Cyril Chemparathy wrote:
> +static void __init init_patch_kernel(void)
> +{
> +	const void *start = &__patch_table_begin;
> +	const void *end   = &__patch_table_end;
> +
> +	BUG_ON(patch_kernel(start, end - start));
> +	flush_icache_range(init_mm.start_code, init_mm.end_code);

Err.  You are asking the kernel to flush every single cache line
manually throughout the kernel code.  That's a flush every 32-bytes
over maybe a few megabytes of address space.

This is one of the reasons we do the patching in assembly code before
the caches are enabled - so we don't have to worry about the interaction
with the CPU caches, which for this kind of application would be very
expensive.
