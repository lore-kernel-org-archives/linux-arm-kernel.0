From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 4 Oct 2017 14:50:23 -0700
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <40a0ab68-dc3a-10e2-f78e-9a386b4a72bd@codeaurora.org>
References: <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
 <20171003220311.GU457@codeaurora.org>
 <40a0ab68-dc3a-10e2-f78e-9a386b4a72bd@codeaurora.org>
Message-ID: <20171004215023.GA457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03, Timur Tabi wrote:
> On 10/03/2017 05:03 PM, Stephen Boyd wrote:
> >I've run into this now on our mobile SoCs after I pull in commit
> >8e51533780ba ("pinctrl: qcom: add get_direction function").
> >Before that commit we never read each pin of the device. On our
> >mobile SoCs we have devicetree and it feels like having that
> >describe which pins are available and not available is
> >half-duplicating information we would already have via consumers
> >indicating which pins they care about. I don't see any value
> >beyond system wide debug in figuring out the default pin
> >configuration of a pin that doesn't have a consumer in Linux.
> 
> At the time I wrote that patch, the ACPI tables exposed all of the
> GPIOs, even the ones it didn't care about.  The new ACPI tables list
> only specific GPIOs, and so we no longer need to blindly read the
> direction of all GPIOs.
> 

Do you avoid this problem on new ACPI tables because only pins
that are able to be read are exposed?

> 
> >This is basically a revert of commit 72d320006177 ("gpio: set up
> >initial state from .get_direction()").
> 
> I would be in favor of either reverting that patch, or moving the
> code into gpiochip_add_pin_range().

If it's in gpiochip_add_pin_range() would we still read the
hardware when creating the pin ranges? I don't want to have to
describe pin ranges of "valid" pins that won't cause the system
to blow up if we touch them, because those pins are never used by
Linux so reading them is not useful.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
