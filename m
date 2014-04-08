From: dave.long@linaro.org (David Long)
Date: Tue, 08 Apr 2014 12:29:25 -0400
Subject: [RFC PATCH] ARM: uprobes need icache flush after xol write
In-Reply-To: <20140408161910.GJ16119@n2100.arm.linux.org.uk>
References: <1396926260-7705-1-git-send-email-victor.kamensky@linaro.org>
 <1396926260-7705-2-git-send-email-victor.kamensky@linaro.org>
 <20140408082444.GA3598@e103592.cambridge.arm.com>
 <20140408114619.GE16119@n2100.arm.linux.org.uk> <5343F42D.5090205@linaro.org>
 <20140408133039.GH16119@n2100.arm.linux.org.uk>
 <CAA3XUr2kxKXpPwy8vqF1+CjcRsu86tGir-NuC7AXYiJVi4TuGw@mail.gmail.com>
 <CAA3XUr1Bj4CD2fhZkWAHx+9W8eGz755OvnE+-3sxaAcQNV6Q-Q@mail.gmail.com>
 <20140408161910.GJ16119@n2100.arm.linux.org.uk>
Message-ID: <534423E5.9060606@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/14 12:19, Russell King - ARM Linux wrote:
> On Tue, Apr 08, 2014 at 08:35:01AM -0700, Victor Kamensky wrote:
>> Looking at flush_ptrace_access more closely. Now I am not sure that
>> ptrace write code could easily reused.
>>
>> 1) flush_ptrace_access seems to handle both data and text segments
>> write. In case of xol write we always know that it is code write
>
> Of course it has to, but writing code is the harder of the two
> problems.  With writes to data segments, the only thing that has to
> be dealt with is the data cache.  With code, not only do you need to
> deal with the data cache, but you also need to deal with the instruction
> cache too.
>
>> 2) as I pointed before flush_ptrace_access handles smp case whereas
>> xol write does not need to do that
>
> Are you sure about that?
>
> If I'm reading the code correctly, uprobes inserts a trapping instruction
> into the userspace program.  When that instruction is hit, it checks
> whether the thread is the desired one, and may request a slot in this
> magic page, which is when the write happens.
>
> The uprobes special page is shared across all threads which share the
> mm_struct, so in the case of a multi-threaded program running on a SMP
> machine, this page is visible to multiple CPUs.
>
> Is it possible for uprobes to be active on more than one thread at a
> time?  If so, because that page is shared, you could end up writing
> to a partial cache line from two threads.  From what I can see, ixol[]
> is two words, and there's normally 8 works per cache line on ARM, or
> occasionally 16.
>
> So, the question now is: is it possible to have uprobes active on more
> than one thread, and for two threads to hit the uprobes processing, both
> needing a slot in the page, hitting the same cache line?
>
> Now, what happens if thread 1 on CPU1 gets there first with its write.
> Then thread 2 on CPU2 gets there, causing the cache line to migrate to
> CPU2.  Then CPU1 does it's (non-broadcasted) flush, meanwhile CPU2 then
> gets preempted and goes off and does something else.
>
> Please tell me that can't happen. :)
>

 From arch/arm/include/asm/uprobes.h:

3) flush_ptra#define UPROBE_XOL_SLOT_BYTES	64



-dl
