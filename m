From: james.morse@arm.com (James Morse)
Date: Wed, 14 Dec 2016 11:16:07 +0000
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
Message-ID: <585129F7.6070704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 14/12/16 09:38, Pratyush Anand wrote:
> On Saturday 26 November 2016 12:00 AM, James Morse wrote:
>> On 22/11/16 04:32, Pratyush Anand wrote:
>>> This patch adds support to enable/disable d-cache, which can be used for
>>> faster purgatory sha256 verification.
>>
>> (I'm not clear why we want the sha256, but that is being discussed elsewhere on
>>  the thread)
>>
>>
>>> We are supporting only 4K and 64K page sizes. This code will not work if a
>>> hardware is not supporting at least one of these page sizes.  Therefore,
>>> D-cache is disabled by default and enabled only when "enable-dcache" is
>>> passed to the kexec().
>>
>> I don't think the maybe-4K/maybe-64K/maybe-neither logic is needed. It would be
>> a lot simpler to only support one page size, which should be 4K as that is what
>> UEFI requires. (If there are CPUs that only support one size, I bet its 4K!)
> 
> Ok.. So, I will implement a new version after considering that 4K will always be
> supported. If 4K is not supported by hw(which is very unlikely) then there would
> be no d-cache enabling feature.

Sounds good tom me. I think its important to keep the purgatory code as small
and as simple as possible as its very hard to debug. If we do get bug reports
they are likely to be 'it didn't nothing', with no further details. If it only
fails on some platform we don't have access to its basically impossible.


>> I would go as far as to generate the page tables at 'kexec -l' time, and only if
> 
> Ok..So you mean that I create a new section which will have page table entries
> mapping physicalmemory represented by remaining section, and then purgatory can
> just enable mmu with page table from that section, right? Seems doable. can do
> that.
> 
>> '/sys/firmware/efi' exists to indicate we booted via UEFI. (and therefore must
>> support 4K pages). This would keep the purgatory code as simple as possible.
> 
> What about reading ID_AA64MMFR0_EL1 instead of /sys/firmware/efi? That can also
> tell us that whether 4K is supported or not?

If you're doing it at EL1/EL2 in the purgatory code, sure. But if you generate
the page tables at 'kexec -l' time you can't read this register from EL0 so you
need another way to guess if 4K pages are supported (or just assume they are and
test that register once you're in purgatory).

I was looking for some way to print a message at 'kexec -l' time that the sha256
would be slow as 4K wasn't supported. (a message printed at any other time won't
get seen).


>>> +/*
>>> + *    disable_dcache: Disable D-cache and flush RAM locations
>>> + *    ram_start - Start address of RAM
>>> + *    ram_end - End address of RAM
>>> + */
>>> +void disable_dcache(uint64_t ram_start, uint64_t ram_end)
>>> +{
>>> +    switch(get_current_el()) {
>>> +    case 2:
>>> +        reset_sctlr_el2();
>>> +        break;
>>> +    case 1:
>>> +        reset_sctlr_el1();
>>
>> You have C code running between disabling the MMU and cleaning the cache. The
>> compiler is allowed to move data on and off the stack in here, but after
>> disabling the MMU it will see whatever was on the stack before we turned the MMU
>> on. Any data written at the beginning of this function is left in the caches.
>>
>> I'm afraid this sort of stuff needs to be done in assembly!
> 
> All these routines are self coded in assembly even though they are called
> from C, so should be safe I think. Anyway, I can keep all of them in
> assembly as well.

You can't tell the compiler that the stack data is inaccessible until the dcache
clean call completes. Some future version may do really crazy things in here.
You can decompile what your compiler version produces to check it doesn't
load/store to the stack, but that doesn't mean my compiler version does the
same. This is the kind of thing that is extremely difficult to debug, its best
not to take the risk.


Thanks,

James
