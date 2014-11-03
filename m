From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 3 Nov 2014 10:41:22 -0700
Subject: PCIe host controller without IO port access.
In-Reply-To: <5456C024.4060103@hauke-m.de>
References: <5456C024.4060103@hauke-m.de>
Message-ID: <CAErSpo5wxRyfpfaTM-MqwMYqzV4tYzz5uZKV5kRWwi5Y7-CiqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Rob (author of 3c5d1699887b), Arnd]

On Sun, Nov 2, 2014 at 4:37 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Hi,
>
> I am currently writing a driver for a PCIe host controller which does
> not support IO port access.
>
> My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
> but then it allocates some generic IORESOURCE_IO memory in
> arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
> the fist PCIe controller, but when the second controller gets registered
> I am getting this: "unable to allocate I/O port region (-16)".
>
> Is there an example for an arm driver for a PCIe controller which does
> not support IO port access?
>
> Should I change arch/arm/kernel/bios32.c in a way so that it would
> ignore the io port mem?

I think this is a case of "all current platforms support an I/O space,
so we'll set it up in the ARM PCI core."  But I/O space is not (as far
as I know) a required feature of PCI host bridges on ARM, so I suspect
you should change arch/arm/kernel/bios32.c in some way to accomodate
controllers with no I/O port space at all.

Bjorn
