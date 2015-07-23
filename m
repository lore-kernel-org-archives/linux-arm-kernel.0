From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 10:36:54 -0500
Subject: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
In-Reply-To: <55B0FFB8.3030506@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
 <20150723130637.GR21967@google.com> <55B0FFB8.3030506@arm.com>
Message-ID: <CAErSpo5DgUMB4FYrjLXnLf8KFx-KPpd_bCnogSv_nsADuV0tjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 9:52 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/07/15 14:06, Bjorn Helgaas wrote:
>> On Thu, Jul 23, 2015 at 10:26:23AM +0100, Marc Zyngier wrote:
>>> In order to be able to populate the device msi_domain field,
>>> add the necessary hooks to propagate the host bridge msi_domain
>>> across secondary busses to devices.
>>>
>>> So far, nobody populates the initial msi_domain.
>>>
>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>
>>> +static void pci_set_msi_domain(struct pci_dev *dev)
>>> +{
>>> +    /*
>>> +     * If no domain has been set through the pcibios callback,
>>> +     * inherit the default from the bus device.
>>
>> Nit: there isn't a pcibios callback anymore.
>
> There is actually one, in pci_add_device:
>
>         [...]
>         ret = pcibios_add_device(dev);
>         WARN_ON(ret < 0);
>
>         /* Setup MSI irq domain */
>         pci_set_msi_domain(dev);
>         [...]
>
> pcibios_add_device is the one I was referring to. I'll clarify the comment.

Oh, right!  I thought you were referring to
pcibios_set_host_bridge_msi_domain(), which got removed, but of course
that wouldn't even make sense.
