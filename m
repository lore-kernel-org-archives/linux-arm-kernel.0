From: dcashman@android.com (Daniel Cashman)
Date: Wed, 25 Nov 2015 11:32:53 -0800
Subject: [PATCH v3 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <1448425601.3762.9.camel@ellerman.id.au>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <1447888808-31571-3-git-send-email-dcashman@android.com>
 <1447888808-31571-4-git-send-email-dcashman@android.com>
 <20151123150459.GD4236@arm.com> <56536114.1020305@android.com>
 <1448425601.3762.9.camel@ellerman.id.au>
Message-ID: <56560CE5.3020202@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2015 08:26 PM, Michael Ellerman wrote:
> On Mon, 2015-11-23 at 10:55 -0800, Daniel Cashman wrote:
>> On 11/23/2015 07:04 AM, Will Deacon wrote:
>>> On Wed, Nov 18, 2015 at 03:20:07PM -0800, Daniel Cashman wrote:
>>>> +config ARCH_MMAP_RND_BITS_MAX
>>>> +       default 20 if ARM64_64K_PAGES && ARCH_VA_BITS=39
>>>> +       default 24 if ARCH_VA_BITS=39
>>>> +       default 23 if ARM64_64K_PAGES && ARCH_VA_BITS=42
>>>> +       default 27 if ARCH_VA_BITS=42
>>>> +       default 29 if ARM64_64K_PAGES && ARCH_VA_BITS=48
>>>> +       default 33 if ARCH_VA_BITS=48
>>>> +       default 15 if ARM64_64K_PAGES
>>>> +       default 19
>>>> +
>>>> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>>> +       default 7 if ARM64_64K_PAGES
>>>> +       default 11
>>>
>>> FYI: we now support 16k pages too, so this might need updating. It would
>>> be much nicer if this was somehow computed rather than have the results
>>> all open-coded like this.
>>
>> Yes, I ideally wanted this to be calculated based on the different page
>> options and VA_BITS (which itself has a similar stanza), but I don't
>> know how to do that/if it is currently supported in Kconfig. This would
>> be even more desirable with the addition of 16K_PAGES, as with this
>> setup we have a combinatorial problem.
>>
>> We could move this logic into the code where min/max are initialized,
>> but that would create its own mess, creating new Kconfig values to
>> introduce it in an arch-agnostic way after patch-set v2 moved that to
>> mm/mmap.c instead of arch/${arch}/mm/mmap.c Suggestions welcome.
> 
> 
> Could we instead change the meaning of the mmap_rnd_bits value to be the number
> of address space bits that may be randomised?
> 
> ie. 40 would mean "please randomise in a 1T range", which with PAGE_SIZE=4K
> gives you 28 random bits. etc.
> 
> That would make the value independent of PAGE_SIZE, and only depend on the size
> of the address space.
> 
> It would also mean the values userspace sets and sees don't need to change if the
> kernel PAGE_SIZE changes. (which probably doesn't happen often but still)

This is an intriguing idea. It might actually be more meaningful to a
sysadmin when weighing how high they're willing to go, since it makes
the relation to the address space overall more apparent.  Though the
cost would be more obvious, the benefit would become less-so, as the
amount of entropy used, and thus expected brute-force requirements would
be hidden.  I'll defer to Andrew Morton, as the maintainer, to make this
decision as I think both approaches are valid.

Thank You,
Dan
