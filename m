From: dianders@chromium.org (Doug Anderson)
Date: Thu, 3 Sep 2015 09:04:19 -0700
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <CAL_JsqLKbW2ur1US1DCAcJeDYzq8f1L3vO9C8TitAqGt9tAusQ@mail.gmail.com>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
 <20150903082210.GU21084@n2100.arm.linux.org.uk>
 <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
 <20150903151854.GA21084@n2100.arm.linux.org.uk>
 <CAL_JsqLKbW2ur1US1DCAcJeDYzq8f1L3vO9C8TitAqGt9tAusQ@mail.gmail.com>
Message-ID: <CAD=FV=XdP9T29drocB_WkNKrDif9Qwrdjt2C4=AwQk9rey3yLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 3, 2015 at 8:46 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Sep 3, 2015 at 10:18 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Thu, Sep 03, 2015 at 09:46:38AM -0500, Rob Herring wrote:
>>> Yes, that is fairly common (ADV75xx is same), and we would not
>>> describe an I2C bus in DT in that case. Same with HPD directly handled
>>> vs. a GPIO line. That is no different than what Doug has said:
>>> ddc-i2c-bus is present if using the SOC's I2C host and absent if using
>>> the HDMI block's DDC functionality. I'm only questioning the location
>>> of the property.
>>
>> No, I don't think that's what Doug wants.  Doug wants the bridge's
>> internal I2C host to be exposed, so he can number it through a DT
>> alias.
>
> See his earlier reply and other patch[1] which states once the dw_hdmi
> built-in I2C controller support is added in mainline, then this
> property is not needed. For now, the SOC's general purpose I2C
> controller is used.
>
> Rob
>
> [1] https://lkml.org/lkml/2015/9/2/571

Hmmm, I think we're getting all mixed up here.  To summarize:

1. On rk3288 you can mux the same pins on the SoC to _either_ be
controlled by a generic rk3288 i2c controller (i2c5) or controlled by
the dw_hdmi's i2c block.

2. At the moment, there's no code in mainline to handle the dw_hdmi's i2c block.

3. Right now there _is_ code in mainline to handle specifying
"ddc-i2c-bus" and have it point to the generic rk3288 i2c controller.

4. So in mainline if you want to read an EDID, you've got to configure
the pinmux as "i2c5" and add a "ddc-i2c-bus" reference to the HDMI
section of the device tree.  That's what most rk3288 boards do and (as
far as I understand) matches existing bindings.  The only reason
veyron didn't have this reference was due to a small oversight when
sending the DTS file upstream.

5. There are apparently benefits to using the builtin i2c controller
in dw_hdmi.  There's an outstanding patch add code to support the
dw_hdmi's i2c block.

6. Once you start using the dw_hdmi's i2c block with the currently
posted patch against mainline (to do this you not only need the patch
but you need to remove the ddc-i2c-bus property, set the pinmux, and
disable i2c5) then you'll see a bonafide i2c bus exposed to Linux.  In
my case this stole i2c0 away from the builtin SoC I2C bus and caused
the SoC I2C bus to fail to probe.  Doh.

7. I was trying to solve #6 by adding an "of_node" to the i2c bus
which allowed me to give it a (non-conflicting) bus ID.


-Doug
