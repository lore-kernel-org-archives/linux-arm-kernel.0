From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Aug 2013 14:53:35 +0200
Subject: [PATCH 32/40] ARM: ux500: Delete U8500 UIB support when booting
 with ATAGs
In-Reply-To: <1377260620-18829-33-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
 <1377260620-18829-33-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZJ_2HF_r8cKpMrG1Usy5bD8Fr7GM_k2Btzxgk71G-VvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 23, 2013 at 2:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's time to remove all ATAG support from ux500 and rely solely on
> Device Tree booting. This patch is part of that endeavour.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This needs some more afterthought.

> -       i2c0 = i2c_get_adapter(0);
> -       if (!i2c0) {
> -               __mop500_uib_init(&mop500_uibs[STUIB],
> -                               "fallback, could not get i2c0");
> -               return -ENODEV;
> -       }
> -
> -       /* U8500-UIB has the TC35893 at 0x44 on I2C0, the ST-UIB doesn't. */
> -       ret = i2c_smbus_xfer(i2c0, 0x44, 0, I2C_SMBUS_WRITE, 0,
> -                       I2C_SMBUS_QUICK, NULL);
> -       i2c_put_adapter(i2c0);
> -
> -       if (ret == 0)
> -               uib = &mop500_uibs[U8500UIB];
> -       else
> -               uib = &mop500_uibs[STUIB];
> -
> -       __mop500_uib_init(uib, "detected");
> +       __mop500_uib_init(&mop500_uibs[STUIB], "detected");

It is not true at all that all HREFs have the STUIB mounted.

This detection needs to stay for now, unless we go and define
in the device tree which UIB is mounted, which would be unfortunate
as we can very well auto-detect it, and that makes it easier for
a user to just swap the UIB and test the other toch screen
(for example).

Yours,
Linus Walleij
