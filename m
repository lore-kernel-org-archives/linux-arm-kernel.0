From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 25 Jun 2012 12:31:00 +0100
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
In-Reply-To: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 8:18 PM, Linus Walleij
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
> ---
> ?arch/arm/mach-ux500/board-mop500.c | ? 54 +-----------------------------------
> ?drivers/tty/serial/amba-pl011.c ? ?| ? 45 +++++++++++++++++++++++++++---
> ?2 files changed, 42 insertions(+), 57 deletions(-)

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> @@ -1869,11 +1897,20 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
> ? ? ? ? ? ? ? ?goto free;
> ? ? ? ?}
>
> - ? ? ? pinctrl = devm_pinctrl_get_select_default(&dev->dev);
> - ? ? ? if (IS_ERR(pinctrl)) {
> - ? ? ? ? ? ? ? ret = PTR_ERR(pinctrl);
> + ? ? ? uap->pinctrl = devm_pinctrl_get(&dev->dev);
> + ? ? ? if (IS_ERR(uap->pinctrl)) {
> + ? ? ? ? ? ? ? ret = PTR_ERR(uap->pinctrl);
> ? ? ? ? ? ? ? ?goto unmap;
> ? ? ? ?}

Hi Linus,

People testing SPEAr with v3.5-rc1 saw that serial devices don't show
up during boot and they
actually return with error from this point, after Shawn's last patch.
That will still happen with
this patch i believe.

What is expected from Platforms to handle this? AFAICR, we haven't
done anything special
to bind a pinctrl node to a struct dev for uart.

--
Viresh
