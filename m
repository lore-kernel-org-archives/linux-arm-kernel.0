From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 15:15:30 +0100
Subject: [PATCH v4 2/3] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <CACRpkdaVJKmMzc0uNL1XK8w93Cf_yWcdW9w4E2NFxroWEkkzZg@mail.gmail.com>
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 <1417777254-26579-3-git-send-email-k.kozlowski@samsung.com>
 <CACRpkdaVJKmMzc0uNL1XK8w93Cf_yWcdW9w4E2NFxroWEkkzZg@mail.gmail.com>
Message-ID: <1420467330.16219.4.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2015-01-05 at 15:05 +0100, Linus Walleij wrote:
> On Fri, Dec 5, 2014 at 12:00 PM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
> 
> > The audio subsystem on Exynos 5420 has separate clocks and GPIO. To
> > operate properly on GPIOs the main block clock 'mau_epll' must be
> > enabled.
> >
> > This was observed on Peach Pi/Pit and Arndale Octa (after enabling i2s0)
> > after introducing runtime PM to pl330 DMA driver. After that commit the
> > 'mau_epll' was gated, because the "amba" clock was disabled and there
> > were no more users of mau_epll.
> >
> > The system hang just before probing i2s0 because
> > samsung_pinmux_setup() tried to access memory from audss block which was
> > gated.
> >
> > Add a clock property to the pinctrl driver and enable the clock during
> > GPIO setup. During normal GPIO operations (set, get, set_direction) the
> > clock is not enabled.
> >
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Tomasz, is this OK and should I apply it for fixes or next?

Ha! That is a good question. The issue is fixed for now by the
workaround (merged) [1].

The workaround just enables the clock for entire runtime of Exynos
5420-like device. This has some energy impact - around 1.5% in idle [2].

So actually this is question which way we want to solve it:
1. Stick with the workaround (small piece of code, energy impact when
not used).
2. Full clock enable on use (big chunk of code, no energy impact when
not used).

[1]
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f1e9203e2366164b832d8a6ce10134de8c575178
[2] http://www.spinics.net/lists/linux-samsung-soc/msg39827.html

Best regards,
Krzysztof
