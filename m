From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 13:30:35 +0100
Subject: [RFT v3 06/14] regulator: max77802: Remove support for board files
In-Reply-To: <54522D2C.9050002@collabora.co.uk>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
 <1414668053-31370-7-git-send-email-k.kozlowski@samsung.com>
 <54522615.7040002@collabora.co.uk> <1414671037.23399.2.camel@AMDC1943>
 <54522D2C.9050002@collabora.co.uk>
Message-ID: <1414672235.23399.7.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On czw, 2014-10-30 at 13:21 +0100, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 10/30/2014 01:10 PM, Krzysztof Kozlowski wrote:
> >> 
> >> I may be missing something but I don't understand why a compatible string
> >> for the regulators sub-node is needed. Isn't enough to just fill the
> >> .regulators_node field in the struct regulator_desc? e.g:
> >> 
> >>     .regulators_node = of_match_ptr("regulators") for max77802
> >>     .regulators_node = of_match_ptr("voltage-regulators") for max77686
> >> 
> >> AFAIU this should be enough for the core to extract the init_data and will
> >> make your change much more simpler and you can drop patches 1-3 and 13-14.
> >> 
> >> Or maybe I misread the regulator_of_get_init_data() function?
> > 
> > The regulator_of_get_init_data() searches from dev->of_node or its child
> > node.
> > 
> > But dev->of_node is NULL.
> > 
> > That's why of_compatible is needed.
> 
> Yes but regulator_register() does dev = config->dev and config->dev is set
> to config.dev = iodev->dev in the driver probe function which is the
> pdev->dev.parent (the PMIC struct device) that has an associated of_node.
> 
> So, regulator_of_get_init_data() will call of_get_child_by_name() passing
> the PMIC of_node and the sub-node name that contains the regulators. That
> is, whatever was set in desc->regulators_node and that should be enough.

I missed that one in max77802 (in max77686: config.dev = &pdev->dev).
Now I wonder if it is proper to attach regulators to driver's parent
device. Consider regulator_register, around line 3640:
	rdev->dev.parent = dev;
The parent of regulators will be equal to parent of regulator driver -
main MFD driver.

Best regards,
Krzysztof
