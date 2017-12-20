From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 19 Dec 2017 22:05:14 -0600
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new ACPI
 HID QCOM8002
In-Reply-To: <20171220022626.GH7997@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <735d4316-9b18-2903-aabd-46ead1db5233@codeaurora.org>
 <20171220022626.GH7997@codeaurora.org>
Message-ID: <d511f096-bad4-c7b3-d7d4-11b1fa3b1cce@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/17 8:26 PM, Stephen Boyd wrote:
> The thing that I don't like about this patch is that we're
> modifying npins to indicate what gpios are available or not and
> then having a huge diff in this patch to do the 's/i/gpio/'.

Considering how small the driver is, I'm not sure if I'd say it's a 
"huge" diff.

Frankly, I think this is a very elegant re-purposing of 'npins'.

> Ideally, everything would flow directly from the request callback
> and the SoC specific pinctrl driver would just tell the core code
> what all pins exist in hardware even if they're locked away and
> in use by something non-linux. 

So you want the request callback to propagated to the SOC driver?  I 
guess that could work.

> That way, we don't have to rejig
> things in the SoC specific driver when the system configuration
> changes. I'm hoping we can do the valid mask part generically in
> the core pinctrl-msm.c file once so that things aren't spread
> around the SoC specific drivers and we solve ACPI and DT at the
> same time.

Well, now I'm confused.  First I thought you wanted to move the valid 
check into pinctrl-qdf2xxx, but now you say you want it done in 
pinctrl-msm, but isn't that what my patches are doing now?

> We will want irq lines to be unallocated for things that aren't
> GPIOs, I'm not sure about ACPI and if it cares here, and we have
> a one to one mapping between irqs, GPIOs, and pinctrl pins with
> this hardware. 

If the pin can't be requested, doesn't that take care of IRQ lines 
automatically?  I don't touch the irq_valid_mask code.

> Furthermore, we have the irq_valid_mask support in
> place already, so it seems that we can at least use the mask to
> be the one place where we indicate which pins are allowed to be
> used. 

Well, I really didn't want to do that.  Keep in mind that the root 
problem is getting pinctrl-qdf2xxx to be able to tell pinctrl-msm what 
pins are valid.  That is the bulk of my code.

I'm understanding you less and less the more I read.

 >And it seems like the simplest solution is to set the irq
> valid mask to be the GPIOs from the device property and then test
> that bitmask in the pinmux_ops structure's request callback so we
> cover both gpio (via the gpiochip_generic_request() ->
> pinmux_request_gpio() -> pin_request() path) and pinctrl (via the
> pin_request() path). 

I do not understand that.  To be honest, I think I already have the 
simplest solution, at least for ACPI.  I don't really want to complicate 
my patches to support DT, since I don't really know what the DT-specific 
problems are.

> Debugfs will need to test the mask too, but
> that should be simple. I believe you don't care about pin muxing,
> but it would make things work in both cases and will help if we
> want to limit access on platforms that use pin muxing.

I don't care about pin muxing, but my patches already take care of debugfs.

> Let's resolve this by the end of this week. If this plan works we
> can have the revert patch for get_direction() and the
> pinctrl-msm.c patch to update the valid mask on gpiochip
> registration.

Frankly, I thought I had everything resolved already, and it sounds like 
you want me to start over from scratch anyway.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
