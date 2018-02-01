From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Feb 2018 13:49:16 +0100
Subject: [PATCH 4/4] drm/pl111: Support multiple endpoints on the CLCD
In-Reply-To: <87wp00w77m.fsf@anholt.net>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
 <20180126132033.19744-4-linus.walleij@linaro.org> <87wp00w77m.fsf@anholt.net>
Message-ID: <CACRpkdY9d+J=eQw=dEJ=GyoOW9RxdofS0oa_TJHA5hA96bieTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:55 AM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> The Versatile PL110 implementations use multiple endpoints:
>> from the PL111 port, the lines are routed through a PLD,
>> and from there forked so the same lines go to a VGA DAC and
>> an external TFT panel connector. This is discrete wireing
>> so there is no way to turn of one output, i.e. this is
>> really two endpoints, not two ports.
>>
>> We model this with multiple endpoints, so we need to loop
>> over the available endpoints, check for panel or bridge on
>> each and accumulate the result before continuing.
>>
>> The code already will give the panel preference over the
>> bridge, if present, so the output will be sent to the panel
>> if both a panel and a bridge is present on two endpoints
>> of the same port.
>>
>> If they all return -EPROBE_DEFER we return -EPROBE_DEFER
>> as well.
>>
>> If just one endpoint is present on the port, the behaviour
>> is the same as before.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Huh, from the binding I would have thought that we were describing
> things to the point of the pins coming out of the PLD, not past whatever
> splitting comes after that.
>
> I'm also confused how this would work.  You're talking about the DT
> looking like:
>
>         clcd at 10020000 {
>                 compatible = "arm,pl111", "arm,primecell";
>                 reg = <0x10020000 0x1000>;
>                 interrupt-names = "combined";
>                 interrupts = <0 44 4>;
>                 clocks = <&oscclk1>, <&oscclk2>;
>                 clock-names = "clcdclk", "apb_pclk";
>                 max-memory-bandwidth = <94371840>; /* Bps, 1024x768 at 60 16bpp */
>
>                 port {
>                         dac_pads: endpoint1 {
>                                 remote-endpoint = <&vgadac>;
>                                 arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
>                         };
>                         tft_pads: endpoint2 {
>                                 remote-endpoint = <&tftpanel>;
>                                 arm,pl11x,tft-r0g0b0-pads = <0 8 16>;
>                         };
>                 };
>
>         };
>
>
> Are you anticipating that a DT would actually connect up to two
> endpoints on the CLCD?

Yes and I have a patch doing exactly that as well.

The thing is that the ARM Versatile reference design
actually does this. It has no electronic protection for the
VGA DAC hanging off the same lines as the panel, and there
is no way of determining if there is a monitor connected to
the dumb VGA DAC or not.

When the system boots up and the panel comes up (I am just
doing the same as the code in fbdev and let the TFT panel
take precedence) there is some shouting about unsupported
resolution on the connected VGA monitor, of course.

Whether this is good taste in design is another question.

But describing it like this in the device tree is indeed (AFAICT)
describing the hardware as it is soldered up, and
documented in official ARM reference design documentation...

This arrangement can be clearly seen in
ARM DUI 0225D, page 3-41, figure 3-19.
http://infocenter.arm.com/help/topic/com.arm.doc.dui0225d/DUI0225D_versatile_application_baseboard_arm926ej_s_ug.pdf

>  How should we resolve the pads property, in that
> case?  Is there much point in supporting this, if we don't actually
> support panels or bridges on both of the endpoints at once (since we
> pick only one to do panel/bridge setup/teardown on)?

There is no way for software to drive both connected displays
at the same time, like trying to find a least common denominator
or something, it simply has to choose one. It is somewhat natural
to select a connected TFT panel (these need to be consciously
pressed in on top of the board) over the VGA DAC. If I just set
the panel node to "disabled" in the device tree, the VGA comes
up instead. The old fbdev driver also let the panel take
precedence.

So the patch checks if there is both a panel and a DAC
connected and selects the panel over the VGA if and only
if a panel is connected.

I guess we need to pick up the pads of the endpoint that
we end up connecting to a bridge and handle that from there.

The pads are only used in Versatile Express and Nomadik,
I haven't gotten to those yet, but the Versatile Express has
only DVI VGA out, and the Nomadik has only a TFT panel,
not this duality, so those designs will not be ambigous about
what pads to use.

Yours,
Linus Walleij
