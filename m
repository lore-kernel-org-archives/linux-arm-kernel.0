From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 8 Sep 2014 13:14:15 +0200
Subject: [PATCH 2/8 v2] leds: add device tree bindings for register bit
 LEDs
In-Reply-To: <CAMuHMdXB_6vJpTeDgr4iiA=T_3bK7nQ3anF-HSdnEz=2QqYzaw@mail.gmail.com>
References: <1409659354-23553-1-git-send-email-linus.walleij@linaro.org>
 <1409659354-23553-3-git-send-email-linus.walleij@linaro.org>
 <CAMuHMdXB_6vJpTeDgr4iiA=T_3bK7nQ3anF-HSdnEz=2QqYzaw@mail.gmail.com>
Message-ID: <CACRpkdbk=QL_N-sTADBi09jZmGs_0A9EMctNmxVOxOFr61_=LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 4:22 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Sep 2, 2014 at 2:02 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> +LED sub-node properties:
>> +
>> +Required properties:
>> +- compatible : must be "register-bit-led"
>> +- offset : register offset to the register controlling this LED
>> +- mask : bit mask for the bit controlling this LED in the register
>
> Why don't you use a "reg" property with "#address-cells = <2>" and
> "#size-cells = <1>", so you can store offset and mask there?

Because "reg" means a register range not based off another range,
i.e. not relative, and the OF cores does not allow overlapping
reg ranges as would be the case here IIRC.

>> +syscon: syscon at 10000000 {
>> +       compatible = "arm,realview-pb1176-syscon", "syscon";
>> +       reg = <0x10000000 0x1000>;
>> +
>> +       led at 08.0 {
>> +               compatible = "register-bit-led";
>> +               offset = <0x08>;
>> +               mask = <0x01>;
>> +               label = "versatile:0";
>> +               linux,default-trigger = "heartbeat";
>> +               default-state = "on";
>> +       };
>
> ePAPR v1.1 says:
>
> "The unit-address must match the first address specified in the reg property
>  of the node. If the node has no reg property, the @ and unit-address must
>  be omitted ..."
>
> So you cannot have the "@8.0" without a "reg" property.

This terminology was suggested by Rob Herring due to the fact that
there were no previous examples.

Rob: care to comment?

Right now I have that distinct feeling of despair as the v8 patch set
is still stuck in DT syntax discussions...

Yours,
Linus Walleij
