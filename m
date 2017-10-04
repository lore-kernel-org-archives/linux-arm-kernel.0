From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 4 Oct 2017 17:41:27 -0500
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20171004215023.GA457@codeaurora.org>
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
 <20171004215023.GA457@codeaurora.org>
Message-ID: <f8c20994-230e-0028-c46a-d001e59223ce@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2017 04:50 PM, Stephen Boyd wrote:

>> At the time I wrote that patch, the ACPI tables exposed all of the
>> GPIOs, even the ones it didn't care about.  The new ACPI tables list
>> only specific GPIOs, and so we no longer need to blindly read the
>> direction of all GPIOs.
>>
> 
> Do you avoid this problem on new ACPI tables because only pins
> that are able to be read are exposed?

Yes.  A recent firmware update enabled the "XPU" block which is being 
programmed with a select subset of individual GPIOs.  On our silicon, 
each TLMM GPIO is in a separate 64k page, and so the XPU can block any 
individual GPIO.  Any attempt to touch those registers causes an XPU 
violation which takes the whole system down.

>>> This is basically a revert of commit 72d320006177 ("gpio: set up
>>> initial state from .get_direction()").
>>
>> I would be in favor of either reverting that patch, or moving the
>> code into gpiochip_add_pin_range().
> 
> If it's in gpiochip_add_pin_range() would we still read the
> hardware when creating the pin ranges?

I presume so.  The idea is that pinctrl-qdf2xxx/pinctrl-msm only submit 
pin ranges that are present in the ACPI tables.

 > I don't want to have to> describe pin ranges of "valid" pins that 
won't cause the system
> to blow up if we touch them, because those pins are never used by
> Linux so reading them is not useful.

Well, that's exactly what I'm trying to do with current patch set :-) 
It seems the most logical approach to me.  I don't understand the 
dislike for it.  What else are pin ranges for, other than to specify 
ranges of pins that can be accessed?

Another alternative was to enumerate all of the GPIOs starting from 0. 
So the first GPIO in ACPI would be gpio0, regardless of what gpio number 
it actually was.  E.g. GPIO 37 would appear as gpio0, GPIO 38 would 
appear as gpio1, and so on.  That also worked, but it meant that 
customers would need to figure out which GPIO that "gpio0" actually 
pointed to.  That was not acceptable, so I dropped it.

I'm at a loss on how else to do it.  I think a gpio_chip.available 
callback is far less elegant than define pin ranges.  There is no chance 
that unavailable GPIOs can be accessed because the physical addresses 
are not in the msm_pingroup array.  That is, groups[0].ctrl_reg == 0, 
not 0xFF02010000.


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
