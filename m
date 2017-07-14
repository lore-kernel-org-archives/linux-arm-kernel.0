From: mirceac@gmail.com (Mircea Ciocan)
Date: Fri, 14 Jul 2017 11:05:54 +0200
Subject: Porting a custom interrupt handler from kernel 2.6.25 to 3.16.45
In-Reply-To: <20170714084831.GG31807@n2100.armlinux.org.uk>
References: <CAHumR2+WR3Fdtft8xrPfcT3-dpKqCL__aaEc6qri3N5-x0yCXw@mail.gmail.com>
 <20170713160625.GB27801@lunn.ch>
 <CAHumR2LazFFmmNNKJ=KrEjt7iCgrKewkdzO6ww7RtLU+wWTFoA@mail.gmail.com>
 <20170713173545.GE31807@n2100.armlinux.org.uk>
 <CAHumR2+5qWG5TTqS47PdtrQfu2N+B7x+gtmq85VL5NZj5X2-tA@mail.gmail.com>
 <20170714084831.GG31807@n2100.armlinux.org.uk>
Message-ID: <CAHumR2L95HSyXEsFtxMwAe1454og5EcsJk70ZaMOgdwQ5QGJHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 10:48 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
[snip..]
>> Hi  and thanks for the answer, first thing first, write a book,
>
> First off, please spell my name correctly.  People tend to get upset
> when their names are mis-spelt (eg, Diana's get upset if you call
> them Diane and Diane's get upset if you call them Diana.)
>
Russell, I sincerely apologize for spelling your name incorrectly, I
should have proofread better my message.
It won't happen again.

[more snip...]
>
> This particular detail that you've asked about hasn't changed for
> about 20 years.  No, I'm not going to write a book, that would take
> way too long, and by the time it's complete, it'll be obsolete.
>
This is really a pity :(

> As for a FAQ, most people over the last 20 years have been able to
> grasp these two macros, you're the first one to really ask in this
> depth about them, so it's hardly a "frequent" question.  Most people
> (as is common with much of the Linux code base) read the code where
> things are used and existing implementations to augment their
> understanding.
>
> That's something even I have to do all the time, and from time to
> time I have asked for better documentation, but that's never been
> forthcoming.  So it's really a case of "read the code."
>
> Sorry if that offends, but that's the way Linux is.
Now offense taken, reading the code do lead to enlightenment (after a
while, sadly) but for stable architecture some comments or a little
text in the doc directory will be nice to have.

>
>> Now that the rant part is over, let me summarize what I understand
>> form my searches and your explanations, and kindly please confirm if
>> it's correct:
>>
>> - *get_irqnr_preamble* - it's mostly used to get the top level
>> interrupt controller address of if it's a funky controller, to make it
>> ready for *get_irqnr_and_base* and  *test_for_ipi* that gets those
>> registers as parameters.
>> It is used only once.
>
> Correct.
>
>> - *get_irqnr_and_base* gets it's \base register already set by
>> *get_irqnr_preamble* and does it have to return the \irqnr or it
>> receives the \irqnr already set by *get_irqnr_preamble* ?
>
> Here's how it's used:
>
>         get_irqnr_preamble r6, lr
> 1:      get_irqnr_and_base r0, r2, r6, lr
>         movne   r1, sp
>         @
>         @ routine called with r0 = irq number, r1 = struct pt_regs *
>         @
>         badrne  lr, 1b
>         bne     asm_do_IRQ
>
> where r0 is "irqnr".  These two questions will help answer yours:
>
> 1. Is r0 passed to get_irqnr_preamble?
> 2. What would it mean if get_irqnr_and_base did not set r0?
>
> Moreover, if the interrupt number _were_ to be only returned by
> get_irqnr_preamble, then how could we ever hope to service more than
> one interrupt number?
>
> I said in my initial reply "get_irqnr_and_base gets the interrupt
> number" which I think also answers your question, and the macro name
> also reflects its operation.
>
>> At the end of the macro, is any of the registers value \irqnr,
>> \irqstat, \base, \tmp of any significance or strictly only the zero
>> flag matters ?
>
> From what we can see from the above quoted code, asm_do_IRQ is called
> with r0 and r1 set.  As the code following the macro sets r1 already,
> r0 needs to be set, and r0 is "irqnr".
>
> Some implementations used to also set "base" where they had multiple
> interrupt controllers (which is why the macro is named the way it is)
> and didn't use get_irqnr_preamble to set the base.
>
> What's required in these two macros is really up to the implementation,
> there's no hard and fast rules apart from not using registers that
> aren't passed to the macro as arguments.
>
>> In the original custom function I have this gem of a comment, where
>> the original developer said:
>>
>> "... snip...
>> 1001:
>>         /* WARNING: These lines override the default behavior, */
>>         /* which is to loop back at the start of the macro after the handler */
>>
>>         /* set r1 to registers address */
>>         movne   r1, sp
>>
>>         /* set label 2 as return address */
>>         adrne   lr, 2f
>>     .endm
>> "
>
> That looks like a horrid hack - it's jumping out of the macro, to some
> other location, and the only way to know that is to look at the code
> in the kernel version that it was created for.  Such hacky code can't
> be expected to work from one kernel version to the next, so it's not
> surprising that it doesn't work with modern kernels.
>
> If it was supposed to be using the "2" label, then it would be passed
> into the macro, to allow the code that calls the macro to be modified
> without affecting the implementations.
>
> In general, macros should never jump outside of themselves - that
> creates unclean code that is context sensitive, destroys readability,
> and creates maintenance problems.
>
> We have the same rule for C code: C preprocessor macros are not allowed
> to use "return" because that destroys the readability of the code.
>
>> I believe in the current framework this is an incorrect behavior, is
>> there any possible situation where this can offer some advantage ?
>
> I couldn't say, because:
> (1) I don't know why it would need such a hack.
> (2) I don't know where it is jumping to.
> so
> (3) I don't know what this code is doing.
>
In the end Russell, I thank you once more for your kind help and I
will try to re-factor the existing code to fit into the framework, the
existing stuff was looking strange to me as well, but lacking an
overview of the architecture lead me to ask this noob questions.

 Have a nice week-end and best regards,
 Mircea
