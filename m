From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 21 Sep 2017 17:00:09 +0200
Subject: [PATCH 0/8] pinctrl: meson: clean pin offsets
In-Reply-To: <CACRpkdYmO2PSKU-qkBMW7C35kHf=usfOoEAobQDMMdzd1RFSTw@mail.gmail.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
 <CACRpkdYmO2PSKU-qkBMW7C35kHf=usfOoEAobQDMMdzd1RFSTw@mail.gmail.com>
Message-ID: <1506006009.2703.175.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 14:21 +0200, Linus Walleij wrote:
> On Wed, Sep 20, 2017 at 3:39 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> 
> > The initial goal of this series was move to TEST_N pin from the EE
> > controller to AO controller, where it belongs. This meant modify the
> > EE_OFF value.
> > 
> > This offset is a quirk we brought from the vendor driver when it was
> > initially merged. There no reason to keep this around and we could simply
> > let pinctrl figure the pin base value.
> > 
> > Removing this offset, while simple, ends up being quite a patch bomb.
> > This is why I split the change over 5 first patches, so the important
> > change, patch #1 remains visible. Of course, to avoid breaking bisect,
> > these first 5 patches should be squashed into one. (If you prefer that I
> > squash it myself, I may have to send you a PR as the patch would exceed
> > VGER 100000 characters limit)
> > 
> > The last change is this series, while not directly related, also requires
> > to adjust the gpio-line-names property in DT. Having these changes going
> > together would make it easier to coordinate the DTS changes.
> > 
> > This was changeset has been test on gxbb P200, gxl libretech-cc.  It was
> > also boot tested on meson8 (Thx Martin!)
> > 
> > Jerome Brunet (8):
> >   pinctrl: meson: remove offset from pinctrl
> >   pinctrl: meson: remove offset continued - gxbb
> >   pinctrl: meson: remove offset continued - gxl
> >   pinctrl: meson: remove offset continued - meson8
> >   pinctrl: meson: remove offset continued - meson8b
> >   pinctrl: meson: get rid of pin_base
> >   pinctrl: meson-gx: TEST_N belongs to the AO controller
> >   pinctrl: meson-gxbb: add missing GPIOX_22 pin
> 
> Looks good just waiting for review from Carlo && || Kevin.

Thanks Linus,

After doing this rework, I noticed that this driver (not the only one though)
assume gpio offset (param of gpio calls) and pin offset are the same thing ...
instead of relying pinctrl (and gpio-ranges) to do the translation.

To make things a bit more clean, I was thinking about forwarding all gpios
framework calls to pinconf, so the gpio to pin offset would go through the
proper mapping function.

Is this the way to do it ?

Using gpio_pinctrl_set_config() I should be able to achieve almost any "write"
functions but I got stuck on gpio_get()

ATM the moment there is no gpio_pinctrl_get_config() or something similar to
read stuff in the gpio framework from pinconf. Would you be open to add
something like this ?

> 
> Yours,
> Linus Walleij
