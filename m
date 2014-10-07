From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 7 Oct 2014 13:35:23 +0200
Subject: [RFC] pinctrl driver for Zynq
In-Reply-To: <CACRpkdaZ2Yy7=CcOjnsQ0K7KYTN=wHaeZTDNxpvnf+axLLLJ_g@mail.gmail.com>
References: <c2b9a1c1-d3b9-48c5-9c14-a4c3a95965fa@BN1AFFO11FD046.protection.gbl>
 <CACRpkdaZ2Yy7=CcOjnsQ0K7KYTN=wHaeZTDNxpvnf+axLLLJ_g@mail.gmail.com>
Message-ID: <90d8a43bab8a4bbfa018b497ce2d6c4d@BY2FFO11FD002.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Soren will reply it I believe just some explanation from me.

>> diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
>> index 4cc9913078cd..1ae9bcaee252 100644
>> --- a/arch/arm/boot/dts/zynq-zc706.dts
>> +++ b/arch/arm/boot/dts/zynq-zc706.dts
>> @@ -33,11 +33,20 @@
>>  &gem0 {
> 
> I'm not familiar with this syntax of putting an ampersand in front
> of a node like that. What does that mean? To me ampersands
> are phandles :-/

It just uses node label as reference and add some properties to it.
It means gem0 node is in dtsi and in this dts we want to extend it
by board specific information.

...

>> +       pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
>> +       if (!pctrl)
>> +               return -ENOMEM;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       slcr = of_get_parent(pdev->dev.of_node);
>> +       if (slcr->data) {
>> +               pctrl->regs = (__force void __iomem *)slcr->data + res->start;
> 
> This looks weird. Use DT parsing functions and accessors, no funny
> business like this. The res-start to the device should be the real
> physical address, not a relative base with offset, dunno what happened
> here but it is wrong.

Soren already has follow up version with is using regmap interface because slcr
is parent and it is syscon. That's why this code will go away.

Thanks,
Michal
