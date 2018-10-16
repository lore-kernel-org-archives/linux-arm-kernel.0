From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 16 Oct 2018 11:33:28 +0200
Subject: [PATCH 1/2] drm/bridge: Add virtual display DT bindings
In-Reply-To: <20180829102320eucas1p28f05f1c765eb85195a06199bb68b87ce~PU9ukgvXA1734817348eucas1p2L@eucas1p2.samsung.com>
References: <CGME20180824122324epcas3p2922f3e5415dacf4c89cfb136fa5c77b2@epcas3p2.samsung.com>
 <20180824122308.3092-1-linus.walleij@linaro.org>
 <20180827115302eucas1p24d36cfaf9835ccb217ac81e508484aa1~Ou5eTkYW-3006130061eucas1p2Z@eucas1p2.samsung.com>
 <CACRpkdaGNhxY-xAAEL1Bu4EMr8x7qTGoM9s-At2v7Ev8PwOTDw@mail.gmail.com>
 <20180829095822eucas1p1fe4336ca7944765c01fc6ad1e941b8b0~PUn7YujBw3056130561eucas1p1_@eucas1p1.samsung.com>
 <20180829100152.GL907@e110455-lin.cambridge.arm.com>
 <20180829102320eucas1p28f05f1c765eb85195a06199bb68b87ce~PU9ukgvXA1734817348eucas1p2L@eucas1p2.samsung.com>
Message-ID: <CACRpkdYx240t5eVCBzCAdNPn1C1SfneLUGtud-0eCoALVQSdmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 12:23 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 29.08.2018 12:01, Liviu Dudau wrote:
> > On Wed, Aug 29, 2018 at 11:58:20AM +0200, Andrzej Hajda wrote:
> >> On 28.08.2018 15:45, Linus Walleij wrote:
> >>> On Mon, Aug 27, 2018 at 1:53 PM Andrzej Hajda <a.hajda@samsung.com> wrote:

> >>> I'm sorry RTSM is half/half. Not my fault. I can't fix...
> >> I do not know the platform, so I  I have dug little bit, but I wan't
> >> call it  thorough research. Just please be kind if I wrote sth stupid.
> >> What I have found:
> >> 1. DTS shows CLCD is pl111.
> >> 2. pl111 documentation says it's output interface supports STN and TFT
> >> up to 24-bit bus. I do not know STN, but TFT seems to be compatible with
> >> DPI.
> >>
> >> If it is correct, dpi panel seems to be OK. And I think it is less
> >> important how the emulator works, more important is that it should
> >> emulate pl111, including it's output interfaces.
> >
> > Yeah, unfortunately that ship has sailed a long time ago. The emulator
> > people thought emulating the register interface is good enough and took
> > liberties on how the behaviour was "emulated". End result: output
> > interfaces are not the same.
>
> So what is wrong/missing with dpi panel?

I suppose you are referring to:
Documentation/devicetree/bindings/display/panel/panel-dpi.txt

In short, the following is what is wrong with "dpi-panel":

cd drivers/gpu/drm/panel
grep 'panel-dpi'
<empty string>

This is because the DRM subsystem does not seem to support
any "generic DPI panel" (compatible = "dpi-panel") like fbdev does.

I guess I *could* add support for it to panel-simple.c, but is that
what we want?

The problem I would personally have with it is that "panel-dpi" is
a bus format or transport mechanism, not a real panel.

Everything else in panel-simple has a proper compatible string
to the actual display following the "vendor,product" convention.

Essentially (IMO) "panel-dpi" as compatible string is no better
than "virtual-display-bridge" as suggested in this patch. It is even
a worse fit since all the stuff that DPI includes (like electronic
signals a, b, c...) certainly does not exist in the RTSMv8 emulator.
What it does (as I explained) is just read what was written into
the x/y and color depth resolution registers and slap something
into the emulator window based on that. It doesn't generate
or even attempt to emulate any electronic signals. And this
emulator is what I am trying to support in the first place.

So I would really like to hear what Thierry has to say about using
"panel-dpi" for that before trying that approach.

I feel it would be equivalent to just add a panel with the name
"arm,rtsmv8" into panel-simple and stop trying to be generic,
is this what we want? I'm fine with it, I just want to progress
the patch series in some way.

Yours,
Linus Walleij
