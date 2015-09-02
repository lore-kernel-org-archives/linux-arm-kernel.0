From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 16:19:07 -0700
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <20150902230408.GR21084@n2100.arm.linux.org.uk>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=WvUp7xhsmXJgVzm1Awqej12hNF_QPJhrQq7z=Fa4Nnuw@mail.gmail.com>
 <20150902225008.GQ21084@n2100.arm.linux.org.uk>
 <CAD=FV=U2BR=Qk2cVS-cq78Rx=VjriZiE6nC3cn+_SBHx2_5ihg@mail.gmail.com>
 <20150902230408.GR21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=XO0cjmmXniGnqvvoWZ=e1EL7t5XDUXVhiNMqWvmaOpMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, Sep 2, 2015 at 4:04 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> > Also, is it appropriate to hook non-DDC devices to a DDC bus?  I suspect
>> > that's asking for trouble.
>>
>> I doubt it's appropriate.  Why do you ask?
>
> To find out why you want to "specify the I2C bus".
>
> Surely if we're talking about the DDC bus, we either want to use a
> separate I2C bus (in which case the HDMI DT description needs to
> specify which I2C bus to use) or we want to use the HDMI-internal
> I2C bus, which being part of the HDMI driver, the HDMI driver will
> know how to find it itself - there should be no need to put an
> explicit ddc-i2c-bus self-reference there in that case.

Overall it comes down to bus numbering.  Possibly that's a stupid
reason, but it is my reason nevertheless.

Specifically it significantly helps my brain process kernel log
messages if the i2c bus that's referred to "bus 5" in my SoC's user
manual shows up consistently as "i2c5" in kernel log messages.  It's
helpful it it shows up as "i2c5" even if "i2c0" - "i2c4" aren't
enabled.

That's all totally possible by using this type of syntax, like in rk3288.dtsi:

aliases {
  i2c0 = &i2c0;
  i2c1 = &i2c1;
  i2c2 = &i2c2;
  i2c3 = &i2c3;
  i2c4 = &i2c4;
  i2c5 = &i2c5;

Similarly, I'd like "bus 0" to show up as i2c0, which will happen as
you can see in the above.

The problem is that if another bus registers itself before the SoC's
i2c0 registers itself and that bus doesn't give a number to itself
then the i2c subsystem will chose "I2C 0".  ...and then when the main
SoC i2c bus registers itself it will fail because i2c0 is already
taken.

By having a of_node for the hdmi i2c bus, we can assign a number to it like:
  i2c15 = &hdmi;

This is all described in the two links I referenced in my original reply.



A possible other option is to have the i2c subsystem try to start
numbering at a larger base for all automatically numbered busses
(those that didn't specify a number).  Then it's more likely (though
still not guaranteed) to conflict with another bus...

-Doug
