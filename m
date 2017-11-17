From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Nov 2017 18:43:32 -0800
Subject: [PATCH 3/4] [v6] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <1510096056-13765-4-git-send-email-timur@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <1510096056-13765-4-git-send-email-timur@codeaurora.org>
Message-ID: <20171117024332.GU11955@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07, Timur Tabi wrote:
> pinctrl-msm only accepts an array of GPIOs from 0 to n-1, and it expects
> each group to support have only one pin (npins == 1).
> 
> We can support "sparse" GPIO maps if we allow for some groups to have zero
> pins (npins == 0).  These pins are "hidden" from the rest of the driver
> and gpiolib.
> 
> A new boolean 'sparse' indicates whether the GPIO map is sparse.  If any
> GPIO has an 'npins' value of 0, then 'sparse' must be set to True.
> 
> Most access to unavailable GPIOs can be blocked via the gpio_chip.request
> function.  The one exception is when gpiochip_add_data() scans all of

If patch 1 is applied is this statement still true?

> the GPIOs without "requesting" them.  To cover this case,

s/GPIOs/GPIOs for their direction/ perhaps?

> msm_gpio_get_direction() separately checks if the GPIO is available.
> 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
