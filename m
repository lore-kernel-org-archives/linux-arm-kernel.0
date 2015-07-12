From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 13 Jul 2015 00:45:58 +0900
Subject: [PATCH v2 10/13] pinctrl: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-11-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-11-git-send-email-robh@kernel.org>
Message-ID: <CA+Ln22He4_LAsZeGbQ+BuZYfhPAQa-JbzgX85-4m0Gay3ikEqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2015-07-12 23:26 GMT+09:00 Rob Herring <robh@kernel.org>:
> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
>
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
>
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Thomas Abraham <thomas.abraham@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> ---
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c         | 1 -
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 --
>  drivers/pinctrl/pinctrl-single.c              | 5 -----
>  drivers/pinctrl/samsung/pinctrl-exynos.c      | 1 -
>  drivers/pinctrl/samsung/pinctrl-exynos5440.c  | 1 -
>  drivers/pinctrl/samsung/pinctrl-s3c24xx.c     | 2 --
>  drivers/pinctrl/samsung/pinctrl-s3c64xx.c     | 2 --

For drivers/pinctrl/samsung:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
