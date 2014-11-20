From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Thu, 20 Nov 2014 13:01:08 +0100
Subject: [RFC PATCH 00/16] Refine PCI host bridge scan interfaces
In-Reply-To: <1534030.bkpIToWlHq@wuerfel>
References: <1416219710-26088-1-git-send-email-wangyijing@huawei.com>
 <20535707.3sA6NjSINh@wuerfel> <546B38F5.6050708@huawei.com>
 <1534030.bkpIToWlHq@wuerfel>
Message-ID: <546DD804.4010105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.11.2014 13:27, Arnd Bergmann wrote:
> On Tuesday 18 November 2014 20:17:57 Yijing Wang wrote:
>>
>>>>
>>>> I hope platforms with ACPI or DT could both use pci_create_host_bridge().
>>>> Why we need to use two different ways to process it ?
>>>
>>> These are completely different use cases:
>>>
>>> a) For DT, we want loadable device drivers that start by probing a host
>>>     bridge device which was added through the DT platform code. The
>>>     driver is self-contained, and eventually we want to be able to unload
>>>     it. We have lots of different per-soc drivers that require different
>>>     quirks
>>>
>>> b) For ACPI, the interface is defined in the ACPI spec across architectures
>>>     and SoCs, we don't have host bridge drivers and the code that initializes
>>>     the PCI is required early during boot and called from architecture
>>>     code. There is no parent device, as ACPI sees PCI as a fundamental building
>>>     block by itself, and there are no drivers because the firmware does
>>>     the initial hardware setup, so we only have to access the config space.
>>
>> Hmmm, I'm a little confused, so why you think ACPI host driver should not use
>> pci_create_host_bridge(), because ACPI PCI driver has no parent device ?
>
> It's one of the difference. Having a parent device can certainly make your
> life simpler, since you have devm_kzalloc(), dev_info(), etc. Coming from
> the other end, I think ACPI needs PCI to be available during early boot,
> at a time where we might not want pci_create_host_bridge() to do the
> right thing.

Device pointer is not required for ACPI, struct acpi_device is all we 
need to get all that info. If pci_create_host_bridge() would be DT 
specific, it would be nice to have sth similar for ACPI but that is out 
of this patch set scope.

Tomasz
