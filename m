From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Tue, 04 Nov 2014 00:08:51 +0100
Subject: PCIe host controller without IO port access.
In-Reply-To: <CAL_JsqK0737hND4C0pkNXYwyuecm8K2k=LUMNDZvqdkg=H52NA@mail.gmail.com>
References: <5456C024.4060103@hauke-m.de>
 <CAErSpo5wxRyfpfaTM-MqwMYqzV4tYzz5uZKV5kRWwi5Y7-CiqQ@mail.gmail.com>
 <CAL_JsqK0737hND4C0pkNXYwyuecm8K2k=LUMNDZvqdkg=H52NA@mail.gmail.com>
Message-ID: <54580B03.1090700@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 11:00 PM, Rob Herring wrote:
> On Mon, Nov 3, 2014 at 11:41 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Rob (author of 3c5d1699887b), Arnd]
>>
>> On Sun, Nov 2, 2014 at 4:37 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>>> Hi,
>>>
>>> I am currently writing a driver for a PCIe host controller which does
>>> not support IO port access.
>>>
>>> My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
>>> but then it allocates some generic IORESOURCE_IO memory in
>>> arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
>>> the fist PCIe controller, but when the second controller gets registered
>>> I am getting this: "unable to allocate I/O port region (-16)".
>>>
>>> Is there an example for an arm driver for a PCIe controller which does
>>> not support IO port access?
>>>
>>> Should I change arch/arm/kernel/bios32.c in a way so that it would
>>> ignore the io port mem?
>>
>> I think this is a case of "all current platforms support an I/O space,
>> so we'll set it up in the ARM PCI core."  But I/O space is not (as far
>> as I know) a required feature of PCI host bridges on ARM, so I suspect
>> you should change arch/arm/kernel/bios32.c in some way to accomodate
>> controllers with no I/O port space at all.
> 
> I guess we could ignore the error on request_resource or define a way
> to flag no i/o space. However, any new driver should be using all the
> new generic infrastructure. I think this code path should not even be
> called in that case.

Is there an example on how to use the new generic infrastructure? I used
drivers/pci/host/pci-host-generic.c as a reference for my driver and
thought it is using the recent infrastructure.

I am working on a BCM5310X SoC and it has a PCIe controller without I/O
port. As far as I know it is only intended to connect some Broadcom Wifi
cards to the SoC. There are also some MIPS based router SoCs without I/O
port support from other vendors.

Hauke
