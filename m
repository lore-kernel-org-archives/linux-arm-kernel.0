From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Sep 2016 11:56:19 +0200
Subject: [PATCH 0/7] drm/sun4i: Introduce A33 display driver
In-Reply-To: <CAGb2v660je7FAiXfeRb5Ynwtr8=fYDR1JHzrj2Hk+43_J0XRLg@mail.gmail.com>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <18951472779805@web6g.yandex.ru> <20160902190605.GF6313@lukather>
 <CAGb2v64p2MMvTpS8nNT2hGF3_jBa7Odr2qkOHD=N4iVXMDxrwA@mail.gmail.com>
 <20160905203707.GF8596@lukather>
 <CAGb2v65Ui5ys_=5fmW4FkfR+oc7sCnwq0cHbgGFt3r-Kgg=k5w@mail.gmail.com>
 <20160906185452.GI9040@lukather>
 <CAGb2v660je7FAiXfeRb5Ynwtr8=fYDR1JHzrj2Hk+43_J0XRLg@mail.gmail.com>
Message-ID: <20160912095619.GI9449@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 07, 2016 at 12:49:58PM +0800, Chen-Yu Tsai wrote:
> On Wed, Sep 7, 2016 at 2:54 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Sep 06, 2016 at 10:50:09AM +0800, Chen-Yu Tsai wrote:
> >> >> The implementation might be along the lines of
> >> >>
> >> >>   1. having multiple output ports, each for a different interface type.
> >> >>      (Some platforms go this route)
> >> >>
> >> >> Or
> >> >>
> >> >>   2. having a DT property describe what the output interface is.
> >> >>
> >> >> The RGB/TCON driver would then setup the registers accordingly.
> >> >
> >> > Hmmm, yeah, we would need to adjust the bindings too...
> >> >
> >> > I guess I'd prefer 1), but that would also be the most invasive
> >> > solution. I'm not sure how the DT maintainers feel about that.
> >>
> >> I wonder if the TCON could use its 2 channels simultaneously?
> >
> > No, it's mutually exclusive.
> 
> I don't see how though. Are you referring to the IO_Map_Sel bit?

Yes.

> I assume that only controls the external output pins though.

As far as I know, channel 1 has no external pins, it's always one of
the blocks using the channel 1 that have external pins.

> >> Like output to one LCD, then mirror through HDMI/VGA?
> >> The first option would be able to cover this better?
> >
> > Even if it wasn't exclusive, that wouldn't be possible
> > unfortunately. Or rather, this would be possible if the LCD and the
> > HDMI screen had the same timings, which is very unlikely.
> 
> What about an LCD-VGA bridge + HDMI in mirror mode on sun6i?
> That should work.

The same resolution doesn't mean you have the same timings. The
porches and sync length might be different, in which case you'll have
to have a different pixel clock and different register set ups.

> >> In addition we'll have to rework the TV encoder binding as well.
> >>
> >> The 2 TV encoders (on the A20) each have four DACs, which map
> >> onto 4 external pins. The address space includes a not so easy
> >> to use mux. More importantly, the binding needs to specify which
> >> pin is used for what signal (RGB, YUV, S/Video, composite).
> >> There seems to be an implicit rule that 1 pin is always used
> >> for composite, and the 3 others RGB, though.
> >
> > I'm not sure why we would need to rework this one though. We have no
> > way to detect whether the screen is connected or not on either
> > connectors, and we can't have both output running at the same time for
> > the same reason than mention above.
> 
> I would like to add connector nodes. At least we can specify stuff
> like what DAC outputs are used for which connector, what type of
> connector, and a ddc bus for VGA connectors. I haven't worked out
> the details though.

The DAC really don't matter. It's purely internal to the driver
itself, it doesn't change from one SoC to the other, so it doesn't
really make sense to have it in the DT.

And is there any design that uses an i2c bus for DDC together with the
TV Encoder?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160912/ff391da2/attachment.sig>
