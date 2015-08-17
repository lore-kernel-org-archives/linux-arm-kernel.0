From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 17 Aug 2015 15:07:00 +0900
Subject: [RFC v2 1/4] ftrace: allow arch-specific check_stack()
In-Reply-To: <20150811170321.GB29880@arm.com>
References: <1438674249-3447-1-git-send-email-takahiro.akashi@linaro.org>
 <1438674249-3447-2-git-send-email-takahiro.akashi@linaro.org>
 <20150811170321.GB29880@arm.com>
Message-ID: <55D17A04.7020800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On 08/12/2015 02:03 AM, Will Deacon wrote:
> On Tue, Aug 04, 2015 at 08:44:06AM +0100, AKASHI Takahiro wrote:
>> A stack frame pointer may be used in a different way depending on
>> cpu architecture. Thus it is not always appropriate to slurp the stack
>> contents, as currently done in check_stack(), in order to calcurate
>> a stack index (height) at a given function call. At least not on arm64.
>>
>> This patch extract potentially arch-specific code from check_stack()
>> and puts it into a new arch_check_stack(), which is declared as weak.
>> So we will be able to add arch-specific and most efficient way of
>> stack traversing Later.
>>
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>
> If arm64 is the only architecture behaving differently, then I'm happy
> to reconsider the fix to unwind_frame that we merged in e306dfd06fcb
> ("ARM64: unwind: Fix PC calculation"). I'd have thought any architecture
> with a branch-and-link instruction would potentially have the same issue,
> so we could just be fixing things in the wrong place if ftrace works
> everywhere else.

I'm not the right person to answer for other architectures (and ftrace
behavior on them.) The only thing I know is that current ftrace stack tracer
works correctly only if the addresses stored and found on stack match to
the ones returned by save_stack_trace().

Anyway, the fix above is not the only reason that I want to introduce arch-specific
arch_check_stack(). Other issues to fix include
   - combined case of stack tracer and function graph tracer (common across arch's)
   - exception entries (as I'm trying to address in RFC 4/4)
   - in-accurate stack size (for each function, my current fix is not perfect though.)

Thanks,
-Takahiro AKASHI

> Will
>
