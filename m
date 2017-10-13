From: ray.jui@broadcom.com (Ray Jui)
Date: Fri, 13 Oct 2017 16:24:19 -0700
Subject: [PATCH] PCI: iproc: Allow allocation of multiple MSIs
In-Reply-To: <CABLWAfR+Nk85wurWnPArpmFPXVhxn0jZ+7H13WnKEPCMJVU0XA@mail.gmail.com>
References: <20171007120851.20230-1-sbodomerle@gmail.com>
 <d0467282-a44a-bd1e-e449-0bba953c4cfd@broadcom.com>
 <CABLWAfR+Nk85wurWnPArpmFPXVhxn0jZ+7H13WnKEPCMJVU0XA@mail.gmail.com>
Message-ID: <893cb377-53c0-5a65-af82-c8be4c74c83b@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, the change looks okay to me. It would be nice to test it on an 
SMP system if possible. But I don't see how the change should break 
existing support for IRQ affinity setting.

With that,

Reviewed-by: Ray Jui <ray.jui@broadcom.com>

Regards,

Ray

On 10/11/2017 1:26 AM, Sandor Bodo-Merle wrote:
> Hi Ray,
> 
> we tested on a custom board based on BCM56260. SMP affinity was not
> tested as our board runs on a single core.
> 
> br,
> 
> Sandor
> 
> ps - sorry for the duplicate, but by default gmail sent out html
> formatted mail :(
> 
> On Tue, Oct 10, 2017 at 8:09 PM, Ray Jui <ray.jui@broadcom.com> wrote:
>> Hi Bodo,
>>
>>
>> On 10/7/2017 5:08 AM, Bodo-Merle Sandor wrote:
>>>
>>> From: Sandor Bodo-Merle <sbodomerle@gmail.com>
>>>
>>> Add support for allocating multiple MSIs at the same time, so that the
>>> MSI_FLAG_MULTI_PCI_MSI flag can be added to the msi_domain_info
>>> structure.
>>>
>>> Avoid storing the hwirq in the low 5 bits of the message data, as it is
>>> used by the device. Also fix an endianness problem by using readl().
>>>
>>> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
>>> ---
>>>    drivers/pci/host/pcie-iproc-msi.c | 19 ++++++++++++-------
>>>    1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/host/pcie-iproc-msi.c
>>> b/drivers/pci/host/pcie-iproc-msi.c
>>> index 2d0f535a2f69..990fc906d73d 100644
>>> --- a/drivers/pci/host/pcie-iproc-msi.c
>>> +++ b/drivers/pci/host/pcie-iproc-msi.c
>>> @@ -179,7 +179,7 @@ static struct irq_chip iproc_msi_irq_chip = {
>>>      static struct msi_domain_info iproc_msi_domain_info = {
>>>          .flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>> -               MSI_FLAG_PCI_MSIX,
>>> +               MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
>>>          .chip = &iproc_msi_irq_chip,
>>>    };
>>>    @@ -237,7 +237,7 @@ static void iproc_msi_irq_compose_msi_msg(struct
>>> irq_data *data,
>>>          addr = msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
>>>          msg->address_lo = lower_32_bits(addr);
>>>          msg->address_hi = upper_32_bits(addr);
>>> -       msg->data = data->hwirq;
>>> +       msg->data = data->hwirq << 5; >   }
>>>      static struct irq_chip iproc_msi_bottom_irq_chip = {
>>> @@ -251,7 +251,7 @@ static int iproc_msi_irq_domain_alloc(struct
>>> irq_domain *domain,
>>>                                        void *args)
>>>    {
>>>          struct iproc_msi *msi = domain->host_data;
>>> -       int hwirq;
>>> +       int hwirq, i;
>>>          mutex_lock(&msi->bitmap_lock);
>>>    @@ -267,10 +267,14 @@ static int iproc_msi_irq_domain_alloc(struct
>>> irq_domain *domain,
>>>          mutex_unlock(&msi->bitmap_lock);
>>>    -     irq_domain_set_info(domain, virq, hwirq,
>>> &iproc_msi_bottom_irq_chip,
>>> -                           domain->host_data, handle_simple_irq, NULL,
>>> NULL);
>>> +       for (i = 0; i < nr_irqs; i++) {
>>> +               irq_domain_set_info(domain, virq + i, hwirq + i,
>>> +                                   &iproc_msi_bottom_irq_chip,
>>> +                                   domain->host_data, handle_simple_irq,
>>> +                                   NULL, NULL);
>>> +       }
>>>    -     return 0;
>>> +       return hwirq;
>>>    }
>>>      static void iproc_msi_irq_domain_free(struct irq_domain *domain,
>>> @@ -302,7 +306,8 @@ static inline u32 decode_msi_hwirq(struct iproc_msi
>>> *msi, u32 eq, u32 head)
>>>          offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
>>>          msg = (u32 *)(msi->eq_cpu + offs);
>>> -       hwirq = *msg & IPROC_MSI_EQ_MASK;
>>> +       hwirq = readl(msg);
>>> +       hwirq = (hwirq >> 5) + (hwirq & 0x1f);
>>>          /*
>>>           * Since we have multiple hwirq mapped to a single MSI vector,nnn
>>>
>>
>> Change looks okay to me in general. May I know which platform you tested
>> this patch on and was SMP affinity configuration tested?
>>
>> Thanks,
>>
>> Ray
