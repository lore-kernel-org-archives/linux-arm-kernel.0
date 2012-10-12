From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 12 Oct 2012 23:22:44 +0200
Subject: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
In-Reply-To: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdaaG1d4C9n7=2A_au0D99bVTGW1s2KX4hFHbaDAkeiK0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 4:02 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant non power of two block sizes are supported.
> This will make it possible to decrease data overhead for SDIO
> transfers. Although we need to put some constraints to the alignment
> of the buffers when enabling this feature.
>
> Buffers must be 4 bytes aligned due to restrictions that the PL18x
> FIFO accesses must be done in a 4 byte aligned manner. Moreover we
> need to enable DMA_REQCTL for SDIO to support write of non 32 bytes
> aligned sg element lengths. In PIO mode any buffer length can be
> handled as long as the buffer address is 4 byte aligned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I finally understand how this works now.

Bonus for comments like this:

> +/*
> + * DMA request control is required for write
> + * if transfer size is not 32 byte aligned.
> + * DMA request control is also needed if the total
> + * transfer size is 32 byte aligned but any of the
> + * sg element lengths are not aligned with 32 byte.
> + */
>  #define MCI_ST_DPSM_DMAREQCTL  (1 << 12)

Which make you understand what is actually happening.

Yours,
Linus Walleij
