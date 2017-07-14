From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 14 Jul 2017 15:04:22 -0700
Subject: [PATCH 1/2] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <e8720afb-fbf9-2330-d4f6-89acb6e839cc@codeaurora.org>
References: <1499982763-29619-1-git-send-email-timur@codeaurora.org>
 <1499982763-29619-2-git-send-email-timur@codeaurora.org>
 <20170714171148.GH22780@codeaurora.org>
 <8eaeefc0-2f2c-a488-283f-80e26f4d13f5@codeaurora.org>
 <20170714214648.GL22780@codeaurora.org>
 <e8720afb-fbf9-2330-d4f6-89acb6e839cc@codeaurora.org>
Message-ID: <20170714220422.GM22780@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14, Timur Tabi wrote:
> On 07/14/2017 04:46 PM, Stephen Boyd wrote:
> >Right, the gpiolib core would need to be updated to request the
> >gpio in gpiochip_add_data() around the loop where it goes and
> >configures things. And it could ignore ones that it can't request
> >there.
> 
> __gpiod_request already calls chip->request(), so this would need to
> be a temporary request.  It seems a bit hackish, but I'll try it.

Yeah, request, configure, free, in a loop. Unless someone is
aware why we don't do that here.

> 
> BTW, I noticed that __gpiod_free() does this:
> 
> 	if (chip->free) {
> 		spin_unlock_irqrestore(&gpio_lock, flags);
> --->		might_sleep_if(chip->can_sleep);
> 		chip->free(chip, gpio_chip_hwgpio(desc));
> 		spin_lock_irqsave(&gpio_lock, flags);
> 
> 
> Should __gpiod_request() also call might_sleep_if()?
> 
> 	if (chip->request) {
> 		/* chip->request may sleep */
> 		spin_unlock_irqrestore(&gpio_lock, flags);
> ---> missing call to might_sleep_if() here?
> 		status = chip->request(chip, gpio_chip_hwgpio(desc));
> 		spin_lock_irqsave(&gpio_lock, flags);
> 

Probably. Except we would have caught it earlier when it was
requested?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
