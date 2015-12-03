From: dcashman@android.com (Daniel Cashman)
Date: Thu, 3 Dec 2015 08:12:32 -0800
Subject: [PATCH v5 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <20151203121712.GE11337@arm.com>
References: <1449000658-11475-1-git-send-email-dcashman@android.com>
 <1449000658-11475-2-git-send-email-dcashman@android.com>
 <1449000658-11475-3-git-send-email-dcashman@android.com>
 <1449000658-11475-4-git-send-email-dcashman@android.com>
 <20151203121712.GE11337@arm.com>
Message-ID: <566069F0.3060409@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/3/15 4:17 AM, Will Deacon wrote:
>> +	select HAVE_ARCH_MMAP_RND_BITS if MMU
>> +	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if MMU && COMPAT
> 
> You can drop the 'if MMU' bits, since we don't support !MMU on arm64.

Ok, will do. I was a little uneasy leaving it implicit, but even if
something w/out MMU on arm64 shows up, it'll easily be corrected.

>> +config ARCH_MMAP_RND_BITS_MIN
>> +       default 15 if ARM64_64K_PAGES
>> +       default 17 if ARM64_16K_PAGES
>> +       default 19
> 
> Is this correct? We currently have a mask of 0x3ffff, so that's 18 bits.

Off-by-one errors provide a good example of why hardening features are
useful? =/ Will change.

>> +config ARCH_MMAP_RND_BITS_MAX
>> +       default 19 if ARM64_VA_BITS=36
>> +       default 20 if ARM64_64K_PAGES && ARM64_VA_BITS=39
>> +       default 22 if ARM64_16K_PAGES && ARM64_VA_BITS=39
>> +       default 24 if ARM64_VA_BITS=39
>> +       default 23 if ARM64_64K_PAGES && ARM64_VA_BITS=42
>> +       default 25 if ARM64_16K_PAGES && ARM64_VA_BITS=42
>> +       default 27 if ARM64_VA_BITS=42
>> +       default 30 if ARM64_VA_BITS=47
>> +       default 29 if ARM64_64K_PAGES && ARM64_VA_BITS=48
>> +       default 31 if ARM64_16K_PAGES && ARM64_VA_BITS=48
>> +       default 33 if ARM64_VA_BITS=48
>> +       default 15 if ARM64_64K_PAGES
>> +       default 17 if ARM64_16K_PAGES
>> +       default 19
> 
> Could you add a comment above this with the formula
> (VA_BITS - PAGE_SHIFT - 3), please, so that we can update this easily in
> the future if we need to?
> 
Yes, seems reasonable.  Time will tell if this remains true for all
architectures, or even here, but it would be good to document it where
someone considering a change could easily find it.

Thank You,
Dan
