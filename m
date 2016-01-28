From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Jan 2016 11:37:33 +0100
Subject: [PATCH] mfd: db8500: avoid uninitialized variable reference
In-Reply-To: <1453737752-1960326-1-git-send-email-arnd@arndb.de>
References: <1453737752-1960326-1-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdb-yw45j_4kV88LXipjfXK2eYgGwkqbzVOE9Lyb1gh7rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 5:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The prcmu_config_clkout() function ensures that the 'clkout' argument
> can only be '0' or '1' using an appropriate BUG_ON(), so the compiler
> should know that the div_mask, mask, and bits variables are always
> initialized later on. However, it doesn't understand this in gcc-5.2
> and produces a false positive warning instead:
>
> drivers/mfd/db8500-prcmu.c: In function 'prcmu_config_clkout':
> drivers/mfd/db8500-prcmu.c:762:10: error: 'div_mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>   if (val & div_mask) {
>           ^
> drivers/mfd/db8500-prcmu.c:769:13: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>     if ((val & mask & ~div_mask) != bits) {
>              ^
> drivers/mfd/db8500-prcmu.c:757:7: error: 'bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> Replacing the switch() statement with an equivalent if() lets
> gcc figure this out reliably and avoids the warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OK then..
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
