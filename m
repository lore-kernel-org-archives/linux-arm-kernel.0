From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 07 Sep 2016 13:47:22 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <75ca65eb-e8c4-bc3f-e00b-b0cba46d28c6@arm.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <5844875.KucAoPMrXi@wuerfel> <20160907063313.GA13903@b29397-desktop>
 <12021424.cItk3A7CfE@wuerfel> <20160907095549.GD13903@b29397-desktop>
 <75ca65eb-e8c4-bc3f-e00b-b0cba46d28c6@arm.com>
Message-ID: <874m5skmv9.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Robin Murphy <robin.murphy@arm.com> writes:
> On 07/09/16 10:55, Peter Chen wrote:
> [...]
>>> Regarding the DMA configuration that you mention in ci_hdrc_add_device(),
>>> I think we should replace 
>>>
>>>         pdev->dev.dma_mask = dev->dma_mask;
>>>         pdev->dev.dma_parms = dev->dma_parms;
>>>         dma_set_coherent_mask(&pdev->dev, dev->coherent_dma_mask);
>>>
>>> with of_dma_configure(), which has the chance to configure more than
>>> just those three, as the dma API might look into different aspects:
>>>
>>> - iommu specific configuration
>>> - cache coherency information
>>> - bus type
>>> - dma offset
>>> - dma_map_ops pointer
>>>
>>> We try to handle everything in of_dma_configure() at configuration
>>> time, and that would be the place to add anything else that we might
>>> need in the future.
>>>
>> 
>> Yes, I agree with you, but just like Felipe mentioned, we also need to
>> consider PCI device, can we do something like gpiod_get_index does? Are
>> there any similar APIs like of_dma_configure for ACPI?
>
> Not yet, but Lorenzo has one in progress[1], primarily for the sake of
> abstracting away the IOMMU configuration.
>
> Robin.
>
> [1]:http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1209911.html

not exported for drivers to use. If Lorenzo is trying to making a
matching API for ACPI systems, then it needs to follow what
of_dma_configure() is doing, and add an EXPORT_SYMBOL_GPL()

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/7e2c94c2/attachment.sig>
