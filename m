From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Thu, 16 Feb 2017 10:51:46 -0600
Subject: [PATCH 3/5] reset: Add Altera Arria10 System Resource Reset
 Controller
In-Reply-To: <1487241047.2377.23.camel@pengutronix.de>
References: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
 <1487195416-23827-4-git-send-email-thor.thayer@linux.intel.com>
 <1487241047.2377.23.camel@pengutronix.de>
Message-ID: <05662fdf-ac7b-94f0-0a32-7a2c7a2e3270@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 02/16/2017 04:30 AM, Philipp Zabel wrote:
> Hi Thor,
>
> thank you for the patch. A few comments below:
>
> On Wed, 2017-02-15 at 15:50 -0600, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> This patch adds the reset controller functionality to the Arria10
>> System Resource Manager.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>  MAINTAINERS                 |   1 +
>>  drivers/reset/Kconfig       |   7 ++
>>  drivers/reset/Makefile      |   1 +
>>  drivers/reset/reset-a10sr.c | 176 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 185 insertions(+)
>>  create mode 100644 drivers/reset/reset-a10sr.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a2c74db..3265cb2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -655,6 +655,7 @@ F:	drivers/gpio/gpio-altera-a10sr.c
>>  F:	drivers/mfd/altera-a10sr.c
>>  F:	include/linux/mfd/altera-a10sr.h
>>  F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
>> +F:	drivers/reset/reset-a10sr.c
>>
>>  ALTERA TRIPLE SPEED ETHERNET DRIVER
>>  M:	Vince Bridgers <vbridger@opensource.altera.com>
>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>> index f4cdfe9..b821d1b 100644
>> --- a/drivers/reset/Kconfig
>> +++ b/drivers/reset/Kconfig
>> @@ -39,6 +39,13 @@ config RESET_MESON
>>  	help
>>  	  This enables the reset driver for Amlogic Meson SoCs.
>>
>> +config ALTERA_A10SR_RESET
>
> Please follow the RESET_<SoC> convention and sort alphabetically.
>
Whoops. Thanks.

>> +	tristate "Altera Arria10 System Resource Reset"
>> +	depends on MFD_ALTERA_A10SR
>> +	help
>> +	  This option enables support for the external reset functions for
>> +	  peripheral PHYs on the Altera Arria10 System Resource Chip.
>> +
>>  config RESET_OXNAS
>>  	bool
>>
>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>> index 2cd3f6c..d6a2a87 100644
>> --- a/drivers/reset/Makefile
>> +++ b/drivers/reset/Makefile
>> @@ -15,3 +15,4 @@ obj-$(CONFIG_TI_SYSCON_RESET) += reset-ti-syscon.o
>>  obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>>  obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
>>  obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>> +obj-$(CONFIG_ALTERA_A10SR_RESET) += reset-a10sr.o
>> diff --git a/drivers/reset/reset-a10sr.c b/drivers/reset/reset-a10sr.c
>> new file mode 100644
>> index 0000000..ed058f3
>> --- /dev/null
>> +++ b/drivers/reset/reset-a10sr.c
>> @@ -0,0 +1,176 @@
>> +/*
>> + *  Copyright Intel Corporation (C) 2017. All Rights Reserved
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + *
>> + * Reset driver for Altera Arria10 MAX5 System Resource Chip
>> + *
>> + * Adapted from reset-socfpga.c
>> + */
>> +
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>
> This is not used.
>
OK, thanks.

