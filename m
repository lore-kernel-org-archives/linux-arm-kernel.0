From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 14 Sep 2012 15:31:45 +0100
Subject: [PATCH v4 16/24] xen: clear IRQ_NOAUTOEN and IRQ_NOREQUEST
In-Reply-To: <alpine.DEB.2.02.1209141527030.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209141145150.29232@kaball.uk.xensource.com>
 <1347621207-11294-16-git-send-email-stefano.stabellini@eu.citrix.com>
 <505338E6.4050504@arm.com>
 <alpine.DEB.2.02.1209141508130.29232@kaball.uk.xensource.com>
 <50533D46.5000704@arm.com>
 <alpine.DEB.2.02.1209141527030.29232@kaball.uk.xensource.com>
Message-ID: <50533FD1.6000005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/09/12 15:28, Stefano Stabellini wrote:
> On Fri, 14 Sep 2012, Marc Zyngier wrote:
>> On 14/09/12 15:13, Stefano Stabellini wrote:
>>> On Fri, 14 Sep 2012, Marc Zyngier wrote:
>>>> On 14/09/12 12:13, Stefano Stabellini wrote:
>>>>> Reset the IRQ_NOAUTOEN and IRQ_NOREQUEST flags that are enabled by
>>>>> default on ARM. If IRQ_NOAUTOEN is set, __setup_irq doesn't call
>>>>> irq_startup, that is responsible for calling irq_unmask at startup time.
>>>>> As a result event channels remain masked.
>>>>>
>>>>> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
>>>>> Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>>>> ---
>>>>>  drivers/xen/events.c |    1 +
>>>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
>>>>> index 5ecb596..8ffb7b7 100644
>>>>> --- a/drivers/xen/events.c
>>>>> +++ b/drivers/xen/events.c
>>>>> @@ -836,6 +836,7 @@ int bind_evtchn_to_irq(unsigned int evtchn)
>>>>>  		struct irq_info *info = info_for_irq(irq);
>>>>>  		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
>>>>>  	}
>>>>> +	irq_clear_status_flags(irq, IRQ_NOREQUEST|IRQ_NOAUTOEN);
>>>>
>>>> This one just sent a shiver down my spine. Are you doing this for a PPI?
>>>
>>> Not really: even though there is just one source of event notifications
>>> (that is a PPI), we have many event channels. When a domain receives a
>>> notification (via the PPI), it checks on a bitmask to which event channel
>>> it corresponds. From the Linux point of view every event channel is a
>>> Linux irq belonging to the xen_dynamic_chip (see
>>> drivers/xen/events.c:xen_dynamic_chip).
>>>
>>> So here I am not doing this for the one PPI, but I am doing this for
>>> every Linux irq (of chip xen_dynamic_chip) that represents an event
>>> channel.
>>
>> So this is some sort of secondary interrupt controller, cascaded into
>> your GIC emulation,
>     
> I guess it could be seen as a secondary interrupt controller
> 
> 
>> and this patch only affects the xen_dynamic_chip?
> 
> Yep

Thanks. I feel relieved... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
