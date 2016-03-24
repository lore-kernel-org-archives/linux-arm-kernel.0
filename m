From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 15:53:16 +0100
Subject: [PATCH 1/1] net: macb: remove BUG_ON() and reset the queue to
 handle RX errors
In-Reply-To: <1458830232-6159-1-git-send-email-cyrille.pitchen@atmel.com>
References: <1458830232-6159-1-git-send-email-cyrille.pitchen@atmel.com>
Message-ID: <56F3FF5C.6030000@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2016 03:37 PM, Cyrille Pitchen wrote:
> This patch removes two BUG_ON() used to notify about RX queue corruptions
> on macb (not gem) hardware without actually handling the error.
> 
> The new code skips corrupted frames but still processes faultless frames.
> Then it resets the RX queue before restarting the reception from a clean
> state.
> 
> This patch is a rework of an older patch proposed by Neil Armstrong:
> http://patchwork.ozlabs.org/patch/371525/
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> ---
>  drivers/net/ethernet/cadence/macb.c | 59 ++++++++++++++++++++++++++++++-------
>  1 file changed, 49 insertions(+), 10 deletions(-)

Hi Cyrille,

Thanks for the rework, we solved this situation by moving the descriptors to
an internal RAM with lower latencies, we suspected our AHB-AXI bridge + DDR Controller
to delay the descriptor writes while the interrupt was handled in the meantime.
But the error case was still not handled.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
