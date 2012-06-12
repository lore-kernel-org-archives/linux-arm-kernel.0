From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 12 Jun 2012 20:54:17 +0200
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
In-Reply-To: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdahoqUEc74eEcf=KcYRoUMEYQ456nZ85qGViLGBxUpdbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 9:18 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> We had a boot regression in Ux500 in the merge window because
> two orthogonal pin control schemes for the PL011 were merged
> at the same time:
>
> - One using the .init() and .exit() hooks into the platform
> ?for Ux500 putting the pins into default vs sleep state
> ?respectively as the port was started/stopped.
> ?commit a09806607fd20bed2f8c41fe22793386790a14aa
> ?"ARM: ux500: switch to using pinctrl for uart0"
>
> - One hogging the default setting at PL011 probe()
> ?commit 258e055111d3cde2607e0d04eb91da2f7a59b591
> ?"serial: amba-pl011: adopt pinctrl support"
>
> To get a solution that works for both let's scrap the stuff
> in the platform callbacks, instead have the driver itself
> select default and sleep states when the port is
> started/stopped. Hopefully this works for all clients.
> Platform callbacks are bad for device tree migration anyway,
> so this rids us of another problem in Ux500.
>
> Cc: linux-serial at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

A friendly poke at Greg to push this for the -rc series whenever
time permits (if OK) as it's regressing Ux500 for the moment.

Yours,
Linus Walleij
