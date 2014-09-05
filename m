From: wangyijing0307@gmail.com (wangyijing)
Date: Fri, 5 Sep 2014 19:33:08 +0800
Subject: [PATCH v1 15/21] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <540994D4.6040500@cogentembedded.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
 <1409911806-10519-16-git-send-email-wangyijing@huawei.com>
 <540994D4.6040500@cogentembedded.com>
Message-ID: <43412AE0-85BB-4B4B-A4EA-2C6D3B8B85D7@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> ? 2014?9?5??18:47?Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> ???
> 
> Hello.
> 
>> On 9/5/2014 2:10 PM, Yijing Wang wrote:
>> 
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
> 
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>>  arch/powerpc/kernel/msi.c |   14 ++++++++++++--
>>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
>> diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
>> index 71bd161..01781a4 100644
>> --- a/arch/powerpc/kernel/msi.c
>> +++ b/arch/powerpc/kernel/msi.c
> [...]
>> @@ -27,7 +27,17 @@ int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>      return ppc_md.setup_msi_irqs(dev, nvec, type);
>>  }
>> 
>> -void arch_teardown_msi_irqs(struct pci_dev *dev)
>> +static void ppc_teardown_msi_irqs(struct pci_dev *dev)
> 
>   Shouldn't this function take IRQ # instead?

This function need to teardown all msi irqs of the pci dev, we should pass the pci dev as argument .

Thanks!
Yijing.

> 
>>  {
>>      ppc_md.teardown_msi_irqs(dev);
>>  }
>> +
>> +static struct msi_chip ppc_msi_chip = {
>> +    .setup_irqs = ppc_setup_msi_irqs,
>> +    .teardown_irqs = ppc_teardown_msi_irqs,
>> +};
>> +
>> +struct msi_chip *arch_find_msi_chip(struct pci_dev *dev)
>> +{
>> +    return &ppc_msi_chip;
>> +}
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
