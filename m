From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 24 Jun 2013 19:52:45 -0600
Subject: [PATCHv3 02/11] pci: use weak functions for MSI arch-specific
 functions
In-Reply-To: <20130620185707.GA8888@mithrandir>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130620185707.GA8888@mithrandir>
Message-ID: <CAErSpo6Mm6kYZKN_n-fMRD2T1-F0sf9GStmOTA8tT0wVLedCgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 12:57 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jun 19, 2013 at 06:56:10PM +0200, Thomas Petazzoni wrote:
> [...]
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index 2c10752..4bc0c8f 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -30,19 +30,35 @@ static int pci_msi_enable = 1;
>>
>>  /* Arch hooks */
>>
>> -#ifndef arch_msi_check_device
>> -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
>> +int default_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +{
>> +     return -EINVAL;
>> +}
>> +
>> +int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>> +{
>> +     return default_setup_msi_irq(dev, desc);
>> +}
>> +
>> +void default_teardown_msi_irq(unsigned int irq)
>> +{
>> +}
>> +
>> +void __weak arch_teardown_msi_irq(unsigned int irq)
>> +{
>> +     return default_teardown_msi_irq(irq);
>> +}
>> +
>> +int default_msi_check_device(struct pci_dev *dev, int nvec, int type)
>>  {
>>       return 0;
>>  }
>> -#endif
>
> I don't think keeping the default_*() for these three is necessary,
> given that they don't do anything and therefore no architecture is
> likely to call them when overriding.

I agree; the whole point of __weak is to provide a "default"
implementation, so I hope you can just remove any empty default_*()
functions and fold the others into the arch_*() functions directly.

If there actually are callbacks from arch-specific strong functions
back to the stuff in the default_*() functions, that suggests that we
should refactor and rename that bit of functionality.

Bjorn
