From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Mar 2012 21:33:03 +0100
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <1330630010-11241-9-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
Message-ID: <CACRpkdZK+9gF7N2akyWw=tvcBS2X2FmSd2-SiNKiuRgUCYXx7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2012 at 8:26 PM, Alan Ott <alan@signal11.us> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver should not call set_irq_flags itself, and
> cannot do this from a loadable module.
>
> Remove the call for now, which might break the driver
> but at least lets the kernel link again.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> ?drivers/usb/host/ehci-tegra.c | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index dbc7fe8..ab91f26 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -729,7 +729,6 @@ static int tegra_ehci_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?err = -ENODEV;
> ? ? ? ? ? ? ? ?goto fail;
> ? ? ? ?}
> - ? ? ? set_irq_flags(irq, IRQF_VALID);

The kernel is full of this kind of stuff (drivers/mfd/twl4030-irq.c):

#ifdef CONFIG_ARM
        /* ARM requires an extra step to clear IRQ_NOREQUEST, which it
         * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
         */
        set_irq_flags(irq, IRQF_VALID);
#else
        /* same effect on other architectures */
        irq_set_noprobe(irq);
#endif

Can't we try to fix this for real instead of breaking the universe,
hehe :-)

Yours,
Linus Walleij
