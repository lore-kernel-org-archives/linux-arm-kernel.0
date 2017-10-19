From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 19 Oct 2017 17:44:59 -0500
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <CACRpkdYYp5TSM1QV-f+FmbwzY_ittgW-4MuXiZ9NW694GoMwKQ@mail.gmail.com>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
 <20171002174414.GL1165@minitux>
 <9f28c9dd-6277-6c75-1186-a834e15c5346@codeaurora.org>
 <CACRpkdYYp5TSM1QV-f+FmbwzY_ittgW-4MuXiZ9NW694GoMwKQ@mail.gmail.com>
Message-ID: <819a0c67-3494-030d-3166-748081509c83@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2017 06:07 AM, Linus Walleij wrote:
> I mean that you add
> unsigned long *line_valid_mask;
> to struct gpio_chip using the same type of logic
> as .irq_valid_mask. The mask should be optional.
> 
> Then the operation gpiod_get[_index]() will FAIL if the
> line is not valid.
> 
> There is no need to check on every operation, there should
> be no way to get a handle on the pin any other way.
> 
> All new code should be using descriptors at this point so we
> only need to design for that case.

I think I'm missing something, because I implemented what you're asking 
for, but whenever I try to expose a GPIO from sysfs (e.g. echo 37 > 
/sys/class/gpio/export), gpiod_get_index() is not called.  The only 
thing preventing the GPIO from being exported is the ->request callback:

static int msm_gpio_request(struct gpio_chip *chip, unsigned int offset)
{
	struct msm_pinctrl *pctrl = gpiochip_get_data(chip);
	const struct msm_pingroup *g = &pctrl->soc->groups[offset];

	if (!g->npins)
		return -ENODEV;

What operation is supposed to trigger a call to gpiod_get_index?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
