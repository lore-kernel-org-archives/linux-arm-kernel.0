From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 16 Oct 2017 08:52:09 -0500
Subject: [PATCH 1/2] [v5] pinctrl: qcom: disable GPIO groups with no pins
In-Reply-To: <20171016080117.GA17369@ulmo>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <1504798409-32041-2-git-send-email-timur@codeaurora.org>
 <20171016080117.GA17369@ulmo>
Message-ID: <9c142b32-5f14-38c5-3611-884f2589d682@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2017 03:01 AM, Thierry Reding wrote:
> This is the bit that I don't understand. If you only tell gpiolib about
> the GPIOs that exist, then it won't be initializing the .irq_valid_mask
> in a wrong way.

I know, and that's what my patches do.  I tell gpiolib that I need a 
valid mask:

/* If the GPIO map is sparse, then we need to disable specific IRQs */
chip->irq_need_valid_mask = pctrl->soc->sparse;

Then I proceed to provide the specific GPIOs that exist, one block at a 
time:

	ret = gpiochip_add_pin_range(&pctrl->chip,
				     dev_name(pctrl->dev),
				     start, start, count);

> In other words, what I'm trying to say is that in your case, ngpio isn't
> equal to the sum of .npins over all groups.

That's true.  I set it to the maximum number of GPIOs that exist on the 
chip.  I could set it to the highest number of GPIOs that I register 
(e.g. the highest value of "start + count"), but that's not necessary 
for my patches to work.

> If instead you make the chip
> register only the lines that actually exist, .irq_valid_mask will only
> contain bits that do exist.

That's what I'm doing.

> The reason I'm bringing this up is because we had the same discussion
> back in November last year (yes, that driver still isn't upstream...):
> 
> 	https://lkml.org/lkml/2016/11/22/543
> 
> In a nutshell: the Tegra driver was assuming that each port had a fixed
> number (8) of lines, but when gpiolib changed to query the direction of
> GPIOs at driver probe time this broke badly because on of the instances
> of the GPIO controller is very strict about what it allows access to.

It appear we're re-hashing that same exact argument.

> This seems to be similar to what you're experiencing. In our case we'd
> run into a hard hang trying to access a register for a non-existing
> GPIO. One of the possibilities discussed in the thread was to introduce
> something akin to what's being proposed here.

I guess great minds do think alike!

> In the end it turned out to be easiest to just don't tell gpiolib about
> any non-existing GPIOs, because then you don't get to deal with any of
> these workarounds.

I agree.

> The downside is that you need a little more code to
> find out exactly what GPIO you're talking about, or to determine how
> many you have.

In my case, the ACPI table provides an exact list that I use at probe() 
time.

> In the end I think it's all worth it by making it a lot
> easier in general to deal with. I think it's really confusing if you
> expose, say, 200 pins, and for 50 of them users will get -EACCES, or
> -ENOENT or whatever if they try to use them.

True, but /sys/kernel/debug/gpio is the only mechanism I found where the 
user can get a list of valid GPIOs.  Maybe we need something similar in 
/sys/class/gpio/.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
