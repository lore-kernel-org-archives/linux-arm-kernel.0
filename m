From: ronald.wahl@raritan.com (Ronald Wahl)
Date: Thu, 07 Aug 2014 14:43:32 +0200
Subject: [PATCH v2] usb: gadget: at91_udc: move prepare clk into process
 context
In-Reply-To: <20140807095912.7648de46@bbrezillon>
References: <1407330702-2926-1-git-send-email-ronald.wahl@raritan.com>	<20140807095231.11bde829@bbrezillon>
 <20140807095912.7648de46@bbrezillon>
Message-ID: <53E37474.6060501@raritan.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.08.2014 09:59, Boris BREZILLON wrote:
> On Thu, 7 Aug 2014 09:52:31 +0200
> Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:
>> On Wed,  6 Aug 2014 15:11:42 +0200
>> Ronald Wahl <ronald.wahl@raritan.com> wrote:
>>
>>> Commit 7628083227b6bc4a7e33d7c381d7a4e558424b6b added clock preparation in
>>> interrupt context. This is not allowed as it might sleep. Move clock
>>> preparation into process context (at91udc_probe).
>>> ---
>>>   drivers/usb/gadget/udc/at91_udc.c | 39 ++++++++++++++++++++++++++++++---------
>>>   1 file changed, 30 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
>>> index cfd18bc..0b347a0 100644
>>> --- a/drivers/usb/gadget/udc/at91_udc.c
>>> +++ b/drivers/usb/gadget/udc/at91_udc.c
>>> @@ -872,10 +872,10 @@ static void clk_on(struct at91_udc *udc)
>>>
>>>   	if (IS_ENABLED(CONFIG_COMMON_CLK)) {
>>>   		clk_set_rate(udc->uclk, 48000000);
>>> -		clk_prepare_enable(udc->uclk);
>>> +		clk_enable(udc->uclk);
>>>   	}
>>> -	clk_prepare_enable(udc->iclk);
>>> -	clk_prepare_enable(udc->fclk);
>>> +	clk_enable(udc->iclk);
>>> +	clk_enable(udc->fclk);
>>>   }
>>>
>>>   static void clk_off(struct at91_udc *udc)
>>> @@ -884,10 +884,10 @@ static void clk_off(struct at91_udc *udc)
>>>   		return;
>>>   	udc->clocked = 0;
>>>   	udc->gadget.speed = USB_SPEED_UNKNOWN;
>>> -	clk_disable_unprepare(udc->fclk);
>>> -	clk_disable_unprepare(udc->iclk);
>>> +	clk_disable(udc->fclk);
>>> +	clk_disable(udc->iclk);
>>>   	if (IS_ENABLED(CONFIG_COMMON_CLK))
>>> -		clk_disable_unprepare(udc->uclk);
>>> +		clk_disable(udc->uclk);
>>>   }
>>
>> As you stated prepare and unprepare should never be called in interrupt
>> context.
>>
>> My concern here is that PLLB (which is often used as USB clock
>> parent) will never be gated/disabled (because all this work is
>> done in its unprepare method), and thus your power consumption will be
>> higher (when entering suspend mode) than if you'd done a
>> disable_unprepare call.
>>
>> How about leaving the clk_on/off unchanged and use a threaded irq
>> instead of a normal irq ?

Even with threaded interrupts things are still called while interrupts 
are disabled by one or more layers of spin_lock_irqsave. There are also 
different code paths from where clk_on() is called. So getting this 
right while saving power is probably not trivial and beyond my 
knowledge/experience with the udc code. It would be nice if someone with 
a deeper knowledge of the atmel udc code can get this right. My primary 
intention was to get the code working again.

thx & greets,
ron

-- 
Ronald Wahl - ronald.wahl at raritan.com - Phone +49 375271349-0 Fax -99
Raritan Deutschland GmbH, Kornmarkt 7, 08056 Zwickau, Germany
USt-IdNr. DE813094160, Steuer-Nr. 227/117/01749
Amtsgericht Chemnitz HRB 23605
Gesch?ftsf?hrung: Stuart Hopper, Ralf Ploenes
