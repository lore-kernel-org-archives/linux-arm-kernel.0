From: davem@davemloft.net (David Miller)
Date: Wed, 02 Feb 2011 13:38:31 -0800 (PST)
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <20110202163702.GA23240@n2100.arm.linux.org.uk>
References: <201102021700.20683.arnd@arndb.de>
	<20110202163702.GA23240@n2100.arm.linux.org.uk>
Message-ID: <20110202.133831.193702414.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 2 Feb 2011 16:37:02 +0000

> 1. there's no way to tell GCC that the inline assembly is a load
>    instruction and therefore it needs to schedule the following
>    instructions appropriately.

Just add a dummy '"m" (pointer)' asm input argument to the inline asm
statement.  Just make sure "typeof(pointer)" has a size matching the
size of the load your are performing.

> 2. GCC will needlessly reload pointers from structures and other such
>    behaviour because it can't be told clearly what the inline assembly
>    is doing, so the inline asm needs to have a "memory" clobber.

This behavior is correct, and in fact needed.  Writing to chip registers
can trigger changes to arbitrary main memory locations.

> 3. It seems to misses out using the pre-index addressing, prefering to
>    create add/sub instructions prior to each inline assembly load/store.

Yes, this is indeed a problem.

But you really need that memory clobber there whether you like it or
not, see above.
