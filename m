From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:57:38 +0200
Subject: [RFC PATCH 08/11] dmaengine: PL08x: Add cyclic transfer support
In-Reply-To: <1371416058-22047-9-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-9-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdbW3GW4-UL2Qhv+3Vcpv84d3sT+-7t+d3ZPJ4_0KEkNmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> From: Alban Bedel <alban.bedel@avionic-design.de>
>
> Many audio interface drivers require support of cyclic transfers to work
> correctly, for example Samsung ASoC DMA driver. This patch adds support
> for cyclic transfers to the amba-pl08x driver.
>
> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Nice! This is useful for others as well.

> @@ -198,6 +199,8 @@ struct pl08x_txd {
>          */
>         u32 ccfg;
>         bool done;
> +
> +       bool cyclic;
>  };

You can never have enough whitespace right?

>  /**
> @@ -561,9 +564,9 @@ static u32 pl08x_getbytes_chan(struct pl08x_dma_chan *plchan)
>                         bytes += get_bytes_in_cctl(llis_va[index].cctl);
>
>                 /*
> -                * A LLI pointer of 0 terminates the LLI list
> ++               * A LLI pointer going backward terminates the LLI list

++? Really?

This looks like a merge leftover being merged in.

> -               if (!llis_va[index].lli)
> +               if (llis_va[index].lli <= clli)

This was clever.

The rest of the code looks nice.

Yours,
Linus Walleij
