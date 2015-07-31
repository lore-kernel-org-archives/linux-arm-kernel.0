From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 31 Jul 2015 19:48:39 +0530
Subject: [PATCH v3 3/5] usb: phy: add usb3.0 phy driver for mt65xx SoCs
In-Reply-To: <1438345550.28007.25.camel@mhfsdcap03>
References: <1437573945-31586-1-git-send-email-chunfeng.yun@mediatek.com>		
 <1437573945-31586-4-git-send-email-chunfeng.yun@mediatek.com>		
 <20150722142157.GA10467@saruman.tx.rr.com>	
 <1437879072.3040.7.camel@mhfsdcap03> <55B71772.70807@ti.com>
 <1438345550.28007.25.camel@mhfsdcap03>
Message-ID: <55BB83BF.6040105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 31 July 2015 05:55 PM, chunfeng yun wrote:
> hi,
> On Tue, 2015-07-28 at 11:17 +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Sunday 26 July 2015 08:21 AM, chunfeng yun wrote:
>>> hi,
>>> On Wed, 2015-07-22 at 09:21 -0500, Felipe Balbi wrote:
>>>> Hi,
>>>>
>>>> On Wed, Jul 22, 2015 at 10:05:43PM +0800, Chunfeng Yun wrote:
>>>>> support usb3.0 phy of mt65xx SoCs
>>>>>
>>>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>>>
>>>> you missed Kishon here.
>>>>
>>> Thank you.
>>>>> ---
>>>>>  drivers/phy/Kconfig           |   9 +
>>>>>  drivers/phy/Makefile          |   1 +
>>>>>  drivers/phy/phy-mt65xx-usb3.c | 426 ++++++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 436 insertions(+)
>>>>>  create mode 100644 drivers/phy/phy-mt65xx-usb3.c
>>>>>
>>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>>>>> index c0e6ede..019cf8b 100644
>>>>> --- a/drivers/phy/Kconfig
>>>>> +++ b/drivers/phy/Kconfig
>>>>> @@ -193,6 +193,15 @@ config PHY_HIX5HD2_SATA
>>>>>  	help
>>>>>  	  Support for SATA PHY on Hisilicon hix5hd2 Soc.
>>>>>  
>>>>> +config PHY_MT65XX_USB3
>>>>> +	tristate "Mediatek USB3.0 PHY Driver"
>>>>> +	depends on ARCH_MEDIATEK && OF
>>>>> +	select GENERIC_PHY
>>>>> +	help
>>>>> +	  Say 'Y' here to add support for Mediatek USB3.0 PHY driver
>>>>> +	  for mt65xx SoCs. it supports two usb2.0 ports and
>>>>> +	  one usb3.0 port.
>>>>> +
>>>>>  config PHY_SUN4I_USB
>>>>>  	tristate "Allwinner sunxi SoC USB PHY driver"
>>>>>  	depends on ARCH_SUNXI && HAS_IOMEM && OF
>>>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>>>>> index f344e1b..3ceff2a 100644
>>>>> --- a/drivers/phy/Makefile
>>>>> +++ b/drivers/phy/Makefile
>>>>> @@ -22,6 +22,7 @@ obj-$(CONFIG_TI_PIPE3)			+= phy-ti-pipe3.o
>>>>>  obj-$(CONFIG_TWL4030_USB)		+= phy-twl4030-usb.o
>>>>>  obj-$(CONFIG_PHY_EXYNOS5250_SATA)	+= phy-exynos5250-sata.o
>>>>>  obj-$(CONFIG_PHY_HIX5HD2_SATA)		+= phy-hix5hd2-sata.o
>>>>> +obj-$(CONFIG_PHY_MT65XX_USB3)		+= phy-mt65xx-usb3.o
>>>>>  obj-$(CONFIG_PHY_SUN4I_USB)		+= phy-sun4i-usb.o
>>>>>  obj-$(CONFIG_PHY_SUN9I_USB)		+= phy-sun9i-usb.o
>>>>>  obj-$(CONFIG_PHY_SAMSUNG_USB2)		+= phy-exynos-usb2.o
>>>>> diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
>>>>> new file mode 100644
>>>>> index 0000000..5da4534
>>>>> --- /dev/null
>>>>> +++ b/drivers/phy/phy-mt65xx-usb3.c
>>>>> @@ -0,0 +1,426 @@
>>>>> +/*
>>>>> + * Copyright (c) 2015 MediaTek Inc.
>>>>> + * Author: Chunfeng.Yun <chunfeng.yun@mediatek.com>
>>>>> + *
>>>>> + * This software is licensed under the terms of the GNU General Public
>>>>> + * License version 2, as published by the Free Software Foundation, and
>>>>> + * may be copied, distributed, and modified under those terms.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + */
>>>>> +
>>>>> +#include <linux/clk.h>
>>>>> +#include <linux/delay.h>
>>>>> +#include <linux/io.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of_address.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/of_gpio.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/phy/phy.h>
>>>>> +#include <linux/platform_device.h>
>>>>> +#include <linux/pm_runtime.h>
>>>>> +#include <linux/regulator/consumer.h>
>>
>> Lot of these #include are not required. Add only those what are required by
>> this driver.
> The dummy header files will be removed later
> 
>>>>> +#include <linux/resource.h>
>>>>> +
>>>>> +/*
>>>>> + * for sifslv2 register
>>>>> + * relative to USB3_SIF2_BASE base address
>>>>> + */
>>>>> +#define SSUSB_SIFSLV_SPLLC	(0x0000)
>>>>> +#define SSUSB_SIFSLV_U2PHY_COM_BASE	(0x0800)
>>
>> Looks like all this base address can come from dt.
> The phy supports multi-ports, and these are sub-segment registers for
> port0, and other ports can be calculated from the bases. So I think it's
> better to use the same base address in dts

