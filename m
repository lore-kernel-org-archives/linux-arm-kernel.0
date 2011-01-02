From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Sat, 01 Jan 2011 22:26:58 -0800
Subject: [PATCH] GIC: Assign correct flow handler type in set_type callback
In-Reply-To: <4D1DB2DD.3020701@codeaurora.org>
References: <1293686960-12581-1-git-send-email-adharmap@codeaurora.org>	<AANLkTimA8ZP4WL8u0Uvtt-0MWXPkGfjwQ7437pL-h0D-@mail.gmail.com>
	<4D1DB2DD.3020701@codeaurora.org>
Message-ID: <4D201AB2.7050805@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31/2010 02:39 AM, Abhijeet Dharmapurikar wrote:
> On 12/29/2010 10:27 PM, Rabin Vincent wrote:
>> On Thu, Dec 30, 2010 at 10:59 AM, Abhijeet Dharmapurikar
>> <adharmap@codeaurora.org> wrote:
>>> There are some interrupts that are true edge triggered in nature. If not
>>> marked IRQ_PENDING, when disabled, they will be lost.
>>>
>>> Use the set_type callback to assign the correct flow type handler for
>>> shared peripheral interrupts.
>>>
>>> Signed-off-by: Abhijeet Dharmapurikar<adharmap@codeaurora.org>
>>> ---
>>> This came to light when a edge triggered interrupt was supposed to
>>> wakeup the
>>> sytem. The flow handler was set to the default handle_level_irq. On
>>> the resume
>>> path the flow handler was invoked right after the I bit was cleared
>>> but before
>>> each individual interrupts were enabled. This made the
>>> handle_level_irq ignore
>>
>> Why does the flow handler hit when the interrupt is disabled? Have you
>> set
>> IRQF_NOSUSPEND on this interrupt?
>>
> Since GIC doesnt have disable callback it implements lazy disabling. The
> interrupt is only marked IRQ_DISABLED in the descriptor but is not
> masked in the GIC. Hence the interrupt flow handler is hit.
>
> Now that I re-read the code setting IRQF_NO_SUSPEND would fix the issue.

Let me correct myself, IRQF_NO_SUSPEND isnt exactly what I want to do. 
If an interrupt triggers after suspend_device_irqs() is run and before 
the I bit is set in arch_suspend_disable_irqs() the system will handle 
the interrupt but will not abort suspend - check_wakeup_irqs() will 
return 0.

IMO, using handle_edge_irq() for an edge triggered wakeup interrupt 
would be the right way to address the issue.
