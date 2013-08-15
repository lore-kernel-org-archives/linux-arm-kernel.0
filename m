From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Aug 2013 16:42:34 +0100
Subject: [PATCH] ARM64: KVM: Fix =?UTF-8?Q?coherent=5Ficache=5Fguest?=
 =?UTF-8?Q?=5Fpage=28=29=20for=20host=20with=20external=20L=33-cache=2E?=
In-Reply-To: <CAAHg+HiYK-kEp6=XTd89UMDOuMyvqgbMm4iDHmvDV7owHga8ug@mail.gmail.com>
References: <1376480832-18705-1-git-send-email-pranavkumar@linaro.org>
 <f8917fe8409b1fae634c7de45e34d4a7@www.loen.fr>
 <CAAhSdy2TctgKk7m48S7jUCMr2dkDoeyT-r=-SMX+_Ce-sUimYA@mail.gmail.com>
 <da83e967f5a266ca28ee54638a4a9be9@www.loen.fr>
 <CAAHg+HiYK-kEp6=XTd89UMDOuMyvqgbMm4iDHmvDV7owHga8ug@mail.gmail.com>
Message-ID: <d2a468fedde1db5aa7b9eb832ae9af0f@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pranav,

On 2013-08-15 09:39, Pranavkumar Sawargaonkar wrote:

[...]

> Just to add few more points to this discussion :
>
> Actually we are already flushing d-cache in 
> "coherent_icache_guest_page"
> by calling flush_icache_range.
>
> Now in my patch i am doing same thing one more time by calling
> __flush_dcache_area just below flush_icache_range.
>
> Main difference between d-cache flushing in above two routines is :
> flush_icache_range is flushing d-cache by point of unification (dc
> cvau) and
>  __flush_dcache_area is flushing that by point of coherency (dc      
> civac).
>
> Now since second routine is doing it by coherency it is making L3C to
> be coherent and sync changes with immediate effect and solving the
> issue.

I understand that. What I object to is that always cleaning to PoC is 
expensive (both in terms of latency and energy), and doing so for each 
page, long after the MMU has been enabled feels like a great loss of 
performance.

My gut feeling is that a single clean operation at startup time 
(whether it is from the kernel or userspace) would be a lot better.

Thanks,

         M.
-- 
Fast, cheap, reliable. Pick two.
