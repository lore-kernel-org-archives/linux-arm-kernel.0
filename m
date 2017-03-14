From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 14 Mar 2017 16:41:40 -0700
Subject: [PATCH] pinctrl: qcom: add get_direction function
In-Reply-To: <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
References: <1486768860-18237-1-git-send-email-timur@codeaurora.org>
 <8652c018-4051-5c77-3126-2d41d150518a@codeaurora.org>
 <CACRpkdaoHTZa+XjEBAMtO2dS1jevi5h-QYe90SrZDuJghQSyYw@mail.gmail.com>
 <13b19c7f-9440-ab8e-8a2f-d1796a9b3dde@codeaurora.org>
 <CACRpkdZFzYStyPfK1DwkZfvtd7wX9HtD1bnCy+i9h-7xowOz4g@mail.gmail.com>
 <e209d18d-dc53-c0e9-448c-8a88264cac74@codeaurora.org>
 <20170314233040.GH10239@codeaurora.org>
 <c40b0ee7-6d8c-8c5d-d4c5-9ecf8076e44f@codeaurora.org>
Message-ID: <20170314234140.GI10239@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14, Timur Tabi wrote:
> Stephen Boyd wrote:
> >I don't see any problem with failing msm_gpio_set() when the
> >function is "not gpio", but I also wonder why it matters. Drivers
> >shouldn't be doing that, because if the gpio is muxed to some
> >other functionality they shouldn't be treating it as a gpio in
> >the first place.
> 
> The idea is to notify drivers with an error code when they make a
> mistake. Perhaps the device tree or the ACPI table has an error?

In general the kernel isn't a firmware validator. At least that's
the way I view it. Others may have different opinions here.

> 
> >Perhaps we can have some sort of gpio validation debug option
> >that the check goes under. Then we could fail and print a big
> >warning if this happens, but if we aren't debugging then we don't
> >do any checking and rely on drivers to do the right thing.
> 
> I could add that, but I still think returning an error code is
> appropriate.  On the TLMM, we know for sure that the pin must be set
> to function 0 in order for the read/write routines to operate
> correctly.

On ACPI we could make the gpio_get() path fail if the pin isn't
in GPIO mode? That would work assuming ACPI can't change the pin
muxing at runtime. On DT we might have runtime muxing though so I
don't see how it would work there.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
