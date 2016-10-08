From: panand@redhat.com (Pratyush Anand)
Date: Sat, 8 Oct 2016 10:40:34 +0530
Subject: [PATCH 2/3] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
References: <1474643941-109020-1-git-send-email-labath@google.com>
 <1474643941-109020-2-git-send-email-labath@google.com>
 <CAHB_GupyUp_s4nWq-QVnEoCZvmkrXyCcxs-XpH3x0Yugkknpzg@mail.gmail.com>
 <CAJt8pk9WOhebSXpbahbbLscqJcY1OOqHiA_9hHC0zmHruRPxWQ@mail.gmail.com>
Message-ID: <CAHB_GupR4sJtAGYdRwvCwu7891KM8TEByZCgqMCrYrdt=cJuYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,


On Fri, Oct 7, 2016 at 10:54 PM, Pavel Labath <labath@google.com> wrote:
> On 7 October 2016 at 09:38, Pratyush Anand <panand@redhat.com> wrote:
>>
>>
>> IIUC, then you see an issue when an address watched is not the base
>> address accessed by the instruction. For example, if an address 'a+8'
>> is watched and an instruction accesses instruction from  a to a +16. I
>> tried to reproduce the issue with mustang using your test-case in
>> patch3 (after couple of syntax modifcations for resolving compilation
>> issue with gcc). All the test case did pass with existing code in
>> v4.8. I noticed that, watchpoint exception is generated if any of the
>> sub-location accessed from a single instruction is watched, provided
>> watchdpoint watches either a byte, half word, word or double word
>> from the base.
>>
>>
>> So, either I must be missing something or the problem is not related
>> to all arm64 platform.
>
>
> Hello Pratyush,
>
> Thank you for looking into this.
>
> The thing is, I have observed different behavior here depending on the
> exact hardware used. I don't have the exact parameters with me now,
> but I can look it up next week.
>
> The thing is that the spec is imprecise about what exact address the
> hardware can report for the watchpoint hit. I presume that is
> deliberate to give some leeway to implementers. The spec says the
> address can be anywhere in the range from the lowest memory address
> accessed by the instruction to the highest address watched by the
> watchpoint,

I think, my patches should  be able to take care of the above condition.

>  but most hardware seems to be stricter than that and
> return an address that fits inside the watched range.
>
> On chip 1, I observed the behavior where the hardware would
> consistently report an address out of range of the watchpoint and we
> would just spin it in a loop.
>
> On chip 2, I observed the behavior where the hardware would report an
> out-of-range address for the first two dozen (~) iterations, after
> which it would "give up" and report an address that we were happy
> with. I don't really have an explanation for this - I can only assume
> that some external event like a reschedule to a different core caused
> some internal state of the hardware to be reset and cause it to report
> a different (better?) address instead. In the case where this was
> happening, it had no observable effects on userspace - it did not see
> the fact that we had re-executed the offending instruction a dozen
> times and as far as it was concerned, the watchpoint functionality
> worked perfectly. You can check whether this is happening in your case
> by instrumenting the code to print the reported address whenever it
> enters `watchpoint_handler`.
>

Yes, I had done that. In my case it was always starting memory address
accessed by the instruction. e.g. if a strb writes to 0x400023, I
would get addr=0x400023 in watchpoint_handler(), if a str writes to
0x400020-0x400027, I would get addr=0x400020.

> (I am sorry about the test errors. I was compiling the test case with
> an android gcc - I'll make sure to check it with a vanilla linux gcc
> also.)
>

your test cases are helpful. I think, I would use them to build
further test cases.

>  >
>> However, I did notice that it does not work if we watch an address
>> which is at some offset from address programmed. For example, it works
>> when byte_mask is 0x3, but it does not work if byte_mask if 0x2 (which
>> is supported by hardware).
>>
>> I do have some patches to resolve that.
>>
>> https://github.com/pratyushanand/linux/commits/perf/upstream_arm64_devel
>>
>> I will send them for review comment after some testing.
>
> I am looking forward to these patches - they were the next on my list
> to look into after I got this resolved. :)
>
> However: Are sure about 0x2 not being a valid byte mask? According to

It is a valid mask indeed, and you should be able to use all those
mask after my patches.

> my reading of the armv8 spec (section  D7.3.11, "DBGWCR<n>_EL1, Debug
> Watchpoint Control Registers, n = 0 - 15") it should be fine.
> ====
> The valid values for BAS are 0b0000000, or a binary number all of
> whose set bits are contiguous. All other values are reserved and must
> not be used by software.
> ====
> So, 0x2 (as well as 0x6, 0xC, 0xE) should be fine as it has a
> contiguous sequence of set bit(s). I haven't tried yet whether any
> hardware actually handles that correctly, but I was certainly hoping
> we would be able to watch more precise memory regions.

I have tested couple of them, and I think my patches should help with
using any contiguous bit mask acceptable by spec.

~Pratyush
