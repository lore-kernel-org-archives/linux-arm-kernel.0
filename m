From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 29 Jan 2015 11:28:53 +0100
Subject: [PATCH] mmc: sdhci: switch voltage before sdhci_set_ios in
 runtime resume
In-Reply-To: <1422524532-4275-1-git-send-email-jszhang@marvell.com>
References: <1422524532-4275-1-git-send-email-jszhang@marvell.com>
Message-ID: <CAPDyKFq_nkPNdmUc0gxhEffDYDdPmunHgqPGUsfax=BtyUjPTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 January 2015 at 10:42, Jisheng Zhang <jszhang@marvell.com> wrote:
> I observed the Host Control2 register isn't correctly restored
> after runtime resuming on BG2Q. For example, the register reads
> as 0x800c before runtime suspend, but it's set as 0x8004 after runtime
> resuming. This could results in a non working host.
>
> The reason is the Host Control2 is incorrectly reset when switching
> voltage. We fix this by following the same sequence during initialization.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c9881ca..0ad412a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2871,9 +2871,9 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
>         /* Force clock and power re-program */
>         host->pwr = 0;
>         host->clock = 0;
> +       sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
>         sdhci_do_set_ios(host, &host->mmc->ios);
>
> -       sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
>         if ((host_flags & SDHCI_PV_ENABLED) &&
>                 !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
>                 spin_lock_irqsave(&host->lock, flags);
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
