From: wangzhou1@hisilicon.com (Zhou Wang)
Date: Wed, 14 Oct 2015 16:59:03 +0800
Subject: [PATCH v10 4/6] PCI: hisi: Add PCIe host support for HiSilicon
 SoC Hip05
In-Reply-To: <11677087.JbqAo0FWJE@wuerfel>
References: <1444445957-239522-1-git-send-email-wangzhou1@hisilicon.com>
 <6336414.HvfCQcuT3Y@wuerfel>
 <EE11001F9E5DDD47B7634E2F8A612F2E16242C92@lhreml503-mbs>
 <11677087.JbqAo0FWJE@wuerfel>
Message-ID: <561E1957.5030503@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/13 23:00, Arnd Bergmann wrote:
> On Tuesday 13 October 2015 14:49:07 Gabriele Paoloni wrote:
>>> On Monday 12 October 2015 16:35:45 Bjorn Helgaas wrote:
>>>>
>>>>> +{
>>>>> +     u64 addr;
>>>>> +     struct device_node *msi_node;
>>>>> +     struct resource res;
>>>>> +     struct device_node *np = pp->dev->of_node;
>>>>> +     struct hisi_pcie *pcie = to_hisi_pcie(pp);
>>>>> +
>>>>> +     msi_node = of_parse_phandle(np, "msi-parent", 0);
>>>>> +     if (!msi_node) {
>>>>> +             dev_err(pp->dev, "failed to find msi-parent\n");
>>>>> +             return -EINVAL;
>>>>> +     }
>>>>> +     of_address_to_resource(msi_node, 0, &res);
>>>>
>>>> Does this use the "msi-parent" node in the same way as other drivers
>>>> do?  I'm sure there must be other places where we extract struct
>>>> resource information from an "msi-parent" node, but I don't see them.
>>>>
>>>> I'm trying to verify that this isn't some kind of incompatible
>>>> extension of the "msi-parent" property.  I cc'd Arnd and Rob (DT
>>>> experts).
>>>
>>> This is not ok, what this does is that it relies on a particular
>>> implementation of the MSI controller and directly accesses its
>>> registers.
>>
>> Hi Arnd, thanks for reviewing.
>>
>> What we do is to retrieve the msi-parent physical address and we store it
>> in our internal PCIe register locations...
> 
> Ah, thanks for the clarification, I missed that part.
> 
>> So we do not operate directly on the msi controller registers...
>>
>> So I wonder if the current implementation is Ok to retrieve the
>> msi-parent address....
> 
> Not sure. Why do you do this? Normally the PCI host does not know
> or care about the address of the MSI controller, because the messages
> are just passed up to the parent bus as DMA transfers.
>

Hi Arnd,

In Hip05 PCIe host, it uses GITS_TRANSLATER's address to get TLP package
which contains MSI address and MSI data, and then combine BDF and MSI data
to a 32 bit data which will be writen to GITS_TRANSLATER register of ITS.

I think maybe this is a defect of our PCIe controller.

> I don't think what you do here is safe because the 'reg' property
> of the MSI controller might point to the address that is used for
> the message directly.

I see your point, however we must get address of GITS_TRANSLATER and set it to PCIe
host. How about adding necessary comments here?

Best Regards,
Zhou

>
> 	Arnd
> 
> .
> 
