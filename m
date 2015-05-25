From: catalin.marinas@foss.arm.com (Catalin Marinas)
Date: Tue, 26 May 2015 01:36:29 +0300
Subject: [RFC PATCH 2/2] arm64: Implement vmalloc based thread_info
 allocator
In-Reply-To: <5601369.jDWtB6nFJC@wuerfel>
References: <1432483340-23157-1-git-send-email-jungseoklee85@gmail.com>
 <B873B881-4972-4524-B1D9-4BB05D7248A4@gmail.com>
 <F68D2983-226C-4704-A1E0-E79C9425B822@foss.arm.com>
 <5601369.jDWtB6nFJC@wuerfel>
Message-ID: <1CD6E4BA-95AF-420C-8270-6AAF783B6F60@foss.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2015, at 23:29, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 25 May 2015 19:47:15 Catalin Marinas wrote:
>> On 25 May 2015, at 13:01, Jungseok Lee <jungseoklee85@gmail.com> wrote:
>>>> Could the stack size be reduced to 8KB perhaps?
>>> 
>>> I guess probably not.
>>> 
>>> A commit, 845ad05e, says that 8KB is not enough to cover SpecWeb benchmark.
>> 
>> We could go back to 8KB stacks if we implement support for separate IRQ 
>> stack on arm64. It's not too complicated, we would have to use SP0 for (kernel) threads 
>> and SP1 for IRQ handlers.
> 
> I think most architectures that see a lot of benchmarks have moved to
> irqstacks at some point, that definitely sounds like a useful idea,
> even if the implementation turns out to be a bit more tricky than
> what you describe.

Of course, it's more complicated than just setting up two stacks (but I'm away for a 
week and writing from a phone). We would need to deal with the initial per-CPU setup, 
rescheduling following an IRQ, CPU on following power management and maybe 
other issues. However, the architecture helps us a bit by allowing both SP0 and SP1 to be 
used at EL1. 

> There are a lot of workloads that would benefit from having lower
> per-thread memory cost.

If we keep the 16KB stack, is there any advantage in a separate IRQ one (assuming 
that we won't overflow 16KB)?

Catalin
