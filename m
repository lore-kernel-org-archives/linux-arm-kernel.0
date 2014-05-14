From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 14 May 2014 17:35:00 +0200
Subject: [PATCHv5 10/20] phy: add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <53737D4E.8090706@ti.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399832288-19899-11-git-send-email-thomas.petazzoni@free-electrons.com>
 <5371B36C.6000703@ti.com> <5371D2A2.5020904@free-electrons.com>
 <5371E8BF.50303@free-electrons.com> <53737D4E.8090706@ti.com>
Message-ID: <53738D24.5000705@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/2014 16:27, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 13 May 2014 03:11 PM, Gregory CLEMENT wrote:
>> On 13/05/2014 10:06, Gregory CLEMENT wrote:
>>> On 13/05/2014 07:53, Kishon Vijay Abraham I wrote:
>>>> Hi,
>>>>
>>>> On Sunday 11 May 2014 11:47 PM, Thomas Petazzoni wrote:
>>>>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>>>
>>>>> The Armada 375 SoC comes with an USB2 host and device controller and
>>>>> an USB3 controller. The USB cluster control register allows to manage
>>>>> common features of both USB controllers.
>>>>>
>>>>> This commit adds a driver integrated in the generic PHY framework to
>>>>> control this USB cluster feature.
>>>>>
>>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>>>> ---
>>>>>  drivers/phy/Kconfig              |   6 ++
>>>>>  drivers/phy/Makefile             |   1 +
>>>>>  drivers/phy/phy-armada375-usb2.c | 157 +++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 164 insertions(+)
>>>>>  create mode 100644 drivers/phy/phy-armada375-usb2.c
>>>>>
>>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>>> index 3bb05f1..e63cf9d 100644
>>>>> --- a/drivers/phy/Kconfig
>>>>> +++ b/drivers/phy/Kconfig
>>>>> @@ -15,6 +15,12 @@ config GENERIC_PHY
>>>>>  	  phy users can obtain reference to the PHY. All the users of this
>>>>>  	  framework should select this config.
>>>>>  
>>>>> +config ARMADA375_USBCLUSTER_PHY
>>>>> +	def_bool y
>>>>> +	depends on MACH_ARMADA_375 || COMPILE_TEST
>>>>> +	depends on OF
>>>>> +	select GENERIC_PHY
>>>>> +
>>>>>  config PHY_EXYNOS_MIPI_VIDEO
>>>>>  	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
>>>>>  	depends on HAS_IOMEM
>>>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>>>> index 2faf78e..47d5a86 100644
>>>>> --- a/drivers/phy/Makefile
>>>>> +++ b/drivers/phy/Makefile
>>>>> @@ -3,6 +3,7 @@
>>>>>  #
>>>>>  
>>>>>  obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>>>>> +obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>>>>>  obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
>>>>>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
>>>>>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
>>>>> diff --git a/drivers/phy/phy-armada375-usb2.c b/drivers/phy/phy-armada375-usb2.c
>>>>> new file mode 100644
>>>>> index 0000000..a6f746d
>>>>> --- /dev/null
>>>>> +++ b/drivers/phy/phy-armada375-usb2.c
>>>>> @@ -0,0 +1,157 @@
>>>>> +/*
>>>>> + * USB cluster support for Armada 375 platform.
>>>>> + *
>>>>> + * Copyright (C) 2014 Marvell
>>>>> + *
>>>>> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>>> + *
>>>>> + * This file is licensed under the terms of the GNU General Public
>>>>> + * License version 2 or later. This program is licensed "as is"
>>>>> + * without any warranty of any kind, whether express or implied.
>>>>> + *
>>>>> + * Armada 375 comes with an USB2 host and device controller and an
>>>>> + * USB3 controller. The USB cluster control register allows to manage
>>>>> + * common features of both USB controllers.
>>>>> + */
>>>>> +
>>>>> +#include <linux/init.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/kernel.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/phy/phy.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/slab.h>
>>>>> +
>>>>> +#define USB2_PHY_CONFIG_DISABLE BIT(0)
>>>>> +
>>>>> +/* The USB cluster allows to choose between two PHYs */
>>>>> +#define NB_PHY 2
>>>>> +
>>>>> +enum {
>>>>> +	PHY_USB2 = 0,
>>>>> +	PHY_USB3 = 1,
>>>>> +};
>>>>> +
>>>>> +struct armada375_cluster_phy {
>>>>> +	struct phy *phy;
>>>>> +	void __iomem *reg;
>>>>> +	bool enable;
>>>>> +	bool use_usb3;
>>>>> +};
>>>>> +
>>>>> +struct armada375_cluster_phy usb_cluster_phy[NB_PHY];
>>>>> +
>>>>> +static int armada375_usb_phy_init(struct phy *phy)
>>>>> +{
>>>>> +	struct armada375_cluster_phy *cluster_phy = phy_get_drvdata(phy);
>>>>> +	u32 reg;
>>>>
>>>> This function should be protected since both your PHYs use this ops.
>>>
>>> Right
>>
>> Actually only one PHY can access this register. See the probe function,
>> cluster_phy->enable is only set to true for one PHY.
>>
>>>
>>>>> +
>>>>> +	if (!cluster_phy->enable)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	reg = readl(cluster_phy->reg);
>>>>> +	if (cluster_phy->use_usb3)
>>>>> +		reg |= USB2_PHY_CONFIG_DISABLE;
>>>>> +	else
>>>>> +		reg &= ~USB2_PHY_CONFIG_DISABLE;
>>>>> +	writel(reg, cluster_phy->reg);
>>>>
>>>> This is confusing since both your PHYs control the same bit?
>>
>> Same here at the end the bit is accessed by only one PHY.
>>
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static struct phy_ops armada375_usb_phy_ops = {
>>>>> +	.init = armada375_usb_phy_init,
>>>>> +	.owner		= THIS_MODULE,
>>>>> +};
>>>>> +
>>>>> +static struct phy *armada375_usb_phy_xlate(struct device *dev,
>>>>> +					struct of_phandle_args *args)
>>>>> +{
>>>>> +	if (WARN_ON(args->args[0] >= NB_PHY))
>>>>> +		return ERR_PTR(-ENODEV);
>>>>> +
>>>>> +	return usb_cluster_phy[args->args[0]].phy;
>>>>> +}
>>>>> +
>>>>> +static int armada375_usb_phy_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct device *dev = &pdev->dev;
>>>>> +	struct phy *phy;
>>>>> +	struct phy_provider *phy_provider;
>>>>> +	void __iomem *usb_cluster_base;
>>>>> +	struct device_node *xhci_node;
>>>>> +	struct resource *res;
>>>>> +	int i;
>>>>> +
>>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>> +	usb_cluster_base = devm_ioremap_resource(&pdev->dev, res);
>>>>> +	if (!usb_cluster_base)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	for (i = 0; i < NB_PHY; i++) {
>>>>
>>>> For devices which have multiple PHYs, each PHY should be modelled as the
>>>> sub-node of the *PHY provider* device node.
>>>
>>> Actually it is the opposite the same PHY is shared between the EHCI
>>> and the xHCI controllers. It is more a PHY muxer than a PHY itself.
>>>
>>> I had to create 2 logical PHYs because once the phy_init() is called
>>> by a USB driver then the .init ops is not called anymore by the next
>>> call to phy_init(). One of the goal of this is to disable a port for
>>> the USB controller which can't use it due to the configuration of the
>>> USB cluster.
>>>
>>> But I can see how to make this two "pseudo" PHYs sub-node of the *PHY
>>> provider* device node. It shouldn't change the internal logic of this
>>> driver.
>>
>> I need to make a distinction when the PHY access by the xHCI or when
>> it was access by the EHCI. If I create two new sub-node then I will
>> also need to add a property to make this distinction. It seems a little
>> overkill for the need.
> 
> Alright, so you have a single PHY that can be used by either XHCI or EHCI? And
> the use of PHY is mutually exclusive? How should it behave if you have both
> XHCI and EHCI?

if we have both XHCI and EHCI then it is the USB2_PHY_CONFIG_DISABLE which
determine which one is used. By default we decide to select the XHCI.

> 
> One way to configure the PHY to a particular mode is by passing it as phandle
> arguments. I think you can use that to enable or disable USB2_PHY_CONFIG_DISABLE?

actually it was more or less what I do:
for the XHCI I use:
phys = <&usbcluster 1>;
which enable the USB2_PHY_CONFIG_DISABLE

for the EHCI I use phys = <&usbcluster 0>;
which disable the USB2_PHY_CONFIG_DISABLE

If I had to create two PHY it was because of the behavior of
phy_init(). I need to be able to disable a controller if it can't use
the PHY. For this purpose my ops->init() exits in error. However
phy_init() will call ops->init() only one time, then the internal
counter init_count will be incremented, and the next call to phy_init
will skip the call to ops->init. And the behavior is the same for
phy_power_on().

So given this I don't see how to do in an other way except by
modifying the value of the counter in my ops.


Thanks,

Gregory


> 
> Thanks
> Kishon
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
