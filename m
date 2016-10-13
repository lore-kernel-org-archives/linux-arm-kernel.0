From: labath@google.com (Pavel Labath)
Date: Thu, 13 Oct 2016 18:03:05 +0100
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <CAHB_GupRgSgnQS+YKhKxWhf8+t+GP5+7_hoigKUQaYcnhwG8NA@mail.gmail.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
 <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
 <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
 <CAHB_GupR4sJtAGYdRwvCwu7891KM8TEByZCgqMCrYrdt=cJuYw@mail.gmail.com>
 <CAJt8pk-HJYFUCxRuY5EV6KnM+kNP6mVBrFgPwiGfEkMKqGyjXw@mail.gmail.com>
 <CAHB_GupRgSgnQS+YKhKxWhf8+t+GP5+7_hoigKUQaYcnhwG8NA@mail.gmail.com>
Message-ID: <CAJt8pk8OOTbuNhN635kRCot89eLjXPQqd2AG2qJ_t7GComtZCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 October 2016 at 10:58, Pratyush Anand <panand@redhat.com> wrote:
> Hi Pavel,
>
> Thanks a lot for your testing.
>
> On Wed, Oct 12, 2016 at 7:20 PM, Pavel Labath <labath@google.com> wrote:
>> Hello Pratyush,
>>
>> I am sorry about the delay. I have finally had a chance to try out
>> your changes today. Response inline.
>>
>> On 8 October 2016 at 06:10, Pratyush Anand <panand@redhat.com> wrote:
>>> On Fri, Oct 7, 2016 at 10:54 PM, Pavel Labath <labath@google.com> wrote:
>>>> The thing is, I have observed different behavior here depending on the
>>>> exact hardware used. I don't have the exact parameters with me now,
>>>> but I can look it up next week.
>>>>
>>>> The thing is that the spec is imprecise about what exact address the
>>>> hardware can report for the watchpoint hit. I presume that is
>>>> deliberate to give some leeway to implementers. The spec says the
>>>> address can be anywhere in the range from the lowest memory address
>>>> accessed by the instruction to the highest address watched by the
>>>> watchpoint,
>>>
>>> I think, my patches should  be able to take care of the above condition.
>> Unfortunately, the patch does not solve the problem for my hardware,
>> because of the leeway you give in watchpoint_handler is not big
>> enough. It does work however, if I change the line
>>> if (addr + 7 < val + lens || addr > val + lene)
>> to
>>> if (addr + 15 < val + lens || addr > val + lene)
>
> Yes, I missed that floating point register will be of size 16.
>
>> I do not think we can assume that address reported by the hardware
>> will be at most 7 bytes off from the address we put the watchpoint at.
>> There is nothing in the spec that guarantees that, and it does not
>> seem to be enough for some hardware. In fact, I am not sure we can
>> assume 15 is enough either, but maybe it can do for now, until we can
>
> Right. It might even be bigger, in case of cache maintenance instructions.
>
>> find hardware that does not work with that (I haven't yet tried what
>> happens it the watchpoint is triggered by cache management
>> instructions, which can access much larger blocks of memory).
>
> Not, sure, may be it can lie in cache line size range.
>
>>
>> For reference, the hardware in question is:
>>> Processor : AArch64 Processor rev 0 (aarch64)
>>> processor : 0
>>> min_vddcx : 400000
>>> min_vddmx : 490000
>>> BogoMIPS : 38.00
>>> Features : fp asimd evtstrm aes pmull sha1 sha2 crc32
>>> CPU implementer : 0x51
>>> CPU architecture: 8
>>> CPU variant : 0x2
>>> CPU part : 0x201
>>> CPU revision : 0
>>> CPU param : 300 468 468 621 939 299 445 445 621 1077
>>> Hardware : Qualcomm Technologies, Inc MSM8996pro
>>
>> And this is how it behaves:
>> The output of the test app triggering the watchpoint (I have set a
>> single-byte watchpoint at 555556705f)
>>>
>>> Writing to: 555556705f, size: 1
>>> Writing to: 555556705e, size: 2
>>> Writing to: 555556705c, size: 4
>>> Writing to: 5555567058, size: 8
>>> Writing to: 5555567050, size: 16
>>> Writing to: 5555567040, size: 32
>>
>> The addresses received by the kernel:
>> [  251.812166] c1   3780 hw-breakpoint: watchpoint_handler: addr:
>> 555556705f, val+lens: 555556705f, val+lene: 555556705f
>> [  251.820341] c1   3781 hw-breakpoint: watchpoint_handler: addr:
>> 555556705e, val+lens: 555556705f, val+lene: 555556705f
>> [  251.825572] c0   3782 hw-breakpoint: watchpoint_handler: addr:
>> 555556705c, val+lens: 555556705f, val+lene: 555556705f
>> [  251.831085] c0   3783 hw-breakpoint: watchpoint_handler: addr:
>> 5555567058, val+lens: 555556705f, val+lene: 555556705f
>> [  251.835804] c0   3784 hw-breakpoint: watchpoint_handler: addr:
>> 5555567050, val+lens: 555556705f, val+lene: 555556705f
>> [  251.841350] c0   3785 hw-breakpoint: watchpoint_handler: addr:
>> 5555567050, val+lens: 555556705f, val+lene: 555556705f
>>
>> Note that for the case of 16 and 32-byte access it returns the address
>> 5555567050 -- this is why the "+15" is sufficient for me.
>>
>>
>> The other thing I am not so sure about in your patch is that it has
>> potential to mis-attribute the watchpoint hit if we have two
>> watchpoints close together. For example, if I have first watchpoint on
>> 0x1008-0x100f and a second one on 0x1000-0x1007, *and* the application
>> writes one byte to 0x1004, then your code will still attribute the hit
>> to the first watchpoint, even though it was not really triggered. This
>
> Hummm..yes, thanks for pointing it out.
> There could be only two solutions for it:
> (1) We read instruction at the location regs->pc and analyse it and
> find the size of read/write.
> or(2) What you have suggested in your patch.
>
> I think, its easier to go with your implementation. So, I have taken
> your patch and updated my perf/upstream_arm64_devel branch. May be you
> can give it a test for your test cases.

I've checked out the new version of your branch, and it works great.
I'll write a patch with additional test cases to go on top of your
branch, as the tests there do not capture the bug I was fixing.

regards,
Pavel
