From: robherring2@gmail.com (Rob Herring)
Date: Fri, 14 Mar 2014 15:24:13 -0500
Subject: [PATCHv2 2/3] arm64: Support DMA_ATTR_WRITE_COMBINE
In-Reply-To: <1394826745-24191-2-git-send-email-lauraa@codeaurora.org>
References: <1394732716-11507-2-git-send-email-lauraa@codeaurora.org>
 <1394826745-24191-2-git-send-email-lauraa@codeaurora.org>
Message-ID: <CAL_JsqKziSNiuN8VjXSv9Lm1vjn9Tc+OLxuVs5mDr3pnaEA4Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 2:52 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> DMA_ATTR_WRITE_COMBINE is currently ignored. Set the pgprot
> appropriately for non coherent opperations.
>
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> ---
>  arch/arm64/mm/dma-mapping.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 0cdd2f6..608c343 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -29,6 +29,17 @@
>  struct dma_map_ops *dma_ops;
>  EXPORT_SYMBOL(dma_ops);
>
> +
> +static inline pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
> +                                       bool coherent)
> +{
> +       if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
> +               return pgprot_writecombine(prot)

Does this compile? Missing semicolon.

> +       else if (!coherent)
> +               return pgprot_dmacoherent(prot);
> +       return prot;

Isn't DMA_ATTR_WRITE_COMBINE supposed to be an optimization over plain
non-cached? But coherent would be more optimal over just write
combine, so we would want to continue to ignore DMA_ATTR_WRITE_COMBINE
in the coherent case. Something like this:

      if (coherent)
               return prot;
      else if (dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
               return pgprot_writecombine(prot);
      return pgprot_dmacoherent(prot);


But then this function is never used in the coherent case, so I'm
confused by Catalin's comment. The original version seems sufficient
to me.

Rob
