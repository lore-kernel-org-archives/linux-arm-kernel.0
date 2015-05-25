From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 25 May 2015 19:01:33 +0900
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <5992243.NYDGjLH37z@wuerfel>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <5992243.NYDGjLH37z@wuerfel>
Message-ID: <B873B881-4972-4524-B1D9-4BB05D7248A4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On May 25, 2015, at 2:49 AM, Arnd Bergmann wrote:
> On Monday 25 May 2015 01:02:20 Jungseok Lee wrote:
>> Fork-routine sometimes fails to get a physically contiguous region for
>> thread_info on 4KB page system although free memory is enough. That is,
>> a physically contiguous region, which is currently 16KB, is not available
>> since system memory is fragmented.
>> 
>> This patch tries to solve the problem as allocating thread_info memory
>> from vmalloc space, not 1:1 mapping one. The downside is one additional
>> page allocation in case of vmalloc. However, vmalloc space is large enough,
>> around 240GB, under a combination of 39-bit VA and 4KB page. Thus, it is
>> not a big tradeoff for fork-routine service.
> 
> vmalloc has a rather large runtime cost. I'd argue that failing to allocate
> thread_info structures means something has gone very wrong.

That is why the feature is marked "N" by default.
I focused on fork-routine stability rather than performance.

Could you give me an idea how to evaluate performance degradation?
Running some benchmarks would be helpful, but I would like to try to
gather data based on meaningful methodology.

> Can you describe the scenario that leads to fragmentation this bad?

Android, but I could not describe an exact reproduction procedure step
by step since it's behaved and reproduced randomly. As reading the following
thread from mm mailing list, a similar symptom is observed on other systems. 

https://lkml.org/lkml/2015/4/28/59

Although I do not know the details of a system mentioned in the thread,
even order-2 page allocation is not smoothly operated due to fragmentation on
low memory system.

I think the point is *low memory system*. 64-bit kernel is usually a feasible
option when system memory is enough, but 64-bit kernel and low memory system
combo is not unusual in case of ARM64.

> Could the stack size be reduced to 8KB perhaps?

I guess probably not.

A commit, 845ad05e, says that 8KB is not enough to cover SpecWeb benchmark.
The stack size is 16KB on x86_64. I am not sure whether all applications,
which work fine on x86_64 machine, run very well on ARM64 with 8KB stack size.

Best Regards
Jungseok Lee
