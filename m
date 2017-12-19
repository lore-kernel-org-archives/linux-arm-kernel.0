From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Dec 2017 11:10:38 -0800
Subject: [PATCH 3/3] [v6] pinctrl: qcom: qdf2xxx: add support for new
 ACPI HID QCOM8002
In-Reply-To: <13bbaec1-31d9-f9fe-71b1-5b991f123108@codeaurora.org>
References: <1513189818-7384-1-git-send-email-timur@codeaurora.org>
 <1513189818-7384-4-git-send-email-timur@codeaurora.org>
 <20171213230155.GS7997@codeaurora.org>
 <6ca3b4a6-90b9-0481-beb8-29a95c86f07c@codeaurora.org>
 <615426d4-7c46-9671-87ef-790fb5733385@codeaurora.org>
 <20171219023935.GA17456@codeaurora.org>
 <13bbaec1-31d9-f9fe-71b1-5b991f123108@codeaurora.org>
Message-ID: <20171219191038.GB7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18, Timur Tabi wrote:
> On 12/18/17 8:39 PM, Stephen Boyd wrote:
> >Ah I missed that the u16 array can't be iterated through. Any
> >chance the ACPI tables can be changed to list pin ranges, like
> ><33 3>, <90 2>, to indicate that pins 33, 34, 35 and pins 90, 91
> >are available?
> 
> It's too late.  Firmware is already shipping with the current
> layout. Unfortunately, there's no good peer review process for DSDs
> that don't have a DT equivalent.

Alright!

> 
> >That would allow us to put that into the core
> >pinctrl-msm.c file a little better and then only expose pins on
> >the gpiochip when call gpiochip_add_pin_range(). If we want to
> >support this in DT, I think we would have a DT property like
> >available-gpios = <33 3>, <90 2>, <100 34> that we can then
> >iterate through and add only these pins to the gpiochip. That's
> >better than a bitmap in DT and is still compressed somewhat.
> 
> Keep in mind that all this ACPI junk is localized to
> pinctrl-qdf2xxx. pinctrl-msm does not define any new data
> structures, it just reuses the existing one.  You can still define
> your DT properties any way you want in your client drivers.
> pinctrl-qdf2xxx is specific to the Centriq chips.

Of course.

> 
> >Without going all the way down into that path, here's my patch to
> >make your patch smaller, but perhaps we can just look for the
> >ACPI property or the DT property in the pinctrl-msm.c core and
> >then add pin ranges directly. Then this ACPI driver doesn't
> >really need to change besides for the ID update. We can expose
> >all the pins and offsets, etc. from the hardware driver but cut
> >out gpios in the core layer in a generic way.
> 
> Ok, let me review this.  I don't think there's any gain in moving
> the ACPI processing to pinctrl-msm, however.
> 

I will attempt to implement the DT part today. It may make the
get_direction() revert irrelevant if the gpios aren't even
exposed to gpiolib in the first place.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
