From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Fri, 27 Nov 2015 11:36:30 +0300
Subject: [PATCH v3 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <56561C71.30602@android.com>
References: <1447888808-31571-1-git-send-email-dcashman@android.com>
 <1447888808-31571-2-git-send-email-dcashman@android.com>
 <1447888808-31571-3-git-send-email-dcashman@android.com>
 <1447888808-31571-4-git-send-email-dcashman@android.com>
 <20151123150459.GD4236@arm.com> <56536114.1020305@android.com>
 <20151125120601.GC3109@e104818-lin.cambridge.arm.com>
 <56561C71.30602@android.com>
Message-ID: <CAPAsAGyJr5OD+_4TO9dt2EwOGUGewEy4bAmhFhDbP3RJ+6QxaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-11-25 23:39 GMT+03:00 Daniel Cashman <dcashman@android.com>:
> On 11/25/2015 04:06 AM, Catalin Marinas wrote:
>> On Mon, Nov 23, 2015 at 10:55:16AM -0800, Daniel Cashman wrote:
>>> On 11/23/2015 07:04 AM, Will Deacon wrote:
>>>> On Wed, Nov 18, 2015 at 03:20:07PM -0800, Daniel Cashman wrote:
>>>>> +config ARCH_MMAP_RND_BITS_MAX
>>>>> +       default 20 if ARM64_64K_PAGES && ARCH_VA_BITS=39
>>
>> Where is ARCH_VA_BITS defined? We only have options like
>> ARM64_VA_BITS_39.
>>
>> BTW, we no longer allow the 64K pages and 39-bit VA combination.
>
> It is not, and should have been ARM64_VA_BITS.  This stanza was meant to
> mimic the one for ARM64_VA_BITS.  Thank you for pointing this, and the
> 39-bit combination out.
>
>>>>> +       default 24 if ARCH_VA_BITS=39
>>>>> +       default 23 if ARM64_64K_PAGES && ARCH_VA_BITS=42
>>>>> +       default 27 if ARCH_VA_BITS=42
>>>>> +       default 29 if ARM64_64K_PAGES && ARCH_VA_BITS=48
>>>>> +       default 33 if ARCH_VA_BITS=48
>>>>> +       default 15 if ARM64_64K_PAGES
>>>>> +       default 19
>>>>> +
>>>>> +config ARCH_MMAP_RND_COMPAT_BITS_MIN
>>>>> +       default 7 if ARM64_64K_PAGES
>>>>> +       default 11
>>>>
>>>> FYI: we now support 16k pages too, so this might need updating. It would
>>>> be much nicer if this was somehow computed rather than have the results
>>>> all open-coded like this.
>>>
>>> Yes, I ideally wanted this to be calculated based on the different page
>>> options and VA_BITS (which itself has a similar stanza), but I don't
>>> know how to do that/if it is currently supported in Kconfig. This would
>>> be even more desirable with the addition of 16K_PAGES, as with this
>>> setup we have a combinatorial problem.
>>
>> For KASan, we ended up calculating KASAN_SHADOW_OFFSET in
>> arch/arm64/Makefile. What would the formula be for the above
>> ARCH_MMAP_RND_BITS_MAX?
>
> The general formula I used ended up being:
> _max = floor(log(TASK_SIZE)) - log(PAGE_SIZE) - 3
>

For kasan, we calculate KASAN_SHADOW_OFFSET in Makefile, because we need to use
that value in Makefiles.

For ARCH_MMAP_RND_COMPAT_BITS_MIN/MAX I don't see a reason why it has
to be in Kconfig.
Can't we just use your formula to #define ARCH_MMAP_RND_COMPAT_BITS_*
in some arch header?

> which in the case of arm64 ended up being VA_BITS - PAGE_SHIFT - 3.
> Aside: following this would actually put COMPAT_BITS_MAX at 17 for 4k
> pages, rather than 16, but I left it at 16 to mirror what was put in
> arch/arm/Kconfig.
>
>
> Thank You,
> Dan
>
