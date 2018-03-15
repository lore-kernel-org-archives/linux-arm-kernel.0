From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Wed, 14 Mar 2018 18:53:35 -0700
Subject: [PATCH 1/7] i40e/i40evf: Eliminate duplicate barriers on
 weakly-ordered archs
In-Reply-To: <1520997599-17298-1-git-send-email-okaya@codeaurora.org>
References: <1520997599-17298-1-git-send-email-okaya@codeaurora.org>
Message-ID: <CAKgT0Ud8jhDKCggC8hN5xF-twLc7sycNh8R0pcLvayY2-5b+Cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 8:19 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Code includes wmb() followed by writel(). writel() already has a barrier
> on some architectures like arm64.
>
> This ends up CPU observing two barriers back to back before executing the
> register write.
>
> Since code already has an explicit barrier call, changing writel() to
> writel_relaxed().
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index e554aa6cf..7028516 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1375,7 +1375,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> index 357d605..2d323fc 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
> @@ -667,7 +667,7 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>          * such as IA-64).
>          */
>         wmb();
> -       writel(val, rx_ring->tail);
> +       writel_relaxed(val, rx_ring->tail);
>  }
>

So this one missed writel calls in:
i40e:
  i40e_program_fdir_filter
  i40e_clean_rx_irq
  i40e_tx_map
i40evf:
  i40e_clean_rx_irq
  i40e_tx_map
