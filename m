From: zhichang.yuan02@gmail.com (zhichang.yuan)
Date: Sat, 1 Apr 2017 10:16:53 +0800
Subject: [PATCH V8 5/6] ACPI: Support the probing on the devices which
 apply indirect-IO
In-Reply-To: <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
References: <1490887619-61732-1-git-send-email-yuanzhichang@hisilicon.com>
 <1490887619-61732-6-git-send-email-yuanzhichang@hisilicon.com>
 <1908501.jAQQKvjW4f@aspire.rjw.lan> <58DDFCBE.1030705@hisilicon.com>
 <CAJZ5v0gZdghH7jjd-zMmqXNkuvVVVSPDHfBrJXx5OXR2NE0KgA@mail.gmail.com>
Message-ID: <bfdf2de0-c309-0139-4075-dfcd678b6d51@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/01/2017 07:02 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 31, 2017 at 8:52 AM, zhichang.yuan
> <yuanzhichang@hisilicon.com> wrote:
>> Hi, Rafael,
>>
>> Thanks for reviewing this!
>>
>> On 2017/3/31 4:31, Rafael J. Wysocki wrote:
>>> On Thursday, March 30, 2017 11:26:58 PM zhichang.yuan wrote:
>>>> On some platforms(such as Hip06/Hip07), the legacy ISA/LPC devices access I/O
>>>> with some special host-local I/O ports known on x86. To access the I/O
>>>> peripherals, an indirect-IO mechanism is introduced to mapped the host-local
>>>> I/O to system logical/fake PIO similar the PCI MMIO on architectures where no
>>>> separate I/O space exists. Just as PCI MMIO, the host I/O range should be
>>>> registered before probing the downstream devices and set up the I/O mapping.
>>>> But current ACPI bus probing doesn't support these indirect-IO hosts/devices.
>>>>
>>>> This patch introdueces a new ACPI handler for this device category. Through the
>>>> handler attach callback, the indirect-IO hosts I/O registration is done and
>>>> all peripherals' I/O resources are translated into logic/fake PIO before
>>>> starting the enumeration.
>>>
>>> Can you explain to me briefly what exactly this code is expected to be doing?
>>
>> As you know currently for ARM architecture IO space is memory mapped and
>> is only used by pci devices. The port number is dynamically allocated
>> converting the device IO address into a PIO token: i.e.
>> http://lxr.free-electrons.com/source/drivers/acpi/pci_root.c#L745
>> This patch is meant to support a new class of IO host controller
>> that are not PCI based and that still require to have the IO addresses
>> be translated in the same PIO token space as the PCI controller
> 
> IOW, this is ARM-specific, right?

Yes. The current host added in this patch with _HID "HISI0191" is on ARM64.
But, I think the handler driver is architecture dependent.

Thanks,
Zhichang

> 
> Thanks,
> Rafael
> 
