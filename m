From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Sep 2017 14:59:08 +0200
Subject: [PATCH 2/2] RFC: drm/pl111: Support using the VGA bridge as
 fallback
In-Reply-To: <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
References: <20170901094629.6566-1-linus.walleij@linaro.org>
 <20170904074355.gjbf7he2dt5kszfg@phenom.ffwll.local>
Message-ID: <CACRpkdZrwZ980YhKGQSpLxoYaFtHvQBUPTXzXqLCbn+4+zvs9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 4, 2017 at 9:43 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Fri, Sep 01, 2017 at 11:46:29AM +0200, Linus Walleij wrote:
>> If we cannot find a panel, assume that the output from the
>> PL111 is connected directly to a "dumb" VGA connector,
>> so look up the connector from that bridge.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

>>       if (panel) {
>>               priv->panel = panel;
>>               priv->connector = panel->connector;
>> +     } else {
>> +             priv->connector = drm_dumb_vga_get_connector(bridge);
>
> Why do you need to set this?

Essentially because drm_simple_display_pipe_init() require that you
specify a connector in the last argument, so I have to get it from
somewhere.

> The only code I could find tries to set
> polarity values from bus_flags, and for VGA I'd assume you want to instead
> key this off the mode?

The usecase is that either a panel or a dumb VGA bridge is used
(not both, luckily).

On *some* dumb VGA bridges, the polarity of the clock signal is
inverted, i.e. it expects data to be clocked out on the negative
edge rather than the positive edge. See:
https://lists.freedesktop.org/archives/dri-devel/2017-September/151603.html

And the PL111 can control this in software, that is why it is inspecting
the flags on the connector to figure out when to clock things out.

It seems logical to check the connector to figure out what clock edge
it wants?

> Wrt the more general problem: They way we solve this in the i915 atomic
> framework is that the various ->fixup calls fill out relevant fields in
> the drm_crtc_state. I guess we could add an ->atomic_check to bridges, add
> a bus_flags to drm_crtc_state (or maybe just let everyone patch up
> adjusted_mode->flags) instead?

Not quite following... I do need fixups to mask some modes off the
PL111 but that would be on the driver side.

Yours,
Linus Walleij
