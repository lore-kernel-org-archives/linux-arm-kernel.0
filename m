From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 14 Jan 2010 12:22:49 +1300
Subject: [PATCH] Fix soft lockup in at91 udc driver
In-Reply-To: <3efb10971001131500i1ee520d1l983a04787c0a4c6c@mail.gmail.com>
References: <4990882D.3050302@bluewatersys.com>	
	<4999C24F.9050906@bluewatersys.com>
	<3efb10971001131500i1ee520d1l983a04787c0a4c6c@mail.gmail.com>
Message-ID: <4B4E55C9.6090703@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remy Bohmer wrote:
> Hi Ryan,
> 
> 2009/2/16 Ryan Mallon <ryan@bluewatersys.com>:
>> Ryan Mallon wrote:
>>> The udc registers are only writeable if the udc clocks are enabled, but
>>> udc interrupts can still occur. This can lead to a situation where an
>>> interrupt is perpetually received when the clocks are disabled and is
>>> never cleared or masked, which causes a lockup. The following patch
>>> ensures that the clocks are enabled while handling an interrupt:
>> Any comments on this patch? Has anybody else had problems with the AT91
>> UDC driver causing soft lockups?
> 
> Although this patch is now almost a year old, we first encountered
> this type of bug just a few weeks ago.
> The problem description you mention fits the problem we see. We also
> noticed that the clocks were disabled in the case our lockup occurs.
> 
> The funny thing is that we never encountered this problem with a
> 2.6.24(-rt) kernel. 2.6.31-rt11 did show this problem extremely rare,
> and now 2.6.31-rt19 shows it hard with a certain type of PCI-USB host
> controller. Many host-controllers work fine and we even have 2
> different PCI-boards (of different manufacturers) with the same NEC
> host-controller chip of which only 1 shows this problem.
> 
> So, it does not surprise me that nobody else noticed this problem
> before, although this patch really seems to be valid.
> If it works in our case as well, and we will verify it tomorrow, we
> should push it forward.

[Fixed the CC for the new location of the ARM kernel mailing list]

Awesome, thanks. The patch certainly fixed the problem on our board
(from memory I originally wrote this for our 2.6.20 kernel), but the
patch does seem valid even if the occurrence of the problem is rare. I
never bothered following up on it, because nobody else was reporting
problems.

If you could test and give me a Tested-by or Acked-by, then I'll rebase
and repost the patch.

Thanks,
~Ryan

>>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>>>
>>> --
>>>
>>> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
>>> index 0b2bb8f..fcbdf24 100644
>>> --- a/drivers/usb/gadget/at91_udc.c
>>> +++ b/drivers/usb/gadget/at91_udc.c
>>> @@ -1370,6 +1370,12 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
>>>  {
>>>       struct at91_udc         *udc = _udc;
>>>       u32                     rescans = 5;
>>> +     int                     disable_clock = 0;
>>> +
>>> +     if (!udc->clocked) {
>>> +             clk_on(udc);
>>> +             disable_clock = 1;
>>> +     }
>>>
>>>       while (rescans--) {
>>>               u32 status;
>>> @@ -1458,6 +1464,9 @@ static irqreturn_t at91_udc_irq (int irq, void *_udc)
>>>               }
>>>       }
>>>
>>> +     if (disable_clock)
>>> +             clk_off(udc);
>>> +
>>>       return IRQ_HANDLED;
>>>  }
>>>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
