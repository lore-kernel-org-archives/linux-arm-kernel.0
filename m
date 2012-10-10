From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 09:26:51 +0200
Subject: [PATCH 01/16] ARM: dts: exynos4210: Replace legacy GPIO bank
 nodes with pinctrl bank nodes
In-Reply-To: <1349685556-23718-2-git-send-email-t.figa@samsung.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-2-git-send-email-t.figa@samsung.com>
Message-ID: <CACRpkdZgH9TSr2uWQW+-8-U7BxJCscQgStVOndGixGmRz74TWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:

> Seuqential patches from this series introduce SoC-specific data parsing
> from device tree.
>
> This patch removes legacy GPIO bank nodes from exynos4210.dtsi and
> replaces them with nodes and properties required for these patches.

So to be clear:

> +       pinctrl-bank-types {
> +               bank_off: bank-off {
> +                       samsung,reg-names = "func", "dat", "pud",
> +                                               "drv", "conpdn", "pudpdn";
> +                       samsung,reg-params = <0x00 4>, <0x04 1>, <0x08 2>,
> +                                               <0x0C 2>, <0x10 2>, <0x14 2>;
> +               };

This is starting to look like a firmware language, I have mixed
feelings about this. Shall this be read:

"Poke 4 into 0x00, poke 1 into 0x04, poke 2 into 0x08" etc?

We really need to discuss this, Grant has already NACK:ed
such approaches once.

If you're still going to do this, it is mandatory
to NOT use magic hex numbers anymore, because Stephen has
merged preprocessor support to the DTC compiler so you
can use #defined macros.

See commit:
cd296721a9645f9f28800a072490fa15458d1fb7

> +       pinctrl at 11400000 {
> +               gpa0: gpa0 {
> +                       gpio-controller;
> +                       samsung,pctl-offset = <0x000>;
> +                       samsung,pin-count = <8>;
> +                       samsung,bank-type = <&bank_off>;
> +                       #gpio-cells = <2>;

This part is OK.

> +
> +                       interrupt-controller;
> +                       samsung,eint-offset = <0x00>;

This property is *NOT* OK. IMHO the driver should know these
offsets, not the device tree. The driver only needs the offset to
the register range, what registers there are and their names
should be #defined.

> +                       #interrupt-cells = <2>;
> +               };

Yours,
Linus Walleij
