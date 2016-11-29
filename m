From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Nov 2016 18:04:33 +0530
Subject: [PATCH] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <b2ddb9ed-2cf8-da93-6aba-e77ea0eea006@baylibre.com>
References: <1480350566-26225-1-git-send-email-abailon@baylibre.com>
 <36a2e5e1-e7b7-2ca0-0484-98636771ec65@ti.com>
 <b2ddb9ed-2cf8-da93-6aba-e77ea0eea006@baylibre.com>
Message-ID: <aac017b2-fc5b-6773-46b3-fd797dc904a6@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2016 04:46 PM, Alexandre Bailon wrote:
> On 11/29/2016 11:48 AM, Sekhar Nori wrote:
>> On Monday 28 November 2016 09:59 PM, Alexandre Bailon wrote:
>>> Everytime the usb20 phy is enabled, there is a
>>> "sleeping function called from invalid context" BUG.
>>
>> Who calls PHY clk_enable() from non-preemptible context? Can you provide
>> the call stack?
> Actually, clk_enable() is called from preemptible context (from phy
> driver) but it disables interrupts before to call the clk_enable()
> callback.
> I attached the call stack that is probably more understandable than
> my explanation.

Thanks! So this happens due to spin_lock_irqsave() in clk_enable() in
arch/arm/mach-davinci/clock.c. Can you add reference to this in your
commit description.

Also +David since this issue should have shown up since the time this
code was added.

>>>  		pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
>>>  		return;
>>>  	}
>>>  
>>>  	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
>>> -	err = clk_prepare_enable(usb20_clk);
>>> +	err = clk_enable(usb20_clk);
>>>  	if (err) {
>>>  		pr_err("failed to enable usb20 clk: %d\n", err);
>>>  		clk_put(usb20_clk);
>>> @@ -197,8 +197,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
>>>  
>>>  	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
>>>  done:
>>> -	clk_disable_unprepare(usb20_clk);
>>> -	clk_put(usb20_clk);
>>> +	clk_disable(usb20_clk);
>>
>>
>> I noticed that we are missing clk_disable(usb20_clk) in
>> usb20_phy_clk_disable(). It will now be easier to do that after this
>> patch. Can you add that in a separate patch?
>>
> I don't think we need it.
> What we don't see in this patch is that usb20_clk is enabled and,
> it is disabled right after the PHY PLL is ready in usb20_phy_clk_enable().

Agreed.

Thanks,
Sekhar
