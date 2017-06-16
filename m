From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 11:34:25 +0530
Subject: [PATCH 5/5] phy: bcm-ns-usb3: add MDIO driver using proper bus
 layer
In-Reply-To: <a5062fcb-a051-e0a9-9e19-954d4e611780@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170511132925.14564-6-zajec5@gmail.com>
 <a5062fcb-a051-e0a9-9e19-954d4e611780@gmail.com>
Message-ID: <50c92818-5f96-0b9a-b631-898cc09c7349@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

On Thursday 11 May 2017 09:59 PM, Florian Fainelli wrote:
> On 05/11/2017 06:29 AM, Rafa? Mi?ecki wrote:
>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>
>> As USB 3.0 PHY is attached to the MDIO bus this module should provide a
>> MDIO driver and use a proper bus layer. This is a proper (cleaner)
>> solution which doesn't require code to know this specific MDIO bus
>> details. It also allows reusing the driver with other MDIO buses.
>>
>> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
>> ---
>>  drivers/phy/Kconfig           |  1 +
>>  drivers/phy/phy-bcm-ns-usb3.c | 98 ++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 98 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index afaf7b643eeb..2a9186b98ae0 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -29,6 +29,7 @@ config PHY_BCM_NS_USB3
>>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
>>  	depends on HAS_IOMEM && OF
>>  	select GENERIC_PHY
>> +	select PHYLIB
> 
> Should not this be select MDIO_DEVICE instead? 4.11 introduced the
> possibility to build support for MDIO bus/devices without requiring PHYLIB.
> 
>>  	help
>>  	  Enable this to support Broadcom USB 3.0 PHY connected to the USB
>>  	  controller on Northstar family.
>> diff --git a/drivers/phy/phy-bcm-ns-usb3.c b/drivers/phy/phy-bcm-ns-usb3.c
>> index 2c9a0d5f43d8..389f5e5a6238 100644
>> --- a/drivers/phy/phy-bcm-ns-usb3.c
>> +++ b/drivers/phy/phy-bcm-ns-usb3.c
>> @@ -16,7 +16,9 @@
>>  #include <linux/bcma/bcma.h>
>>  #include <linux/delay.h>
>>  #include <linux/err.h>
>> +#include <linux/mdio.h>
>>  #include <linux/module.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/phy/phy.h>
>> @@ -52,6 +54,7 @@ struct bcm_ns_usb3 {
>>  	enum bcm_ns_family family;
>>  	void __iomem *dmp;
>>  	void __iomem *ccb_mii;
>> +	struct mdio_device *mdiodev;
>>  	struct phy *phy;
>>  
>>  	int (*phy_write)(struct bcm_ns_usb3 *usb3, u16 reg, u16 value);
>> @@ -183,6 +186,77 @@ static const struct phy_ops ops = {
>>  };
>>  
>>  /**************************************************
>> + * MDIO driver code
>> + **************************************************/
>> +
>> +static int bcm_ns_usb3_mdiodev_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
>> +					 u16 value)
>> +{
>> +	struct mdio_device *mdiodev = usb3->mdiodev;
>> +
>> +	return mdiobus_write(mdiodev->bus, mdiodev->addr, reg, value);
>> +}
>> +
>> +static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
>> +{
>> +	struct device *dev = &mdiodev->dev;
>> +	const struct of_device_id *of_id;
>> +	struct phy_provider *phy_provider;
>> +	struct device_node *syscon_np;
>> +	struct bcm_ns_usb3 *usb3;
>> +	struct resource res;
>> +	int err;
>> +
>> +	usb3 = devm_kzalloc(dev, sizeof(*usb3), GFP_KERNEL);
>> +	if (!usb3)
>> +		return -ENOMEM;
>> +
>> +	usb3->dev = dev;
>> +	usb3->mdiodev = mdiodev;
>> +
>> +	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
>> +	if (!of_id)
>> +		return -EINVAL;
>> +	usb3->family = (enum bcm_ns_family)of_id->data;
>> +
>> +	syscon_np = of_parse_phandle(dev->of_node, "usb3-dmp-syscon", 0);
>> +	err = of_address_to_resource(syscon_np, 0, &res);
>> +	of_node_put(syscon_np);
>> +	if (err)
>> +		return err;
>> +
>> +	usb3->dmp = devm_ioremap_resource(dev, &res);
>> +	if (IS_ERR(usb3->dmp)) {
>> +		dev_err(dev, "Failed to map DMP regs\n");
>> +		return PTR_ERR(usb3->dmp);
>> +	}
>> +
>> +	usb3->phy_write = bcm_ns_usb3_mdiodev_phy_write;
>> +
>> +	usb3->phy = devm_phy_create(dev, NULL, &ops);
>> +	if (IS_ERR(usb3->phy)) {
>> +		dev_err(dev, "Failed to create PHY\n");
>> +		return PTR_ERR(usb3->phy);
>> +	}
>> +
>> +	phy_set_drvdata(usb3->phy, usb3);
>> +
>> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +
>> +	return PTR_ERR_OR_ZERO(phy_provider);
>> +}
>> +
>> +static struct mdio_driver bcm_ns_usb3_mdio_driver = {
>> +	.mdiodrv = {
>> +		.driver = {
>> +			.name = "bcm_ns_mdio_usb3",
>> +			.of_match_table = bcm_ns_usb3_id_table,
>> +		},
>> +	},
>> +	.probe = bcm_ns_usb3_mdio_probe,
>> +};
>> +
>> +/**************************************************
>>   * Platform driver code
>>   **************************************************/
>>  
>> @@ -297,6 +371,28 @@ static struct platform_driver bcm_ns_usb3_driver = {
>>  		.of_match_table = bcm_ns_usb3_id_table,
>>  	},
>>  };
>> -module_platform_driver(bcm_ns_usb3_driver);
>> +
>> +static int __init bcm_ns_usb3_module_init(void)
>> +{
>> +	int err;
>> +
>> +	err = mdio_driver_register(&bcm_ns_usb3_mdio_driver);
>> +	if (err)
>> +		return err;
>> +
>> +	err = platform_driver_register(&bcm_ns_usb3_driver);
>> +	if (err)
>> +		mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>> +
>> +	return err;
>> +}
>> +module_init(bcm_ns_usb3_module_init);
>> +
>> +static void __exit bcm_ns_usb3_module_exit(void)
>> +{
>> +	platform_driver_unregister(&bcm_ns_usb3_driver);
>> +	mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>> +}
>> +module_exit(bcm_ns_usb3_module_exit)
> 
> Do we need to keep both platform device and mdio device registration
> here? Do you have a depreciation time line for when we can entirely
> switch to mdio device (assuming this is for backwards compatibility)?

I too have the same question.

Thanks
Kishon
