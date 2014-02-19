From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Feb 2014 09:02:34 +0000
Subject: [PATCH v4 00/12] arm/arm64: KVM: host cache maintenance when
 guest caches are off
In-Reply-To: <CAG7+5M3nBfX7qfq9d6Cvrpk2YeoHsy1yG0PjmTspa6zqQvUsXg@mail.gmail.com>
References: <1392737253-10480-1-git-send-email-marc.zyngier@arm.com>
 <CAG7+5M3nBfX7qfq9d6Cvrpk2YeoHsy1yG0PjmTspa6zqQvUsXg@mail.gmail.com>
Message-ID: <56ae8a2975cd21765b90d98260862af1@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-02-18 20:57, Eric Northup wrote:
> On Tue, Feb 18, 2014 at 7:27 AM, Marc Zyngier <marc.zyngier@arm.com> 
> wrote:
>>
>> When we run a guest with cache disabled, we don't flush the cache to
>> the Point of Coherency, hence possibly missing bits of data that 
>> have
>> been written in the cache, but have not yet reached memory.
>>
>> We also have the opposite issue: when a guest enables its cache,
>> whatever sits in the cache is suddenly going to become visible,
>> shadowing whatever the guest has written into RAM.
>>
>> There are several approaches to these issues:
>> - Using the DC bit when caches are off: this breaks guests assuming
>>   caches off while doing DMA operations. Bootloaders, for example.
>>   It also breaks the I-D coherency.
>> - Fetch the memory attributes on translation fault, and flush the
>>   cache while handling the fault. This relies on using the PAR_EL1
>>   register to obtain the Stage-1 memory attributes, and tends to be
>>   slow.
>> - Detecting the translation faults occuring with MMU off (and
>>   performing a cache clean), and trapping SCTLR_EL1 to detect the
>>   moment when the guest is turning its caches on (and performing a
>>   cache invalidation). Trapping of SCTLR_EL1 is then disabled to
>>   ensure the best performance.
>
> This will preclude noticing the 2nd .. Nth cache off -> on cycles,
> right?  Will any guests care - doesn't kexec go through a caches-off
> state?

kexec, bootloaders, and whatever firmware requires to switch caches on 
and then off. Guest does care, but we don't have an (efficient) 
architectural solution to that.

The best I can think of so far is a "switch-the-damned-thing-off" 
hypercall that would do the above before returning to the guest.

         M.
-- 
Fast, cheap, reliable. Pick two.