Nope. Except for the register offsets everything else can come from dt.
> 
>>>>> +#define SSUSB_SIFSLV_U3PHYD_BASE	(0x0900)
>>>>> +#define SSUSB_USB30_PHYA_SIV_B_BASE	(0x0b00)
>>>>> +#define SSUSB_SIFSLV_U3PHYA_DA_BASE	(0x0c00)
>>>>> +
>>>>> +/*port1 refs. +0x800(refer to port0)*/
>>>>> +#define U3P_PORT_INTERVAL (0x800)	/*based on port0 */
>>>>> +#define U3P_PHY_DELTA(index) ((U3P_PORT_INTERVAL) * (index))
>>>>> +
>>>>> +#define U3P_USBPHYACR0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0000)
>>>>> +#define PA0_RG_U2PLL_FORCE_ON	(0x1 << 15)
>>>>> +
>>>>> +#define U3P_USBPHYACR2	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0008)
>>>>> +#define PA2_RG_SIF_U2PLL_FORCE_EN	(0x1 << 18)
>>>>> +
>>>>> +#define U3P_USBPHYACR5	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0014)
>>>>> +#define PA5_RG_U2_HSTX_SRCTRL		(0x7 << 12)
>>>>> +#define PA5_RG_U2_HSTX_SRCTRL_VAL(x)	((0x7 & (x)) << 12)
>>>>> +#define PA5_RG_U2_HS_100U_U3_EN		(0x1 << 11)
>>>>> +
>>>>> +#define U3P_USBPHYACR6	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0018)
>>>>> +#define PA6_RG_U2_ISO_EN		(0x1 << 31)
>>>>> +#define PA6_RG_U2_BC11_SW_EN	(0x1 << 23)
>>>>> +#define PA6_RG_U2_OTG_VBUSCMP_EN	(0x1 << 20)
>>>>> +
>>>>> +#define U3P_U2PHYACR4	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0020)
>>>>> +#define P2C_RG_USB20_GPIO_CTL	(0x1 << 9)
>>>>> +#define P2C_USB20_GPIO_MODE	(0x1 << 8)
>>>>> +#define P2C_U2_GPIO_CTR_MSK	(P2C_RG_USB20_GPIO_CTL | P2C_USB20_GPIO_MODE)
>>>>> +
>>>>> +#define U3D_U2PHYDCR0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0060)
>>>>> +#define P2C_RG_SIF_U2PLL_FORCE_ON	(0x1 << 24)
>>>>> +
>>>>> +#define U3P_U2PHYDTM0	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x0068)
>>>>> +#define P2C_FORCE_UART_EN	(0x1 << 26)
>>>>> +#define P2C_FORCE_DATAIN	(0x1 << 23)
>>>>> +#define P2C_FORCE_DM_PULLDOWN	(0x1 << 21)
>>>>> +#define P2C_FORCE_DP_PULLDOWN	(0x1 << 20)
>>>>> +#define P2C_FORCE_XCVRSEL	(0x1 << 19)
>>>>> +#define P2C_FORCE_SUSPENDM	(0x1 << 18)
>>>>> +#define P2C_FORCE_TERMSEL	(0x1 << 17)
>>>>> +#define P2C_RG_DATAIN		(0xf << 10)
>>>>> +#define P2C_RG_DATAIN_VAL(x)	((0xf & (x)) << 10)
>>>>> +#define P2C_RG_DMPULLDOWN	(0x1 << 7)
>>>>> +#define P2C_RG_DPPULLDOWN	(0x1 << 6)
>>>>> +#define P2C_RG_XCVRSEL		(0x3 << 4)
>>>>> +#define P2C_RG_XCVRSEL_VAL(x)	((0x3 & (x)) << 4)
>>>>> +#define P2C_RG_SUSPENDM		(0x1 << 3)
>>>>> +#define P2C_RG_TERMSEL		(0x1 << 2)
>>>>> +#define P2C_DTM0_PART_MASK \
>>>>> +		(P2C_FORCE_DATAIN | P2C_FORCE_DM_PULLDOWN | \
>>>>> +		P2C_FORCE_DP_PULLDOWN | P2C_FORCE_XCVRSEL | \
>>>>> +		P2C_FORCE_TERMSEL | P2C_RG_DMPULLDOWN | \
>>>>> +		P2C_RG_DPPULLDOWN | P2C_RG_TERMSEL)
>>>>> +
>>>>> +#define U3P_U2PHYDTM1	(SSUSB_SIFSLV_U2PHY_COM_BASE + 0x006C)
>>>>> +#define P2C_RG_UART_EN		(0x1 << 16)
>>>>> +#define P2C_RG_VBUSVALID	(0x1 << 5)
>>>>> +#define P2C_RG_SESSEND		(0x1 << 4)
>>>>> +#define P2C_RG_AVALID		(0x1 << 2)
>>>>> +
>>>>> +#define U3P_U3_PHYA_REG0	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0000)
>>>>> +#define P3A_RG_U3_VUSB10_ON	(1 << 5)
>>>>> +
>>>>> +#define U3P_U3_PHYA_REG6	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0018)
>>>>> +#define P3A_RG_TX_EIDLE_CM	(0xf << 28)
>>>>> +#define P3A_RG_TX_EIDLE_CM_VAL(x)	((0xf & (x)) << 28)
>>>>> +
>>>>> +#define U3P_U3_PHYA_REG9	(SSUSB_USB30_PHYA_SIV_B_BASE + 0x0024)
>>>>> +#define P3A_RG_RX_DAC_MUX	(0x1f << 1)
>>>>> +#define P3A_RG_RX_DAC_MUX_VAL(x)	((0x1f & (x)) << 1)
>>>>> +
>>>>> +#define U3P_U3PHYA_DA_REG0	(SSUSB_SIFSLV_U3PHYA_DA_BASE + 0x0)
>>>>> +#define P3A_RG_XTAL_EXT_EN_U3	(0x3 << 10)
>>>>> +#define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
>>>>> +
>>>>> +#define U3P_PHYD_CDR1	(SSUSB_SIFSLV_U3PHYD_BASE + 0x5c)
>>>>> +#define P3D_RG_CDR_BIR_LTD1		(0x1f << 24)
>>>>> +#define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
>>>>> +#define P3D_RG_CDR_BIR_LTD0		(0x1f << 8)
>>>>> +#define P3D_RG_CDR_BIR_LTD0_VAL(x)	((0x1f & (x)) << 8)
>>>>> +
>>>>> +#define U3P_XTALCTL3		(SSUSB_SIFSLV_SPLLC + 0x18)
>>>>> +#define XC3_RG_U3_XTAL_RX_PWD		(0x1 << 9)
>>>>> +#define XC3_RG_U3_FRC_XTAL_RX_PWD	(0x1 << 8)
>>>>> +
>>>>> +#define MT65XX_MAX_PHYS	2
>>>>> +
>>>>> +struct mt65xx_phy_instance {
>>>>> +	struct phy *phy;
>>>>> +	u32 index;
>>>>> +	u32 delta; /* increament refers to port0 */
>>>>> +};
>>>>> +
>>>>> +struct mt65xx_u3phy {
>>>>> +	struct device *dev;
>>>>> +	void __iomem *sif_base;	/* include sif2 */
>>>>> +	struct clk *u3phya_ref;	/* reference clock of usb3 anolog phy */
>>>>> +	struct mt65xx_phy_instance phys[MT65XX_MAX_PHYS];
>>>>> +};
>>>>> +
>>>>> +static struct mt65xx_u3phy *to_usbdrd_phy(
>>>>> +	struct mt65xx_phy_instance *instance)
>>>>> +{
>>>>> +	return container_of((instance), struct mt65xx_u3phy,
>>>>> +			    phys[(instance)->index]);
>>>>> +}
>>>>> +
>> .
>> .
>> <<snip>>
>> .
>> .
>>
>>>>> +static struct phy *mt65xx_phy_xlate(struct device *dev,
>>>>> +					struct of_phandle_args *args)
>>>>> +{
>>>>> +	struct mt65xx_u3phy *u3phy = dev_get_drvdata(dev);
>>>>> +
>>>>> +	if (WARN_ON(args->args[0] > MT65XX_MAX_PHYS))
>>>>> +		return ERR_PTR(-ENODEV);
>>>>> +
>>>>> +	return u3phy->phys[args->args[0]].phy;
>>>>> +}
>>
>> If the driver doesn't have to get any data from dt, then custom xlate is not
>> required at all. All you have to do is create separate nodes for every
>> individual phy and keep it as the child node of the phy_provider dt node. Note
>> that the phy consumer dt node should now use the label given for the chld-nodes
>> and not the phy_provider. Look at drivers/phy/phy-miphy365x.c for reference.
>>
> It is multi-port PHY, and these ports share some registers from offset
> [0, 0x7ff], and port0 segment is [0x800, 0xfff], port1 segment is

The shared registers can be added in the 'phy_provider' dt node and the port
specific registers can be added in the sub-node of phy_provider.
> [0x1000, 0x17ff], etc, so I think maybe it is not suitable to create
> separate nodes in dts for each port.

Sorry, don't agree with you here.
> BTW: I refer to phy-exynos5-usbdrd.c which is multi-channel usb3.0 phy
> to write this driver.

Bad driver to refer to. It was added when phy-core was just merged to the linux
kernel. And later new features had been added to the phy-core just to better
support multi-phy phy-providers. If it is not for maintaining old dtbs
compatibility, that driver would have been changed as well.

Thanks
Kishon
