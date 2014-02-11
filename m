From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 11 Feb 2014 11:36:33 -0800
Subject: [PATCH v2] ARM: asm: rename logical shift macros push pull into
 lspush lspull
In-Reply-To: <alpine.LFD.2.11.1402111253160.17677@knanqh.ubzr>
References: <1392063589-24111-1-git-send-email-victor.kamensky@linaro.org>
 <1392063589-24111-2-git-send-email-victor.kamensky@linaro.org>
 <alpine.LFD.2.11.1402101607120.17677@knanqh.ubzr>
 <20140211155437.GC3035@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1402111159230.17677@knanqh.ubzr>
 <20140211173754.GE3035@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1402111253160.17677@knanqh.ubzr>
Message-ID: <CAA3XUr3Q8tr9-CzYHq_sfbFKSjNbrYYE8_H1-9ypnXo8HgUe2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2014 09:58, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 11 Feb 2014, Dave Martin wrote:
>
>> On Tue, Feb 11, 2014 at 12:09:35PM -0500, Nicolas Pitre wrote:
>> > On Tue, 11 Feb 2014, Dave Martin wrote:
>> >
>> > > On Mon, Feb 10, 2014 at 04:30:01PM -0500, Nicolas Pitre wrote:
>> > > > On Mon, 10 Feb 2014, Victor Kamensky wrote:
>> > > >
>> > > > > Renames logical shift macros, 'push' and 'pull', defined in
>> > > > > arch/arm/include/asm/assembler.h, into 'lspush' and 'lspull'.
>> > > >
>> > > > I don't have any fundamental objection to the idea, except maybe for the
>> > > > actual names.  I just can't come up with anything better though.
>> > >
>> > > For consistency with the get_byte_ stuff, how about:
>> > >
>> > >   push -> towards_byte_0
>> > >   pull -> from_byte_0
>> > >
>> > > That may make the purpose a little clearer, too.
>> >
>> > I don't know if
>> >
>> >     mov     r0, r1, from_byte_0 #8
>> >
>> > is that much clearer though.
>> >
>> > > (Assuming I've got them the right way around...)
>> >
>> > As you later noticed you got it wrong.  :-)
>> > Most likely because "full from" and "push towards" are common english
>> > constructs.
>>
>> No more so than "pull towards" and "push from".
>
> OK.  I'll trust you on that account.
>
>> I'll blame it on the fact that the get_byte_ macros have wrong-
>> endian numbering, which I didn't look at carefully enough ;)
>>
>> But I think we proved that my suggestion didn't really make things
>> easier to understand...
>
> What about:
>
>         push -> next
>         pull -> prev
>
> ?
>
> That would make:
>
>         mov     r0, r1, next #8

I am not native English speaker, so subtle details of your
discussion go above my head :). For me those tokens
were just symbols with specific meaning of logical shifts
and selected endianness. I'll do as you decide. Quick
grep over .S files under arch/arm seems 'next' and 'prev'
will be OK and I did build that confirms that.

One nit/question though: there are some cases where
'push' and 'pull' macros were used in macros and macro
parameters were also called 'push' and 'pull'. I.e something
like this:

mov     r3, lr, pull #\pull

with rename 'pull' to 'lspull' I did not bother to rename
macro parameters because they are separate, have
just local context and 'lspull' is close to 'pull'. Resulting
proposed diff was:
-               mov     r3, lr, pull #\pull
+               mov     r3, lr, lspull #\pull

I assume that if we change 'push -> next' and 'pull -> prev' I
will need to rename macro parameters in the same way.
So it will be:
+               mov     r3, lr, prev #\prev
Is it correct?

Thanks,
Victor

>
> Nicolas
