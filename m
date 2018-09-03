From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 3 Sep 2018 14:14:55 +0200
Subject: [PATCH 02/14] mmc: mmci: internalize dma map/unmap into mmci dma
 functions
In-Reply-To: <1533116221-380-3-git-send-email-ludovic.Barre@st.com>
References: <1533116221-380-1-git-send-email-ludovic.Barre@st.com>
 <1533116221-380-3-git-send-email-ludovic.Barre@st.com>
Message-ID: <CAPDyKFpmjVK8P8p-KkKMVYpEMkDW64F_i7-WMexsne1qgSQoxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 August 2018 at 11:36, Ludovic Barre <ludovic.Barre@st.com> wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
>
> This patch internalizes the management of dma map/unmap into
> mmci dma interfaces. This allows to simplify and prepare the next dma
> callbacks for mmci host ops.
> mmci_dma_unmap was called in mmci_data_irq & mmci_cmd_irq functions
> and can be integrated in mmci_dma_data_error.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  drivers/mmc/host/mmci.c | 44 +++++++++++++++++++-------------------------
>  1 file changed, 19 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 1841d250..d8fa178 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -482,17 +482,7 @@ static inline void mmci_dma_release(struct mmci_host *host)
>         host->dma_rx_channel = host->dma_tx_channel = NULL;
>  }
>
> -static void mmci_dma_data_error(struct mmci_host *host)
> -{
> -       dev_err(mmc_dev(host->mmc), "error during DMA transfer!\n");
> -       dmaengine_terminate_all(host->dma_current);
> -       host->dma_in_progress = false;
> -       host->dma_current = NULL;
> -       host->dma_desc_current = NULL;
> -       host->data->host_cookie = 0;
> -}
> -
> -static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
> +static void __mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)

The renaming of the function seems irrelevant to this change. Can you
please keep the existing name?

[...]

Besides the minor thing above, this looks good to me!

Kind regards
Uffe
