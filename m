From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 17 Jun 2015 08:10:55 +0530
Subject: [PATCH 9/9] irq: spear-shirq: fix race in installing chained IRQ
 handler
In-Reply-To: <E1Z4z0X-0002T1-6U@rmk-PC.arm.linux.org.uk>
References: <E1Z4z0X-0002T1-6U@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOh2x=m2y+T0Z78nV5zDmSa6_7NH972EXcEEUKZMZ1dSxE6YKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 17, 2015 at 3:37 AM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Fix a race where a pending interrupt could be received and the handler
> called before the handler's data has been setup, by converting to
> irq_set_chained_handler_and_data().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> Depends on patch 1.
>
>  drivers/irqchip/spear-shirq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/spear-shirq.c b/drivers/irqchip/spear-shirq.c
> index 9c145a7cb056..a45121546caf 100644
> --- a/drivers/irqchip/spear-shirq.c
> +++ b/drivers/irqchip/spear-shirq.c
> @@ -207,8 +207,7 @@ static void __init spear_shirq_register(struct spear_shirq *shirq,
>         if (!shirq->irq_chip)
>                 return;
>
> -       irq_set_chained_handler(parent_irq, shirq_handler);
> -       irq_set_handler_data(parent_irq, shirq);
> +       irq_set_chained_handler_and_data(parent_irq, shirq_handler, shirq);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
