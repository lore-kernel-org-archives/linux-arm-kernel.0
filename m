From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 May 2012 17:18:11 +0200
Subject: [PATCH v3 1/3] mmc: atmel-mci: add device tree support
In-Reply-To: <20120522151048.GD3377@game.jcrosoft.org>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-2-git-send-email-ludovic.desroches@atmel.com>
 <20120522140845.GA3377@game.jcrosoft.org> <4FBBA756.8030501@atmel.com>
 <20120522151048.GD3377@game.jcrosoft.org>
Message-ID: <4FBBAE33.5050506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/2012 05:10 PM, Jean-Christophe PLAGNIOL-VILLARD :
> On 16:48 Tue 22 May     , ludovic.desroches wrote:
>> Le 05/22/2012 04:08 PM, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
>>> On 12:09 Tue 22 May     , ludovic.desroches at atmel.com wrote:
>>>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>>>
>>>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
>>>> ---
>>>>  .../devicetree/bindings/mmc/atmel-hsmci.txt        |   67 +++++++++++++++
>>>>  drivers/mmc/host/atmel-mci.c                       |   89 +++++++++++++++++++-
>>>>  2 files changed, 154 insertions(+), 2 deletions(-)
>>>>  create mode 100644 Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
>>>> new file mode 100644
>>>> index 0000000..81c20cc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
>>>> @@ -0,0 +1,67 @@
>>>> +* Atmel High Speed MultiMedia Card Interface
>>>> +
>>>> +This controller on atmel products provides an interface for MMC, SD and SDIO
>>>> +types of memory cards.
>>>> +
>>>> +1) MCI node
>>>> +
>>>> +Required properties:
>>>> +- compatible: no blank "atmel,hsmci"
>>>> +- reg: should contain HSMCI registers location and length
>>>> +- interrupts: should contain HSMCI interrupt number
>>>> +- #address-cells: should be one. The cell is the slot id.
>>>> +- #size-cells: should be zero.
>>>> +- at least one slot node
>>>> +
>>>> +The node contains child nodes for each slot that the platform uses
>>>> +
>>>> +Example MCI node:
>>>> +
>>>> +mmc0: mmc at f0008000 {
>>>> +	compatible = "atmel,hsmci";
>>>> +	reg =<0xf0008000 0x600>;
>>>> +	interrupts =<12 4>;
>>>> +	#address-cells =<1>;
>>>> +	#size-cells =<0>;
>>>> +
>>>> +	[ child node definitions...]
>>>> +};
>>>> +
>>>> +2) slot nodes
>>>> +
>>>> +Required properties:
>>>> +- reg: should contain the slot id.
>>>> +- bus-width: number of data lines connected to the controller
>>>> +
>>>> +Optional properties:
>>>> +- cd-gpios: specify GPIOs for card detection
>>>> +- cd-inverted: invert the value of external card detect gpio line
>>> why this
>>>
>>> no need you can use the third field and OF_GPIO_ACTIVE_LOW
>>> as done on ohci-at91.c
>>>
>>
>> It's a property from the common mmc binding so why not using it?
> gpio alread carry this information mmc common bindingd need to use is

Discussion seem ongoing about common mmc binding. What you describe
above has been proposed but not adopted. So, until it reaches a
consensus, we keep what is described in current binding.


