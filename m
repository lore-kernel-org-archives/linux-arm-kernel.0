From: ghackmann@google.com (Greg Hackmann)
Date: Wed, 15 Aug 2018 12:30:19 -0700
Subject: [PATCH] arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()
In-Reply-To: <20180814152958.GD567@arm.com>
References: <20180813193013.236362-1-ghackmann@google.com>
 <20180814104041.GB28664@arm.com>
 <eb90a28e-893c-e02e-a9c2-1d988f08cf3a@google.com>
 <20180814152958.GD567@arm.com>
Message-ID: <e5585e80-8c5a-fd39-adc2-3eccd42cae07@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2018 08:29 AM, Will Deacon wrote:
> On Tue, Aug 14, 2018 at 08:17:48AM -0700, Greg Hackmann wrote:
>> On 08/14/2018 03:40 AM, Will Deacon wrote:
>>> Hi Greg,
>>>
>>> On Mon, Aug 13, 2018 at 12:30:11PM -0700, Greg Hackmann wrote:
>>>> ARM64's pfn_valid() shifts away the upper PAGE_SHIFT bits of the input
>>>> before seeing if the PFN is valid.  This leads to false positives when
>>>> some of the upper bits are set, but the lower bits match a valid PFN.
>>>>
>>>> For example, the following userspace code looks up a bogus entry in
>>>> /proc/kpageflags:
>>>>
>>>>     int pagemap = open("/proc/self/pagemap", O_RDONLY);
>>>>     int pageflags = open("/proc/kpageflags", O_RDONLY);
>>>>     uint64_t pfn, val;
>>>>
>>>>     lseek64(pagemap, [...], SEEK_SET);
>>>>     read(pagemap, &pfn, sizeof(pfn));
>>>>     if (pfn & (1UL << 63)) {        /* valid PFN */
>>>>         pfn &= ((1UL << 55) - 1);   /* clear flag bits */
>>>>         pfn |= (1UL << 55);
>>>>         lseek64(pageflags, pfn * sizeof(uint64_t), SEEK_SET);
>>>>         read(pageflags, &val, sizeof(val));
>>>>     }
>>>>
>>>> On ARM64 this causes the userspace process to crash with SIGSEGV rather
>>>> than reading (1 << KPF_NOPAGE).  kpageflags_read() treats the offset as
>>>> valid, and stable_page_flags() will try to access an address between the
>>>> user and kernel address ranges.
>>>>
>>>> Signed-off-by: Greg Hackmann <ghackmann@google.com>
>>>> ---
>>>>  arch/arm64/mm/init.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> Thanks, this looks like a sensible fix to me. Do you think it warrants a
>>> CC stable?
>>>
>>> Will
>>
>> Yes, I think so.  Should I resend with a "Fixes" field?
> 
> Could do, but I think this goes all the way back to day 1! Doesn't arch/arm/
> also suffer from the same issue?
> 
> Will
> 

Yeah, it looks like this happens on non-LPAE 32-bit kernels too.  LPAE
kernels aren't affected since __pfn_to_phys() promotes to a 64-bit type.

I can submit a fix for that too while I'm at it.
