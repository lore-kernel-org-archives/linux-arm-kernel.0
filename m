From: feumilieu@gmail.com (Aleksey Makarov)
Date: Sun, 30 Aug 2015 12:20:38 +0300
Subject: [PATCH net-next 6/8] net: thunderx: Rework interrupt handler
In-Reply-To: <CALW4P++2cG5epoit8BXBjp7Z2PK=P5wqbxkDqrt6kCa7SaZK+g@mail.gmail.com>
References: <CALW4P++2cG5epoit8BXBjp7Z2PK=P5wqbxkDqrt6kCa7SaZK+g@mail.gmail.com>
Message-ID: <55E2CAE6.1040305@auriga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.08.2015 04:44, Alexey Klimov wrote:

>> -static irqreturn_t nicvf_intr_handler(int irq, void *nicvf_irq)
>> +static irqreturn_t nicvf_intr_handler(int irq, void *cq_irq)
>> +{
>> +       struct nicvf_cq_poll *cq_poll = (struct nicvf_cq_poll *)cq_irq;
>> +       struct nicvf *nic = cq_poll->nicvf;
>> +       int qidx = cq_poll->cq_idx;
>> +
>> +       nicvf_dump_intr_status(nic);
>> +
>> +       /* Disable interrupts */
>> +       nicvf_disable_intr(nic, NICVF_INTR_CQ, qidx);
>> +
>> +       /* Schedule NAPI */
>> +       napi_schedule(&cq_poll->napi);
>> +
>> +       /* Clear interrupt */
>> +       nicvf_clear_intr(nic, NICVF_INTR_CQ, qidx);
>> +
>> +       return IRQ_HANDLED;
>> +}
>
> You're not considering spurious irqs in all new irq handlers here and
> below and schedule napi/tasklets unconditionally. Is it correct?
> For me it looks like previous implementation relied on reading of
> NIC_VF_INT to understand irq type and what actions should be
> performed. It generally had idea that no interrupt might occur.

1. The previous version of the handler did not handle spurious 
interrupts either.  Probably that means that the author of the patch 
knows for sure that they do not happen.

2. Instead of reading the status register new version registers 
different handlers for different irqs.  I don't see why it can be wrong.

I am going to address your other suggestions in the next version of the 
patchset.

Thank you
Aleksey Makarov
