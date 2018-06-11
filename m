From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 11 Jun 2018 16:19:30 +0200
Subject: [PATCH V3] ARM: shmobile: Rework the PMIC IRQ line quirk
In-Reply-To: <CAMuHMdXJEC8HbuB5+YHMLjZy9GfCYyXmGTk0TXkoAxLhxTOJyA@mail.gmail.com>
References: <20180604175911.799-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdXG6mMfFTz+fdZQ53hLxYgVZPmsGpaRri8TesiruUNYUg@mail.gmail.com>
 <fa4f843b-ae9d-fac2-77e2-b3ac1116f916@gmail.com>
 <CAMuHMdXw146fwm0tHS7CBAofDAgRgDD2tNqgEJwzx0Jm1xKCyw@mail.gmail.com>
 <967b800e-c935-aa35-da5a-ca3672fd18c2@gmail.com>
 <CAMuHMdVJ+ad-kr0iYuoaH3chJ49_g6yjEb8PHmTpwjFdYcG4=Q@mail.gmail.com>
 <47e87deb-a7a8-4780-53b5-4e4ed6e1bac3@gmail.com>
 <CAMuHMdXJEC8HbuB5+YHMLjZy9GfCYyXmGTk0TXkoAxLhxTOJyA@mail.gmail.com>
Message-ID: <6864ed2c-39ac-615d-f38e-b28c3647e451@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2018 04:10 PM, Geert Uytterhoeven wrote:
> Hi Marek,

Hi,

> On Mon, Jun 11, 2018 at 4:04 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 06/11/2018 03:49 PM, Geert Uytterhoeven wrote:
>>> On Mon, Jun 11, 2018 at 3:39 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>> On 06/11/2018 03:03 PM, Geert Uytterhoeven wrote:
>>>>> On Mon, Jun 11, 2018 at 2:15 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>> On 06/11/2018 11:56 AM, Geert Uytterhoeven wrote:
>>>>>>> On Mon, Jun 4, 2018 at 7:59 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>>>>>>> Rather than hard-coding the quirk topology, which stopped scaling,
>>>>>>>> parse the information from DT. The code looks for all compatible
>>>>>>>> PMICs -- da9036 and da9210 -- and checks if their IRQ line is tied
>>>>>>>> to the same pin. If so, the code sends a matching sequence to the
>>>>>>>> PMIC to deassert the IRQ.
>>>
>>>>>>>> +               ret = of_property_read_u32(np, "reg", &addr);
>>>>>>>> +               if (ret)
>>>>>>>> +                       return ret;
>>>>>>>
>>>>>>> I think it's safer to skip this entry and continue, after calling
>>>>>>> kfree(quirk), of course.
>>>>>>>
>>>>>>>> +
>>>>>>>> +               quirk->id = id;
>>>>>>>> +               quirk->i2c_msg.addr = addr;
>>>>>>>> +               quirk->shared = false;
>>>>>>>> +
>>>>>>>> +               ret = of_irq_parse_one(np, 0, &quirk->irq_args);
>>>>>>>> +               if (ret)
>>>>>>>> +                       return ret;
>>>>>>>
>>>>>>> kfree(quirk) and continue...
>>>>>>
>>>>>> I wonder if it shouldn't rather free the entire list and abort ?
>>>>>
>>>>> "Be strict when sending, be liberal when receiving."
>>>>
>>>> Meaning ? I think "the language barrier is protecting me" (TM)
>>>
>>> Do the best you can, given the buggy DT you received.
>>> I.e. don't fail completely, just ignore the bad device node, and continue.
>>
>> But if you ignore node, you might as well ignore one which is shared and
>> then the system crashes due to IRQ storm anyway. So hum, what can we do ?
> 
> Correct. If it's a critical node, it will crash regardless.
> If it's a non-critical node, you have the choice between aborting and crashing,
> or ignoring and keeping the system alive. Your call.

But wait, since we control which machines this code runs on , can't we
assure they have valid DTs ? This situation with invalid DT starts to
look a bit hypothetical to me.

-- 
Best regards,
Marek Vasut
