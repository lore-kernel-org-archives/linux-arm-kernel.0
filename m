From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Nov 2015 16:01:39 -0800
Subject: [PATCH 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <CAGb2v650S8+8SNNBqx7u8k8wxHm2fSKdht=W3yA9Mh=rpU+hOA@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-5-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v650S8+8SNNBqx7u8k8wxHm2fSKdht=W3yA9Mh=rpU+hOA@mail.gmail.com>
Message-ID: <20151107000139.GP6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 31, 2015 at 05:53:26PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The TCON is a controller generating the timings to output videos signals,
> > acting like both a CRTC and an encoder.
> >
> > It has two channels depending on the output, each channel being driven by
> > its own clock (and own clock controller).
> >
> > Add a driver for the channel 1 clock.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clk/sunxi/Makefile             |   1 +
> >  drivers/clk/sunxi/clk-sun4i-tcon-ch1.c | 167 +++++++++++++++++++++++++++++++++
> >  2 files changed, 168 insertions(+)
> >  create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
> 
> According to the documents I have, this variant of the TCON clock
> is specific to sun5i. On sun4i/sun7i, TCON CH1 clock has the same
> layout as TCON CH0 and the other display clocks.

At least for the A20, it's not true.

Make sure you do not confuse LCD1 CH0 (p79, which is a channel 0
clock), with LCD0 CH1 (p81, which is a channel 1 clock).

> > +       sclk1_parents[0] = sclk2_name;
> > +       sclk1_parents[1] = sclk2d2_name;
> 
> Is there any need to expose these 2 clocks via DT using of_clk_add_provider?

No, as far as I'm aware, there's no user external to this clock
driver.

> Note that these complex clock trees within a clock node breaks the
> assigned-clock-parents mechanism, as you can no longer specify the output
> clock's direct parents.

There's no point of changing the parent either. Hardware blocks are
always connected to the leaf clock (sclk1). We could also model it as
an extra 1-bit divider, which would simplify a bit the logic though.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151106/2524a5a4/attachment-0001.sig>
