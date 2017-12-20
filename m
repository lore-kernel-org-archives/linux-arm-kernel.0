From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Dec 2017 18:26:26 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
Message-ID: <20171220022626.GH7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19, Timur Tabi wrote:
> On 12/18/2017 08:39 PM, Stephen Boyd wrote:
> >+		if (gpios && gpios[j] != i)
> >+			continue;
> ...
> > +		j++;
> 
> Doesn't this assume that the available GPIOs are listed in numerical
> order in the ACPI table?  If so, then this patch won't work because
> that order is not guaranteed.
> 

Yes, I added a comment in the patch about that assumption. It's
simple enough to sort the array in place with sort() though.

I was looking at the gpiochip_add_pin_ranges() code to try and
understand how to only expose pins that are supported as gpios
into gpiolib, and then I looked at the history of these patches
and wrote some code around pin ranges, got super confused and
started thinking about adding gpiochips for each range (ugh),
talked to Bjorn, and now I'm writing this mail. The approach of
multiple ranges or chips looks like a dead-end that you've
already gone down so let's not do that.

The thing that I don't like about this patch is that we're
modifying npins to indicate what gpios are available or not and
then having a huge diff in this patch to do the 's/i/gpio/'.
Ideally, everything would flow directly from the request callback
and the SoC specific pinctrl driver would just tell the core code
what all pins exist in hardware even if they're locked away and
in use by something non-linux. That way, we don't have to rejig
things in the SoC specific driver when the system configuration
changes. I'm hoping we can do the valid mask part generically in
the core pinctrl-msm.c file once so that things aren't spread
around the SoC specific drivers and we solve ACPI and DT at the
same time.

We will want irq lines to be unallocated for things that aren't
GPIOs, I'm not sure about ACPI and if it cares here, and we have
a one to one mapping between irqs, GPIOs, and pinctrl pins with
this hardware. Furthermore, we have the irq_valid_mask support in
place already, so it seems that we can at least use the mask to
be the one place where we indicate which pins are allowed to be
used. And it seems like the simplest solution is to set the irq
valid mask to be the GPIOs from the device property and then test
that bitmask in the pinmux_ops structure's request callback so we
cover both gpio (via the gpiochip_generic_request() ->
pinmux_request_gpio() -> pin_request() path) and pinctrl (via the
pin_request() path). Debugfs will need to test the mask too, but
that should be simple. I believe you don't care about pin muxing,
but it would make things work in both cases and will help if we
want to limit access on platforms that use pin muxing.

Let's resolve this by the end of this week. If this plan works we
can have the revert patch for get_direction() and the
pinctrl-msm.c patch to update the valid mask on gpiochip
registration.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
