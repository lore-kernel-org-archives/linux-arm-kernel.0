From: viresh.linux@gmail.com (viresh kumar)
Date: Sat, 12 Feb 2011 21:45:45 +0530
Subject: reboot not working on linux-2.6.37 for ARMv7
In-Reply-To: <20110211120305.GD23404@n2100.arm.linux.org.uk>
References: <AANLkTi=FCJr-0aF0LG92PC4Q7J4R5PDU7xobnvCgDHy8@mail.gmail.com>
	<20110211120305.GD23404@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikvBRJyDJb4=puFzbTCXNYGSEXDRkAZ=1PZuneD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/11/11, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Feb 11, 2011 at 05:01:06PM +0530, shiraz hashim wrote:
>> I am using linux-2.6.37 on our ARM Cortex A9 (dual core) SMP platform
>> with PL310 as Level 2 cache. We observe that on reboot the control
>> is not able to reach to the arch_reset.
>>
>> The problem happens when L1 cache is disabled in
>> arm_machine_restart, through cpu_proc_fin() and L2 cache is flushed.
>
> Where's the L2 cache flush?  The sequence is:
>
>         /* Clean and invalidate caches */
>         flush_cache_all();
>         /* Turn off caching */
>         cpu_proc_fin();
>         /* Push out any further dirty data, and ensure cache is empty */
>         flush_cache_all();
>
> and flush_cache_all() calls v7_flush_kern_cache_all() in
> arch/arm/mm/cache-v7.S.
>
> I do hope you're not modifying flush_cache_all() to also call the L2
> cache functions because that's wrong.
>

Russell,

We are not modifying flush_cache_all. L2 cache is not flushed from there.
Actually as soon as L1 Cache is flushed and disabled, spin_lock is taken from
some other thread. This creates problem for our platform, as we do not have
monitors support at L2 thus failing strex instruction.

If we disable L2 then reboot works fine, as expected.

--
viresh
