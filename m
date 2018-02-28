From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 28 Feb 2018 17:40:16 +0200
Subject: [PATCH 2/2] serial: stm32: update interrupt initialization
In-Reply-To: <1519815044-22669-3-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com>
Message-ID: <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 12:51 PM, Bich HEMON <bich.hemon@st.com> wrote:
> For each port, get each IRQ using its specific name instead of its index.
>
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  drivers/tty/serial/stm32-usart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
> index 0fa735b..5c85cbc 100644
> --- a/drivers/tty/serial/stm32-usart.c
> +++ b/drivers/tty/serial/stm32-usart.c
> @@ -680,8 +680,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
>         port->flags     = UPF_BOOT_AUTOCONF;
>         port->ops       = &stm32_uart_ops;
>         port->dev       = &pdev->dev;
> -       port->irq       = platform_get_irq(pdev, 0);
> -       stm32port->wakeirq = platform_get_irq(pdev, 1);

> +       port->irq       = platform_get_irq_byname(pdev, "event");

This is I have no idea about...

> +       stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");

But this one is redundant since Tony's patch:
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=da997b22c40473b7db60bde6ea188d35565d10c8

>         stm32port->fifoen = stm32port->info->cfg.has_fifo;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --
> 1.9.1



-- 
With Best Regards,
Andy Shevchenko
