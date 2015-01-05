From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Jan 2015 15:05:46 +0100
Subject: [PATCH v4 2/3] pinctrl: exynos: Fix GPIO setup failure because
 domain clock being gated
In-Reply-To: <1417777254-26579-3-git-send-email-k.kozlowski@samsung.com>
References: <1417777254-26579-1-git-send-email-k.kozlowski@samsung.com>
 <1417777254-26579-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdaVJKmMzc0uNL1XK8w93Cf_yWcdW9w4E2NFxroWEkkzZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 5, 2014 at 12:00 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> The audio subsystem on Exynos 5420 has separate clocks and GPIO. To
> operate properly on GPIOs the main block clock 'mau_epll' must be
> enabled.
>
> This was observed on Peach Pi/Pit and Arndale Octa (after enabling i2s0)
> after introducing runtime PM to pl330 DMA driver. After that commit the
> 'mau_epll' was gated, because the "amba" clock was disabled and there
> were no more users of mau_epll.
>
> The system hang just before probing i2s0 because
> samsung_pinmux_setup() tried to access memory from audss block which was
> gated.
>
> Add a clock property to the pinctrl driver and enable the clock during
> GPIO setup. During normal GPIO operations (set, get, set_direction) the
> clock is not enabled.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Tomasz, is this OK and should I apply it for fixes or next?

Yours,
Linus Walleij
