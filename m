From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Mar 2014 13:46:31 +0100
Subject: [PATCH 6/8] mmc: mmci: Mask IRQs for all variants during runtime
 suspend
In-Reply-To: <1393671371-2398-7-git-send-email-ulf.hansson@linaro.org>
References: <1393671371-2398-1-git-send-email-ulf.hansson@linaro.org>
 <1393671371-2398-7-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAPDyKFr3fjuZa1mDK-FV5gEBynos5ox7LtKf-kMgiSupPiKpJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2014 11:56, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In runtime suspended state, we are not expecting IRQs and thus we can
> safely mask them, not only for pwrreg_nopower variants but for all.
>
> Obviously we then also need to make sure we restore the IRQ mask while
> becoming runtime resumed.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Russell,

I suppose we have discussed and sorted out the concerns you had around
this patch!?

It's available in your patch tracker, would be nice to get it merged
for 3.15, if that's possible.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmci.c |   23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b931226..178868a 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1758,35 +1758,34 @@ static void mmci_save(struct mmci_host *host)
>  {
>         unsigned long flags;
>
> -       if (host->variant->pwrreg_nopower) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
>
> -               writel(0, host->base + MMCIMASK0);
> +       writel(0, host->base + MMCIMASK0);
> +       if (host->variant->pwrreg_nopower) {
>                 writel(0, host->base + MMCIDATACTRL);
>                 writel(0, host->base + MMCIPOWER);
>                 writel(0, host->base + MMCICLOCK);
> -               mmci_reg_delay(host);
> -
> -               spin_unlock_irqrestore(&host->lock, flags);
>         }
> +       mmci_reg_delay(host);
>
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static void mmci_restore(struct mmci_host *host)
>  {
>         unsigned long flags;
>
> -       if (host->variant->pwrreg_nopower) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
>
> +       if (host->variant->pwrreg_nopower) {
>                 writel(host->clk_reg, host->base + MMCICLOCK);
>                 writel(host->datactrl_reg, host->base + MMCIDATACTRL);
>                 writel(host->pwr_reg, host->base + MMCIPOWER);
> -               writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> -               mmci_reg_delay(host);
> -
> -               spin_unlock_irqrestore(&host->lock, flags);
>         }
> +       writel(MCI_IRQENABLE, host->base + MMCIMASK0);
> +       mmci_reg_delay(host);
> +
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static int mmci_runtime_suspend(struct device *dev)
> --
> 1.7.9.5
>
