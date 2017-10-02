From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 2 Oct 2017 15:47:51 -0500
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20171002174414.GL1165@minitux>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
 <20171002174414.GL1165@minitux>
Message-ID: <9f28c9dd-6277-6c75-1186-a834e15c5346@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2017 12:44 PM, Bjorn Andersson wrote:
>> +	/*
>> +	 * If irq_need_valid_mask is true, then gpiochip_add_data() will
>> +	 * initialize irq_valid_mask to all 1s.  We need to clear all the
>> +	 * GPIOs that are unavailable, and we need to find each block
>> +	 * of consecutive available GPIOs are add them as pin ranges.
>> +	 */
>> +	if (chip->irq_need_valid_mask) {
>> +		for (i = 0; i < ngpio; i++)
>> +			if (!groups[i].npins)
>> +				clear_bit(i, pctrl->chip.irq_valid_mask);
>> +
>> +		while ((count = msm_gpio_get_next_range(pctrl, &start))) {
>> +			ret = gpiochip_add_pin_range(&pctrl->chip,
>> +						     dev_name(pctrl->dev),
>> +						     start, start, count);
>> +			if (ret)
>> +				break;
>> +			start += count;
> I do not fancy the idea of specifying a bitmap of valid irq pins and
> then having the driver register the pin-ranges in-between. 

But that's exactly what abx500_gpio_probe() in pinctrl-abx500.c does. 
Here's even a reference to holes in the GPIO space:

/*
  * Compute number of GPIOs from the last SoC gpio range descriptors
  * These ranges may include "holes" but the GPIO number space shall
  * still be homogeneous, so we need to detect and account for any
  * such holes so that these are included in the number of GPIO pins.
  */

 > If we provide
> a bitmap of validity to the core it should support using this for the
> pins as well. (Which I believe is what Linus answered in the discussion
> following patch 0/2)

So you want to change "gpio_chip" to add an "available" callback?  And 
every time gpiolib wants to call a gpio_chip callback, it should call 
->available first?  Like this:

if (chip->available && chip->available())
	status = chip->direction_input(chip, gpio_chip_hwgpio(desc));

I can do that, but it just seems very redundant.  The core already knows 
not to touch GPIOs that are not in a pin range.  The only exception is 
gpiochip_add_data(), as I've stated before.

It just seems wrong to call an API every time to ask permission before 
we can call any other API.  But since the API may not be defined, we 
have to first check if the API exists before we can ask permission.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