> btw for bool property you need to use of_property_read_bool
>>
>>>> +- wp-gpios: specify GPIOs for write protection
>>>> +
>>>> +Example slot node:
>>>> +
>>>> +slot at 0 {
>>>> +	reg =<0>;
>>>> +	bus-width =<4>;
>>>> +	cd-gpios =<&pioD 15 0>
>>>> +	cd-inverted;
>>>> +};
>>>> +
>>>> +Example full MCI node:
>>>> +mmc0: mmc at f0008000 {
>>>> +	compatible = "atmel,hsmci";
>>>> +	reg =<0xf0008000 0x600>;
>>>> +	interrupts =<12 4>;
>>>> +	#address-cells =<1>;
>>>> +	#size-cells =<0>;
>>>> +	slot at 0 {
>>>> +		reg =<0>;
>>>> +		bus-width =<4>;
>>>> +		cd-gpios =<&pioD 15 0>
>>>> +		cd-inverted;
>>>> +	};
>>>> +	slot at 1 {
>>>> +		reg =<1>;
>>>> +		bus-width =<4>;
>>>> +	};
>>>> +};
>>>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>>>> index 556d384..43f98fc 100644
>>>> --- a/drivers/mmc/host/atmel-mci.c
>>>> +++ b/drivers/mmc/host/atmel-mci.c
>>>> @@ -19,6 +19,9 @@
>>>>  #include<linux/interrupt.h>
>>>>  #include<linux/ioport.h>
>>>>  #include<linux/module.h>
>>>> +#include<linux/of.h>
>>>> +#include<linux/of_device.h>
>>>> +#include<linux/of_gpio.h>
>>>>  #include<linux/platform_device.h>
>>>>  #include<linux/scatterlist.h>
>>>>  #include<linux/seq_file.h>
>>>> @@ -493,6 +496,74 @@ err:
>>>>  	dev_err(&mmc->class_dev, "failed to initialize debugfs for slot\n");
>>>>  }
>>>>
>>>> +#if defined(CONFIG_OF)
>>>> +static const struct of_device_id atmci_dt_ids[] = {
>>>> +	{ .compatible = "atmel,hsmci" },
>>>> +	{ /* sentinel */ }
>>>> +};
>>>> +
>>>> +MODULE_DEVICE_TABLE(of, atmci_dt_ids);
>>>> +
>>>> +static struct mci_platform_data __devinit*
>>>> +atmci_of_init(struct platform_device *pdev)
>>>> +{
>>>> +	struct device_node *np = pdev->dev.of_node;
>>>> +	struct device_node *cnp;
>>>> +	struct mci_platform_data *pdata;
>>>> +	unsigned int slot_id;
>>>> +	const __be32 *reg;
>>>> +
>>>> +	if (!np) {
>>>> +		dev_err(&pdev->dev, "device node not found\n");
>>>> +		return ERR_PTR(-EINVAL);
>>>> +	}
>>>> +
>>>> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>>> +	if (!pdata) {
>>>> +		dev_err(&pdev->dev, "could not allocate memory for pdata\n");
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +	}
>>>> +
>>>> +	for_each_child_of_node(np, cnp) {
>>>> +		reg = of_get_property(cnp, "reg", NULL);
>>>> +		if (!reg) {
>>>> +			dev_warn(&pdev->dev, "reg property is missing for %s\n",
>>>> +				 cnp->full_name);
>>>> +			continue;
>>>> +		}
>>>> +
>>>> +		slot_id = be32_to_cpu(reg[0]);
>>> read_u32
>>
>> ok
>>
>>>> +
>>>> +		if (slot_id>  (ATMCI_MAX_NR_SLOTS-1)) {
>>>> +			dev_warn(&pdev->dev, "can't have more than %d slots\n",
>>>> +			         ATMCI_MAX_NR_SLOTS);
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (of_property_read_u32(cnp, "bus-width",
>>>> +		&pdata->slot[slot_id].bus_width))
>>>> +			pdata->slot[slot_id].bus_width = 1;
>>>> +
>>>> +		pdata->slot[slot_id].detect_pin =
>>>> +			of_get_named_gpio(cnp, "cd-gpios", 0);
>>>> +
>>>> +		if (of_find_property(cnp, "cd-inverted", NULL))
>>>> +			pdata->slot[slot_id].detect_is_active_high = true;
>>>> +
>>>> +		pdata->slot[slot_id].wp_pin =
>>>> +			of_get_named_gpio(cnp, "wp-gpios", 0);
>>>> +	}
>>>> +
>>>> +	return pdata;
>>>> +}
>>>> +#else /* CONFIG_OF */
>>>> +static inline struct mci_platform_data*
>>>> +atmci_of_init(struct platform_device *dev)
>>>> +{
>>>> +	return ERR_PTR(-EINVAL);
>>>> +}
>>>> +#endif
>>>> +
>>>>  static inline unsigned int atmci_get_version(struct atmel_mci *host)
>>>>  {
>>>>  	return atmci_readl(host, ATMCI_VERSION)&  0x00000fff;
>>>> @@ -2038,6 +2109,13 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>>>>  	slot->sdc_reg = sdc_reg;
>>>>  	slot->sdio_irq = sdio_irq;
>>>>
>>>> +	dev_dbg(&mmc->class_dev,
>>>> +	        "slot[%u]: bus_width=%u, detect_pin=%d, "
>>>> +		"detect_is_active_high=%s, wp_pin=%d\n",
>>>> +		id, slot_data->bus_width, slot_data->detect_pin,
>>>> +		slot_data->detect_is_active_high ? "true" : "false",
>>>> +		slot_data->wp_pin);
>>>> +
>>>>  	mmc->ops =&atmci_ops;
>>>>  	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
>>>>  	mmc->f_max = host->bus_hz / 2;
>>>> @@ -2258,8 +2336,14 @@ static int __init atmci_probe(struct platform_device *pdev)
>>>>  	if (!regs)
>>>>  		return -ENXIO;
>>>>  	pdata = pdev->dev.platform_data;
>>>> -	if (!pdata)
>>>> -		return -ENXIO;
>>> check the node and then check the return
>>>
>>
>> Sorry but what do you mean? The node is checked into atmci_of_init
>> and the return is checked:
>>
>> +	if (!pdata) {
>> +		pdata = atmci_of_init(pdev);
>> +		if (IS_ERR(pdata)) {
>> +			dev_err(&pdev->dev, "platform data not available\n");
>> +			return -EINVAL;
> and here return the reall error btw
>> +		}
>> +	}
> you just call the of_init if you have a node

Well, this seems simple and elegant to me.

Bye,
-- 
Nicolas Ferre
