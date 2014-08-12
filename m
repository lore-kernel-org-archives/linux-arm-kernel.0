From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Aug 2014 10:34:10 +0100
Subject: [PATCH v3] ARM: zImage: perform cache maintenance after
 relocating code (was: ARM: zImage: add DSB and ISB barriers after
 relocating code)
In-Reply-To: <1407803747-21379-1-git-send-email-marc.ceeeee@gmail.com>
References: <1407803747-21379-1-git-send-email-marc.ceeeee@gmail.com>
Message-ID: <20140812093410.GH30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 11, 2014 at 05:35:47PM -0700, Marc Carino wrote:
> The zImage loader will relocate the kernel image if it determines that
> decompression will overwrite its current location. Since the act of relocation
> is a form of code self-modification, we need to ensure that the CPU fetches
> the updated instruction stream.
> 
> Instead of conditionally executing cache maintenance, this commit ensures that
> cache maintenance is performed in all cases. Besides ensuring coherency with
> the caches and main memory, performing cache maintenance ensures that any
> potentially stale instructions are flushed from the instruction pipeline.

This is not a good idea.  It means that if we fail to create the page
table, we could end up doing some rather expensive cache flushing when
it's not required.

It is simple enough to add a new call into the cache handling code -

cache_barrier:
		mov	r3, #20
		b	call_cache_fn

change PROC_ENTRY_SIZE:

#define PROC_ENTRY_SIZE (5*5)

and then add to each of the proc_types table a new pointer at the bottom
of each entry to do the right thing - you can even set it to point at the
barriers at the end of the cache flushing code for the CPUs which require
it, so it doesn't mean that you have to write lots of new code.

Then you just need to add a call to cache_barrier at the appropriate
point.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
