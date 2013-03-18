From: robherring2@gmail.com (Rob Herring)
Date: Mon, 18 Mar 2013 08:01:58 -0500
Subject: [PATCHv1 0/2] ARM: socfpga: Soft reset, hotplug and device tree
 clocks
In-Reply-To: <20130317181343.GB4394@amd.pavel.ucw.cz>
References: <1363211722-27237-1-git-send-email-dinguyen@altera.com>
 <5141220A.7050008@gmail.com> <20130317181343.GB4394@amd.pavel.ucw.cz>
Message-ID: <51471046.1010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/17/2013 01:13 PM, Pavel Machek wrote:
> Hi!
> 
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Hi Arnd/Olof,
>>>
>>> Just 2 patches for mach-socfpga:
>>>
>>> 0001: ARM: socfpga: Enable hotplug and soft reset
>>> 	- Able to hotplug CPU1 by putting it into reset and bringing back online.
>>>
>>
>> Have you seen the discussion on PSCI? There's an ARM doc on it and
>> Linaro session from last week. Is there a possibility you can use that?
>> You would need to be able to run in non-secure mode and implement
>> smc calls.
> 
> What would be the advantage?

It gets rid of some platform code. If you do an A15 part, it abstracts
out the differences between the cores on entering/exiting coherency. It
should also save you from writing suspend/resume and cpuidle support for
your platform.

Once you do go to an A15, you will have to run in non-secure world. Once
you run in non-secure mode, you cannot do everything within the kernel.
So either you create custom smc calls or you use PSCI. If you really
support secure mode too, then the SOC design should prevent non-secure
accesses to anything that would affect the secure world like powergating
a core or cache.

> We do not have suitable hypervisor at the moment. Nor I see why it
> would be good to push power management into it.

It's not a hypervisor. A minimal implementation is only about 100 lines
of assembly.

> (Plus, the implementation seems pretty incomplete for arm32.).

That's the point. The linux side is simple. The secure monitor side is
also simplified somewhat. When you enter secure monitor mode, you are
automatically running with the cache and mmu off. This avoids the side
effects of cache allocations while trying to flush the caches.

Rob

> 
> 									Pavel
> 
