From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Sep 2015 08:55:24 -0700
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <20150903151854.GA21084@n2100.arm.linux.org.uk>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
 <20150903082210.GU21084@n2100.arm.linux.org.uk>
 <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
 <20150903151854.GA21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=WsLTQEpoUXyQ4D_F5Uhwg1j0+4=M-VO1niqEipZKAu1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 3, 2015 at 8:18 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Sep 03, 2015 at 09:46:38AM -0500, Rob Herring wrote:
>> Yes, that is fairly common (ADV75xx is same), and we would not
>> describe an I2C bus in DT in that case. Same with HPD directly handled
>> vs. a GPIO line. That is no different than what Doug has said:
>> ddc-i2c-bus is present if using the SOC's I2C host and absent if using
>> the HDMI block's DDC functionality. I'm only questioning the location
>> of the property.
>
> No, I don't think that's what Doug wants.  Doug wants the bridge's
> internal I2C host to be exposed, so he can number it through a DT
> alias.

Actually, my primary concern is that it _doesn't_ conflict with the DT
aliases for busses I care about.  If I didn't provide it with a number
the i2c subsystem was assigning 0 which was conflicting with the real
i2c bus 0.  If the bus was simply not exposed that would have solved
my problem just fine.  ...but if it is being exposed, we need a way to
give it a number.

That being said, my (uninformed) opinion is that if the hardware does
provide enough functionality to expose an i2c bus it's convenient to
expose it, even if it's under a DEBUG config option.  That allows you
to use standard i2c tools during bringup or to debug strange problems.

Obviously since there is hardware that doesn't expose a full i2c bus
then the abstraction should handle that and let a driver just provide
the data directly.

-Doug
