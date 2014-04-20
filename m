From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 20 Apr 2014 12:04:51 +0200
Subject: [PATCH 02/29] pinctrl: mvebu: new driver for Orion platforms
In-Reply-To: <20140419192846.78ff71ab@skate>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BA725.9010609@gmail.com> <20140419192846.78ff71ab@skate>
Message-ID: <53539BC3.5070908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2014 07:28 PM, Thomas Petazzoni wrote:
> On Mon, 14 Apr 2014 11:15:17 +0200, Sebastian Hesselbarth wrote:
>>> +mpp3          3        gpio, pci(gnt3)
>>> +mpp4          4        gpio, pci(req4), bootnand(re), sata0(prsnt)
>>> +mpp5          5        gpio, pci(gnt4), bootnand(we), sata1(prsnt)
>>> +mpp6          6        gpio, pci(req5), nand(re0), sata0(act)
>>> +mpp7          7        gpio, pci(gnt5), nand(we0), sata1(act)
>>> +mpp8          8        gpio, ge(col)
>>> +mpp9          9        gpio, ge(rxerr)
>>> +mpp10         10       gpio, ge(crs)
>>> +mpp11         11       gpio, ge(txerr)
>>> +mpp12         12       gpio, ge(txd4), nand(re1), sata0(ledprsnt)
>>> +mpp13         13       gpio, ge(txd5), nand(we1), sata1(ledprsnt)
>>> +mpp14         14       gpio, ge(txd6), nand(re2), sata0(ledact)
>>> +mpp15         15       gpio, ge(txd7), nand(we2), sata1(ledact)
>>
>> Four "led" prefixes above should be removed.
> 
> I don't agree, because there would then be no difference between
> sata0(act) and sata0(ledact), even if in the datasheet, their
> description is different:
> 
>  * SATA 0 active indication (for which I've used "sata0(act)")
>  * SATA 0 presence LED indication (Active Low) (for which I've used
>    "sata0(ledact)")
> 
> Do you have another suggestion?

No, I thought that "led" prefix would be a typo in the DS already.
The other SoCs have one pin to indicate SATA activity (act) and one
to indicate SATA presence (prnst). If there is really two different
functions on Orion5x, then there should be two different names, of
course.

>>> +static struct mvebu_mpp_ctrl orion_mpp_controls[] = {
>>> +	MPP_FUNC_CTRL(0, 19, NULL, orion_mpp_ctrl),
>>> +};
>>> +
>>> +static struct pinctrl_gpio_range mv88f5181l_gpio_ranges[] = {
>>> +	MPP_GPIO_RANGE(0, 0, 0, 16),
>>> +};
>>> +
>>> +static struct pinctrl_gpio_range mv88f5182_gpio_ranges[] = {
>>> +	MPP_GPIO_RANGE(0, 0, 0, 19),
>>> +};
>>> +
>>> +static struct pinctrl_gpio_range mv88f5281_gpio_ranges[] = {
>>> +	MPP_GPIO_RANGE(0, 0, 0, 16),
>>> +};
>>
>> mv88f5181l_gpio_ranges == mv88f5281_gpio_ranges.
>>
>> You can possibly join them to mv88f5x81_gpio ranges, but I have
>> no strong opinion about it.
> 
> I prefer to have them all for each SoC, for consistency.

Ok.

>>> +static int orion_pinctrl_probe(struct platform_device *pdev)
>>> +{
>>> +	const struct of_device_id *match =
>>> +		of_match_device(orion_pinctrl_of_match, &pdev->dev);
>>> +	struct resource *res;
>>> +
>>> +	pdev->dev.platform_data = (void*) match->data;
>>
>> Useless (void *) cast?
> 
> No: there is the same cast in pinctrl-dove.c and pinctrl-kirkwood.c.
> The reason is a bit ugly: match->data is "const" but
> pdev->dev.platform_data is not. Certainly something to fix at some
> point, but probably not as part of this patch series, since Dove and
> Kirkwood are already doing the bad thing :)

Ach, dammit you are right. Thanks for reminding me about the pending
second round of mvebu/pinctrl cleanup ;)

Sebastian
