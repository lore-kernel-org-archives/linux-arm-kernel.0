From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 05 Dec 2013 15:10:11 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <CAC8NTUUHiaB3m+zmoPPKXTzWq82veNhT4gCERSQiLvKhfMvRyQ@mail.gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <5295D1A5.5090403@arm.com>
 <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
 <5296330D.9010801@arm.com>
 <CAC8NTUVvLgNPdsSPY6Ms_D3JoyJR8AEFRH0=M7-kQEUegNVhKg@mail.gmail.com>
 <CAC8NTUUHiaB3m+zmoPPKXTzWq82veNhT4gCERSQiLvKhfMvRyQ@mail.gmail.com>
Message-ID: <20a7cf05faae55f5787e7a30d7c03860@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-12-05 14:35, Radha Mohan wrote:
> On Thu, Nov 28, 2013 at 7:44 AM, Radha Mohan <mohun106@gmail.com> 
> wrote:
>> On Wed, Nov 27, 2013 at 11:29 PM, Marc Zyngier 
>> <marc.zyngier@arm.com> wrote:
>>> On 27/11/13 15:33, Radha Mohan wrote:
>>>> On Wed, Nov 27, 2013 at 4:34 PM, Marc Zyngier 
>>>> <marc.zyngier@arm.com> wrote:
>>>>> [CC-ing the maintainers - seems odd they were not cc-ed the first 
>>>>> place]
>>>>>
>>>>> On 27/11/13 07:34, mohun106 at gmail.com wrote:
>>>>>> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>>>>>
>>>>>> This patch series provides an implementation of supporting 
>>>>>> 48-bit
>>>>>> Physical Addresses for ARMv8 platforms. It is the maximum width 
>>>>>> that
>>>>>> any ARMv8 based processor can support.
>>>>>>
>>>>>> The implementation extends the existing support of 40-bit PA.The 
>>>>>> kernel
>>>>>> and user space will now be able to access 128TB each. With 4KB 
>>>>>> page size
>>>>>> the Linux now will be using 4 levels of page tables by making 
>>>>>> use of
>>>>>> 'pud'. And with 64KB page size the Linux will be using 3 levels 
>>>>>> of page
>>>>>> tables.
>>>>>>
>>>>>> The code has been tested with LTP.
>>>>>
>>>>> Aside from finding out whether or not this is a useful change, 
>>>>> this
>>>>> breaks KVM, more specifically the way kernel pages are mapped 
>>>>> into HYP.
>>>>> Also, guests will still be limited to 40-bit IPAs, and the 
>>>>> stage-2
>>>>> output range needs to be addressed as well.
>>>>
>>>> This is useful for platforms (like ours) that will use 48-bit PAs.
>>>> Sooner or later there will
>>>> be such processors.
>>>
>>> So should the 4-level page table cost be unconditionally forced 
>>> onto all
>>> implementations?
>>>
>>
>> We can have a kernel compile-time config option so that platforms 
>> having
>> a 48-bit PA can select that option. But having it will create the 
>> code something
>> like below
>>
>> #ifndef CONFIG_ARM64_64KB_PAGES
>> #ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
>> ...
>> ..
>> #else
>> ..
>> ..
>> #endif
>> #else /* !CONFIG_ARM64_64KB_PAGES */
>> #ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
>> ..
>> ..
>> #else
>> ..
>> ..
>> #endif
>> #endif /* CONFIG_ARM64_64KB_PAGES */
>>
>> And we might need to do this at lot of places. Is this ok?
>>
>
> Before going for a next version of patch to fix breaking SMMU and 
> KVM,
> I would like to know  about the best possible implementation.
> Should I go for a compile time option? I am not in favor of this. 
> What
> are options if in future there's 16KB page support in the kernel.
>
> Penalties for platforms that do not have a 48-bit PA are an extra
> lookup and extra memory space for another pagetable. We don't have an
> actual hardware to get an reliable data.
> If someone can try this on a real hardware I would like to know.

This is really a questions for Catalin and Will, but my first approach 
would be that because 3 level page-tables are well understood and 
tested, they should remain the default.

48bit PA system are likely to be rare for quite a while, and that 
leaves us some time to evaluate if we're happy to take the overhead on 
all of the arm64 platforms or not.

Over time, and assuming we grow confident enough about the stability of 
the solution and that the performance hit is within acceptable limits, 
we can look at making it the default. But in my opinion, the basic 
approach should be "this is optional".

Cheers,

         M.
-- 
Fast, cheap, reliable. Pick two.
