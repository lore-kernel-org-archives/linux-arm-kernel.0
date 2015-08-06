From: djkurtz@chromium.org (Daniel Kurtz)
Date: Thu, 6 Aug 2015 17:13:21 +0800
Subject: [PATCH v6 7/9] clk: mediatek: Add subsystem clocks of MT8173
In-Reply-To: <1438851644.27884.21.camel@mtksdaap41>
References: <1438676218-11310-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438676218-11310-8-git-send-email-jamesjj.liao@mediatek.com>
 <20150805064605.GZ18700@pengutronix.de> <1438849431.27884.9.camel@mtksdaap41>
 <20150806085354.GN18700@pengutronix.de> <1438851644.27884.21.camel@mtksdaap41>
Message-ID: <CAGS+omAAYZyZJ4+eSdu2jmwThvHg1YpVoehui_cqNp4A5fURWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 5:00 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Sascha,
>
> On Thu, 2015-08-06 at 10:53 +0200, Sascha Hauer wrote:
>> On Thu, Aug 06, 2015 at 04:23:51PM +0800, James Liao wrote:
>> > On Wed, 2015-08-05 at 08:46 +0200, Sascha Hauer wrote:
>> > > On Tue, Aug 04, 2015 at 04:16:56PM +0800, James Liao wrote:
>> > > >  static const struct mtk_fixed_clk fixed_clks[] __initconst = {
>> > > >         FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", 400 * MHZ),
>> > > >         FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
>> > > > +       FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", 130 * MHZ),
>> > > > +       FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", 130 * MHZ),
>> > > > +       FIXED_CLK(CLK_TOP_LVDS_PXL, "lvds_pxl", "lvdspll", 148.5 * MHZ),
>> > > > +       FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", 51.975 * MHZ),
>> > >
>> > > I would expect 51975 * KHZ here to avoid fractional numbers. Probably
>> > > gcc calculates that during compile time so this will work as expected,
>> > > still I'm not sure this is good style to use fractional numbers here.
>> >
>> > As I know all constants will be calculated in compile time, so there
>> > should be no difference between 51.975 * MHZ and 51975 * KHz.
>> >
>> > > Anyway, on my system lvdspll is running at 150MHz. Are you sure there is
>> > > a clock derived from this running at 148.5MHz? Is it really correct to
>> > > use a fixed clock here or should it rather be lvdspll directly?
>> >
>> > Here is the clock hierarchy between lvdspll and lvds_pxl:
>> >
>> >             --------       AD_VPLL_DPIX_CK  --------   lvds_pxl  -----
>> >            |        |--------------------->|        |---------->|
>> >            |        |                      | cksys  |           |
>> > LVDSPLL -->| LVDSTX |                      | buffer |           | MMSYS
>> >            |        | AD_LVDSTX_CLKDIG_CTS | test   |  lvds_cts |
>> >            |        |--------------------->|        |---------->|
>> >             --------                        --------             -----
>> >
>> > Some clocks and blocks are not modeled into CCF. But we prefer to enable
>> > lvdspll before enabling lvds_pxl. So I modeled lvds_pxl (and lvds_cts)
>> > as a fixed-rate clock with a source from lvdspll.
>> >
>> > The frequency of these fixed-rate clocks (such as 148.5 MHz) are typical
>> > rate. In fact, we don't care about the actual rate of these clocks. We
>> > just care about the enable / disable sequence of them.
>>
>> Please either use the real rate or 0 (along with a explaining why). Using
>> a frequency with four to five significant digits makes me think that the
>> actual rate is very important.
>
> Oops, your suggestion is much different from Daniel's.
>
> Daniel, could you help to comment about how we model these clocks?

First of all, for clocks where the rate doesn't matter, it doesn't
matters to what rate we set the clock.

As for the color of our shed, "the designer says these are the typical
rates" sounds good enough to me for a "real rate", so I prefer using
the rates in James' patch.

If not sure what Sascha's concern is, but if he insists on 0, I'm fine
with that too.

-Dan
