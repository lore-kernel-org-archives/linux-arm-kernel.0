From: alexander.duyck@gmail.com (Alexander Duyck)
Date: Wed, 14 Mar 2018 18:48:40 -0700
Subject: [PATCH 4/7] igbvf: eliminate duplicate barriers on weakly-ordered
 archs
In-Reply-To: <1520997629-17361-4-git-send-email-okaya@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-4-git-send-email-okaya@codeaurora.org>
Message-ID: <CAKgT0Ue2tGgNEjjUVZJUwWx_U8RiQ8n6msbNobh1yPBN_2QjJQ@mail.gmail.com>
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
>  drivers/net/ethernet/intel/igbvf/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
> index 4214c15..fe3441b 100644
> --- a/drivers/net/ethernet/intel/igbvf/netdev.c
> +++ b/drivers/net/ethernet/intel/igbvf/netdev.c
> @@ -251,7 +251,7 @@ static void igbvf_alloc_rx_buffers(struct igbvf_ring *rx_ring,
>                  * such as IA-64).
>                 */
>                 wmb();
> -               writel(i, adapter->hw.hw_addr + rx_ring->tail);
> +               writel_relaxed(i, adapter->hw.hw_addr + rx_ring->tail);
>         }
>  }
>

This one missed the writel at the end of igbvf_tx_queue_adv().
