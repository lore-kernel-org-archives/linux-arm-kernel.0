From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 2 Aug 2018 22:42:53 +0200
Subject: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
In-Reply-To: <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
 <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com>
 <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
Message-ID: <CAFBinCAAcqiJAwBMr2_7V90beFwq9xkPBnBdKB8oPsMKXU_-HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 2, 2018 at 1:21 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2018-08-02 at 09:52 +0200, Neil Armstrong wrote:
> > On 01/08/2018 22:23, Martin Blumenstingl wrote:
> > > Hi Neil,
> > >
> > > On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > > >
> > > > The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> > > > set the TEST_N pin direction.
> > > > This patch adds a "smc" boolean to the bank structure to differentiate
> > > > the TEST_N bank and call the Secure Monitor in the _input/_output functions.
> > > >
> > > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > > ---
> > > >  drivers/pinctrl/meson/Kconfig         |  1 +
> > > >  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
> > > >  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
> > > >  3 files changed, 36 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> > > > index c80951d..1b90470 100644
> > > > --- a/drivers/pinctrl/meson/Kconfig
> > > > +++ b/drivers/pinctrl/meson/Kconfig
> > > > @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
> > > >         select GPIOLIB
> > > >         select OF_GPIO
> > > >         select REGMAP_MMIO
> > > > +       select MESON_SM
> > >
> > > I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
> > > PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
> > > instead?
> > > selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
> > > don't have the GX secure monitor), but I haven't tested it yet
>
> I'm not so sure about that. meson_sm_call() symbol is used in the common pinctrl
> code, so it should be selected when compiled even if meson8b is not going to use
> it in the end.
unfortunately MESON_SM depends on ARM64_4K_PAGES so it can't be
enabled for the 32-bit SoCs
any ideas how to solve this?


Regards
Martin
