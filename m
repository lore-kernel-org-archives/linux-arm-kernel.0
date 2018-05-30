From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 30 May 2018 10:27:12 -0700
Subject: [PATCH 2/6] PCI: iproc: Add INTx support with better modeling
In-Reply-To: <CAHp75VfwfKbikfat3tTbMzSfNgt4v9nFpExyDvhOdX9ko1Z4Fw@mail.gmail.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
 <1527631130-20045-3-git-send-email-ray.jui@broadcom.com>
 <CAHp75VfwfKbikfat3tTbMzSfNgt4v9nFpExyDvhOdX9ko1Z4Fw@mail.gmail.com>
Message-ID: <9f4aedd8-17e0-3747-3bdb-2f2dc0a20756@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

On 5/29/2018 5:59 PM, Andy Shevchenko wrote:
> On Wed, May 30, 2018 at 12:58 AM, Ray Jui <ray.jui@broadcom.com> wrote:
>> Add PCIe legacy interrupt INTx support to the iProc PCIe driver by
>> modeling it with its own IRQ domain. All 4 interrupts INTA, INTB, INTC,
>> INTD share the same interrupt line connected to the GIC in the system,
>> while the status of each INTx can be obtained through the INTX CSR
>> register
> 
>> +       while ((status = iproc_pcie_read_reg(pcie, IPROC_PCIE_INTX_CSR) &
>> +               SYS_RC_INTX_MASK) != 0) {
>> +               for_each_set_bit(bit, &status, PCI_NUM_INTX) {
>> +                       virq = irq_find_mapping(pcie->irq_domain, bit + 1);
>> +                       if (virq)
>> +                               generic_handle_irq(virq);
>> +                       else
>> +                               dev_err(dev, "unexpected INTx%u\n", bit);
>> +               }
>> +       }
> 
> do {
>    status = ...;
>    for_each_set_bit() {
>      ...
>    }
> } while (status);
> 
> would look slightly better for my opinion.
> 

Indeed. I agree with you. I'll wait for comments before sending out v2 
which will include this improvement.

Thanks,

Ray
