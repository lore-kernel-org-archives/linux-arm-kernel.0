From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 06 Jan 2013 18:24:19 +0200
Subject: [PATCH] ARM: PXA27x: fix workaround for AC97 reset
In-Reply-To: <87fw2ebe1i.fsf@free.fr>
References: <1357470761-14363-1-git-send-email-grinberg@compulab.co.il>
 <87fw2ebe1i.fsf@free.fr>
Message-ID: <50E9A533.2050106@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06/13 16:07, Robert Jarzmik wrote:
> Igor Grinberg <grinberg@compulab.co.il> writes:
> 
>> Fix the workaround to a hardware bug in the AC97 controller of PXA27x.
>> A bug in the controller's warm reset functionality requires that the MFP
>> used by the controller as the AC97_RESET_n line be temporarily
>> reconfigured as a GPIO (AF0) and manually held high for the duration of
>> the warm reset cycle.
>>
>> The workaround was broken long ago by commit fb1bf8cd
>> ([ARM] pxa: introduce processor specific pxa27x_assert_ac97reset()).
>> The commit above changed the original workaround code in a way that
>> changed the MFP to AF0 (GPIO), but forgot to drive the GPIO high output.
>> This way, the GPIO state was left input (and undriven) and only worked
>> for boards with external pullup on the line.
>>
>> Fix the above breakage by actually configurring the GPIO for output high
>> in case of reset assert and returning it to default state
>> (AF2 and GPDR - input) in case of reset deassert.
> 
> NAK.
> If you return GPIO95 to AF-input, the GPIO95 will be "KP_DKIN<2>", ie. you'll
> map a keyboard input to a AC97 reset.

I'm sorry, I don't understand what do you mean by "AF-input"?
For GPIO95 AF1 means AC97_nRESET and GPDR settings should not meter at all.
So setting GPDR for GPIO95/113 to input is only a safety measure.

> As I said in a mail before, don't put a AC97 reset line as an input pin, this is
> not a sensible patch.

Hmmm... I've opened the PXA27x dev manual once again in several years.
Ok. I was mislead by all the newer SoC where direction pins do not count
unless the MFP in AF-GPIO. As I've remembered now, it is not true for PXA27x.

This is what the manual says:
"Each pin can be programmed as an output, an input, or as bidirectional
for certain alternate functions (that override the value programmed in the
GPIO direction registers)."

So, you're right and GPDR does meter for AC97_nRESET.
I'll send a v2.

Thanks!

-- 
Regards,
Igor.
