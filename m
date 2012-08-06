From: cyril@ti.com (Cyril Chemparathy)
Date: Mon, 6 Aug 2012 09:19:10 -0400
Subject: [PATCH 01/22] ARM: add mechanism for late code patching
In-Reply-To: <20120806111224.GA18957@n2100.arm.linux.org.uk>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-2-git-send-email-cyril@ti.com>
 <20120806111224.GA18957@n2100.arm.linux.org.uk>
Message-ID: <501FC44E.1040806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/6/2012 7:12 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2012 at 07:04:37PM -0400, Cyril Chemparathy wrote:
>> +static void __init init_patch_kernel(void)
>> +{
>> +	const void *start = &__patch_table_begin;
>> +	const void *end   = &__patch_table_end;
>> +
>> +	BUG_ON(patch_kernel(start, end - start));
>> +	flush_icache_range(init_mm.start_code, init_mm.end_code);
>
> Err.  You are asking the kernel to flush every single cache line
> manually throughout the kernel code.  That's a flush every 32-bytes
> over maybe a few megabytes of address space.
>

With a flush_cache_all(), we could avoid having to operate a cacheline 
at a time, but that clobbers way more than necessary.

Maybe the better answer is to flush only the patched cachelines.

> This is one of the reasons we do the patching in assembly code before
> the caches are enabled - so we don't have to worry about the interaction
> with the CPU caches, which for this kind of application would be very
> expensive.
>

Sure, flushing caches is expensive.  But then, so is running the 
patching code with caches disabled.  I guess memory access latencies 
drive the performance trade off here.

-- 
Thanks
- Cyril
