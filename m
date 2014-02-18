From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 14:32:34 +0000
Subject: [BUG] Circular locking dependency - DRM/CMA/MM/hotplug/...
In-Reply-To: <53036D51.2070502@samsung.com>
References: <20140211183543.GK26684@n2100.arm.linux.org.uk>
 <52FB9602.1000805@samsung.com>
 <20140212163317.GQ26684@n2100.arm.linux.org.uk>
 <53036D51.2070502@samsung.com>
Message-ID: <20140218143234.GC21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please learn how to trim emails down to contain only the bits relevant to
your reply, thanks.

On Tue, Feb 18, 2014 at 03:25:21PM +0100, Marek Szyprowski wrote:
> Hello,
>
> On 2014-02-12 17:33, Russell King - ARM Linux wrote:
>> So, the full locking dependency tree is this:
>>
>> CPU0		CPU1		CPU2		CPU3		CPU4
>> dev->struct_mutex (from #0)
>> 		mm->mmap_sem
>> 		dev->struct_mutex (from #5)
>> 				console_lock (from #4)
>> 				mm->mmap_sem
>> 						cpu_hotplug.lock (from #3)
>> 						console_lock
>> 								cma_mutex (from #2, but also from #1)
>> 								cpu_hotplug.lock
>> cma_mutex
>>
>> Which is pretty sick - and I don't think that blaming this solely on V4L2
>> nor DRM is particularly fair.  I believe the onus is on every author of
>> one of those locks involved in that chain needs to re-analyse whether
>> their locking is sane.
>>
>> For instance, what is cma_mutex protecting?  Is it protecting the CMA
>> bitmap?
>
> This lock is protecting CMA bitmap and also serializes all CMA allocations.
> It is required by memory management core to serialize all calls to
> alloc_contig_range() (otherwise page block's migrate types might get
> overwritten). I don't see any other obvious solution for serializing
> alloc_contig_range() calls.

That's unfortunate, because what you're effectively asking is for every
subsystem in the kernel to avoid a complex set of lock dependencies.  It
appears that two subsystems have now hit this, and I wouldn't be
surprised if they weren't the last.

> This will not work correctly if there will be 2 concurrent calls to  
> alloc_contig_range(), which will touch the same memory page blocks.

Can you see any other way to lessen the impact of cma_mutex on the
whole kernel?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
