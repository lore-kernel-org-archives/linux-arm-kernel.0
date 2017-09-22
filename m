From: timur@codeaurora.org (Timur Tabi)
Date: Fri, 22 Sep 2017 08:37:07 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
Message-ID: <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/22/2017 08:29 AM, Linus Walleij wrote:
> 
> What is your response to Stephen's comment:
> 
>> [Stephen Boyd]
>> Perhaps we can add another hook for our purposes here that
>> tells gpiolib that the gpio is not usable and to skip it. The
>> semantics would be clear, it's just about probing availability of
>> this pin as a gpio and doesn't mux any pins.

> I think this kind of related to my response (after I realized it
> was not just about IRQs):

We already have 95% of this.  We can already specify individual pin 
ranges, and the vast majority of the code recognizes the ranges.  There 
is only one small loophole, and that's in gpiochip_add_data().  The 
for-loop iterates over all GPIOs:

	for (i = 0; i < chip->ngpio; i++) {
		struct gpio_desc *desc = &gdev->descs[i];

		desc->gdev = gdev;
		/*
		 * REVISIT: most hardware initializes GPIOs as inputs
		 * (often with pullups enabled) so power usage is
		 * minimized. Linux code should set the gpio direction
		 * first thing; but until it does, and in case
		 * chip->get_direction is not set, we may expose the
		 * wrong direction in sysfs.
		 */

I believe the real problem is that this for-loop should be moved from 
gpiochip_add_data() into some other function that is called *after* the 
pin ranges are defined.  We can put it in gpiochip_add_pin_range(), maybe.

My patch covers the loophole by adding a check inside get_direction(). 
If we fix gpiochip_add_data(), I can remove that patch.

However, I think that change is risky and will require a lot of testing 
and review.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