>> +#include <linux/mfd/altera-a10sr.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset-controller.h>
>> +#include <linux/types.h>
>> +
>> +#include <dt-bindings/reset/altr,rst-mgr-a10sr.h>
>> +
>> +/* Number of A10 System Controller Resets */
>> +#define A10SR_RESETS		16
>
> So 16 resets...
>
>> +struct a10sr_reset {
>> +	struct reset_controller_dev     rcdev;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static inline struct a10sr_reset *to_a10sr_rst(struct reset_controller_dev *rc)
>> +{
>> +	return container_of(rc, struct a10sr_reset, rcdev);
>> +}
>> +
>> +static inline int a10sr_reset_shift(unsigned long id)
>> +{
>> +	switch (id) {
>> +	case A10SR_RESET_ENET_HPS:
>> +		return 1;
>> +	case A10SR_RESET_PCIE:
>> +	case A10SR_RESET_FILE:
>> +	case A10SR_RESET_BQSPI:
>> +	case A10SR_RESET_USB:
>> +		return id + 11;
>
> ... but only 5 are handled. What about the other 11? Could you point me
> to documentation for this reset controller?
>
Whoops. Good catch, I will fix this. Remnants of my first implementation 
before realizing a switch statement was cleaner.

I looked and apparently we don't publish the System Resource 
documentation yet. This is for a CPLD programmed as a system manager so 
there is some sharing of reset/enable and status bits.

There were two 8-bit registers but only 5 bits are writable while others 
only show status. Bit 2 of the first register and bits 12-15 of the 2nd 
register are writable resets.

>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int a10sr_reset_update(struct reset_controller_dev *rcdev,
>> +			      unsigned long id, bool assert)
>> +{
>> +	struct a10sr_reset *a10r = to_a10sr_rst(rcdev);
>> +	int offset = a10sr_reset_shift(id);
>> +	u8 mask = ALTR_A10SR_REG_BIT_MASK(offset);
>> +	int index = ALTR_A10SR_HPS_RST_REG + ALTR_A10SR_REG_OFFSET(offset);
>> +
>> +	if (id >= rcdev->nr_resets)
>> +		return -EINVAL;
>
> Checking the id is not necessary. The ops are called with rstc->id,
> which was checked in of_reset_simple_xlate.
>
OK. I didn't notice that check. Thanks.

>> +	return regmap_update_bits(a10r->regmap, index, mask, assert ? 0 : mask);
>> +}
>> +
>> +static int a10sr_reset_assert(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	return a10sr_reset_update(rcdev, id, true);
>> +}
>> +
>> +static int a10sr_reset_deassert(struct reset_controller_dev *rcdev,
>> +				unsigned long id)
>> +{
>> +	return a10sr_reset_update(rcdev, id, false);
>> +}
>> +
>> +static int a10sr_reset_status(struct reset_controller_dev *rcdev,
>> +			      unsigned long id)
>> +{
>> +	int error;
>> +	struct a10sr_reset *a10r = to_a10sr_rst(rcdev);
>> +	int offset = a10sr_reset_shift(id);
>> +	u8 mask = ALTR_A10SR_REG_BIT_MASK(offset);
>> +	int index = ALTR_A10SR_HPS_RST_REG + ALTR_A10SR_REG_OFFSET(offset);
>> +	unsigned int value;
>> +
>> +	if (id >= rcdev->nr_resets)
>> +		return -EINVAL;
>
> Same here. reset_status should never be called with an invalid id.
>
>> +	error = regmap_read(a10r->regmap, index, &value);
>> +	if (error < 0)
>> +		return -ENOMEM;
>
> Why ENOMEM? Just propagate the error.
>
Yes, that would be better.

>> +
>> +	return !!(value & mask);
>> +}
>> +
>> +static const struct reset_control_ops a10sr_reset_ops = {
>> +	.assert		= a10sr_reset_assert,
>> +	.deassert	= a10sr_reset_deassert,
>> +	.status		= a10sr_reset_status,
>> +};
>> +
>> +static const struct of_device_id a10sr_reset_of_match[];
>
> Avoid forward declarations. Just move a10sr_reset_of_match up here if
> needed. Although I don't think this is necessary, see below.
>
OK. Yes, I agree that this isn't necessary with the below changes. Thanks.

>> +static int a10sr_reset_probe(struct platform_device *pdev)
>> +{
>> +	struct altr_a10sr *a10sr = dev_get_drvdata(pdev->dev.parent);
>> +	struct a10sr_reset *a10r;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>
> Here np is assigned to pdev->dev.of_node.
>
>> +	/* Ensure we have a valid DT entry. */
>> +	np = of_find_matching_node(NULL, a10sr_reset_of_match);
>
> And here it is overwritten again. Shouldn't those be the same anyway? I
> think this assignment and the DT entry check could be removed.
>
Yes, Thanks.

>> +	if (!np) {
>> +		dev_err(&pdev->dev, "A10 Reset DT Entry not found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!of_find_property(np, "#reset-cells", NULL)) {
>> +		dev_err(&pdev->dev, "%s missing #reset-cells property\n",
>> +			np->full_name);
>> +		return -EINVAL;
>> +	}
>
> This is unnecessary. If #reset-cells is missing, the reset lookups will
> fail.
>
Nice, Thanks.

>> +	a10r = devm_kzalloc(&pdev->dev, sizeof(struct a10sr_reset),
>> +			    GFP_KERNEL);
>> +	if (!a10r)
>> +		return -ENOMEM;
>> +
>> +	a10r->rcdev.owner = THIS_MODULE;
>> +	a10r->rcdev.nr_resets = A10SR_RESETS;
>> +	a10r->rcdev.ops = &a10sr_reset_ops;
>> +	a10r->rcdev.of_node = np;
>> +	a10r->regmap = a10sr->regmap;
>> +
>> +	platform_set_drvdata(pdev, a10r);
>> +
>> +	return devm_reset_controller_register(dev, &a10r->rcdev);
>> +}
>> +
>> +static int a10sr_reset_remove(struct platform_device *pdev)
>> +{
>> +	struct a10sr_reset *a10r = platform_get_drvdata(pdev);
>> +
>> +	reset_controller_unregister(&a10r->rcdev);
>
> Since you use the devm_ variant of reset_controller_register above, this
> happens automatically. You can drop a10sr_reset_remove completely.
>
OK, thanks.

>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id a10sr_reset_of_match[] = {
>> +	{ .compatible = "altr,a10sr-reset" },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, a10sr_reset_of_match);
>> +
>> +static struct platform_driver a10sr_reset_driver = {
>> +	.probe	= a10sr_reset_probe,
>> +	.remove	= a10sr_reset_remove,
>> +	.driver = {
>> +		.name		= "altr_a10sr_reset",
>> +		.owner		= THIS_MODULE,
>
> Assigning .owner is not necessary anymore, __platform_driver_register
> does this.
>
Got it. Thanks for reviewing! I will fix this and resubmit.

>> +	},
>> +};
>> +module_platform_driver(a10sr_reset_driver);
>> +
>> +MODULE_AUTHOR("Thor Thayer <thor.thayer@linux.intel.com>");
>> +MODULE_DESCRIPTION("Altera Arria10 System Resource Reset Controller Driver");
>> +MODULE_LICENSE("GPL v2");
>
> regards
> Philipp
>
