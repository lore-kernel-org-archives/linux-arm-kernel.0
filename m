From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 09:39:23 +0200
Subject: [PATCHv2 2/2] gpio: mvebu: fix gpio bank registration when pwm is
 used
In-Reply-To: <20170601121826.14685-3-richard.genoud@gmail.com>
References: <20170601121826.14685-1-richard.genoud@gmail.com>
 <20170601121826.14685-3-richard.genoud@gmail.com>
Message-ID: <CACRpkdbQXyz+ZLgjGSg-0wELfxdNbNUy8F=eEcWii4WOSc3BPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 2:18 PM, Richard Genoud <richard.genoud@gmail.com> wrote:

> If more than one gpio bank has the "pwm" property, only one will be
> registered successfully, all the others will fail with:
> mvebu-gpio: probe of f1018140.gpio failed with error -17
>
> That's because in alloc_pwms(), the chip->base (aka "int pwm"), was not
> set (thus, ==0) ; and 0 is a meaningful start value in alloc_pwm().
> What was intended is mvpwm->chip->base = -1.
> Like that, the numbering will be done auto-magically
>
> Moreover, as the region might be already occupied by another pwm, we
> shouldn't force:
> mvpwm->chip->base = 0
> nor
> mvpwm->chip->base = id * MVEBU_MAX_GPIO_PER_BANK;
>
> Tested on clearfog-pro (Marvell 88F6828)
>
> Fixes: 757642f9a584 ("gpio: mvebu: Add limited PWM support")
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Patch applied for fixes with Gregory's review tag.

Yours,
Linus Walleij
