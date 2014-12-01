From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 01 Dec 2014 09:37:23 +0100
Subject: [PATCH v2 3/5] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <CA+Ln22Ejo51VPWf6DmuRvV_fZr_H=-BXAshSPSOokNE1bz=-QA@mail.gmail.com>
References: <1417011857-10419-1-git-send-email-k.kozlowski@samsung.com>
 <1417011857-10419-4-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdb8F8YcvFeHPvOKHjx_p4HEpimck3XRabB3oHpZTdmRQQ@mail.gmail.com>
 <1417183724.18249.36.camel@AMDC1943>
 <CA+Ln22Ejo51VPWf6DmuRvV_fZr_H=-BXAshSPSOokNE1bz=-QA@mail.gmail.com>
Message-ID: <1417423043.4055.14.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On nie, 2014-11-30 at 21:19 +0900, Tomasz Figa wrote:
> Hi Krzysztof,
> 
> 2014-11-28 23:08 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> > On pi?, 2014-11-28 at 15:04 +0100, Linus Walleij wrote:
> >> On Wed, Nov 26, 2014 at 3:24 PM, Krzysztof Kozlowski
> >> <k.kozlowski@samsung.com> wrote:
> >>
> >> > The audio subsystem on Exynos 5420 has separate clocks and GPIO. To
> >> > operate properly on GPIOs the main block clock 'mau_epll' must be
> >> > enabled.
> >> >
> >> > This was observed on Peach Pi/Pit and Arndale Octa (after enabling i2s0)
> >> > after introducing runtime PM to pl330 DMA driver. After that commit the
> >> > 'mau_epll' was gated, because the "amba" clock was disabled and there
> >> > were no more users of mau_epll.
> >> >
> >> > The system hang just before probing i2s0 because
> >> > samsung_pinmux_setup() tried to access memory from audss block which was
> >> > gated.
> >> >
> >> > Add a clock property to the pinctrl driver and enable the clock during
> >> > GPIO setup. During normal GPIO operations (set, get, set_direction) the
> >> > clock is not enabled.
> 
> Could you make sure that possibility of gating this clock is worth the
> effort of adding gating code to all affected drivers? If there is no
> significant change in power consumption maybe it could be simply keep
> running all the time?

I had an impression that last time you disliked such idea:
http://www.spinics.net/lists/arm-kernel/msg338127.html
That's why I developed these patches. Because keeping a clock always on,
even when it is unused, is undesirable.

Anyway, I did some simple measurements (after booting Arndale Octa
to /bin/sh, idle):
 - with mau_epll gated: ~523 mA
 - with mau_epll always on: ~531 mA

Keeping it on increases energy usage by 1.5% in idle (with measurement
uncertainty ~0.4%).


> Also isn't a similar problem happening due to power domains? I believe
> the whole maudio block is located in a separate power domain but
> somehow it doesn't get turned off?

There is Maudio power domain... but I think it is not related here.
Pinctrl driver does not have runtime PM and is not attached to a domain.
I thought about other solution to this problem (with utilization of
power domains):
 - add runtime PM to pinctrl and audss clocks,
 - attach pinctrl and audss clocks to maudio power domain,
 - enable the clock when power domain is turned on.
However almost the same changes had to be added to pinctrl and audss
clocks drivers (replace clock_enable() with pm_runtime_get_sync()).

Best regards,
Krzysztof
