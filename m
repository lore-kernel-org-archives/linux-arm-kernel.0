From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Dec 2015 11:38:53 +0000
Subject: [PATCH v8 3/4] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <5667F897.5070005@arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-4-git-send-email-james.morse@arm.com>
 <20151207224805.GA20777@MBP.local> <20151208114321.GD19612@arm.com>
 <4EBA6141-5CFB-4CAC-97D2-26346AAA91F0@gmail.com>
 <56671214.30402@arm.com> <5667F897.5070005@arm.com>
Message-ID: <20151209113852.GC9303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 09, 2015 at 09:47:03AM +0000, James Morse wrote:
> On 08/12/15 17:23, James Morse wrote:
> > My only theory is that there is an off by one, and its reading what was
> > x29 instead. This wouldn't show up in these tests, but might be a
> > problem for aarch32 user-space, as presumably x29==0 when it switches to
> > aarch64 mode for el0_irq(). I will try this tomorrow.
> 
> Yup, this is what is happening. Its an off-by-one due to broken thinking
> about how the stack works. My broken thinking was:
> 
> >   top ------------
> >       | dummy_lr | <- irq_stack_ptr
> >       ------------
> >       |   x29    |
> >       ------------
> >       |   x19    | <- irq_stack_ptr - 0x10
> >       ------------
> >       |   xzr    |
> >       ------------
> 
> But the stack-pointer is decreased before use. So it actually looks like
> this:
> 
> >       ------------
> >       |          |  <- irq_stack_ptr
> >   top ------------
> >       | dummy_lr |
> >       ------------
> >       |   x29    | <- irq_stack_ptr - 0x10
> >       ------------
> >       |   x19    |
> >       ------------
> >       |   xzr    | <- irq_stack_ptr - 0x20
> >       ------------
> 
> The value being used as the original stack is x29, which in all the
> tests is sp but without the current frames data, hence there are no
> missing frames in the output.
> 
> Jungseok Lee picked it up with a 32bit user space because aarch32 can't
> use x29, so it remains 0 forever. The fix he posted is correct.
> 
> Will: do you want to take Jungseok Lee's patch as a 'Fixes:', or is it
> easier if I repost the series?

I'll take it as a fix on top, but I still want to get to the bottom of
why unwind_frame appeared to be exploding. We really shouldn't be relying
on the frame layout to provide us with safe addresses in there.

Will
