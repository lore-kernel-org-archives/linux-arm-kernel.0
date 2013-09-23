From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Sep 2013 09:34:04 -0300
Subject: [PATCH] clk: mxs: source LCD clock from PLL instead of from
 ref_xtal
In-Reply-To: <1379922623-4875-1-git-send-email-hector.palacios@digi.com>
References: <1379922623-4875-1-git-send-email-hector.palacios@digi.com>
Message-ID: <CAOMZO5C7Ce_KSmh+6Xqh+9s6TFASGkz2Ybsfea67TRGf_vROgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 23, 2013 at 4:50 AM, Hector Palacios
<hector.palacios@digi.com> wrote:
> The lcd clock hierarchy is as follows:
>
>     ref_clk (24MHz)-----\
>                          +--+ lcdif_sel (MUX type)
>     frac1_clk (480Mhz)--/   |
>                             \--+ lcdif_div (DIV type)
>                                |
>                                \-- lcdif (GATE type)
>
> The mxsfb driver retrieves the 'lcdif_div' clock from the DT, but the
> 'lcdif_sel' is by default sourced from 'ref_clk' which is a fixed 24MHz.
> This means the pixel clock can only be 24MHz or a power-of-two divisor
> of that frequency (12, 6, 3...) which is a very poor divisor granularity.
>
> Since the driver doesn't know about the different clocks that can
> source its clk parent from, we must select the PLL (480MHz) to be the
> parent during the general clocks initialization. This allows for much
> better divisor granularity and for more accurate frequencies for LCD
> displays.
>
> Signed-off-by: Hector Palacios <hector.palacios@digi.com>
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
> CC: Maxime Rippard <maxime.ripard@free-electrons.com>
> CC: Marek Vasut <marex@denx.de>
> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

You added a lot of people on Cc, but you missed the clk maintaner
(Mike Turquette) :-)
