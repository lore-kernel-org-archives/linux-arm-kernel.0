From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Apr 2013 13:55:39 +0200
Subject: [PATCH 2/9] crypto: ux500/hash - Set DMA configuration though
 dma_slave_config()
In-Reply-To: <1366280825-31136-3-git-send-email-lee.jones@linaro.org>
References: <1366280825-31136-1-git-send-email-lee.jones@linaro.org>
 <1366280825-31136-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkda0sE+KgdagN0CsRsoDFR+VoUzh2jaipB_1BtShYpBCcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pls include Magnus.p.persson at stericsson.com on all these crypto/hash
postings.

On Thu, Apr 18, 2013 at 12:26 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The DMA controller currently takes configuration information from
> information passed though dma_channel_request(), but it shouldn't.
> Using the API, the DMA channel should only be configured during
> a dma_slave_config() call.
>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Andreas Westin <andreas.westin@stericsson.com>
> Cc: linux-crypto at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

(...)
>  #define HASH_BLOCK_SIZE                        64
> +#define HASH_DMA_FIFO                  4

This is an address so write 0x0004 here please. Some hex notation atleast.

>  /**
>   * struct hash_device_data - structure for a hash device.
> - * @base:              Pointer to the hardware base address.
> + * @base:              Pointer to virtual base address of the hash device.
> + * @phybase:           Pointer to physical memory location of the hash device.
>   * @list_node:         For inclusion in klist.
>   * @dev:               Pointer to the device dev structure.
>   * @ctx_lock:          Spinlock for current_ctx.
> @@ -361,6 +363,7 @@ struct hash_req_ctx {
>   */
>  struct hash_device_data {
>         struct hash_register __iomem    *base;
> +       phys_addr_t             phybase;

What you pass to the config function is a dma_addr_t actually.

This is the same thing on the platform, but generally:

phys_addr_t = in the address space as the memory controller sees it.
dma_addr_t = in the address space as the DMA controller sees it.

Often the same. Not always. So use dma_addr_t.

Apart from this a real nice patch!

Yours,
Linus Walleij
