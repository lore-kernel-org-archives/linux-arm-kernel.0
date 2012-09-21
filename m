From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 20 Sep 2012 21:19:30 -0600
Subject: [PATCH v2 2/2] PCI: Provide a default pcibios_update_irq()
In-Reply-To: <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
References: <1347880974-13615-1-git-send-email-thierry.reding@avionic-design.de>
 <1347880974-13615-2-git-send-email-thierry.reding@avionic-design.de>
 <20120920083731.b99255eb8fdeea908d34ed2f@canb.auug.org.au>
Message-ID: <CAErSpo4RgNjFE7zH9vKTgAq_7djbWi5sR7k_DJYr8=G3A=0zeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 4:37 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi,
>
> On Mon, 17 Sep 2012 13:22:54 +0200 Thierry Reding <thierry.reding@avionic-design.de> wrote:
>>
>> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
>> index 270ae7b..3d61ce3 100644
>> --- a/drivers/pci/setup-irq.c
>> +++ b/drivers/pci/setup-irq.c
>> @@ -17,6 +17,11 @@
>>  #include <linux/ioport.h>
>>  #include <linux/cache.h>
>>
>> +void __weak pcibios_update_irq(struct pci_dev *dev, int irq)
>> +{
>> +     dev_dbg(&dev->dev, "Assigning IRQ %02d\n", irq);
>> +     pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>> +}
>>
>>  static void
>>  pdev_fixup_irq(struct pci_dev *dev,
>
> Didn't we have a problem with some compiler versions when the weak
> definition was in the same file as the call (there is a call to this
> function in drivers/pci/setup-irq.c)?

There was such a bug, but as far as I know, we aren't worrying about
it anymore: https://lkml.org/lkml/2011/7/4/9
