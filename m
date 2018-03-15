From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Wed, 14 Mar 2018 18:50:05 -0700
Subject: [PATCH 5/7] igb: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1520997629-17361-5-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-5-git-send-email-okaya@codeaurora.org>
Message-ID: <CAKgT0UfE0vvpOLaA0at=YPQDLpqC0yvKUdFb2hKi7P8fr0ZOcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 8:20 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
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
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index b88fae7..ba8ccb5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8072,7 +8072,7 @@ void igb_alloc_rx_buffers(struct igb_ring *rx_ring, u16 cleaned_count)
>                  * such as IA-64).
>                  */
>                 wmb();
> -               writel(i, rx_ring->tail);
> +               writel_relaxed(i, rx_ring->tail);
>         }
>  }
>

This one missed the writel at the end of igb_tx_map().
