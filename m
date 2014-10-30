From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Thu, 30 Oct 2014 13:42:12 +0100
Subject: [RFT v3 06/14] regulator: max77802: Remove support for board files
In-Reply-To: <1414672235.23399.7.camel@AMDC1943>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-7-git-send-email-k.kozlowski@samsung.com>
 <54522615.7040002@collabora.co.uk> <1414671037.23399.2.camel@AMDC1943>
 <54522D2C.9050002@collabora.co.uk> <1414672235.23399.7.camel@AMDC1943>
Message-ID: <54523224.3010407@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 10/30/2014 01:30 PM, Krzysztof Kozlowski wrote:
tor_of_get_init_data() function?
>> > 
>> > The regulator_of_get_init_data() searches from dev->of_node or its child
>> > node.
>> > 
>> > But dev->of_node is NULL.
>> > 
>> > That's why of_compatible is needed.
>> 
>> Yes but regulator_register() does dev = config->dev and config->dev is set
>> to config.dev = iodev->dev in the driver probe function which is the
>> pdev->dev.parent (the PMIC struct device) that has an associated of_node.
>> 
>> So, regulator_of_get_init_data() will call of_get_child_by_name() passing
>> the PMIC of_node and the sub-node name that contains the regulators. That
>> is, whatever was set in desc->regulators_node and that should be enough.
> 
> I missed that one in max77802 (in max77686: config.dev = &pdev->dev).
> Now I wonder if it is proper to attach regulators to driver's parent
> device. Consider regulator_register, around line 3640:
> 	rdev->dev.parent = dev;
> The parent of regulators will be equal to parent of regulator driver -
> main MFD driver.
>

An early version of the max77802 regulator driver also set config.dev to
&pdev->dev but then Mark asked me if I was sure that it should not be the
MFD device instead.

I then read in regulator_register() that the rdev->dev.parent was set
to the device passed in config.dev as you said so I was convinced that it
should be the parent device instead.

Please take a look at [0] for that discussion.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/17/174
