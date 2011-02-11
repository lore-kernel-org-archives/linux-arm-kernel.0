From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 12:03:05 +0000
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
Message-ID: <20110211120305.GD23404@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 05:01:06PM +0530, shiraz hashim wrote:
> Hi,
> 
> I am using linux-2.6.37 on our ARM Cortex A9 (dual core) SMP platform
> with PL310 as Level 2 cache. We observe that on reboot the control
> is not able to reach to the arch_reset.
> 
> The problem happens when L1 cache is disabled in
> arm_machine_restart, through cpu_proc_fin() and L2 cache is flushed.

Where's the L2 cache flush?  The sequence is:

        /* Clean and invalidate caches */
        flush_cache_all();
        /* Turn off caching */
        cpu_proc_fin();
        /* Push out any further dirty data, and ensure cache is empty */
        flush_cache_all();

and flush_cache_all() calls v7_flush_kern_cache_all() in
arch/arm/mm/cache-v7.S.

I do hope you're not modifying flush_cache_all() to also call the L2
cache functions because that's wrong.
