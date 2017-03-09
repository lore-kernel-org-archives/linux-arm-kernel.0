From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Mar 2017 19:31:27 +0800
Subject: [linux-sunxi] Re: [PATCH 10/15] drm/sun4i: tcon: Switch mux on
 only for composite
In-Reply-To: <20170309105800.mnzhvnky6na7d5vn@lukather>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <3f70bcfe2ec03188c06d54a262d49ad91963a510.1488876832.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67iTOV-=u5rReu6_wi6NFoCoJkbJKshTpmFYUmJ=ggKUw@mail.gmail.com>
 <20170309105800.mnzhvnky6na7d5vn@lukather>
Message-ID: <CAGb2v67XkaC2+AxubaUF9nPcoGZcAzny7LKVD6C+-9BM5Fi+9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 6:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Mar 08, 2017 at 11:51:39AM +0800, Chen-Yu Tsai wrote:
>> On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Even though that mux is undocumented, it seems like it needs to be set to 1
>> > when using composite, and 0 when using HDMI.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > index d2335f109601..93249c5ab1e4 100644
>> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> > @@ -268,11 +268,16 @@ void sun4i_tcon1_mode_set(struct sun4i_tcon *tcon, struct drm_encoder *encoder,
>> >                            SUN4I_TCON_GCTL_IOMAP_MASK,
>> >                            SUN4I_TCON_GCTL_IOMAP_TCON1);
>> >
>> > +       if (encoder->encoder_type == DRM_MODE_ENCODER_TVDAC)
>> > +               val = 1;
>> > +       else
>> > +               val = 0;
>> > +
>> >         /*
>> >          * FIXME: Undocumented bits
>> >          */
>> >         if (tcon->quirks->has_unknown_mux)
>> > -               regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, 1);
>> > +               regmap_write(tcon->regs, SUN4I_TCON_MUX_CTRL_REG, val);
>>
>> We might want to do this the other way around, i.e. exporting
>>
>>     int sun4i_tcon_mux_set(struct drm_device *drm, int encoder_type,
>>                            int pipeline)
>>
>> and have downstream encoders call it. For the A31, the mux is not exclusively
>> used for channel 1; there is a mux setting for MIPI DSI as well, but AFAIK
>> DSI is connected to channel 0.
>
> We could make it part of sun4i_tcon_channel_enable too, though. What
> do you think?

We still need some way of figuring out what mux value to set for those
cases. Let's keep your solution for now. We can work on it later when
we have an actual use case to deal with.

>
>> Additionally, the mux registers are only valid in the first TCON, meaning
>> it must available be active in 2 pipeline chips. It's also why we'd pass
>> "struct drm_device *" instead of "struct sun4i_tcon *".
>
> Hmmmm. That's going to be tricky to support. Has this been confirmed
> somehow? Is the register used for something else on TCON1?

At this point, the only reference is Allwinner's kernel, and the old 3.4
kernel for A10/A20. I could try getting HDMI working on the A31 to get
some real results.

FWIW, the registers do not seem to be aliased across the two TCONs.

Regards
ChenYu
