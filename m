From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 13 Sep 2010 15:39:13 +0800
Subject: [PATCH 1/4] ARM: pxa168fb: fix clear operation
In-Reply-To: <1283953362-2363-1-git-send-email-haojian.zhuang@marvell.com>
References: <1283953362-2363-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTinBiD7QycMKMz5T_eRspp8bdFLMxCAkrQFYSxfU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 8, 2010 at 9:42 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> While fb isn't active, we should clear CFG_GRA_ENA bit. The existing code
> can't clear this bit.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Acked-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>

Applied to 'fix'.

> ---
> ?drivers/video/pxa168fb.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index c91a7f7..13c238b 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -298,8 +298,8 @@ static void set_dma_control0(struct pxa168fb_info *fbi)
> ? ? ? ? * Set bit to enable graphics DMA.
> ? ? ? ? */
> ? ? ? ?x = readl(fbi->reg_base + LCD_SPU_DMA_CTRL0);
> - ? ? ? x |= fbi->active ? 0x00000100 : 0;
> - ? ? ? fbi->active = 0;
> + ? ? ? x &= ~CFG_GRA_ENA_MASK;
> + ? ? ? x |= fbi->active ? CFG_GRA_ENA(1) : CFG_GRA_ENA(0);
>
> ? ? ? ?/*
> ? ? ? ? * If we are in a pseudo-color mode, we need to enable
> --
> 1.5.6.5
>
>
