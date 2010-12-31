From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 31 Dec 2010 02:39:25 -0800
Subject: [PATCH] GIC: Assign correct flow handler type in set_type callback
In-Reply-To: <AANLkTimA8ZP4WL8u0Uvtt-0MWXPkGfjwQ7437pL-h0D-@mail.gmail.com>
References: <1293686960-12581-1-git-send-email-adharmap@codeaurora.org>
	<AANLkTimA8ZP4WL8u0Uvtt-0MWXPkGfjwQ7437pL-h0D-@mail.gmail.com>
Message-ID: <4D1DB2DD.3020701@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2010 10:27 PM, Rabin Vincent wrote:
> On Thu, Dec 30, 2010 at 10:59 AM, Abhijeet Dharmapurikar
> <adharmap@codeaurora.org>  wrote:
>> There are some interrupts that are true edge triggered in nature. If not
>> marked IRQ_PENDING, when disabled, they will be lost.
>>
>> Use the set_type callback to assign the correct flow type handler for
>> shared peripheral interrupts.
>>
>> Signed-off-by: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
>> ---
>> This came to light when a edge triggered interrupt was supposed to wakeup the
>> sytem. The flow handler was set to the default handle_level_irq. On the resume
>> path the flow handler was invoked right after the I bit was cleared but before
>> each individual interrupts were enabled. This made the handle_level_irq ignore
>
> Why does the flow handler hit when the interrupt is disabled?  Have you set
> IRQF_NOSUSPEND on this interrupt?
>
Since GIC doesnt have disable callback it implements lazy disabling. The 
interrupt is only marked IRQ_DISABLED in the descriptor but is not 
masked in the GIC. Hence the interrupt flow handler is hit.

Now that I re-read the code setting IRQF_NO_SUSPEND would fix the issue. 
But shouldnt set_irq_wake() do something similar?

Do I need to request IRQF_NO_SUSPEND for all the interrupts that could 
possibly wakeup the system - seems a bit unnecessary. IMO the interrupt 
should not be disabled if it is marked IRQF_NO_SUPEND || IRQ_WAKEUP is set.

Abhijeet
