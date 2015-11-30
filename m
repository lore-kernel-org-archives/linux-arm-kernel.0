From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 13:55:19 +0100
Subject: [PATCH v2] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <1448055950-21190-1-git-send-email-leoli@freescale.com>
References: <1448055950-21190-1-git-send-email-leoli@freescale.com>
Message-ID: <CACRpkdbb-GFJSVvxOLda6CVG_fB2zAPPC2MMzQ6P1mAfvsrkPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 10:45 PM, Li Yang <leoli@freescale.com> wrote:

> -       if (IS_ERR(i2c_imx->pinctrl)) {
> +       /* bailout on -ENOMEM or -EPROBE_DEFER, continue for other errors */
> +       if (PTR_ERR(i2c_imx->pinctrl) == -ENOMEM ||
> +                       PTR_ERR(i2c_imx->pinctrl) == -EPROBE_DEFER) {

This is one of the evils of deferred probe: you never know if
something will eventually turn up. It feels wrong to bail out
on deferred probe...

I have no better idea though.
Acked-by

Yours,
Linus Walleij
