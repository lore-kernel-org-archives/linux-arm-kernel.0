From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 09:06:27 +0200
Subject: [PATCH 09/18] ASoC: Samsung: Do not queue cyclic buffers multiple
 times
In-Reply-To: <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-10-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZd+LJeZdSjsD6OCLOnZ0VrDg0aa-e163NXsw6ajWf7rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 7:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> The legacy S3C-DMA API required every period of a cyclic buffer to be
> queued separately. After conversion of Samsung ASoC to Samsung DMA
> wrappers somebody made an assumption that the same is needed for DMA
> engine API, which is not true.
>
> In effect, Samsung ASoC DMA code was queuing the whole cyclic buffer
> multiple times with a shift of one period per iteration, leading to:
>   a) severe memory waste - up to 13x times more DMA transfer descriptors
>      are allocated than needed,
>   b) possible memory corruption, because further cyclic buffers were out
>      of the original buffers, due to the offset.
>
> This patch fixes this problem by making the legacy S3C-DMA API use the
> same semantics as DMA engine (the whole cyclic buffer is enqueued at
> once) and modifying users of Samsung DMA wrappers in cyclic mode to
> behave appropriately.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

If patch 1 thru 9 are uncontroversial now, maybe Vinod can apply
these for v3.12 so we can get less noise and risk of collissions
in the next merge window?

Just an idea.

Yours,
Linus Walleij
