From: adrian.hunter@intel.com (Adrian Hunter)
Date: Tue, 12 Apr 2016 12:59:14 +0300
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <20160412084048.GM19428@n2100.arm.linux.org.uk>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
 <20160411083510.GN10108@pengutronix.de> <570B780E.7090801@intel.com>
 <alpine.DEB.2.00.1604111803080.6072@blala.de> <570C902E.7090607@intel.com>
 <20160412084048.GM19428@n2100.arm.linux.org.uk>
Message-ID: <570CC6F2.4090301@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/16 11:40, Russell King - ARM Linux wrote:
> On Tue, Apr 12, 2016 at 09:05:34AM +0300, Adrian Hunter wrote:
>> On 11/04/16 19:13, Alexander Kurz wrote:
>>> Hi Adrian,
>>> On Mon, 11 Apr 2016, Adrian Hunter wrote:
>>>
>>>> On 11/04/16 11:35, Uwe Kleine-K?nig wrote:
>>>>> Hello,
>>>>>
>>>>> I added the people involved in 7b91369b4655 to Cc.
>>>>>
>>>>> On Mon, Apr 11, 2016 at 10:20:46AM +0200, Alexander Kurz wrote:
>>>>>> With commit 7b91369b DMA access got disabled for device drivers with zero
>>>>
>>>> Is that because dma_set_mask_and_coherent() fails?
>>> right, dma_set_mask_and_coherent() fails, thats the only reason for
>>> this patch. This popped up on a Kindle3 (IMX35 with eMMC based root fs).
>>
>> Arnd, Alexandre : Why should dma_set_mask_and_coherent() fail in this case
>> when DMA apparently doesn't need a dma_mask anyway?
> 
> What do you mean "doesn't need a dma_mask" ?  DMA _always_ requires a
> DMA mask.  The DMA mask defines how many address bits are capable of
> being used on the bus.
> 
> If there's no DMA mask, then there's no usable address bits, and so
> the device is not DMA capable.  Hence, dma_set_mask_and_coherent()
> will fail because its not possible to negotiate a non-zero number of
> address bits.
> 

The point is, now we valid dma_set_mask_and_coherent(), DMA will stop
working for any other SDHCI device that hasn't allocated dev.dma_mask.  Is
that OK?
