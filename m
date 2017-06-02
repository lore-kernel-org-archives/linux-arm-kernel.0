From: raviteja.garimella@broadcom.com (Raviteja Garimella)
Date: Fri, 2 Jun 2017 17:18:38 +0530
Subject: [PATCH v6 2/3] phy:phy-bcm-ns2-usbdrd:Broadcom USB DRD Phy driver
 for Northstar2
In-Reply-To: <f90cd885-be89-5c66-c5d8-224173825f0c@ti.com>
References: <1496225523-22035-1-git-send-email-raviteja.garimella@broadcom.com>
 <1496225523-22035-3-git-send-email-raviteja.garimella@broadcom.com>
 <f90cd885-be89-5c66-c5d8-224173825f0c@ti.com>
Message-ID: <CAEHZuqMJyxCdNmv2RZ9ZOc=FuWRQesfJ9-QMQCKW+XHUQru6wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

On Fri, Jun 2, 2017 at 3:59 PM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi,
>
> On Wednesday 31 May 2017 03:42 PM, Raviteja Garimella wrote:
>> This is driver for USB DRD Phy used in Broadcom's Northstar2
>> SoC. The phy can be configured to be in Device mode or Host
>> mode based on the type of cable connected to the port. The
>> driver registers to  extcon framework to get appropriate
>> connect events for Host/Device cables connect/disconnect
>> states based on VBUS and ID interrupts.
>>
>> Signed-off-by: Raviteja Garimella <raviteja.garimella@broadcom.com>
>> ---
>>  drivers/phy/Kconfig              |  13 ++
>>  drivers/phy/Makefile             |   1 +
>>  drivers/phy/phy-bcm-ns2-usbdrd.c | 466 +++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 480 insertions(+)
>>  create mode 100644 drivers/phy/phy-bcm-ns2-usbdrd.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index afaf7b6..8028da7 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -507,6 +507,19 @@ config PHY_CYGNUS_PCIE
>>         Enable this to support the Broadcom Cygnus PCIe PHY.
>>         If unsure, say N.
>>
>> +config PHY_NS2_USB_DRD
>> +     tristate "Broadcom Northstar2 USB DRD PHY support"
>> +     depends on OF && (ARCH_BCM_IPROC || COMPILE_TEST)
>> +     select GENERIC_PHY
>> +     select EXTCON
>> +     default ARCH_BCM_IPROC
>> +     help
>> +       Enable this to support the Broadcom Northstar2 USB DRD PHY.
>> +       This driver initializes the PHY in either HOST or DEVICE mode.
>> +       The host or device configuration is read from device tree.
>> +
>> +       If unsure, say N.
>> +
>>  source "drivers/phy/tegra/Kconfig"
>>
>>  config PHY_NS2_PCIE
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index f8047b4..e5fbb0e 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -61,6 +61,7 @@ obj-$(CONFIG_PHY_TUSB1210)          += phy-tusb1210.o
>>  obj-$(CONFIG_PHY_BRCM_SATA)          += phy-brcm-sata.o
>>  obj-$(CONFIG_PHY_PISTACHIO_USB)              += phy-pistachio-usb.o
>>  obj-$(CONFIG_PHY_CYGNUS_PCIE)                += phy-bcm-cygnus-pcie.o
>> +obj-$(CONFIG_PHY_NS2_USB_DRD)                += phy-bcm-ns2-usbdrd.o
>>  obj-$(CONFIG_ARCH_TEGRA) += tegra/
>>  obj-$(CONFIG_PHY_NS2_PCIE)           += phy-bcm-ns2-pcie.o
>>  obj-$(CONFIG_PHY_MESON8B_USB2)               += phy-meson8b-usb2.o
>> diff --git a/drivers/phy/phy-bcm-ns2-usbdrd.c b/drivers/phy/phy-bcm-ns2-usbdrd.c
>> new file mode 100644
>> index 0000000..8e05c70
>> --- /dev/null
>> +++ b/drivers/phy/phy-bcm-ns2-usbdrd.c
>> @@ -0,0 +1,466 @@
>> +/*
>> + * Copyright (C) 2017 Broadcom
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation version 2.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/delay.h>
>> +#include <linux/extcon.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irq.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slab.h>
>> +#include <linux/workqueue.h>
>> +
>> +#define ICFG_DRD_AFE         0x0
>> +#define ICFG_MISC_STAT               0x18
>> +#define ICFG_DRD_P0CTL               0x1C
>> +#define ICFG_STRAP_CTRL              0x20
>> +#define ICFG_FSM_CTRL                0x24
>> +
>> +#define ICFG_DEV_BIT         BIT(2)
>> +#define IDM_RST_BIT          BIT(0)
>> +#define AFE_CORERDY_VDDC     BIT(18)
>> +#define PHY_PLL_RESETB               BIT(15)
>> +#define PHY_RESETB           BIT(14)
>> +#define PHY_PLL_LOCK         BIT(0)
>> +
>> +#define DRD_DEV_MODE         BIT(20)
>> +#define OHCI_OVRCUR_POL              BIT(11)
>> +#define ICFG_OFF_MODE                BIT(6)
>> +#define PLL_LOCK_RETRY               1000
>> +
>> +#define EVT_DEVICE           0
>> +#define EVT_HOST             1
>> +
>> +#define DRD_HOST_MODE                (BIT(2) | BIT(3))
>> +#define DRD_DEVICE_MODE              (BIT(4) | BIT(5))
>> +#define DRD_HOST_VAL         0x803
>> +#define DRD_DEV_VAL          0x807
>> +#define GPIO_DELAY           20
>> +
>> +struct ns2_phy_data;
>> +struct ns2_phy_driver {
>> +     void __iomem *icfgdrd_regs;
>> +     void __iomem *idmdrd_rst_ctrl;
>> +     void __iomem *crmu_usb2_ctrl;
>> +     void __iomem *usb2h_strap_reg;
>> +     struct ns2_phy_data *data;
>> +     struct extcon_specific_cable_nb extcon_dev;
>> +     struct extcon_specific_cable_nb extcon_host;
>
> The above two members are not used in the driver.

Missed out to remove them. Will do.

>> +     struct extcon_dev *edev;
>
> Does USB DRD driver waits for extcon events? If not using extcon here is bogus.

DRD driver uses extcon events to disconnect/connect gadget driver runtime.

>> +     struct gpio_desc *vbus_gpiod;
>> +     struct gpio_desc *id_gpiod;
>> +     int id_irq;
>> +     int vbus_irq;
>> +     unsigned long debounce_jiffies;
>> +     struct delayed_work wq_extcon;
>> +};
>> +
>> +struct ns2_phy_data {
>> +     struct ns2_phy_driver *driver;
>> +     struct phy *phy;
>> +     int new_state;
>> +};
>> +
>> +static const unsigned int usb_extcon_cable[] = {
>> +     EXTCON_USB,
>> +     EXTCON_USB_HOST,
>> +     EXTCON_NONE,
>> +};
>> +
>> +static inline int pll_lock_stat(u32 usb_reg, int reg_mask,
>> +                             struct ns2_phy_driver *driver)
>> +{
>> +     int retry = PLL_LOCK_RETRY;
>> +     u32 val;
>> +
>> +     do {
>> +             udelay(1);
>> +             val = readl(driver->icfgdrd_regs + usb_reg);
>> +             if (val & reg_mask)
>> +                     return 0;
>> +     } while (--retry > 0);
>> +
>> +     return -EBUSY;
>> +}
>> +
>> +static int ns2_drd_phy_init(struct phy *phy)
>> +{
>> +     struct ns2_phy_data *data = phy_get_drvdata(phy);
>> +     struct ns2_phy_driver *driver = data->driver;
>> +     u32 val;
>> +
>> +     val = readl(driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +     if (data->new_state == EVT_HOST) {
>> +             val &= ~DRD_DEVICE_MODE;
>> +             val |= DRD_HOST_MODE;
>> +     } else {
>> +             val &= ~DRD_HOST_MODE;
>> +             val |= DRD_DEVICE_MODE;
>> +     }
>> +     writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ns2_drd_phy_shutdown(struct phy *phy)
>> +{
>> +     struct ns2_phy_data *data = phy_get_drvdata(phy);
>> +     struct ns2_phy_driver *driver = data->driver;
>> +     u32 val;
>> +
>> +     val = readl(driver->crmu_usb2_ctrl);
>> +     val &= ~AFE_CORERDY_VDDC;
>> +     writel(val, driver->crmu_usb2_ctrl);
>> +
>> +     val = readl(driver->crmu_usb2_ctrl);
>> +     val &= ~DRD_DEV_MODE;
>> +     writel(val, driver->crmu_usb2_ctrl);
>> +
>> +     /* Disable Host and Device Mode */
>> +     val = readl(driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +     val &= ~(DRD_HOST_MODE | DRD_DEVICE_MODE | ICFG_OFF_MODE);
>> +     writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +     return 0;
>> +}
>> +
>> +static int ns2_drd_phy_poweron(struct phy *phy)
>> +{
>> +     struct ns2_phy_data *data = phy_get_drvdata(phy);
>> +     struct ns2_phy_driver *driver = data->driver;
>> +     u32 extcon_event = data->new_state;
>> +     int ret;
>> +     u32 val;
>> +
>> +     if (extcon_event == EVT_DEVICE) {
>> +             writel(DRD_DEV_VAL, driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +
>> +             val = readl(driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +             val &= ~(DRD_HOST_MODE | ICFG_OFF_MODE);
>> +             val |= DRD_DEVICE_MODE;
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>
> Setting to DRD_DEVICE_MODE or DRD_HOST_MODE is done in connect_change. Why do
> you want to do it here?

Will remove it if not required for power management support. I would
like this to be there now.
Pls let me know.

>> +
>> +             val = readl(driver->idmdrd_rst_ctrl);
>> +             val &= ~IDM_RST_BIT;
>> +             writel(val, driver->idmdrd_rst_ctrl);
>> +
>> +             val = readl(driver->crmu_usb2_ctrl);
>> +             val |= (AFE_CORERDY_VDDC | DRD_DEV_MODE);
>> +             writel(val, driver->crmu_usb2_ctrl);
>> +
>> +             /* Bring PHY and PHY_PLL out of Reset */
>> +             val = readl(driver->crmu_usb2_ctrl);
>> +             val |= (PHY_PLL_RESETB | PHY_RESETB);
>> +             writel(val, driver->crmu_usb2_ctrl);
>> +
>> +             ret = pll_lock_stat(ICFG_MISC_STAT, PHY_PLL_LOCK, driver);
>> +             if (ret < 0) {
>> +                     dev_err(&phy->dev, "Phy PLL lock failed\n");
>> +                     goto err_shutdown;
>> +             }
>> +     } else {
>> +             writel(DRD_HOST_VAL, driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +
>> +             val = readl(driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +             val &= ~(DRD_DEVICE_MODE | ICFG_OFF_MODE);
>> +             val |= DRD_HOST_MODE;
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +             val = readl(driver->crmu_usb2_ctrl);
>> +             val |= AFE_CORERDY_VDDC;
>> +             writel(val, driver->crmu_usb2_ctrl);
>> +
>> +             ret = pll_lock_stat(ICFG_MISC_STAT, PHY_PLL_LOCK, driver);
>> +             if (ret < 0) {
>> +                     dev_err(&phy->dev, "Phy PLL lock failed\n");
>> +                     goto err_shutdown;
>> +             }
>> +
>> +             val = readl(driver->idmdrd_rst_ctrl);
>> +             val &= ~IDM_RST_BIT;
>> +             writel(val, driver->idmdrd_rst_ctrl);
>> +
>> +             /* port over current Polarity */
>> +             val = readl(driver->usb2h_strap_reg);
>> +             val |= OHCI_OVRCUR_POL;
>> +             writel(val, driver->usb2h_strap_reg);
>> +     }
>> +
>> +     return 0;
>> +
>> +err_shutdown:
>> +     ns2_drd_phy_shutdown(phy);
>
> This should be left for the consumer driver to handle.

Ok.

>> +     return ret;
>> +}
>> +
>> +static void connect_change(struct ns2_phy_driver *driver)
>> +{
>> +     u32 extcon_event;
>> +     u32 val;
>> +
>> +     extcon_event = driver->data->new_state;
>> +     val = readl(driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +     switch (extcon_event) {
>> +     case EVT_DEVICE:
>> +             val &= ~(DRD_HOST_MODE | DRD_DEVICE_MODE);
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +             val = (val & ~DRD_HOST_MODE) | DRD_DEVICE_MODE;
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +             val = readl(driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +             val |= ICFG_DEV_BIT;
>> +             writel(val, driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +             break;
>> +
>> +     case EVT_HOST:
>> +             val &= ~(DRD_HOST_MODE | DRD_DEVICE_MODE);
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +             val = (val & ~DRD_DEVICE_MODE) | DRD_HOST_MODE;
>> +             writel(val, driver->icfgdrd_regs + ICFG_FSM_CTRL);
>> +
>> +             val = readl(driver->usb2h_strap_reg);
>> +             val |= OHCI_OVRCUR_POL;
>> +             writel(val, driver->usb2h_strap_reg);
>> +
>> +             val = readl(driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +             val &= ~ICFG_DEV_BIT;
>> +             writel(val, driver->icfgdrd_regs + ICFG_DRD_P0CTL);
>> +             break;
>> +
>> +     default:
>> +             pr_err("Invalid extcon event\n");
>> +             break;
>> +     }
>> +}
>> +
>> +static void extcon_work(struct work_struct *work)
>> +{
>> +     struct ns2_phy_driver *driver;
>> +     int vbus;
>> +     int id;
>> +
>> +     driver  = container_of(to_delayed_work(work),
>> +                            struct ns2_phy_driver, wq_extcon);
>> +
>> +     id = gpiod_get_value_cansleep(driver->id_gpiod);
>> +     vbus = gpiod_get_value_cansleep(driver->vbus_gpiod);
>> +
>> +     if (!id && vbus) { /* Host connected */
>> +             extcon_set_cable_state_(driver->edev, EXTCON_USB_HOST, true);
>
> Why do you need all extcon_set_cable_state_ here?

Based on the cable state, the UDC driver can do gagdet driver
connect/disconnect,
the way it is done now.

Thanks,
Ravi

>
> Thanks
> Kishon
