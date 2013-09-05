From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 5 Sep 2013 09:42:14 +0200
Subject: [PATCH 0/8] mmc: sdhci-esdhc-imx: add SD3.0 support
In-Reply-To: <1378299257-2980-1-git-send-email-b29396@freescale.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
Message-ID: <CAPDyKFprH0dixTojis63R0oho6CLaPuzSVDuPia6HWQ6cLYmNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 September 2013 14:54, Dong Aisheng <b29396@freescale.com> wrote:
> This patch series add SD3.0 support for i.MX6Q/DL.
> Since freescale i.MX6Q/DL uSDHC clock tuning progress is a little different from
> the standard tuning process defined in host controller spec v3.0.
> So we add a hook to allow execute platform specific tuning instead of
> standard host controller tuning.
>
> The main difference are:
> 1) not only generate Buffer Read Ready interrupt when tuning is performing.
> It generates all other DATA interrupts like the normal data command.
> 2) SDHCI_CTRL_EXEC_TUNING is not automatically cleared by HW,
> instead it's controlled by SW.
> 3) SDHCI_CTRL_TUNED_CLK is not automatically set by HW,
> it's controlled by SW.
> 4) the clock delay for every tuning is set by SW.

An overall question. Do you have any thoughts around periodic/idle
re-tuning. It is has nothing directly to do with this patchset, but
since you implemented the tuning sequence here, maybe you have some
thoughts around it?

Kind regards
Ulf Hansson

>
> Tested on i.MX6Q Sabreauto board.
>
> The series is based on latest Linus tree.
>
> Dong Aisheng (8):
>   mmc: sdhci: add hooks for platform specific tuning
>   mmc: sdhci: allow platform access of sdhci_send_command
>   sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
>   sdhci: sdhci-esdhci-imx: add sd3.0 clock tuning support
>   sdhci: sdhci-esdhc-imx: change pinctrl state according to uhs mode
>   mmc: sdhci-esdhc: correct pre_div for imx6q
>   mmc: sdhci-esdhc: set actual_clock in clock setting
>   ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
>
>  arch/arm/boot/dts/imx6dl.dtsi               |   33 +++
>  arch/arm/boot/dts/imx6q.dtsi                |   33 +++
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |    4 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c          |  307 ++++++++++++++++++++++++++-
>  drivers/mmc/host/sdhci-esdhc.h              |   35 +++-
>  drivers/mmc/host/sdhci.c                    |   12 +-
>  drivers/mmc/host/sdhci.h                    |    3 +
>  include/linux/platform_data/mmc-esdhc-imx.h |    4 +
>  8 files changed, 419 insertions(+), 12 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
