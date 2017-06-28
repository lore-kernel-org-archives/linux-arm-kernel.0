From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 28 Jun 2017 14:23:15 -0500
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <20170628191204.GP18666@tuxbook>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
 <20170628191204.GP18666@tuxbook>
Message-ID: <9338abeb-2685-510a-1eb6-ebe86c306cea@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 02:12 PM, Bjorn Andersson wrote:
> On Fri 23 Jun 05:33 PDT 2017, Linus Walleij wrote:
> 
>> On Thu, Jun 22, 2017 at 10:54 PM, Timur Tabi <timur@codeaurora.org> wrote:
>>
>>> On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
>>> are actually available to the HLOS.  The others are blocked by the XPU,
>>> and any attempt to access them will cause an XPU violation that halts
>>> the system.
>>
>> That's a bummer. Looking for Bj?rn's review on this patch.
>>
> 
> The TLMM block on this platform has N gpios, regardless of the XPU
> configuration. The ACPI table provides the kernel with a list of
> available "logical" GPIOs based on some system specification (or
> reference design perhaps?).

It's the list of available physical GPIOs.  Here's the table:

Name (_DSD, Package ()
{
	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
	Package ()
	{
		// Expose only the qdss_tracedata pins as GPIOs,
		// numbered sequentially, so that "gpio X" maps
		// to qdss_tracedata[X].  These pins are configured
		// as GPIOs (function 0) and wired externally
		// to a header on the board, so it's safe to
		// expose them to the HLOS driver.
		Package (2) {"gpios", Package ()
			{116, 117, 118, 119, 120, 121, 122, 123,
			 124, 125, 126, 127, 128, 129, 130, 131,
			 80, 81, 82, 83, 84, 85, 86, 87, 88, 89,
			 90, 50, 36, 37, 38, 39}}
	}
})

> I have not seen the Qualcomm server platforms, but I imagine that
> customers can alter this list.

Not easily, as it requires recompiling the ACPI tables.  I also don't 
know how much control customers have over the XPU settings.  The XPU is 
supposed to block access to any GPIOs that have been muxed to other 
purposes, but it's a hand-crafted list that could be anything.

> I think the numbering of the GPIOs should be that of the TLMM and the
> "logical" names should be populated from ACPI by using gpio_chip->names.

Is that not what my driver is doing?  Or do I misunderstand you?

> The question left is how to represent the XPU locked gpios - a problem
> we do share with in the mobile TLMM drivers.
> 
> 
> It seems that if we extend the msm_pingroup with a flag to carry the XPU
> lock information and then implement pinmux_ops->request() and deny any
> requests on the locked pins, we should cover all[*] the normal GPIO code
> paths.

Instead of a flag, I was thinking if npins == 0, then this GPIO should 
be disabled.

> [*] Except the reported case of gpiochip_add_data() looping over all
> pins and calling get_direction() without first requesting the pin.

This is what triggered the problem in the first place.  Every time the 
kernel boots, it's queries all of the GPIOs.  Ironically, I created that 
feature because on server platforms, that was the only way to know the 
current setting.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
