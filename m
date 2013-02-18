From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 18 Feb 2013 10:53:43 +0800
Subject: [V6 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <51134240.1090503@ti.com>
References: <1360135431-27280-1-git-send-email-chao.xie@marvell.com>
 <1360135431-27280-2-git-send-email-chao.xie@marvell.com>
 <51120FEA.3070901@ti.com>
 <CADApbegwSbdDbFwWZj3o-cZvUoiV6fFaYNrSE3M0gk=21i+6Eg@mail.gmail.com>
 <51123202.4080001@ti.com>
 <CADApbeiU+zWOA-B+d_xpPm9bBrhvkLb-D8mdX7-fC1dgdb2kOg@mail.gmail.com>
 <51134240.1090503@ti.com>
Message-ID: <CADApbej8Kr28nOAEHXw4MwCAA=zNPFq3du48yXUy+xEOS7yB3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 7, 2013 at 1:57 PM, kishon <kishon@ti.com> wrote:
> Hi,
>
>
> On Thursday 07 February 2013 07:56 AM, Chao Xie wrote:
>>
>> On Wed, Feb 6, 2013 at 6:35 PM, kishon <kishon@ti.com> wrote:
>>>
>>> Hi,
>>>
>>>
>>> On Wednesday 06 February 2013 01:48 PM, Chao Xie wrote:
>>>>
>>>>
>>>> On Wed, Feb 6, 2013 at 4:10 PM, kishon <kishon@ti.com> wrote:
>>>>>
>>>>>
>>>>> Hi,
>>>>>
>>>>>
>>>>> On Wednesday 06 February 2013 12:53 PM, Chao Xie wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> The PHY is seperated from usb controller.
>>>>>> The usb controller used in marvell pxa168/pxa910/mmp2 are same,
>>>>>> but PHY initialization may be different.
>>>>>> the usb controller can support udc/otg/ehci, and for each of
>>>>>> the mode, it need PHY to initialized before use the controller.
>>>>>> Direclty writing the phy driver will make the usb controller
>>>>>> driver to be simple and portable.
>>>>>> The PHY driver will be used by marvell udc/otg/ehci.
>>>>>>
>>>>>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>>>>>> ---
>>>>>>     drivers/usb/phy/Kconfig              |    7 +
>>>>>>     drivers/usb/phy/Makefile             |    1 +
>>>>>>     drivers/usb/phy/mv_usb2_phy.c        |  454
>>>>>> ++++++++++++++++++++++++++++++++++
>>>>>>     include/linux/platform_data/mv_usb.h |    9 +-
>>>>>>     include/linux/usb/mv_usb2.h          |   43 ++++
>>>>>>     5 files changed, 511 insertions(+), 3 deletions(-)
>>>>>>     create mode 100644 drivers/usb/phy/mv_usb2_phy.c
>>>>>>     create mode 100644 include/linux/usb/mv_usb2.h
>>>>>>
>>>>>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>>>>>> index 65217a5..5479760 100644
>>>>>> --- a/drivers/usb/phy/Kconfig
>>>>>> +++ b/drivers/usb/phy/Kconfig
>>>>>> @@ -73,3 +73,10 @@ config SAMSUNG_USBPHY
>>>>>>           help
>>>>>>             Enable this to support Samsung USB phy controller for
>>>>>> samsung
>>>>>>             SoCs.
>>>>>> +
>>>>>> +config MV_USB2_PHY
>>>>>> +       tristate "Marvell USB 2.0 PHY Driver"
>>>>>> +       depends on USB || USB_GADGET
>>>>>> +       help
>>>>>> +         Enable this to support Marvell USB 2.0 phy driver for
>>>>>> Marvell
>>>>>> +         SoC.
>>>>>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>>>>>> index b13faa1..3835316 100644
>>>>>> --- a/drivers/usb/phy/Makefile
>>>>>> +++ b/drivers/usb/phy/Makefile
>>>>>> @@ -12,3 +12,4 @@ obj-$(CONFIG_MV_U3D_PHY)              +=
>>>>>> mv_u3d_phy.o
>>>>>>     obj-$(CONFIG_USB_EHCI_TEGRA)  += tegra_usb_phy.o
>>>>>>     obj-$(CONFIG_USB_RCAR_PHY)            += rcar-phy.o
>>>>>>     obj-$(CONFIG_SAMSUNG_USBPHY)          += samsung-usbphy.o
>>>>>> +obj-$(CONFIG_MV_USB2_PHY)              += mv_usb2_phy.o
>>>>>> diff --git a/drivers/usb/phy/mv_usb2_phy.c
>>>>>> b/drivers/usb/phy/mv_usb2_phy.c
>>>>>> new file mode 100644
>>>>>> index 0000000..c2bccae
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/usb/phy/mv_usb2_phy.c
>>>>>> @@ -0,0 +1,454 @@
>>>>>> +/*
>>>>>> + * Copyright (C) 2010 Google, Inc.
>>>>>> + *
>>>>>> + * Author:
>>>>>> + *     Chao Xie <xiechao.mail@gmail.com>
>>>>>> + *
>>>>>> + * This software is licensed under the terms of the GNU General
>>>>>> Public
>>>>>> + * License version 2, as published by the Free Software Foundation,
>>>>>> and
>>>>>> + * may be copied, distributed, and modified under those terms.
>>>>>> + *
>>>>>> + * This program is distributed in the hope that it will be useful,
>>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>>> + * GNU General Public License for more details.
>>>>>> + *
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/resource.h>
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/slab.h>
>>>>>> +#include <linux/of.h>
>>>>>> +#include <linux/of_device.h>
>>>>>> +#include <linux/io.h>
>>>>>> +#include <linux/err.h>
>>>>>> +#include <linux/clk.h>
>>>>>> +#include <linux/export.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/platform_device.h>
>>>>>> +#include <linux/platform_data/mv_usb.h>
>>>>>> +#include <linux/usb/mv_usb2.h>
>>>>>> +
>>>>>> +/* phy regs */
>>>>>> +#define UTMI_REVISION          0x0
>>>>>> +#define UTMI_CTRL              0x4
>>>>>> +#define UTMI_PLL               0x8
>>>>>> +#define UTMI_TX                        0xc
>>>>>> +#define UTMI_RX                        0x10
>>>>>> +#define UTMI_IVREF             0x14
>>>>>> +#define UTMI_T0                        0x18
>>>>>> +#define UTMI_T1                        0x1c
>>>>>> +#define UTMI_T2                        0x20
>>>>>> +#define UTMI_T3                        0x24
>>>>>> +#define UTMI_T4                        0x28
>>>>>> +#define UTMI_T5                        0x2c
>>>>>> +#define UTMI_RESERVE           0x30
>>>>>> +#define UTMI_USB_INT           0x34
>>>>>> +#define UTMI_DBG_CTL           0x38
>>>>>> +#define UTMI_OTG_ADDON         0x3c
>>>>>> +
>>>>>> +/* For UTMICTRL Register */
>>>>>> +#define UTMI_CTRL_USB_CLK_EN                    (1 << 31)
>>>>>> +/* pxa168 */
>>>>>> +#define UTMI_CTRL_SUSPEND_SET1                  (1 << 30)
>>>>>> +#define UTMI_CTRL_SUSPEND_SET2                  (1 << 29)
>>>>>> +#define UTMI_CTRL_RXBUF_PDWN                    (1 << 24)
>>>>>> +#define UTMI_CTRL_TXBUF_PDWN                    (1 << 11)
>>>>>> +
>>>>>> +#define UTMI_CTRL_INPKT_DELAY_SHIFT             30
>>>>>> +#define UTMI_CTRL_INPKT_DELAY_SOF_SHIFT                28
>>>>>> +#define UTMI_CTRL_PU_REF_SHIFT                 20
>>>>>> +#define UTMI_CTRL_ARC_PULLDN_SHIFT              12
>>>>>> +#define UTMI_CTRL_PLL_PWR_UP_SHIFT              1
>>>>>> +#define UTMI_CTRL_PWR_UP_SHIFT                  0
>>>>>> +
>>>>>> +/* For UTMI_PLL Register */
>>>>>> +#define UTMI_PLL_PLLCALI12_SHIFT               29
>>>>>> +#define UTMI_PLL_PLLCALI12_MASK                        (0x3 << 29)
>>>>>> +
>>>>>> +#define UTMI_PLL_PLLVDD18_SHIFT                        27
>>>>>> +#define UTMI_PLL_PLLVDD18_MASK                 (0x3 << 27)
>>>>>> +
>>>>>> +#define UTMI_PLL_PLLVDD12_SHIFT                        25
>>>>>> +#define UTMI_PLL_PLLVDD12_MASK                 (0x3 << 25)
>>>>>> +
>>>>>> +#define UTMI_PLL_CLK_BLK_EN_SHIFT               24
>>>>>> +#define CLK_BLK_EN                              (0x1 << 24)
>>>>>> +#define PLL_READY                               (0x1 << 23)
>>>>>> +#define KVCO_EXT                                (0x1 << 22)
>>>>>> +#define VCOCAL_START                            (0x1 << 21)
>>>>>> +
>>>>>> +#define UTMI_PLL_KVCO_SHIFT                    15
>>>>>> +#define UTMI_PLL_KVCO_MASK                      (0x7 << 15)
>>>>>> +
>>>>>> +#define UTMI_PLL_ICP_SHIFT                     12
>>>>>> +#define UTMI_PLL_ICP_MASK                       (0x7 << 12)
>>>>>> +
>>>>>> +#define UTMI_PLL_FBDIV_SHIFT                    4
>>>>>> +#define UTMI_PLL_FBDIV_MASK                     (0xFF << 4)
>>>>>> +
>>>>>> +#define UTMI_PLL_REFDIV_SHIFT                   0
>>>>>> +#define UTMI_PLL_REFDIV_MASK                    (0xF << 0)
>>>>>> +
>>>>>> +/* For UTMI_TX Register */
>>>>>> +#define UTMI_TX_REG_EXT_FS_RCAL_SHIFT          27
>>>>>> +#define UTMI_TX_REG_EXT_FS_RCAL_MASK           (0xf << 27)
>>>>>> +
>>>>>> +#define UTMI_TX_REG_EXT_FS_RCAL_EN_SHIFT       26
>>>>>> +#define UTMI_TX_REG_EXT_FS_RCAL_EN_MASK                (0x1 << 26)
>>>>>> +
>>>>>> +#define UTMI_TX_TXVDD12_SHIFT                   22
>>>>>> +#define UTMI_TX_TXVDD12_MASK                    (0x3 << 22)
>>>>>> +
>>>>>> +#define UTMI_TX_CK60_PHSEL_SHIFT                17
>>>>>> +#define UTMI_TX_CK60_PHSEL_MASK                 (0xf << 17)
>>>>>> +
>>>>>> +#define UTMI_TX_IMPCAL_VTH_SHIFT                14
>>>>>> +#define UTMI_TX_IMPCAL_VTH_MASK                 (0x7 << 14)
>>>>>> +
>>>>>> +#define REG_RCAL_START                          (0x1 << 12)
>>>>>> +
>>>>>> +#define UTMI_TX_LOW_VDD_EN_SHIFT                11
>>>>>> +
>>>>>> +#define UTMI_TX_AMP_SHIFT                      0
>>>>>> +#define UTMI_TX_AMP_MASK                       (0x7 << 0)
>>>>>> +
>>>>>> +/* For UTMI_RX Register */
>>>>>> +#define UTMI_REG_SQ_LENGTH_SHIFT                15
>>>>>> +#define UTMI_REG_SQ_LENGTH_MASK                 (0x3 << 15)
>>>>>> +
>>>>>> +#define UTMI_RX_SQ_THRESH_SHIFT                 4
>>>>>> +#define UTMI_RX_SQ_THRESH_MASK                  (0xf << 4)
>>>>>> +
>>>>>> +#define UTMI_OTG_ADDON_OTG_ON                  (1 << 0)
>>>>>> +
>>>>>> +enum mv_usb2_phy_type {
>>>>>> +       PXA168_USB,
>>>>>> +       PXA910_USB,
>>>>>> +       MMP2_USB,
>>>>>> +};
>>>>>> +
>>>>>> +static struct mv_usb2_phy *the_phy;
>>>>>> +
>>>>>> +struct mv_usb2_phy *mv_usb2_get_phy(void)
>>>>>> +{
>>>>>> +       return the_phy;
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(mv_usb2_get_phy);
>>>>>> +
>>>>>> +static unsigned int u2o_get(void __iomem *base, unsigned int offset)
>>>>>> +{
>>>>>> +       return readl(base + offset);
>>>>>> +}
>>>>>> +
>>>>>> +static void u2o_set(void __iomem *base, unsigned int offset,
>>>>>> +               unsigned int value)
>>>>>> +{
>>>>>> +       u32 reg;
>>>>>> +
>>>>>> +       reg = readl(base + offset);
>>>>>> +       reg |= value;
>>>>>> +       writel(reg, base + offset);
>>>>>> +       readl(base + offset);
>>>>>> +}
>>>>>> +
>>>>>> +static void u2o_clear(void __iomem *base, unsigned int offset,
>>>>>> +               unsigned int value)
>>>>>> +{
>>>>>> +       u32 reg;
>>>>>> +
>>>>>> +       reg = readl(base + offset);
>>>>>> +       reg &= ~value;
>>>>>> +       writel(reg, base + offset);
>>>>>> +       readl(base + offset);
>>>>>> +}
>>>>>> +
>>>>>> +static void u2o_write(void __iomem *base, unsigned int offset,
>>>>>> +               unsigned int value)
>>>>>> +{
>>>>>> +       writel(value, base + offset);
>>>>>> +       readl(base + offset);
>>>>>> +}
>>>>>> +
>>>>>> +static int _usb_phy_init(struct mv_usb2_phy *mv_phy)
>>>>>> +{
>>>>>> +       struct platform_device *pdev = mv_phy->pdev;
>>>>>> +       unsigned int loops = 0;
>>>>>> +       void __iomem *base = mv_phy->base;
>>>>>> +
>>>>>> +       dev_dbg(&pdev->dev, "phy init\n");
>>>>>> +
>>>>>> +       /* Initialize the USB PHY power */
>>>>>> +       if (mv_phy->type == PXA910_USB) {
>>>>>> +               u2o_set(base, UTMI_CTRL,
>>>>>> (1<<UTMI_CTRL_INPKT_DELAY_SOF_SHIFT)
>>>>>> +                       | (1<<UTMI_CTRL_PU_REF_SHIFT));
>>>>>> +       }
>>>>>> +
>>>>>> +       u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
>>>>>> +       u2o_set(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
>>>>>> +
>>>>>> +       /* UTMI_PLL settings */
>>>>>> +       u2o_clear(base, UTMI_PLL, UTMI_PLL_PLLVDD18_MASK
>>>>>> +               | UTMI_PLL_PLLVDD12_MASK | UTMI_PLL_PLLCALI12_MASK
>>>>>> +               | UTMI_PLL_FBDIV_MASK | UTMI_PLL_REFDIV_MASK
>>>>>> +               | UTMI_PLL_ICP_MASK | UTMI_PLL_KVCO_MASK);
>>>>>> +
>>>>>> +       u2o_set(base, UTMI_PLL, 0xee<<UTMI_PLL_FBDIV_SHIFT
>>>>>> +               | 0xb<<UTMI_PLL_REFDIV_SHIFT |
>>>>>> 3<<UTMI_PLL_PLLVDD18_SHIFT
>>>>>> +               | 3<<UTMI_PLL_PLLVDD12_SHIFT |
>>>>>> 3<<UTMI_PLL_PLLCALI12_SHIFT
>>>>>> +               | 1<<UTMI_PLL_ICP_SHIFT | 3<<UTMI_PLL_KVCO_SHIFT);
>>>>>> +
>>>>>> +       /* UTMI_TX */
>>>>>> +       u2o_clear(base, UTMI_TX, UTMI_TX_REG_EXT_FS_RCAL_EN_MASK
>>>>>> +               | UTMI_TX_TXVDD12_MASK | UTMI_TX_CK60_PHSEL_MASK
>>>>>> +               | UTMI_TX_IMPCAL_VTH_MASK |
>>>>>> UTMI_TX_REG_EXT_FS_RCAL_MASK
>>>>>> +               | UTMI_TX_AMP_MASK);
>>>>>> +       u2o_set(base, UTMI_TX, 3<<UTMI_TX_TXVDD12_SHIFT
>>>>>> +               | 4<<UTMI_TX_CK60_PHSEL_SHIFT |
>>>>>> 4<<UTMI_TX_IMPCAL_VTH_SHIFT
>>>>>> +               | 8<<UTMI_TX_REG_EXT_FS_RCAL_SHIFT |
>>>>>> 3<<UTMI_TX_AMP_SHIFT);
>>>>>> +
>>>>>> +       /* UTMI_RX */
>>>>>> +       u2o_clear(base, UTMI_RX, UTMI_RX_SQ_THRESH_MASK
>>>>>> +               | UTMI_REG_SQ_LENGTH_MASK);
>>>>>> +       u2o_set(base, UTMI_RX, 7<<UTMI_RX_SQ_THRESH_SHIFT
>>>>>> +               | 2<<UTMI_REG_SQ_LENGTH_SHIFT);
>>>>>> +
>>>>>> +       /* UTMI_IVREF */
>>>>>> +       if (mv_phy->type == PXA168_USB)
>>>>>> +               /* fixing Microsoft Altair board interface with NEC
>>>>>> hub
>>>>>> issue -
>>>>>> +                * Set UTMI_IVREF from 0x4a3 to 0x4bf */
>>>>>> +               u2o_write(base, UTMI_IVREF, 0x4bf);
>>>>>> +
>>>>>> +       /* toggle VCOCAL_START bit of UTMI_PLL */
>>>>>> +       udelay(200);
>>>>>> +       u2o_set(base, UTMI_PLL, VCOCAL_START);
>>>>>> +       udelay(40);
>>>>>> +       u2o_clear(base, UTMI_PLL, VCOCAL_START);
>>>>>> +
>>>>>> +       /* toggle REG_RCAL_START bit of UTMI_TX */
>>>>>> +       udelay(400);
>>>>>> +       u2o_set(base, UTMI_TX, REG_RCAL_START);
>>>>>> +       udelay(40);
>>>>>> +       u2o_clear(base, UTMI_TX, REG_RCAL_START);
>>>>>> +       udelay(400);
>>>>>> +
>>>>>> +       /* Make sure PHY PLL is ready */
>>>>>> +       loops = 0;
>>>>>> +       while ((u2o_get(base, UTMI_PLL) & PLL_READY) == 0) {
>>>>>> +               mdelay(1);
>>>>>> +               loops++;
>>>>>> +               if (loops > 100) {
>>>>>> +                       dev_warn(&pdev->dev, "calibrate timeout,
>>>>>> UTMI_PLL
>>>>>> %x\n",
>>>>>> +                               u2o_get(base, UTMI_PLL));
>>>>>> +                       break;
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       if (mv_phy->type == PXA168_USB) {
>>>>>> +               u2o_set(base, UTMI_RESERVE, 1 << 5);
>>>>>> +               /* Turn on UTMI PHY OTG extension */
>>>>>> +               u2o_write(base, UTMI_OTG_ADDON, 1);
>>>>>> +       }
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int _usb_phy_shutdown(struct mv_usb2_phy *mv_phy)
>>>>>> +{
>>>>>> +       void __iomem *base = mv_phy->base;
>>>>>> +
>>>>>> +       if (mv_phy->type == PXA168_USB)
>>>>>> +               u2o_clear(base, UTMI_OTG_ADDON,
>>>>>> UTMI_OTG_ADDON_OTG_ON);
>>>>>> +
>>>>>> +       u2o_clear(base, UTMI_CTRL, UTMI_CTRL_RXBUF_PDWN);
>>>>>> +       u2o_clear(base, UTMI_CTRL, UTMI_CTRL_TXBUF_PDWN);
>>>>>> +       u2o_clear(base, UTMI_CTRL, UTMI_CTRL_USB_CLK_EN);
>>>>>> +       u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PWR_UP_SHIFT);
>>>>>> +       u2o_clear(base, UTMI_CTRL, 1<<UTMI_CTRL_PLL_PWR_UP_SHIFT);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int usb_phy_init(struct mv_usb2_phy *mv_phy)
>>>>>> +{
>>>>>> +       int i = 0;
>>>>>> +
>>>>>> +       mutex_lock(&mv_phy->phy_lock);
>>>>>> +       if (mv_phy->refcount++ == 0) {
>>>>>> +               for (i = 0; i < mv_phy->clks_num; i++)
>>>>>> +                       clk_prepare_enable(mv_phy->clks[i]);
>>>>>> +               _usb_phy_init(mv_phy);
>>>>>> +       }
>>>>>> +       mutex_unlock(&mv_phy->phy_lock);
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void usb_phy_shutdown(struct mv_usb2_phy *mv_phy)
>>>>>> +{
>>>>>> +       int i = 0;
>>>>>> +
>>>>>> +       mutex_lock(&mv_phy->phy_lock);
>>>>>> +       if (mv_phy->refcount++ == 0) {
>>>>>> +               _usb_phy_shutdown(mv_phy);
>>>>>> +               for (i = 0; i < mv_phy->clks_num; i++)
>>>>>> +                       clk_disable_unprepare(mv_phy->clks[i]);
>>>>>> +       }
>>>>>> +       mutex_unlock(&mv_phy->phy_lock);
>>>>>> +}
>>>>>> +
>>>>>> +static struct of_device_id usb_phy_dt_ids[] = {
>>>>>> +       { .compatible = "mrvl,pxa168-usb-phy",  .data = (void
>>>>>> *)PXA168_USB},
>>>>>> +       { .compatible = "mrvl,pxa910-usb-phy",  .data = (void
>>>>>> *)PXA910_USB},
>>>>>> +       { .compatible = "mrvl,mmp2-usb-phy",    .data = (void
>>>>>> *)MMP2_USB},
>>>>>> +       {}
>>>>>> +};
>>>>>> +MODULE_DEVICE_TABLE(of, usb_phy_dt_ids);
>>>>>> +
>>>>>> +static int usb_phy_parse_dt(struct platform_device *pdev,
>>>>>> +                               struct mv_usb2_phy *mv_phy)
>>>>>> +{
>>>>>> +       struct device_node *np = pdev->dev.of_node;
>>>>>> +       const struct of_device_id *of_id =
>>>>>> +                       of_match_device(usb_phy_dt_ids, &pdev->dev);
>>>>>> +       unsigned int clks_num;
>>>>>> +       int i, ret;
>>>>>> +       const char *clk_name;
>>>>>> +
>>>>>> +       if (!np)
>>>>>> +               return 1;
>>>>>> +
>>>>>> +       clks_num = of_property_count_strings(np, "clocks");
>>>>>> +       if (clks_num < 0) {
>>>>>> +               dev_err(&pdev->dev, "failed to get clock number\n");
>>>>>> +               return clks_num;
>>>>>> +       }
>>>>>> +
>>>>>> +       mv_phy->clks = devm_kzalloc(&pdev->dev,
>>>>>> +               sizeof(struct clk *) * clks_num, GFP_KERNEL);
>>>>>> +       if (mv_phy->clks == NULL) {
>>>>>> +               dev_err(&pdev->dev,
>>>>>> +                       "failed to allocate mempory for clocks");
>>>>>> +               return -ENOMEM;
>>>>>> +       }
>>>>>> +
>>>>>> +       for (i = 0; i < clks_num; i++) {
>>>>>> +               ret = of_property_read_string_index(np, "clocks", i,
>>>>>> +                       &clk_name);
>>>>>> +               if (ret) {
>>>>>> +                       dev_err(&pdev->dev, "failed to read
>>>>>> clocks\n");
>>>>>> +                       return ret;
>>>>>> +               }
>>>>>> +               mv_phy->clks[i] = devm_clk_get(&pdev->dev, clk_name);
>>>>>> +               if (IS_ERR(mv_phy->clks[i])) {
>>>>>> +                       dev_err(&pdev->dev, "failed to get clock
>>>>>> %s\n",
>>>>>> +                               clk_name);
>>>>>> +                       return PTR_ERR(mv_phy->clks[i]);
>>>>>> +               }
>>>>>> +       }
>>>>>> +
>>>>>> +       mv_phy->clks_num = clks_num;
>>>>>> +       mv_phy->type = (enum mv_usb2_phy_type)(of_id->data);
>>>>>> +
>>>>>> +       return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int usb_phy_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +       struct mv_usb2_phy *mv_phy;
>>>>>> +       struct resource *r;
>>>>>> +       int ret, i;
>>>>>> +
>>>>>> +       mv_phy = devm_kzalloc(&pdev->dev, sizeof(*mv_phy),
>>>>>> GFP_KERNEL);
>>>>>> +       if (mv_phy == NULL) {
>>>>>> +               dev_err(&pdev->dev, "failed to allocate memory\n");
>>>>>> +               return -ENOMEM;
>>>>>> +       }
>>>>>> +       mutex_init(&mv_phy->phy_lock);
>>>>>> +
>>>>>> +       ret = usb_phy_parse_dt(pdev, mv_phy);
>>>>>> +       /* no CONFIG_OF */
>>>>>> +       if (ret > 0) {
>>>>>> +               struct mv_usb_phy_platform_data *pdata
>>>>>> +                               = pdev->dev.platform_data;
>>>>>> +               const struct platform_device_id *id
>>>>>> +                               = platform_get_device_id(pdev);
>>>>>> +
>>>>>> +               if (pdata == NULL || id == NULL) {
>>>>>> +                       dev_err(&pdev->dev,
>>>>>> +                               "missing platform_data or
>>>>>> id_entry\n");
>>>>>> +                       return -ENODEV;
>>>>>> +               }
>>>>>> +               mv_phy->type = (unsigned int)(id->driver_data);
>>>>>> +               mv_phy->clks_num = pdata->clknum;
>>>>>> +               mv_phy->clks = devm_kzalloc(&pdev->dev,
>>>>>> +                       sizeof(struct clk *) * mv_phy->clks_num,
>>>>>> GFP_KERNEL);
>>>>>> +               if (mv_phy->clks == NULL) {
>>>>>> +                       dev_err(&pdev->dev,
>>>>>> +                               "failed to allocate mempory for
>>>>>> clocks");
>>>>>> +                       return -ENOMEM;
>>>>>> +               }
>>>>>> +               for (i = 0; i < mv_phy->clks_num; i++)
>>>>>> +                       mv_phy->clks[i] = devm_clk_get(&pdev->dev,
>>>>>> +
>>>>>> pdata->clkname[i]);
>>>>>> +                       if (IS_ERR(mv_phy->clks[i])) {
>>>>>> +                               dev_err(&pdev->dev, "failed to get
>>>>>> clock
>>>>>> %s\n",
>>>>>> +                                       pdata->clkname[i]);
>>>>>> +                               return PTR_ERR(mv_phy->clks[i]);
>>>>>> +                       }
>>>>>> +       } else if (ret < 0) {
>>>>>> +               dev_err(&pdev->dev, "error parse dt\n");
>>>>>> +               return ret;
>>>>>> +       }
>>>>>> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>>>> +       if (r == NULL) {
>>>>>> +               dev_err(&pdev->dev, "no phy I/O memory resource
>>>>>> defined\n");
>>>>>> +               return -ENODEV;
>>>>>> +       }
>>>>>> +       mv_phy->base = devm_ioremap(&pdev->dev, r->start,
>>>>>> resource_size(r));
>>>>>> +       if (mv_phy->base == NULL) {
>>>>>> +               dev_err(&pdev->dev, "error map register base\n");
>>>>>> +               return -EBUSY;
>>>>>> +       }
>>>>>> +       platform_set_drvdata(pdev, mv_phy);
>>>>>> +       mv_phy->pdev = pdev;
>>>>>> +       mv_phy->init = usb_phy_init;
>>>>>> +       mv_phy->shutdown = usb_phy_shutdown;
>>>>>> +
>>>>>> +       platform_set_drvdata(pdev, mv_phy);
>>>>>> +
>>>>>> +       the_phy = mv_phy;
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Is there any specific reason for not using the usb phy library?
>>>>> Please use the APIs provided in drivers/usb/otg/otg.c.
>>>>> These APIs will be moved to phy.c soon.
>>>>>
>>>>> Thanks
>>>>> Kishon
>>>>
>>>>
>>>>
>>>> The phy in driver/usb/otg/otg.c is bound to OTG. The major target of
>>>> this APIs in OTG is help functions for OTG support.
>>>
>>>
>>>
>>> Not really. Much of what's in otg.c is related to PHY and we have an
>>> action
>>> item to rename otg.c to phy.c. Sascha hauer has already sent a patch for
>>> it.
>>>
>>>> I have used it and implemented it at mv_otg.c for OTG support. The
>>>> APIs only allow one phy driver register to it.
>>>
>>>
>>>
>>> PHY library has changed quite a bit since then. You might want to have a
>>> look at usb/otg/otg.c again in usb-next.
>>>
>> Thanks for your suggestion.
>>
>> I have taken look at the otg.c again.
>> The problem is the phy list only allow a single phy driver for each type.
>> It defines only two valid types
>>
>>          USB_PHY_TYPE_USB2,
>>          USB_PHY_TYPE_USB3,
>> when invoke usb_add_phy  to add a phy driver, if USB_PHY_TYPE_USB2 has
>> been added, it will return error
>> some piece of the code is listed below
>>
>> list_for_each_entry(phy, &phy_list, head) {
>>                  if (phy->type == type) {
>>                          ret = -EBUSY;
>>                          dev_err(x->dev, "transceiver type %s already
>> exists\n",
>>
>> usb_phy_type_string(type));
>>                          goto out;
>>                  }
>>          }
>>
>> The USB IP we used includes EHCI and UDC controller together, and it
>> can support OTG functions.
>> When either mode(EHCI/UDC) is used, the PHY blocks should be enabled
>> because it controller to turn
>> the internal signals of USB IP block to the D+/D-/VBUS signals we see.
>> So if we register this phy to be type USB_PHY_TYPE_USB2, then how about
>> OTG?
>> For OTG support we need register the PHY to complete the device->host
>> and host->device transaction, if we register it as
>> USB_PHY_TYPE_USB2, the registertation will fail.
>>
>> So there will be three ways to do the job
>> way1:
>> 1. invoke usb_add_phy in phy driver with type of USB_PHY_TYPE_USB2,
>> and initialize the callbacks
>> 2. in usb otg driver, invoke usb_get_phy and initialize the otg part
>> way1 seems a little tricky because when the phy initialize is
>> seperated into two parts.
>>
>> way2:
>> change the otg.c and make it can add mutiple phy for the type.
>> It takes time and will impact many drivers. I hope i can do it after i
>> have completed my patches.
>
>
> This is already done. We have added API's like usb_add_phy_dev() for the
> same purpose. Now you can use usb_add_phy_dev() to add multiple PHYs (of
> same type or different) and then get the PHY using usb_get_phy_dev(). Note
> that you should use usb_bind_phy() in platform initialization file for
> binding the controller to the PHY.
>
> These patches are merged in usb-next
> http://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-next
>
> Thanks
> Kishon

Thanks for your suggestion. I will take a look and redo the patches.
