From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 09 Jan 2014 19:18:45 +0100
Subject: [PATCH v3 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <4432391.5QkdBVBQQi@wuerfel>
References: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
 <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
 <4432391.5QkdBVBQQi@wuerfel>
Message-ID: <52CEE805.8010703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/09/2014 07:07 PM, Arnd Bergmann wrote:
> On Thursday 09 January 2014 18:57:05 Hans de Goede wrote:
>> +       if (pdata == &ohci_platform_defaults && dev->dev.of_node) {
>> +               priv->phy = devm_phy_get(&dev->dev, "usb");
>> +               if (IS_ERR(priv->phy)) {
>> +                       err = PTR_ERR(priv->phy);
>> +                       if (err == -EPROBE_DEFER)
>> +                               goto err_put_hcd;
>> +                       priv->phy = NULL;
>> +               }
>> +
>> +               for (clk = 0; clk < OHCI_MAX_CLKS; clk++) {
>> +                       priv->clks[clk] = of_clk_get(dev->dev.of_node, clk);
>> +                       if (IS_ERR(priv->clks[clk])) {
>> +                               err = PTR_ERR(priv->clks[clk]);
>> +                               if (err == -EPROBE_DEFER)
>> +                                       goto err_put_clks;
>> +                               priv->clks[clk] = NULL;
>> +                               break;
>> +                       }
>> +               }
>> +       }
>
> Ah, very nice! This way it will actually work to replace a number
> of older drivers that require a specific clock name.

I'm glad you like it.
>
> I still think we should change the phy subsystem to allow the
> same, that would make it more consistent here, and avoid the
> need for coming up with a number of bogus phy names for random
> drivers that can only ever have one phy.

I'm not disagreeing, but that will have to be a battle for
another day. Currently the dt-bindings for phy actually
make phy-names mandatory at the bindings-description level, so
someone would first need to change the specification.

Documentation/devicetree/bindings/phy/phy-bindings.txt:

"""
PHY user node
=============

Required Properties:
phys : the phandle for the PHY device (used by the PHY subsystem)
phy-names : the names of the PHY corresponding to the PHYs present in the
             *phys* phandle
"""

Regards,

Hans
