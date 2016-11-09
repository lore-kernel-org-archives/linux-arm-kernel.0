From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 09 Nov 2016 09:53:25 +0200
Subject: [PATCH 01/30] usb: dwc2: Deprecate g-use-dma binding
In-Reply-To: <6e90b835-73b1-3970-24a4-eab72381b469@synopsys.com>
References: <cover.1478558343.git.johnyoun@synopsys.com>
 <e99e9d8df77884671f94734109a1a8d76a0222c1.1478558343.git.johnyoun@synopsys.com>
 <87wpgeibdh.fsf@linux.intel.com>
 <6e90b835-73b1-3970-24a4-eab72381b469@synopsys.com>
Message-ID: <87zil9gkcq.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

John Youn <John.Youn@synopsys.com> writes:
> On 11/8/2016 1:12 AM, Felipe Balbi wrote:
>> 
>> Hi,
>> 
>> John Youn <johnyoun@synopsys.com> writes:
>>> Add a vendor prefix and make the name more consistent by renaming it to
>>> "snps,gadget-dma-enable".
>>>
>>> Signed-off-by: John Youn <johnyoun@synopsys.com>
>>> ---
>>>  Documentation/devicetree/bindings/usb/dwc2.txt | 5 ++++-
>>>  arch/arm/boot/dts/rk3036.dtsi                  | 2 +-
>>>  arch/arm/boot/dts/rk3288.dtsi                  | 2 +-
>>>  arch/arm/boot/dts/rk3xxx.dtsi                  | 2 +-
>>>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 2 +-
>>>  arch/arm64/boot/dts/rockchip/rk3368.dtsi       | 2 +-
>>>  drivers/usb/dwc2/params.c                      | 9 ++++++++-
>>>  drivers/usb/dwc2/pci.c                         | 2 +-
>>>  8 files changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
>>> index 9472111..389a461 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
>>> @@ -26,11 +26,14 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
>>>  - dr_mode: shall be one of "host", "peripheral" and "otg"
>>>    Refer to usb/generic.txt
>>>  - snps,host-dma-disable: disable host DMA mode.
>>> -- g-use-dma: enable dma usage in gadget driver.
>>> +- snps,gadget-dma-enable: enable gadget DMA mode.
>> 
>> I don't see why you even have this binding. Looking through the code,
>> you have:
>> 
>> #define GHWCFG2_SLAVE_ONLY_ARCH			0
>> #define GHWCFG2_EXT_DMA_ARCH			1
>> #define GHWCFG2_INT_DMA_ARCH			2
>> 
>> void dwc2_set_param_dma_enable(struct dwc2_hsotg *hsotg, int val)
>> {
>> 	int valid = 1;
>> 
>> 	if (val > 0 && hsotg->hw_params.arch == GHWCFG2_SLAVE_ONLY_ARCH)
>> 		valid = 0;
>> 	if (val < 0)
>> 		valid = 0;
>> 
>> 	if (!valid) {
>> 		if (val >= 0)
>> 			dev_err(hsotg->dev,
>> 				"%d invalid for dma_enable parameter. Check HW configuration.\n",
>> 				val);
>> 		val = hsotg->hw_params.arch != GHWCFG2_SLAVE_ONLY_ARCH;
>> 		dev_dbg(hsotg->dev, "Setting dma_enable to %d\n", val);
>> 	}
>> 
>> 	hsotg->core_params->dma_enable = val;
>> }
>> 
>> which seems to hint that DMA support is discoverable. If there is DMA,
>> why would disable it?
>> 
>
> Yes that's the case and I would prefer to make it discoverable and
> enabled by default.
>
> But the legacy behavior has always been like this because DMA was
> never fully implemented in the gadget driver and it was an opt-in
> feature. Periodic support was only added recently.

legacy behavior can be changed if another 'policy' makes more
sense. IMHO, whatever can be discovered in runtime, should be enabled by
default. That way, we force people to use it and find bugs in certain
features.

> What do you think about enabling it by default now? I think most
> platforms already use DMA.

I think it should be discovered. Drop all these "*-use-dma" bindings
because they're not needed if you can probe a register to answer the
same question.

> We would still need a "disable" binding for IP validation purposes at
> least.

Yeah, could be a quirk.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161109/0691c4a0/attachment.sig>
