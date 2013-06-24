From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:35:23 +0200
Subject: [RFC PATCH v2 08/12] ASoC: Samsung: Do not queue cyclic buffers
 multiple times
In-Reply-To: <1371933764-24875-9-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-9-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZVn_jeEYatRRH2abbeWAeoCBf0-cgY2sTiG8cyAbzhkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
