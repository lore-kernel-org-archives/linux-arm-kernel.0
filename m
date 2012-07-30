From: zonque@gmail.com (Daniel Mack)
Date: Mon, 30 Jul 2012 11:31:18 +0200
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <CAN1soZwmyf=Q5mBJhr6AXYp0RzJDj9eN0GBRFzB0gUMzwJzO3g@mail.gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <201207291409.56645.arnd@arndb.de> <50159FBC.2010409@gmail.com>
 <201207300831.32988.arnd@arndb.de> <501646FC.60900@gmail.com>
 <CAN1soZwmyf=Q5mBJhr6AXYp0RzJDj9eN0GBRFzB0gUMzwJzO3g@mail.gmail.com>
Message-ID: <50165466.1020901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2012 10:55, Haojian Zhuang wrote:
> On Mon, Jul 30, 2012 at 4:34 PM, Daniel Mack <zonque@gmail.com> wrote:
>> On 30.07.2012 10:31, Arnd Bergmann wrote:
>>> On Sunday 29 July 2012, Daniel Mack wrote:
>>>> And I also wonder whether using the second spec value for a priority
>>>> wouldn't be somehow abusive? Isn't that considered to denote the trigger
>>>> flags in contexts of interrupt controllers? At least, that is what
>>>> irq_domain_xlate_twocell() assumes.
>>>
>>> You would not use irq_domain_xlate_twocell in that scenario but provide your
>>> own, which is ok. Interpreting the second cell as the trigger flags is just
>>> a convenient default because it's the most common use for that.
>>
>> I see. Don't know how much sense it makes to have that detail
>> configurable though. Haojian? And I think we can still change that
>> detail later.
>>
> Arnd's suggestion is good. So we can setup each interrupt's priority
> while parsing
> all these pxa interrupts. In current code, we only assign priority
> with the irq number.
> Maybe it's not perfect solution. For example, Timer interrupt should
> have highest
> priority. LCD interrupt also has higher priority.

Arnd mentioned that instead of using the default
irq_domain_xlate_onecell(), we can hook up our own translation function.
While that is true, I wonder how that value that we send back in
*out_type will ever appear in the irq_chip callbacks. Looking at the
code that calls ->xlate(), I can see that irq_create_of_mapping() would
call irq_set_irq_type() with our passed value, which will then &= it
with IRQ_TYPE_SENSE_MASK (which is 0xf which doesn't suffice for our up
to 96 interrupts).

Arnd, either I don't get your point, or this would need some changes in
the irqdomain core. Could you elaborate a little?

> It's worth to do. And it's also OK if you want to queue it into your TODO list.

Then let's do it as a separate patch later. It's easy to change once we
agree on how to do it.

> By the way, which patches that you prefer not to go through pxa git tree?

I would say you can take all 9 patches that I prepared in the branch
now. I got some feedback on the first round but didn't hear back from
anyone since then.

For the OHCI part (which is not part of it), I don't know if it might be
better to let it go through the USB tree.


Daniel
