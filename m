From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 14 Jul 2017 14:46:48 -0700
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <8eaeefc0-2f2c-a488-283f-80e26f4d13f5@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714171148.GH22780@codeaurora.org>
 <8eaeefc0-2f2c-a488-283f-80e26f4d13f5@codeaurora.org>
Message-ID: <20170714214648.GL22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14, Timur Tabi wrote:
> On 07/14/2017 12:11 PM, Stephen Boyd wrote:
> >gpiochips also have a request() hook. Can we use that before
> >initializing direction to make sure the GPIO is accessible?
> 
> So I tried it, and it didn't work:
> 
> static int msm_gpio_request(struct gpio_chip *chip, unsigned int offset)
> {
> 	pr_info("%s:%u offset=%u\n", __func__, __LINE__, offset);
> 
> 	return 0;
> }
> 
> static struct gpio_chip msm_gpio_template = {
> 	.request          = msm_gpio_request,
> 	...
> 
> msm_gpio_request() is never called when the driver loads.  In fact,
> I can't figure out when it would be called.
> 

Right, the gpiolib core would need to be updated to request the
gpio in gpiochip_add_data() around the loop where it goes and
configures things. And it could ignore ones that it can't request
there.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
