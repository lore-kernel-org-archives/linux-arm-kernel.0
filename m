From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 1 Dec 2017 11:16:37 -0600
Subject: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <68a11ee4-d0c6-0f4e-3631-125cc4e7a1bd@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-3-git-send-email-timur@codeaurora.org>
 <68a11ee4-d0c6-0f4e-3631-125cc4e7a1bd@codeaurora.org>
Message-ID: <d86c1bc1-1d97-339b-4585-ad796f635638@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2017 05:38 AM, Archit Taneja wrote:
> 
> We're hitting an issue here ^ when a consumer calls the devm_gpiod_get() 
> API. This API
> internally sets idx in gpiod_get_index to always 0. For example, in the 
> call sequence
> below, the idx argument to gpiochip_irqchip_line_valid is always 0:
> 
> devm_gpiod_get(dev, con_id, flags)
>  ?? devm_gpiod_get_index(dev, con_id, 0, flags)
>  ????? gpiod_get_index(dev, con_id, 0, flags)
>  ???????? if (!gpiochip_irqchip_line_valid(desc->gdev->chip, 0))
>  ???????????? return ERR_PTR(-EACCES);
> 
> Therefore, with these patches, if we create a sparse gpio map, and the
> 0th gpio is set to "not accessible", all gpio requests end up failing 
> with EACCESS
> because idx is always passed as 0.

Ok, I can see the problem, but I don't know how to fix it.

struct gpio_desc *__must_check devm_gpiod_get(struct device *dev,
					      const char *con_id,
					      enum gpiod_flags flags)
{
	return devm_gpiod_get_index(dev, con_id, 0, flags);
}

I thought that by putting the check for "availability" inside of the 
GPIO request, it would handle all situations where a client (whether 
kernel or user-space) tries to access a specific GPIO.

However, this doesn't work with [devm_]gpiod_get.  This function 
attempts to claim the entire GPIO block by claiming only the first GPIO.

This is straining my understanding of gpiolib.  Maybe we need to do 
something like this:

struct gpio_desc *__must_check gpiod_get(struct device *dev, const char 
*con_id,
					 enum gpiod_flags flags)
{
	return gpiod_get_index(dev, con_id, -1, flags);
}

Where idx == -1 is a special-case for gpiod_get_index() where it returns 
the gpio_desc without actually requesting it?

> In gpiochip_irqchip_line_valid, shouldn't we test the nth bit (that 
> corresponds to
> this gpio_desc) in chip->line_valid_mask instead of idx passed above, 
> which is always
> 0?

The code has changed upstream, so I need to refactor that function.  But 
I think it's already testing the nth bit:

static bool gpiochip_irqchip_line_valid(const struct gpio_chip gpiochip,
					unsigned int offset)
{
	/* No mask means all valid */
	if (likely(!gpiochip->line_valid_mask))
		return true;
	return test_bit(offset, gpiochip->line_valid_mask);

'offset' is the nth bit.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
