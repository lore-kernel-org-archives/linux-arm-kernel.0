From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:51:20 +0200
Subject: [RFC PATCH 06/11] dma: amba-pl08x: Keep LLIs aligned to 4-word
 boundary
In-Reply-To: <1371416058-22047-7-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-7-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdYzag=sKo87i6H3M_fSQuRiTX3_2-ZhQA+4S7ejZN5j4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> PL080 reference manual states that to LLI entries should be aligned
> to 4-word boundary to make LLI fetches more efficient. This patch adds
> a 3-word padding to the LLi struct to make this condition true.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/dma/amba-pl08x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
> index eb10eb8..0da5539 100644
> --- a/drivers/dma/amba-pl08x.c
> +++ b/drivers/dma/amba-pl08x.c
> @@ -127,6 +127,7 @@ struct pl08x_lli {
>         u32 lli;
>         u32 cctl;
>         u32 cctl1;
> +       u32 dummy[3];

Atleast put a comment into the code explaining what this is all
about. Or someone will add another member to the struct and
all is lost. Call it "padding" rather than dummy.

>  };

So it used to be like this before you added cctl1:

struct pl08x_lli {
        u32 src;
        u32 dst;
        u32 lli;
        u32 cctl;
};

Meaning it was 3 words.

And now you make it take 8 words for everyone.

Atleast this patch should be squashed into the patch
adding cctl1.

But I really don't like this fragile way of casting structs right
into memory, and I don't like that teh other PL080's also have
to waste 8 words when their LLIs fit so nicely into 4.

I would have solved this problem by creating a
marshalling function that just allocate the number of bytes the
LLI entry shall have and fill it in by assigning directly to the
precise target memory cell. This way the LLIs will take
4 words on the original variants and you can use some
nice logic to pad out to 8 words on the PL080S variant.

Yours,
Linus Walleij
