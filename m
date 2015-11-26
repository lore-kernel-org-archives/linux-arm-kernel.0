From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 26 Nov 2015 12:41:54 +0000
Subject: [PATCH v2 2/2] ARM: Replace calls to __aeabi_{u}idiv with
 udiv/sdiv instructions
In-Reply-To: <alpine.LFD.2.20.1511252259090.22569@knanqh.ubzr> (Nicolas
 Pitre's message of "Thu, 26 Nov 2015 00:32:45 -0500 (EST)")
References: <1448488264-23400-1-git-send-email-sboyd@codeaurora.org>
 <1448488264-23400-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.20.1511251733570.22569@knanqh.ubzr>
 <yw1x8u5lpqqz.fsf@unicorn.mansr.com>
 <alpine.LFD.2.20.1511251931050.22569@knanqh.ubzr>
 <yw1x4mg9posf.fsf@unicorn.mansr.com>
 <20151126012859.GX8644@n2100.arm.linux.org.uk>
 <yw1xziy1o62j.fsf@unicorn.mansr.com>
 <alpine.LFD.2.20.1511252259090.22569@knanqh.ubzr>
Message-ID: <yw1xoaehnd9p.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 26 Nov 2015, M?ns Rullg?rd wrote:
>
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Thu, Nov 26, 2015 at 12:50:08AM +0000, M?ns Rullg?rd wrote:
>> >> If not calling the function saves an I-cache miss, the benefit can be
>> >> substantial.  No, I have no proof of this being a problem, but it's
>> >> something that could happen.
>> >
>> > That's a simplistic view of modern CPUs.
>> >
>> > As I've already said, modern CPUs which have branch prediction, but
>> > they also have speculative instruction fetching and speculative data
>> > prefetching - which the CPUs which have idiv support will have.
>> >
>> > With such features, the branch predictor is able to learn that the
>> > branch will be taken, and because of the speculative instruction
>> > fetching, it can bring the cache line in so that it has the
>> > instructions it needs with minimal or, if working correctly,
>> > without stalling the CPU pipeline.
>> 
>> It doesn't matter how many fancy features the CPU has.  Executing more
>> branches and using more cache lines puts additional pressure on those
>> resources, reducing overall performance.  Besides, the performance
>> counters readily show that the prediction is nothing near as perfect as
>> you seem to believe.
>
> OK... Let's try to come up with actual numbers.
>
> We know that letting gcc emit idiv by itself is the ultimate solution. 
> And it is free of maintenance on our side besides passing the 
> appropriate argument to gcc of course. So this is worth doing.
>
> For the case where you have a set of target machines in your kernel that 
> may or may not have idiv, then the first step should be to patch 
> __aeabi_uidiv and __aeabi_idiv.  This is a pretty small and simple 
> change that might turn out to be more than good enough. It is necessary 
> anyway as the full patching solution does not cover all cases.
>
> Then, IMHO, it would be a good idea to get performance numbers to 
> compare that first step and the full patching solution. Of course the 
> full patching will yield better performance. It has to. But if the 
> difference is not significant enough, then it might not be worth 
> introducing the implied complexity into mainline.  And it is not because 
> the approach is bad. In fact I think this is a very cool hack. But it 
> comes with a cost in maintenance and that cost has to be justified.
>
> Just to have an idea, I produced the attached micro benchmark. I tested 
> on a TC2 forced to a single Cortex-A15 core and I got those results:
>
> Testing INLINE_DIV ...
>
> real    0m7.182s
> user    0m7.170s
> sys     0m0.000s
>
> Testing PATCHED_DIV ...
>
> real    0m7.181s
> user    0m7.170s
> sys     0m0.000s
>
> Testing OUTOFLINE_DIV ...
>
> real    0m7.181s
> user    0m7.170s
> sys     0m0.005s
>
> Testing LIBGCC_DIV ...
>
> real    0m18.659s
> user    0m18.635s
> sys     0m0.000s
>
> As you can see, whether the div is inline or out-of-line, whether 
> arguments are moved into r0-r1 or not, makes no difference at all on a 
> Cortex-A15.
>
> Now forcing it onto a Cortex-A7 core:
>
> Testing INLINE_DIV ...
>
> real    0m8.917s
> user    0m8.895s
> sys     0m0.005s
>
> Testing PATCHED_DIV ...
>
> real    0m11.666s
> user    0m11.645s
> sys     0m0.000s
>
> Testing OUTOFLINE_DIV ...
>
> real    0m13.065s
> user    0m13.025s
> sys     0m0.000s
>
> Testing LIBGCC_DIV ...
>
> real    0m51.815s
> user    0m51.750s
> sys     0m0.005s
>
> So on A cortex-A7 the various overheads become visible. How significant 
> is it in practice with normal kernel usage? I don't know.

Bear in mind that in a trivial test like this, everything fits in L1
caches and branch prediction works perfectly.  It would be more
informative to measure the effect on a load that already has some cache
and branch prediction misses.

-- 
M?ns Rullg?rd
mans at mansr.com
