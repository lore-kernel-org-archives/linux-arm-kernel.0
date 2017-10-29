From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 29 Oct 2017 16:02:41 +0100
Subject: [PATCH v4] drm: bridge: Add THS8134A/B support to dumb VGA DAC
In-Reply-To: <13720071.DIiUQShqpX@avalon>
References: <20171020125412.25988-1-linus.walleij@linaro.org>
 <13720071.DIiUQShqpX@avalon>
Message-ID: <CACRpkdZgWRGWUURoBygXY5a=rbAxyhRKz9j0w5o_hGv5woKS7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 10:45 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>> +static const struct vga_dac_info default_dac_variant = {
>> +     /*
>> +      * These DACs read data on the negative edge. For example in the
>> +      * ADV7123 datasheet (revision D, page 8) there is a timing diagram
>> +      * making this clear. So consequently we need to latch the data
>> +      * on the positive edge.
>> +      */
>> +     .clk_edge_latch = DRM_BUS_FLAG_PIXDATA_POSEDGE,
>
> I've checked the datasheet (sorry for not having done so before), and the
> timing diagram on page 8 of revision D shows to me that data is sampled on the
> rising edge of the clock, not the falling edge.
>
> I've checked the schematics of the Renesas boards that use the ADV7123 and
> they route the clock directly from the SoC to the DAC without any inverter or
> other logic on the signal. The R-Car DU driver currently outputs data on the
> rising edge of the clock. However, the DU has an internal delay of 8.5ns
> between the rising clock edge and the data output, which is smaller than the
> 0.2ns setup time of the ADV7123. That's why the current code works on Renesas
> boards, and likely why it also works with the existing users of the THS8135.

Aha! Clever. So apparently the ARM PL111 is not delaying the signals
and that is why I see the annoying flicker on these designs so they need to
be set up differently.

> DRM_BUS_FLAG_PIXDATA_POSEDGE is the right value for my use cases, but it
> doesn't match how the ADV7123 operates.

So if we apply the current patch, I just add some FIXME comments about the
situation above, then things work for everyone, is that reasonable?

> The more I think about it the more I believe that the
> DRM_BUS_FLAG_PIXDATA_POSEDGE and DRM_BUS_FLAG_PIXDATA_NEGEDGE flags are not
> the right way to pass information between bridges and display controllers.
> Reporting the sampling edge and the setup + hold window would allow the
> display engine driver to compute its output parameters, instead of trying to
> infer in the bridge driver how the display engine operates.

This sounds true. And relates to the other problem I have with
making the display driver pick up information from the bridge.

We simply need a good information container to pass information
from the bridge to the display driver, I guess?

I'm a bit insecure on how to deal with this though. I'm happy to hack
something up if I can just get a grip on where to put it and how
the DRI people want their things.

Yours,
Linus Walleij
