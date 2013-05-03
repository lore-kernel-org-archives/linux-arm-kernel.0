From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:27:07 +0200
Subject: [PATCH 20/63] dmaengine: ste_dma40: Remove unnecessary call to
 d40_phy_cfg()
In-Reply-To: <1367591569-32197-21-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-21-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbx_-wcatRaUpRw5LJY6qsoqDc3iqwk+UVmoBWR1M35KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> All configuration left in d40_phy_cfg() is runtime configurable and
> there is already a call into it from d40_runtime_config(), so let's
> rely on that.
>
> Acked-by: Vinod Koul <vnod.koul@intel.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
(...)

> @@ -2027,6 +2027,14 @@ static int d40_config_memcpy(struct d40_chan *d40c)
>         } else if (dma_has_cap(DMA_MEMCPY, cap) &&
>                    dma_has_cap(DMA_SLAVE, cap)) {
>                 d40c->dma_cfg = dma40_memcpy_conf_phy;
> +
> +               /* Generate interrrupt at end of transfer or relink. */
> +               d40c->dst_def_cfg |= BIT(D40_SREG_CFG_TIM_POS);
> +
> +               /* Generate interrupt on error. */
> +               d40c->src_def_cfg |= BIT(D40_SREG_CFG_EIM_POS);
> +               d40c->dst_def_cfg |= BIT(D40_SREG_CFG_EIM_POS);
> +

This hunk looks like it's fixing a bug introduced in patch 19/63.

Do you try to run a memcpy test after patch 19?

Breaking the drive in one patch and fixing it in the next is
a no-no because of bisection.

Maybe things work fine if you just move this hunk of the
patch over to 19/63?

Apart from this the patch looks fine.

Yours,
Linus Walleij
