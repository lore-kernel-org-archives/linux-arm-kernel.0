From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 6 Dec 2013 15:21:41 +0000
Subject: [PATCH V4] ARM : unwinder : Prevent data abort due to stack
 overflow
In-Reply-To: <CAPoNrtuzV=eOWP44om+E6m0NSx+xfFtg-STjPLMBO4OUBF84kQ@mail.gmail.com>
References: <1386242785-5146-1-git-send-email-a.anurag@samsung.com>
 <20131205135928.GA4096@e103592.cambridge.arm.com>
 <CAPoNrtuzV=eOWP44om+E6m0NSx+xfFtg-STjPLMBO4OUBF84kQ@mail.gmail.com>
Message-ID: <20131206152140.GB4897@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 03:15:22PM +0000, Anurag Aggarwal wrote:
> >>if (unlikely(check) &&
> >>    *vsp >= (unsigned long *)ctrl->sp_high))
> 
> Good idea, It can help in optimizing the code and will leave code more readable
> and it will be easy to maintain also.

That was my goal -- it's not always easy to achieve both, but we should
try where possible, especially for non-performance-critical code.

> >>Does the code check anywhere that SP is word-aligned?
> >>
> >>That should probably be checked if it's not done already.
> 
> I think this should be handled in separate patch
> I would also like to hear more your ideas for the file

There are some limitations on how backtracing works with ARM_UNWIND.
The backtracer interface assumes that the compiler's register use with
ARM_UNWIND is "almost the same" as with !ARM_UNWIND.  But this is not
always true, and we've seen some problems.  

I think the best solution will involve some refactoring of the interface
between the backtracer and the unwinder backends, but I don't have it
all figured out yet...

Cheers
---Dave
